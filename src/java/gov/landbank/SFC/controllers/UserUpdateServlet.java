/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.controllers;

import gov.landbank.SFC.models.User;
import gov.landbank.SFC.dao.UserDao;
//import gov.landbank.RMLG.services.UserActivityService;
//import gov.landbank.RMLG.services.UserService;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author F862
 */
@WebServlet(name = "UserUpdateServlet", urlPatterns = {"/UserUpdateServlet"})
public class UserUpdateServlet extends HttpServlet {

    ServletContext application;
    private DataSource datasource = null;
    Connection conn = null;

    public UserUpdateServlet() {
    }

    @Override
    public void init(ServletConfig config) {
        try {
            super.init(config);
            datasource = (DataSource) getServletContext().getAttribute("SFCDSN");
            application = config.getServletContext();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e);
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, JSONException, NamingException {
        JSONObject json = new JSONObject();
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            conn = datasource.getConnection();

            int userid = Integer.parseInt(request.getParameter("userid"));
            String uname = request.getParameter("uname") == null ? "" : request.getParameter("uname");
            String fullname = request.getParameter("fullname") == null ? "" : request.getParameter("fullname");
            String email = request.getParameter("email") == null ? "" : request.getParameter("email");
            String status1 = request.getParameter("status") == null ? "" : request.getParameter("status");
            String userrole = request.getParameter("userrole") == null ? "" : request.getParameter("userrole");
            String useraccess = request.getParameter("useraccess") == null ? "" : request.getParameter("useraccess");
            String department = request.getParameter("department") == null ? "" : request.getParameter("department");
/*
            LoginService userv = new LoginService(conn);
            ArrayList<User> user = userv.getUser(uname);
            int dbuserid = user.get(0).getUserID();
            String dbuname = user.get(0).getUsername() == null ? "" : user.get(0).getUsername();
            String dbfirstname = user.get(0).getFirstName() == null ? "" : user.get(0).getFirstName();
            String dblastname = user.get(0).getLastName() == null ? "" : user.get(0).getLastName();
            String dbuserdesignation = user.get(0).getUserDesignation() == null ? "" : user.get(0).getUserDesignation();
            String dbuserrole = user.get(0).getUserRole() == null ? "" : user.get(0).getUserRole();
            Boolean bisadmin = user.get(0).isIsAdmin();
            String dbisadmin = bisadmin == true ? "true" : "false";
            String dbdepartment = user.get(0).getDepartment() == null ? "" : user.get(0).getDepartment();
            String dbteam = user.get(0).getTeam() == null ? "" : user.get(0).getTeam();
            String dbgroup = user.get(0).getGroup() == null ? "" : user.get(0).getGroup();
*/
            //UserActivityService uaserv = new UserActivityService(conn);

            UserDao userserv = new UserDao(conn);

            json.put("res", userserv.update(userid, uname, fullname, email, userrole, department, status1, useraccess).toString());
                                            
            String status = json.get("res").toString();
            /*
            if (status.equals("updated")) {
                if (!dbuname.equals(uname)) {
                    uaserv.create(createdby.toUpperCase(), "update", "USER_ACCOUNTS", "USERNAME", dbuname, uname, userid, activestat);
                }
                if (!dbfirstname.equals(firstname)) {
                    uaserv.create(createdby.toUpperCase(), "update", "USER_ACCOUNTS", "FIRSTNAME", dbfirstname, firstname, userid, activestat);
                }
                if (!dblastname.equals(lastname)) {
                    uaserv.create(createdby.toUpperCase(), "update", "USER_ACCOUNTS", "LASTNAME", dblastname, lastname, userid, activestat);
                }
                if (!dbuserdesignation.equals(userdesignation)) {
                    uaserv.create(createdby.toUpperCase(), "update", "USER_ACCOUNTS", "USER_DESIGNATION", dbuserdesignation, userdesignation, userid, activestat);
                }
                if (!dbuserrole.equals(userrole)) {
                    uaserv.create(createdby.toUpperCase(), "update", "USER_ACCOUNTS", "USER_ROLE", dbuserrole, userrole, userid, activestat);
                }
                if (!dbisadmin.equals(isadmin)) {
                    uaserv.create(createdby.toUpperCase(), "update", "USER_ACCOUNTS", "IS_ADMIN", dbisadmin, isadmin, userid, activestat);
                }
                if (!dbdepartment.equals(department)) {
                    uaserv.create(createdby.toUpperCase(), "update", "USER_ACCOUNTS", "DEPARTMENT", dbdepartment, department, userid, activestat);
                }
                if (!dbteam.equals(team)) {
                    uaserv.create(createdby.toUpperCase(), "update", "USER_ACCOUNTS", "TEAM", dbteam, team, userid, activestat);
                }
                if (!dbgroup.equals(group)) {
                    uaserv.create(createdby.toUpperCase(), "update", "USER_ACCOUNTS", "GROUP", dbgroup, group, userid, activestat);
                }                
            }
            */
            System.out.println(json);
            System.out.println(json.get("res"));

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException(e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    /* ignored */
                }
            }
        }

        out.print(json);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (JSONException ex) {
            Logger.getLogger(UserUpdateServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(UserUpdateServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (JSONException ex) {
            Logger.getLogger(UserUpdateServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(UserUpdateServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
