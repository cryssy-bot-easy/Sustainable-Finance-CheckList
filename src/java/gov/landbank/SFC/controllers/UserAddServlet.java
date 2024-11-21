/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.controllers;

import gov.landbank.SFC.models.User;
//import gov.landbank.RMLG.services.LoginService;
//import gov.landbank.RMLG.services.UserActivityService;
import gov.landbank.SFC.dao.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
@WebServlet(name = "UserAddServlet", urlPatterns = {"/UserAddServlet"})
public class UserAddServlet extends HttpServlet {

    ServletContext application;
    private DataSource datasource = null;
    Connection conn = null;

    public UserAddServlet() {
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
        try {

            conn = datasource.getConnection();

            String uname = request.getParameter("uname") == null ? "" : request.getParameter("uname");
            String fullname = request.getParameter("fullname") == null ? "" : request.getParameter("fullname");
            String email = request.getParameter("email") == null ? "" : request.getParameter("email");
            String status1 = request.getParameter("status") == null ? "" : request.getParameter("status");
            String userrole = request.getParameter("userrole") == null ? "" : request.getParameter("userrole");
            String useraccess = request.getParameter("useraccess") == null ? "" : request.getParameter("useraccess");
            String department = request.getParameter("department") == null ? "" : request.getParameter("department");
            String createdby = request.getParameter("createdby") == null ? "" : request.getParameter("createdby");
                        
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = new Date();
            //System.out.println(formatter.format(date));              
            String createddate = formatter.format(date);

            UserDao userv = new UserDao(conn);
            String exist = userv.checkUserExist(uname);
            if ("fail".equals(exist)) {
                //UserService userserv = new UserService(conn);

                json.put("res", userv.create(uname, fullname, email, userrole, department, status1, createdby, createddate, useraccess).toString());

                System.out.println(json);
                System.out.println(json.get("res"));

                //String recordid = json.get("res").toString().substring(5);                
                //String status = json.get("res").toString().substring(0, 5);
                //int record_id = Integer.parseInt(recordid);
                /*
                UserActivityService uaserv = new UserActivityService(conn);
                if (status.equals("added")) {
                    uaserv.create(createdby.toUpperCase(), "insert", "USER_ACCOUNTS", "USERNAME", uname, "", record_id, activestat);
                }
                 */
            } else {
                json.put("res", "Exist");
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
            Logger.getLogger(UserAddServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            Logger.getLogger(UserAddServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(UserAddServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            Logger.getLogger(UserAddServlet.class.getName()).log(Level.SEVERE, null, ex);
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
