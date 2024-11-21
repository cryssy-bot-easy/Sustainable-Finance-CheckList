/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.controllers;

import gov.landbank.SFC.dao.Part2Dao;
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
@WebServlet(name = "Part2AddServlet", urlPatterns = {"/Part2AddServlet"})
public class Part2AddServlet extends HttpServlet {

    ServletContext application;
    private DataSource datasource = null;
    Connection conn = null;

    public Part2AddServlet() {
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
            //String lendinv = request.getParameter("lendinv") == null ? "" : request.getParameter("lendinv");
            String esrequestid = request.getParameter("esrequestid") == null ? "" : request.getParameter("esrequestid");
            String sectorprioritysector = request.getParameter("sectorprioritysector") == null ? "" : request.getParameter("sectorprioritysector");
            String typeofinvestmentsubsector = request.getParameter("typeofinvestmentsubsector") == null ? "" : request.getParameter("typeofinvestmentsubsector");
            String typeinvothers = request.getParameter("typeinvothers") == null ? "" : request.getParameter("typeinvothers");
            String availlendprog = request.getParameter("availlendprog") == null ? "" : request.getParameter("availlendprog");
            String lendingprogramcode = request.getParameter("lendingprogramcode") == null ? "0" : request.getParameter("lendingprogramcode");
            String group1_1 = request.getParameter("group1_1") == null ? "" : request.getParameter("group1_1");
            String group1_2 = request.getParameter("group1_2") == null ? "" : request.getParameter("group1_2");
            String group1_3 = request.getParameter("group1_3") == null ? "" : request.getParameter("group1_3");
            String group2_1 = request.getParameter("group2_1") == null ? "" : request.getParameter("group2_1");
            String group2_2 = request.getParameter("group2_2") == null ? "" : request.getParameter("group2_2");
            String group2_3 = request.getParameter("group2_3") == null ? "" : request.getParameter("group2_3");
            String group2_4 = request.getParameter("group2_4") == null ? "" : request.getParameter("group2_4");
            String group2_5 = request.getParameter("group2_5") == null ? "" : request.getParameter("group2_5");
            String group2_6 = request.getParameter("group2_6") == null ? "" : request.getParameter("group2_6");
            String group3_1 = request.getParameter("group3_1") == null ? "" : request.getParameter("group3_1");
            String group3_2 = request.getParameter("group3_2") == null ? "" : request.getParameter("group3_2");
            String group3_3 = request.getParameter("group3_3") == null ? "" : request.getParameter("group3_3");
            String group4_1 = request.getParameter("group4_1") == null ? "" : request.getParameter("group4_1");
            String group4_2 = request.getParameter("group4_2") == null ? "" : request.getParameter("group4_2");
            String group4_3 = request.getParameter("group4_3") == null ? "" : request.getParameter("group4_3");
            String group4_4 = request.getParameter("group4_4") == null ? "" : request.getParameter("group4_4");
            String group4_5 = request.getParameter("group4_5") == null ? "" : request.getParameter("group4_5");
            String group4_6 = request.getParameter("group4_6") == null ? "" : request.getParameter("group4_6");
            String group5_1 = request.getParameter("group5_1") == null ? "" : request.getParameter("group5_1");
            String group6_1 = request.getParameter("group6_1") == null ? "" : request.getParameter("group6_1");
            String group6_2 = request.getParameter("group6_2") == null ? "" : request.getParameter("group6_2");
            String group6_3 = request.getParameter("group6_3") == null ? "" : request.getParameter("group6_3");
            String group7_1 = request.getParameter("group7_1") == null ? "" : request.getParameter("group7_1");
            String group7_2 = request.getParameter("group7_2") == null ? "" : request.getParameter("group7_2");
            String group7_3 = request.getParameter("group7_3") == null ? "" : request.getParameter("group7_3");
            String group7_4 = request.getParameter("group7_4") == null ? "" : request.getParameter("group7_4");
            String group7_5 = request.getParameter("group7_5") == null ? "" : request.getParameter("group7_5");
            String group7_6 = request.getParameter("group7_6") == null ? "" : request.getParameter("group7_6");
            String group8_1 = request.getParameter("group8_1") == null ? "" : request.getParameter("group8_1");
            String group8_2 = request.getParameter("group8_2") == null ? "" : request.getParameter("group8_2");
            String group8_3 = request.getParameter("group8_3") == null ? "" : request.getParameter("group8_3");
            String group8_4 = request.getParameter("group8_4") == null ? "" : request.getParameter("group8_4");
            String group8_5 = request.getParameter("group8_5") == null ? "" : request.getParameter("group8_5");
            String group9_1 = request.getParameter("group9_1") == null ? "" : request.getParameter("group9_1");
            String group9_2 = request.getParameter("group9_2") == null ? "" : request.getParameter("group9_2");
            String group9_3 = request.getParameter("group9_3") == null ? "" : request.getParameter("group9_3");
            String group9_4 = request.getParameter("group9_4") == null ? "" : request.getParameter("group9_4");
            String group10_1 = request.getParameter("group10_1") == null ? "" : request.getParameter("group10_1");
            String group10_2 = request.getParameter("group10_2") == null ? "" : request.getParameter("group10_2");
            String group11_1 = request.getParameter("group11_1") == null ? "" : request.getParameter("group11_1");
            String group11_1_others = request.getParameter("group11_1_others") == null ? "" : request.getParameter("group11_1_others");
            String group11_2 = request.getParameter("group11_2") == null ? "" : request.getParameter("group11_2");
            String group11_3 = request.getParameter("group11_3") == null ? "" : request.getParameter("group11_3");
            String group12_1 = request.getParameter("group12_1") == null ? "" : request.getParameter("group12_1");
            String group12_2 = request.getParameter("group12_2") == null ? "" : request.getParameter("group12_2");
            String group12_3 = request.getParameter("group12_3") == null ? "" : request.getParameter("group12_3");
            String group13_1 = request.getParameter("group13_1") == null ? "" : request.getParameter("group13_1");
            String group13_2 = request.getParameter("group13_2") == null ? "" : request.getParameter("group13_2");
            String group13_3 = request.getParameter("group13_3") == null ? "" : request.getParameter("group13_3");
            String group14_1 = request.getParameter("group14_1") == null ? "" : request.getParameter("group14_1");
            String group14_2 = request.getParameter("group14_2") == null ? "" : request.getParameter("group14_2");
            String group14_3 = request.getParameter("group14_3") == null ? "" : request.getParameter("group14_3");
            String group14_4 = request.getParameter("group14_4") == null ? "" : request.getParameter("group14_4");
            String group14_5 = request.getParameter("group14_5") == null ? "" : request.getParameter("group14_5");
            String group15_1 = request.getParameter("group15_1") == null ? "" : request.getParameter("group15_1");
            String group16_1 = request.getParameter("group16_1") == null ? "" : request.getParameter("group16_1");
            String group16_2 = request.getParameter("group16_2") == null ? "" : request.getParameter("group16_2");
            String group16_3 = request.getParameter("group16_3") == null ? "" : request.getParameter("group16_3");
            String group16_4 = request.getParameter("group16_4") == null ? "" : request.getParameter("group16_4");
            String group17_1 = request.getParameter("group17_1") == null ? "" : request.getParameter("group17_1");
            String group17_2 = request.getParameter("group17_2") == null ? "" : request.getParameter("group17_2");
            String group17_3 = request.getParameter("group17_3") == null ? "" : request.getParameter("group17_3");
            String group17_4 = request.getParameter("group17_4") == null ? "" : request.getParameter("group17_4");
            String group18_1 = request.getParameter("group18_1") == null ? "" : request.getParameter("group18_1");
            String group18_2 = request.getParameter("group18_2") == null ? "" : request.getParameter("group18_2");
            String group18_3 = request.getParameter("group18_3") == null ? "" : request.getParameter("group18_3");
            String group18_4 = request.getParameter("group18_4") == null ? "" : request.getParameter("group18_4");
            String group18_5 = request.getParameter("group18_5") == null ? "" : request.getParameter("group18_5");
            String GP1 = request.getParameter("GP1") == null ? "" : request.getParameter("GP1");
            String GP2 = request.getParameter("GP2") == null ? "" : request.getParameter("GP2");
            String GP3 = request.getParameter("GP3") == null ? "" : request.getParameter("GP3");
            String GP4 = request.getParameter("GP4") == null ? "" : request.getParameter("GP4");
            String GP5 = request.getParameter("GP5") == null ? "" : request.getParameter("GP5");
            String GP6 = request.getParameter("GP6") == null ? "" : request.getParameter("GP6");
            String GP7 = request.getParameter("GP7") == null ? "" : request.getParameter("GP7");
            String SDG1 = request.getParameter("SDG1") == null ? "" : request.getParameter("SDG1");
            String SDG2 = request.getParameter("SDG2") == null ? "" : request.getParameter("SDG2");
            String SDG3 = request.getParameter("SDG3") == null ? "" : request.getParameter("SDG3");
            String SDG4 = request.getParameter("SDG4") == null ? "" : request.getParameter("SDG4");
            String SDG5 = request.getParameter("SDG5") == null ? "" : request.getParameter("SDG5");
            String SDG6 = request.getParameter("SDG6") == null ? "" : request.getParameter("SDG6");
            String SDG7 = request.getParameter("SDG7") == null ? "" : request.getParameter("SDG7");
            String SDG8 = request.getParameter("SDG8") == null ? "" : request.getParameter("SDG8");
            String SDG9 = request.getParameter("SDG9") == null ? "" : request.getParameter("SDG9");
            String SDG10 = request.getParameter("SDG10") == null ? "" : request.getParameter("SDG10");
            String SDG11 = request.getParameter("SDG11") == null ? "" : request.getParameter("SDG11");
            String SDG12 = request.getParameter("SDG12") == null ? "" : request.getParameter("SDG12");
            String SDG13 = request.getParameter("SDG13") == null ? "" : request.getParameter("SDG13");
            String SDG14 = request.getParameter("SDG14") == null ? "" : request.getParameter("SDG14");
            String SDG15 = request.getParameter("SDG15") == null ? "" : request.getParameter("SDG15");
            String SDG16 = request.getParameter("SDG16") == null ? "" : request.getParameter("SDG16");
            String SDG17 = request.getParameter("SDG17") == null ? "" : request.getParameter("SDG17");
            String SDG18 = request.getParameter("SDG18") == null ? "" : request.getParameter("SDG18");
            String programgroupcode = request.getParameter("programgroupcode") == null ? "0" : request.getParameter("programgroupcode");
            String lendinv = request.getParameter("lendinv") == null ? "" : request.getParameter("lendinv");
             
            if (lendinv.equals("Investment")) {
                group1_1 = "";
                group1_2 = "";
                group1_3 = "";
                group2_1 = "";
                group2_2 = "";
                group2_3 = "";
                group2_4 = "";
                group2_5 = "";
                group2_6 = "";
                group3_1 = "";
                group3_2 = "";
                group3_3 = "";
                group4_1 = "";
                group4_2 = "";
                group4_3 = "";
                group4_4 = "";
                group4_5 = "";
                group4_6 = "";
                group5_1 = "";
                group6_1 = "";
                group6_2 = "";
                group6_3 = "";
                group7_1 = "";
                group7_2 = "";
                group7_3 = "";
                group7_4 = "";
                group7_5 = "";
                group7_6 = "";
                group8_1 = "";
                group8_2 = "";
                group8_3 = "";
                group8_4 = "";
                group8_5 = "";
                group9_1 = "";
                group9_2 = "";
                group9_3 = "";
                group9_4 = "";
                group10_1 = "";
                group10_2 = "";
                group11_1 = "";
                group11_1_others = "";
                group11_2 = "";
                group11_3 = "";
                group12_1 = "";
                group12_2 = "";
                group12_3 = "";
                group13_1 = "";
                group13_2 = "";
                group13_3 = "";
                group14_1 = "";
                group14_2 = "";
                group14_3 = "";
                group14_4 = "";
                group14_5 = "";
                group15_1 = "";
                group16_1 = "";
                group16_2 = "";
                group16_3 = "";
                group16_4 = "";
                group17_1 = "";
                group17_2 = "";
                group17_3 = "";
                group17_4 = "";
                group18_1 = "";
                group18_2 = "";
                group18_3 = "";
                group18_4 = "";
                group18_5 = "";   
                lendingprogramcode = "0";
            }                    
            
            Part2Dao pdserv = new Part2Dao(conn);
            json.put("res", pdserv.create(esrequestid, sectorprioritysector, typeofinvestmentsubsector, typeinvothers, availlendprog, lendingprogramcode, group1_1, 
                group1_2, group1_3, group2_1, group2_2, group2_3, group2_4, group2_5, group2_6, group3_1, group3_2, group3_3, group4_1, group4_2, group4_3, group4_4, 
                group4_5, group4_6, group5_1, group6_1, group6_2, group6_3, group7_1, group7_2, group7_3, group7_4, group7_5, group7_6, group8_1, group8_2, group8_3, 
                group8_4, group8_5, group9_1, group9_2, group9_3, group9_4, group10_1, group10_2, group11_1, group11_1_others, group11_2, group11_3, group12_1, group12_2, 
                group12_3, group13_1, group13_2, group13_3, group14_1, group14_2, group14_3, group14_4, group14_5, group15_1, group16_1, group16_2, group16_3, group16_4, 
                group17_1, group17_2, group17_3, group17_4, group18_1, group18_2, group18_3, group18_4, group18_5, GP1, GP2, GP3, GP4, GP5, GP6, GP7, SDG1, SDG2, SDG3, SDG4, 
                SDG5, SDG6, SDG7, SDG8, SDG9, SDG10, SDG11, SDG12, SDG13, SDG14, SDG15, SDG16, SDG17, SDG18));
            String recordid = json.get("res").toString().substring(5);
            System.out.println(json);
            System.out.println(json.get("res"));

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
            Logger.getLogger(Part2AddServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            Logger.getLogger(Part2AddServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Part2AddServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            Logger.getLogger(Part2AddServlet.class.getName()).log(Level.SEVERE, null, ex);
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
