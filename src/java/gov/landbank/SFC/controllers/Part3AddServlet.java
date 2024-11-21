/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.controllers;

import gov.landbank.SFC.dao.Part3Dao;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
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
@WebServlet(name = "Part3AddServlet", urlPatterns = {"/Part3AddServlet"})
public class Part3AddServlet extends HttpServlet {

    ServletContext application;
    private DataSource datasource = null;
    Connection conn = null;

    public Part3AddServlet() {
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
            String alignsdg = request.getParameter("alignsdg") == null ? "" : request.getParameter("alignsdg");
            String lguprojectcode = request.getParameter("lguprojectcode") == null ? "0" : request.getParameter("lguprojectcode");
            String esrequestid = request.getParameter("esrequestid") == null ? "0" : request.getParameter("esrequestid");

            Part3Dao pdserv = new Part3Dao(conn);
            json.put("res", pdserv.create(esrequestid, lguprojectcode, alignsdg));
            System.out.println(json);

        } catch (SQLException e) {
            throw new ServletException(e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
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
            Logger.getLogger(Part3AddServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            Logger.getLogger(Part3AddServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Part3AddServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            Logger.getLogger(Part3AddServlet.class.getName()).log(Level.SEVERE, null, ex);
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
