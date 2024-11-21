/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author F862
 */
@WebServlet(name = "ViewMaintenance", urlPatterns = {"/ViewMaintenance"})
public class ViewMaintenance extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        //session.getAttribute("session_user");
        //session.getAttribute("session_isadmin");
        try {
            String username = (String) session.getAttribute("session_user"); //request.getParameter("username");            
            String isadmin = (String) session.getAttribute("session_isadmin");//request.getParameter("isadmin");            


            System.out.println(username);
            if (username == null || username == "" || username.equals("")) {
                response.sendRedirect("/SFC/login");
            } else if ((username != null || username != "" || !username.equals("")) && isadmin == "false") {
                request.setAttribute("username", username);
                request.setAttribute("isadmin", isadmin);
                session.setAttribute("session_user", username);
                session.setAttribute("session_isadmin", isadmin);

                RequestDispatcher rd = request.getRequestDispatcher("/views/main.jsp");
                rd.forward(request, response);
            } else {
                request.setAttribute("username", username);
                request.setAttribute("isadmin", isadmin);
                session.setAttribute("session_user", username);
                session.setAttribute("session_isadmin", isadmin);

                RequestDispatcher rd = request.getRequestDispatcher("/views/maintenance.jsp");
                rd.forward(request, response);
            }

        } catch (Exception e) {
            System.out.println("ViewMaintenance Servleterror " + e);
        } finally {

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
