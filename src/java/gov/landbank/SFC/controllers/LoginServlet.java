/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gov.landbank.SFC.controllers;

import gov.landbank.SFC.dao.ActiveDirectory;
import gov.landbank.SFC.dao.UserDao;
import gov.landbank.SFC.models.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import javax.naming.ldap.LdapContext;
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
import org.json.JSONObject;

/**
 *
 * @author F862
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    ServletContext application;
    private DataSource datasource = null;
    Connection conn = null;

    public LoginServlet() {
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
        //((project.getRemarks() == null) ? "" : project.getRemarks());

        JSONObject json = new JSONObject();
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        HttpSession ss = request.getSession();
        String ssusername = (String) ss.getAttribute("session_user") == null ? "" : (String) ss.getAttribute("session_user"); //request.getParameter("username");            
        String ssisadmin = (String) ss.getAttribute("session_isadmin") == null ? "" : (String) ss.getAttribute("session_isadmin");//request.getParameter("isadmin");    
        //String ssdepartment = (String) ss.getAttribute("session_department") == null ? "" : (String) ss.getAttribute("session_department");
        //String ssactivestat = (String) ss.getAttribute("session_isactive") == null ? "" : (String) ss.getAttribute("session_isactive");

        String username = (request.getParameter("username") == null) ? "" : request.getParameter("username");
        String password = (request.getParameter("password") == null) ? "" : request.getParameter("password");
        String domain = request.getParameter("domain");
        String distinguishedName = null;
        String email = null;
        String commonName = null;
        String memberof = null;
        String userprincipal = null;
        String status = "";
        String message = "";
        String isAdmin = "";

        boolean passed = false;

        //System.out.println(username);
        //System.out.println(password);
        if (ssusername != "") {
            HttpSession session = request.getSession();
            session.setAttribute("session_user", ssusername);
            session.setAttribute("session_isadmin", ssisadmin);

            RequestDispatcher rd = request.getRequestDispatcher("/views/main.jsp");
            rd.forward(request, response);

        } else {
            if (username == "") {
                status = "";
                HttpSession session = request.getSession();
                session.setAttribute("session_user", ssusername);
                session.setAttribute("session_isadmin", ssisadmin);

                request.setAttribute("username", "");
                request.setAttribute("message", "");

                RequestDispatcher rd = request.getRequestDispatcher("views/login.jsp");
                rd.forward(request, response);

                //response.sendRedirect("views/login.jsp");
                //response.sendRedirect("/ITPM/projects");
            } else {

                try {
                    //LdapContext ctx = ActiveDirectory.getConnection("bob", "password");
                    //LdapContext ctx = ActiveDirectory.getConnection(System.getProperty("user.name"), System.getProperty("pass.word"), domain); 
                    conn = datasource.getConnection();
                    UserDao userdao = new UserDao(conn);
                    String uname = userdao.getUserName(username);

                    System.out.println("username " + username);
                    System.out.println("uname " + uname);

                    if (uname == "") {

                        passed = false;
                        message = "User Not Enrolled";
                        status = "User Not Enrolled";

                    } else {

                        ArrayList<User> user = userdao.getUser(username);
                        String isactive = user.get(0).getAccountStatus();
                        System.out.println("isactive " + isactive);

                        if (isactive.equals("A")) {
                            LdapContext ctx = ActiveDirectory.getConnection(username, password, domain);

                            //System.out.println(ctx);
                            //System.out.println(ActiveDirectory.getUser(username, ctx));
                            if (ActiveDirectory.getUser(username, ctx) != null) {
                                passed = true;
                                distinguishedName = ActiveDirectory.getUser(username, ctx).getDistinguishedName();
                                commonName = ActiveDirectory.getUser(username, ctx).getCommonName();
                                email = ActiveDirectory.getUser(username, ctx).getMail();
                                memberof = ActiveDirectory.getUser(username, ctx).getMemberOf();
                                userprincipal = ActiveDirectory.getUser(username, ctx).getUserPrincipal();
                                isAdmin = user.get(0).getIsAdmin();
                                System.out.println("isAdmin " + isAdmin);
                                //userprincipal = ActiveDirectory.getUser(System.getProperty("user.name"), ctx).getUserPrincipal();
                            } else {
                                //change value to false when prod
                                passed = false;
                                message = "Invalid Credentials";
                            }
                            ctx.close();

                        } else {
                            passed = false;
                            message = "User Inactive";
                        }

                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    passed = false;
                    message = "Invalid Credentials";
                }

                if (passed == false) {

                    status = "";
                    request.setAttribute("username", "");
                    request.setAttribute("message", message);
                    RequestDispatcher rd = request.getRequestDispatcher("views/login.jsp");
                    rd.forward(request, response);

                } else {

                    HttpSession session = request.getSession();
                    status = "";

                    session.setAttribute("session_user", username.toUpperCase());
                    session.setAttribute("session_pword", password);
                    session.setAttribute("session_domain", domain);
                    session.setAttribute("session_isadmin", isAdmin);
                    session.setAttribute("status", status);
                    session.setAttribute("message", message);
                    session.setAttribute("username", username.toUpperCase());
                    session.setAttribute("distinguishedName", distinguishedName);
                    session.setAttribute("commonName", commonName);
                    session.setAttribute("email", email);
                    session.setAttribute("memberof", memberof);
                    session.setAttribute("userprincipal", userprincipal);

                    response.sendRedirect("/SFC/welcome");
                }

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
