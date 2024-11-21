/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.controllers;

import gov.landbank.SFC.dao.Part5Dao;
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
@WebServlet(name = "Part5AddServlet", urlPatterns = {"/Part5AddServlet"})
public class Part5AddServlet extends HttpServlet {

    ServletContext application;
    private DataSource datasource = null;
    Connection conn = null;

    public Part5AddServlet() {
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
            
            String reqID = request.getParameter("esrequestid") == null ? "0" : request.getParameter("esrequestid");            
            String mNoRegEmployees = request.getParameter("mNoRegEmployees") == null ? "0" : request.getParameter("mNoRegEmployees");
            String fNoRegEmployees = request.getParameter("fNoRegEmployees") == null ? "0" : request.getParameter("fNoRegEmployees");
            String mNoContractEmployees = request.getParameter("mNoContractEmployees") == null ? "0" : request.getParameter("mNoContractEmployees");
            String fNoContractEmployees = request.getParameter("fNoContractEmployees") == null ? "0" : request.getParameter("fNoContractEmployees");
            String mNoSubconEmployees = request.getParameter("mNoSubconEmployees") == null ? "0" : request.getParameter("mNoSubconEmployees");
            String fNoSubconEmployees = request.getParameter("fNoSubconEmployees") == null ? "0" : request.getParameter("fNoSubconEmployees");
            String pracChildLabor = request.getParameter("pracChildLabor") == null ? "" : request.getParameter("pracChildLabor");
            String payingBelowMinWage = request.getParameter("payingBelowMinWage") == null ? "" : request.getParameter("payingBelowMinWage");
            String landUsedIP = request.getParameter("landUsedIP") == null ? "" : request.getParameter("landUsedIP");
            String landUsedIPDetail = request.getParameter("landUsedIPDetail") == null ? "" : request.getParameter("landUsedIPDetail");
            String cadtCalt = request.getParameter("cadtCalt") == null ? "" : request.getParameter("cadtCalt");
            String cadtCaltRegion = request.getParameter("cadtCaltRegion") == null ? "" : request.getParameter("cadtCaltRegion");
            String cadtCaltNo = request.getParameter("cadtCaltNo") == null ? "" : request.getParameter("cadtCaltNo");
            String ipAffected = request.getParameter("ipAffected") == null ? "" : request.getParameter("ipAffected");
            String ipAffectedDTL = request.getParameter("ipAffectedDTL") == null ? "" : request.getParameter("ipAffectedDTL");
            String arbBene = request.getParameter("arbBene") == null ? "" : request.getParameter("arbBene");
            String arbBeneDTL = request.getParameter("arbBeneDTL") == null ? "" : request.getParameter("arbBeneDTL");
            String arbBorrower = request.getParameter("arbBorrower") == null ? "" : request.getParameter("arbBorrower");
            String arbBorrowerDTL = request.getParameter("arbBorrowerDTL") == null ? "" : request.getParameter("arbBorrowerDTL");
            String operateWoAuthLandTitle = request.getParameter("operateWoAuthLandTitle") == null ? "" : request.getParameter("operateWoAuthLandTitle");
            String arbAffected = request.getParameter("arbAffected") == null ? "" : request.getParameter("arbAffected");
            String arbAffectedDTL = request.getParameter("arbAffectedDTL") == null ? "" : request.getParameter("arbAffectedDTL");
            String promoteGenderEquality = request.getParameter("promoteGenderEquality") == null ? "" : request.getParameter("promoteGenderEquality");
            String promoteGenderEqualityDTL = request.getParameter("promoteGenderEqualityDTL") == null ? "" : request.getParameter("promoteGenderEqualityDTL");
            String noWomenOwnership = request.getParameter("noWomenOwnership") == null ? "" : request.getParameter("noWomenOwnership");
            String noWomenDecisionBoard = request.getParameter("noWomenDecisionBoard") == null ? "" : request.getParameter("noWomenDecisionBoard");
            String noWomenDecisionSeniorMGMT = request.getParameter("noWomenDecisionSeniorMGMT") == null ? "" : request.getParameter("noWomenDecisionSeniorMGMT");
            String womenBene = request.getParameter("womenBene") == null ? "" : request.getParameter("womenBene");
            String womenBeneDTL = request.getParameter("womenBeneDTL") == null ? "" : request.getParameter("womenBeneDTL");
            String womenLongTermImpact = request.getParameter("womenLongTermImpact") == null ? "" : request.getParameter("womenLongTermImpact");
            String womenLongTermImpactDTL = request.getParameter("womenLongTermImpactDTL") == null ? "" : request.getParameter("womenLongTermImpactDTL");
            String womenMinImpact = request.getParameter("womenMinImpact") == null ? "" : request.getParameter("womenMinImpact");
            String womenMinImpactDTL = request.getParameter("womenMinImpactDTL") == null ? "" : request.getParameter("womenMinImpactDTL");
            String improvePrac = request.getParameter("improvePrac") == null ? "" : request.getParameter("improvePrac");
            String improvePracDTL = request.getParameter("improvePracDTL") == null ? "" : request.getParameter("improvePracDTL");
            
            
            Part5Dao pdserv = new Part5Dao(conn);
            json.put("res", pdserv.create(reqID, mNoRegEmployees, fNoRegEmployees, mNoContractEmployees, 
                    fNoContractEmployees, mNoSubconEmployees, fNoSubconEmployees, pracChildLabor, payingBelowMinWage, 
                    landUsedIP, landUsedIPDetail, cadtCalt, cadtCaltRegion, cadtCaltNo, 
                    ipAffected, ipAffectedDTL, arbBene, arbBeneDTL, arbBorrower,
                    arbBorrowerDTL, operateWoAuthLandTitle, arbAffected, arbAffectedDTL, promoteGenderEquality,
                    promoteGenderEqualityDTL, noWomenOwnership, noWomenDecisionBoard, noWomenDecisionSeniorMGMT, womenBene,
                    womenBeneDTL, womenLongTermImpact, womenLongTermImpactDTL, womenMinImpact, womenMinImpactDTL,
                    improvePrac, improvePracDTL));
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
            Logger.getLogger(Part5AddServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            Logger.getLogger(Part5AddServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Part5AddServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            Logger.getLogger(Part5AddServlet.class.getName()).log(Level.SEVERE, null, ex);
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
