/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.controllers;

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
@WebServlet(name = "ViewWelcome", urlPatterns = {"/welcome"})
public class ViewWelcome extends HttpServlet {

    ServletContext application;
    private DataSource datasource = null;
    Connection conn = null;

    public ViewWelcome() {
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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String ssusername = (String) session.getAttribute("session_user"); //request.getParameter("username");            
        String ssisadmin = (String) session.getAttribute("session_isadmin");//request.getParameter("isadmin");
        String username = (String) session.getAttribute("username");
        String distinguishedName = (String) session.getAttribute("distinguishedName");
        String commonName = (String) session.getAttribute("commonName");
        String email = (String) session.getAttribute("email");
        String memberof = (String) session.getAttribute("memberof");
        String userprincipal = (String) session.getAttribute("userprincipal");
        //String isadmin = (String) request.getAttribute("isadmin");
        //String status = (String) session.getAttribute("status");

        if (ssusername == null || ssusername == "" || ssusername.equals("")) {

            response.sendRedirect("/SFC/login");

        } else {
            session.setAttribute("session_user", ssusername);
            session.setAttribute("session_isadmin", ssisadmin);
            session.setAttribute("username", username);
            session.setAttribute("distinguishedName", distinguishedName);
            session.setAttribute("commonName", commonName);
            session.setAttribute("email", email);
            session.setAttribute("memberof", memberof);
            session.setAttribute("userprincipal", userprincipal);

            RequestDispatcher rd = request.getRequestDispatcher("/views/main.jsp");
            rd.forward(request, response);

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
