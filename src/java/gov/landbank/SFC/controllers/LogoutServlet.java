/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.controllers;

//import gov.landbank.RMLG.services.UserActivityService;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

/**
 *
 * @author F862
 */
@WebServlet(name = "logout", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    ServletContext application;
    private DataSource datasource = null;
    Connection conn = null;

    public LogoutServlet() {
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
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        //String username = request.getParameter("username");
        String username = (String) session.getAttribute("session_user"); //request.getParameter("username");            
        String isadmin = (String) session.getAttribute("session_isadmin");//request.getParameter("isadmin");                        
        //String isactive = (String) session.getAttribute("session_isactive");//request.getParameter("isadmin");                        

        if (username == null || username == "" || username.equals("")) {
            response.sendRedirect("/SFC/login");
        } else {

            try {
                conn = datasource.getConnection();
                request.setAttribute("username", username);
                request.setAttribute("isadmin", isadmin);
                session.setAttribute("session_user", username);
                session.setAttribute("session_isadmin", isadmin);
                //UserActivityService uaserv = new UserActivityService(conn);
                //uaserv.create(username.toUpperCase(), "logout", "", "", "", "", 0, isactive);
                RequestDispatcher rd = request.getRequestDispatcher("/views/signout.jsp");
                rd.forward(request, response);
            } catch (Exception e) {
                System.out.println("logout Servleterror " + e);
            } finally {

            }

        }

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
        processRequest(request, response);
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
        processRequest(request, response);
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
