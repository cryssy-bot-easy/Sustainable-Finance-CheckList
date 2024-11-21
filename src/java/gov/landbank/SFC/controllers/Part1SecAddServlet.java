/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.controllers;

import gov.landbank.SFC.dao.Part1Dao;
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
@WebServlet(name = "Part1SecAddServlet", urlPatterns = {"/Part1SecAddServlet"})
public class Part1SecAddServlet extends HttpServlet {

    ServletContext application;
    private DataSource datasource = null;
    Connection conn = null;

    public Part1SecAddServlet() {
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
            String lendinv = request.getParameter("lendinv") == null ? "" : request.getParameter("lendinv");
            String investmentloanid = request.getParameter("investmentloanid") == null ? "" : request.getParameter("investmentloanid");
            String securityname = request.getParameter("securityname") == null ? "" : request.getParameter("securityname");
            String issuer = request.getParameter("issuer") == null ? "" : request.getParameter("issuer");
            String useofproceeds = request.getParameter("useofproceeds") == null ? "" : request.getParameter("useofproceeds");
            String accountname = request.getParameter("accountname") == null ? "" : request.getParameter("accountname");
            String indvcorp = request.getParameter("indvcorp") == null ? "" : request.getParameter("indvcorp");
            String firstname = request.getParameter("firstname") == null ? "" : request.getParameter("firstname");
            String middlename = request.getParameter("middlename") == null ? "" : request.getParameter("middlename");
            String lastname = request.getParameter("lastname") == null ? "" : request.getParameter("lastname");
            String suffix = request.getParameter("suffix") == null ? "" : request.getParameter("suffix");
            String financedproject = request.getParameter("financedproject") == null ? "" : request.getParameter("financedproject");
            String room = request.getParameter("room") == null ? "" : request.getParameter("room");
            String lot = request.getParameter("lot") == null ? "" : request.getParameter("lot");
            String buildingname = request.getParameter("buildingname") == null ? "" : request.getParameter("buildingname");
            String street = request.getParameter("street") == null ? "" : request.getParameter("street");
            String subdivision = request.getParameter("subdivision") == null ? "" : request.getParameter("subdivision");
            String region = request.getParameter("region") == null ? "" : request.getParameter("region");
            String province = request.getParameter("province") == null ? "" : request.getParameter("province");
            String city = request.getParameter("city") == null ? "" : request.getParameter("city");
            String district = request.getParameter("district") == null ? "" : request.getParameter("district");
            String brgy = request.getParameter("brgy") == null ? "" : request.getParameter("brgy");
            String postalcode = request.getParameter("postalcode") == null ? "" : request.getParameter("postalcode");
            String roomproj = request.getParameter("roomproj") == null ? "" : request.getParameter("roomproj");
            String lotproj = request.getParameter("lotproj") == null ? "" : request.getParameter("lotproj");
            String buildingnameproj = request.getParameter("buildingnameproj") == null ? "" : request.getParameter("buildingnameproj");
            String streetproj = request.getParameter("streetproj") == null ? "" : request.getParameter("streetproj");
            String subdivisionproj = request.getParameter("subdivisionproj") == null ? "" : request.getParameter("subdivisionproj");
            String regionproj = request.getParameter("regionproj") == null ? "" : request.getParameter("regionproj");
            String provinceproj = request.getParameter("provinceproj") == null ? "" : request.getParameter("provinceproj");
            String cityproj = request.getParameter("cityproj") == null ? "" : request.getParameter("cityproj");
            String districtproj = request.getParameter("districtproj") == null ? "" : request.getParameter("districtproj");
            String brgyproj = request.getParameter("brgyproj") == null ? "" : request.getParameter("brgyproj");
            String postalcodeproj = request.getParameter("postalcodeproj") == null ? "" : request.getParameter("postalcodeproj");

            Part1Dao pdserv = new Part1Dao(conn);
            json.put("res", pdserv.create(lendinv, investmentloanid, securityname, issuer, useofproceeds, accountname, indvcorp, firstname, middlename, lastname, suffix, financedproject));
            String recordid = json.get("res").toString().substring(5);
            System.out.println(json);
            System.out.println(json.get("res"));
            if (lendinv.equals("Lending")) {
                json.put("resadd", pdserv.createAddress(Integer.parseInt(recordid), room, lot, buildingname, street, subdivision, region, province, city, district, brgy, postalcode, roomproj, lotproj, buildingnameproj, streetproj, subdivisionproj, regionproj, provinceproj, cityproj, districtproj, brgyproj, postalcodeproj));
                System.out.println(json);
                System.out.println(json.get("resadd"));
            }

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
            Logger.getLogger(Part1SecAddServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            Logger.getLogger(Part1SecAddServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Part1SecAddServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            Logger.getLogger(Part1SecAddServlet.class.getName()).log(Level.SEVERE, null, ex);
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
