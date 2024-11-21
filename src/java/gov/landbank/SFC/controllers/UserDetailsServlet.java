/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.controllers;

import gov.landbank.SFC.dao.ActiveDirectory;
import gov.landbank.SFC.models.User;
import gov.landbank.SFC.dao.UserDao;
//import gov.landbank.RMLG.services.UserActivityService;
//import gov.landbank.RMLG.services.UserService;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.naming.ldap.LdapContext;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author F862
 */
@WebServlet(name = "UserDetailsServlet", urlPatterns = {"/UserDetailsServlet"})
public class UserDetailsServlet extends HttpServlet {

    ServletContext application;
    private DataSource datasource = null;
    Connection conn = null;

    public UserDetailsServlet() {
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
            throws ServletException, IOException, NamingException, JSONException {
        JSONObject json = new JSONObject();
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("session_user"); //request.getParameter("username");
        String password = (String) session.getAttribute("session_pword");//request.getParameter("isadmin");
        String domain = (String) session.getAttribute("session_domain");
        String email = null;
        String fullname = null;
        //String department = null;
        boolean passed = false;
        String message = null;
        String uname = request.getParameter("uname") == null ? "" : request.getParameter("uname");
        LdapContext ctx = ActiveDirectory.getConnection(username, password, domain);
        System.out.println("session username details" + username);
        System.out.println("username for details" + uname);
        //System.out.println(ctx);
        //System.out.println(ActiveDirectory.getUser(username, ctx));

        try {
            conn = datasource.getConnection();

            if (ActiveDirectory.getUser(uname, ctx) != null) {
                passed = true;
                fullname = ActiveDirectory.getUser(uname, ctx).getCommonName();
                email = ActiveDirectory.getUser(uname, ctx).getMail();
                //department = ActiveDirectory.getUser(uname, ctx).getDepartment();
                UserDao userv = new UserDao(conn);                
                String exist = userv.checkUserExist(uname);
                if ("fail".equals(exist)) {
                    message = "User Found";
                    json.put("res", "Exist");
                    json.put("message", message);
                    json.put("fullname", fullname);
                    json.put("email", email);
                    //json.put("department", department);
                    //System.out.println(json);
                    //System.out.println(json.get("res"));                
                } else {
                    message = "User already enrolled";
                    json.put("res", "test");
                    json.put("message", message);
                    json.put("fullname", fullname);
                    json.put("email", email);
                    //json.put("department", department);
                }
            } else {
                //change value to false when prod
                passed = false;
                json.put("res", "Not Found");
                message = "User Not Found";
                json.put("message", message);
            }
            System.out.println(json.get("message"));
            ctx.close();
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    /* ignored */
                }
            }
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
        } catch (NamingException ex) {
            Logger.getLogger(UserDetailsServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            Logger.getLogger(UserDetailsServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (NamingException ex) {
            Logger.getLogger(UserDetailsServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            Logger.getLogger(UserDetailsServlet.class.getName()).log(Level.SEVERE, null, ex);
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
