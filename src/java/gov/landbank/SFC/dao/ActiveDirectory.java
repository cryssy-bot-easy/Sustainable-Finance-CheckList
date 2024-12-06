package gov.landbank.SFC.dao;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Hashtable;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import static javax.naming.directory.SearchControls.SUBTREE_SCOPE;
import javax.naming.ldap.LdapContext;
import javax.naming.ldap.InitialLdapContext;

//Imports for changing password
import javax.naming.directory.ModificationItem;
import javax.naming.directory.BasicAttribute;
import javax.naming.ldap.StartTlsResponse;
import javax.naming.ldap.StartTlsRequest;
import javax.net.ssl.*;

//******************************************************************************
//**  ActiveDirectory
//*****************************************************************************/
/**
 * Provides static methods to authenticate users, change passwords, etc.
 *
 *****************************************************************************
 */
public class ActiveDirectory {

    private static String[] userAttributes = {
        "distinguishedName", "cn", "name", "uid",
        "sn", "givenname", "memberOf", "samaccountname",
        "userPrincipalName", "lockoutTime", "mail", "badPwdCount",
        "userpassword", "unicodePwd", "whenChanged"
    };

    private ActiveDirectory() {
    }

    //**************************************************************************
    //** Attempt Class
    //*************************************************************************/
    /**
     * Used to represent a Attempt Status for counter
     */
    static String attemptStat;

    public static String setAttemptStat(String status) {
        attemptStat = status;
        return status;
    }

    public static String getAttemptStat() {
        return attemptStat;
    }

    //**************************************************************************
    //** getConnection
    //*************************************************************************/
    /**
     * Used to authenticate a user given a username/password. Domain name is
     * derived from the fully qualified domain name of the host machine.
     */
    public static LdapContext getConnection(String username, String password) throws NamingException {
        return getConnection(username, password, null, null);
    }

    //**************************************************************************
    //** getConnection
    //*************************************************************************/
    /**
     * Used to authenticate a user given a username/password and domain name.
     */
    public static LdapContext getConnection(String username, String password, String domainName) throws NamingException {
        return getConnection(username, password, domainName, null);
    }

    //**************************************************************************
    //** getConnection
    //*************************************************************************/
    /**
     * Used to authenticate a user given a username/password and domain name.
     * Provides an option to identify a specific a Active Directory server.
     */
    public static LdapContext getConnection(String username, String password, String domainName, String serverName) throws NamingException {

        if (domainName == null) {
            try {
                String fqdn = java.net.InetAddress.getLocalHost().getCanonicalHostName();
                if (fqdn.split("\\.").length > 1) {
                    domainName = fqdn.substring(fqdn.indexOf(".") + 1);
                }
            } catch (java.net.UnknownHostException e) {
            }
        }

        if (password != null) {
            password = password.trim();
            if (password.length() == 0) {
                password = null;
            }
        }

        //bind by using the specified username/password
        Hashtable props = new Hashtable();
        String principalName = username + "@" + domainName;
        props.put(Context.SECURITY_PRINCIPAL, principalName);
        if (password != null) {
            props.put(Context.SECURITY_CREDENTIALS, password);
        }

        String ldapURL = "ldap://" + ((serverName == null) ? "192.168.1.127" : serverName + "." + domainName) + '/';
        props.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
        props.put(Context.PROVIDER_URL, ldapURL);

        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);

        try {
            return new InitialLdapContext(props, null);
        } catch (javax.naming.CommunicationException e) {
            throw new NamingException(e + " Failed to connect to " + domainName + ((serverName == null) ? "" : " through " + serverName));
        } catch (javax.naming.AuthenticationException e) {
            e.printStackTrace(pw);
            String sStackTrace = sw.toString(); // stack trace as a string
            String errorMsg = errorCode(sStackTrace);

            throw new NamingException("Thrown Error: " + e);
        } catch (NamingException e) {
            throw new NamingException(e + " Failed to authenticate " + username + "@" + domainName + ((serverName == null) ? "" : " through " + serverName));
        }
    }
    //**************************************************************************
    //** checkUser
    //*************************************************************************/

    /**
     * Used to check whether a username is valid.
     *
     * @param username A username to validate (e.g. "peter", "peter@acme.com",
     * or "ACME\peter").
     */
    public static User checkUser(String username, LdapContext context) {
        try {
            String domainName = null;
            if (username.contains("@")) {
                username = username.substring(0, username.indexOf("@"));
                domainName = username.substring(username.indexOf("@") + 1);
            } else if (username.contains("\\")) {
                username = username.substring(0, username.indexOf("\\"));
                domainName = username.substring(username.indexOf("\\") + 1);
            } else {
                String authenticatedUser = (String) context.getEnvironment().get(Context.SECURITY_PRINCIPAL);
                if (authenticatedUser.contains("@")) {
                    domainName = authenticatedUser.substring(authenticatedUser.indexOf("@") + 1);
                }
            }
            String filter = String.format("(sAMAccountName=%s)", username);
            if (domainName != null) {
                SearchControls controls = new SearchControls();
                controls.setSearchScope(SUBTREE_SCOPE);
                controls.setReturningAttributes(userAttributes);
                NamingEnumeration<SearchResult> answer = context.search(toDC(domainName), filter, controls);
                //toDC method splits domainName(by dot .) and adds 'DC= ,' and appends each DC
                if (answer.hasMore()) {
                    Attributes attr = answer.next().getAttributes();
                    Attribute user = attr.get("userPrincipalName");
                    if (user != null) {
                        return new User(attr);
                    }
                }
            }
        } catch (NamingException e) {
            //e.printStackTrace();
        }
        return null;
    }

    //**************************************************************************
    //** getUser
    //*************************************************************************/
    /**
     * Used to check whether a username is valid.
     *
     * @param username A username to validate (e.g. "peter", "peter@acme.com",
     * or "ACME\peter").
     */
    public static User getUser(String username, LdapContext context) {
        try {
            String domainName = null;
            if (username.contains("@")) {
                username = username.substring(0, username.indexOf("@"));
                domainName = username.substring(username.indexOf("@") + 1);
            } else if (username.contains("\\")) {
                username = username.substring(0, username.indexOf("\\"));
                domainName = username.substring(username.indexOf("\\") + 1);
            } else {
                String authenticatedUser = (String) context.getEnvironment().get(Context.SECURITY_PRINCIPAL);
                if (authenticatedUser.contains("@")) {
                    domainName = authenticatedUser.substring(authenticatedUser.indexOf("@") + 1);
                }
            }

            if (domainName != null) {
                String principalName = username + "@" + domainName;
                SearchControls controls = new SearchControls();
                controls.setSearchScope(SUBTREE_SCOPE);
                controls.setReturningAttributes(userAttributes);
                NamingEnumeration<SearchResult> answer = context.search(toDC(domainName), "(& (userPrincipalName=" + principalName + ")(objectClass=user))", controls);

                //toDC method splits domainName(by dot .) and adds 'DC= ,' and appends each DC
                if (answer.hasMore()) {
                    Attributes attr = answer.next().getAttributes();
                    System.out.println("Returned attr " + attr);
                    Attribute user = attr.get("userPrincipalName");
                    if (user != null) {
                        return new User(attr);
                    }
                }
            }
        } catch (NamingException e) {
        }
        return null;
    }

    //**************************************************************************
    //** getUsers
    //*************************************************************************/
    /**
     * Returns a list of users in the domain.
     */
    public static User[] getUsers(LdapContext context) throws NamingException {

        java.util.ArrayList<User> users = new java.util.ArrayList<User>();
        String authenticatedUser = (String) context.getEnvironment().get(Context.SECURITY_PRINCIPAL);
        if (authenticatedUser.contains("@")) {
            String domainName = "OU=ESD,OU=LBP Head Office Units,DC=corp,DC=landbank,DC=com";
            SearchControls controls = new SearchControls();
            controls.setSearchScope(SUBTREE_SCOPE);
            controls.setReturningAttributes(userAttributes);
            String searchFilter = "(objectClass=user)";
            NamingEnumeration answer = context.search((domainName), searchFilter, controls);
            try {
                while (answer.hasMore()) {
                    Attributes attr = ((SearchResult) answer.next()).getAttributes();
                    users.add(new User(attr));
                }
            } catch (Exception e) {
            }
        }
        return users.toArray(new User[users.size()]);
    }

    private static String toDC(String domainName) {
        StringBuilder buf = new StringBuilder();
        for (String token : domainName.split("\\.")) {
            if (token.length() == 0) {
                continue;   // defensive check
            }
            if (buf.length() > 0) {
                buf.append(",");
            }
            buf.append("DC=").append(token);
        }
        return buf.toString();
    }

    private static String errorCode(String errorMessage) {
        StringBuilder buf = new StringBuilder();

        String input = errorMessage;
        String[] parts = input.split(",");
        String errCode = parts[2];
        System.out.println("errCode in AD class: " + errCode.trim() + ".");

        switch (errCode.trim()) {
            case "data 52e":
                buf.append("ERROR_LOGON_FAILURE :  Invalid password!");
                break;
            case "data 525":
                buf.append("LDAP_NO_SUCH_OBJECT :  User does not exist");
                break;
            case "data 775":
                buf.append("ERROR_ACCOUNT_LOCKED_OUT :  User locked out!");
                break;
            case "data 80090346":
                buf.append("ERROR_ACCOUNT_LOCKED_OUT :  User does not exist");
                break;
            default:
                buf.append("No error.");
        }

        return buf.toString();
    }

    //**************************************************************************
    //** User Class
    //*************************************************************************/
    /**
     * Used to represent a User in Active Directory
     */
    public static class User {

        private String distinguishedName;
        private String userPrincipal;
        private String commonName;
        private String lockoutTime;
        private String memberOf;
        private String mail;
        private String badPwdCount;
        private String samaccountname;

        public User(Attributes attr) throws javax.naming.NamingException {
            userPrincipal = (String) attr.get("userPrincipalName").get();
            commonName = (String) attr.get("cn").get();
            distinguishedName = (String) attr.get("distinguishedName").get();
            lockoutTime = (String) attr.get("lockoutTime").get();
            memberOf = (String) attr.get("memberOf").get();
            mail = (String) attr.get("mail").get();
            badPwdCount = (String) attr.get("badPwdCount").get();
            samaccountname = (String) attr.get("samaccountname").get();

        }

        public String getUserPrincipal() {
            return userPrincipal;
        }

        public String getCommonName() {
            return commonName;
        }

        public String getDistinguishedName() {
            return distinguishedName;
        }

        public String getLockoutTime() {
            return lockoutTime;
        }

        public String getMemberOf() {
            return memberOf;
        }

        public String getMail() {
            return mail;
        }

        public String getBadPwdCount() {
            return badPwdCount;
        }

        public String getSamaccountname() {
            return samaccountname;
        }

        public String toString() {
            return getDistinguishedName();
        }

        /**
         * Used to change the user password. Throws an IOException if the Domain
         * Controller is not LDAPS enabled.
         *
         * @param trustAllCerts If true, bypasses all certificate and host name
         * validation. If false, ensure that the LDAPS certificate has been
         * imported into a trust store and sourced before calling this method.
         * Example: String keystore =
         * "/usr/java/jdk1.5.0_01/jre/lib/security/cacerts";
         * System.setProperty("javax.net.ssl.trustStore",keystore);
         */
        public void changePassword(String oldPass, String newPass, boolean trustAllCerts, LdapContext context)
                throws java.io.IOException, NamingException {
            String dn = getDistinguishedName();

            //Switch to SSL/TLS
            StartTlsResponse tls = null;
            try {
                tls = (StartTlsResponse) context.extendedOperation(new StartTlsRequest());
            } catch (Exception e) {
                //"Problem creating object: javax.naming.ServiceUnavailableException: [LDAP: error code 52 - 00000000: LdapErr: DSID-0C090E09, comment: Error initializing SSL/TLS, data 0, v1db0"
                throw new java.io.IOException("Failed to establish SSL connection to the Domain Controller. Is LDAPS enabled?");
            }

            //Exchange certificates
            if (trustAllCerts) {
                tls.setHostnameVerifier(DO_NOT_VERIFY);
                SSLSocketFactory sf = null;
                try {
                    SSLContext sc = SSLContext.getInstance("TLS");
                    sc.init(null, TRUST_ALL_CERTS, null);
                    sf = sc.getSocketFactory();
                } catch (java.security.NoSuchAlgorithmException e) {
                } catch (java.security.KeyManagementException e) {
                }
                tls.negotiate(sf);
            } else {
                tls.negotiate();
            }

            //Change password
            try {

                ModificationItem[] modificationItems = new ModificationItem[2];
                modificationItems[0] = new ModificationItem(DirContext.REMOVE_ATTRIBUTE, new BasicAttribute("unicodePwd", getPassword(oldPass)));
                modificationItems[1] = new ModificationItem(DirContext.ADD_ATTRIBUTE, new BasicAttribute("unicodePwd", getPassword(newPass)));
                context.modifyAttributes(dn, modificationItems);
            } catch (javax.naming.directory.InvalidAttributeValueException e) {
                String error = e.getMessage().trim();
                if (error.startsWith("[") && error.endsWith("]")) {
                    error = error.substring(1, error.length() - 1);
                }
                System.err.println(error);
                tls.close();
                throw new NamingException(
                        "New password does not meet Active Directory requirements. "
                        + "Please ensure that the new password meets password complexity, "
                        + "length, minimum password age, and password history requirements."
                );
            } catch (NamingException e) {
                tls.close();
                throw e;
            }

            //Close the TLS/SSL session
            tls.close();
        }

        private static final HostnameVerifier DO_NOT_VERIFY = new HostnameVerifier() {
            public boolean verify(String hostname, SSLSession session) {
                return true;
            }
        };

        private static TrustManager[] TRUST_ALL_CERTS = new TrustManager[]{
            new X509TrustManager() {
                public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                    return null;
                }

                public void checkClientTrusted(
                        java.security.cert.X509Certificate[] certs, String authType) {
                }

                public void checkServerTrusted(
                        java.security.cert.X509Certificate[] certs, String authType) {
                }
            }
        };

        private byte[] getPassword(String newPass) {
            String quotedPassword = "\"" + newPass + "\"";
            //return quotedPassword.getBytes("UTF-16LE");
            char unicodePwd[] = quotedPassword.toCharArray();
            byte pwdArray[] = new byte[unicodePwd.length * 2];
            for (int i = 0; i < unicodePwd.length; i++) {
                pwdArray[i * 2 + 1] = (byte) (unicodePwd[i] >>> 8);
                pwdArray[i * 2 + 0] = (byte) (unicodePwd[i] & 0xff);
            }
            return pwdArray;
        }
    }
}
