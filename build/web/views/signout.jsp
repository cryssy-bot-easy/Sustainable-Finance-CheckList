<%-- 
    Document   : signout
    Created on : 04 29, 21, 5:33:21 PM
    Author     : F862
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>  
<%

    session = request.getSession();
    String session_user = "";
    String session_isadmin = "";
    //String session_isactive = "";
    //String session_designation = "";
    //String session_team = "";
    //String session_department = "";
    
    //String username = request.getParameter("username");
    //String isadmin = (String) request.getAttribute("isadmin");

    if (session.getAttribute("session_user") == null || session.getAttribute("session_user") == "" || session.getAttribute("session_user").equals("")) {
        response.sendRedirect("/SFC/login");
    } else {
        session_user = session.getAttribute("session_user").toString();
        session_isadmin = session.getAttribute("session_isadmin").toString();
           
    }

%>     

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Sign Out Page</h1>
        <%
                    //session.setAttribute("status", status);
                    //session.setAttribute("message", message);
                    //session.setAttribute("username", username.toUpperCase());
                    //session.setAttribute("distinguishedName", distinguishedName);
                    //session.setAttribute("commonName", commonName);
                    //session.setAttribute("email", email);
                    //session.setAttribute("memberof", memberof);
                    //session.setAttribute("userprincipal", userprincipal);           
            
            System.out.println("sign out page");
            if (session.getAttribute("session_user") != null) {                
                session.removeAttribute("session_user");
                session.removeAttribute("session_isadmin");
                session.removeAttribute("session_pword");
                session.removeAttribute("session_domain");
                session.removeAttribute("status");
                session.removeAttribute("message");
                session.removeAttribute("username");
                session.removeAttribute("distinguishedName");
                session.removeAttribute("commonName");
                session.removeAttribute("email");
                session.removeAttribute("memberof");
                session.removeAttribute("userprincipal");     
                session.removeAttribute("status");
                session.removeAttribute("message");                   
                request.getSession(false);
                session.setAttribute("session_user", null);
		session.setAttribute("session_isadmin", null);
                session.setAttribute("status", null);
                session.setAttribute("message", null);
                session.setAttribute("username", null);
                session.setAttribute("distinguishedName", null);
                session.setAttribute("commonName", null);
                session.setAttribute("email", null);
                session.setAttribute("memberof", null);
                session.setAttribute("userprincipal", null); 
                session.setAttribute("session_pword", null);
                session.setAttribute("session_domain", null);      
                session.setAttribute("status", null);
                session.setAttribute("message", null);                
                session.invalidate();
                System.out.println("sign out page");
                request.setAttribute("username", null);                        
                request.setAttribute("isadmin", null);                        
                response.sendRedirect("/SFC/login");                
            }
        %>     
    </body>
        <script>
        $(document).ready(function () {
            function disableBack() {
                window.history.forward();
            }

            window.onload = disableBack();
            window.onpageshow = function (evt) {
                if (evt.persisted)
                    disableBack();
            };
        });
    </script>  
</html>
