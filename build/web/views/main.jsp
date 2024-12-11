
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<%
    session = request.getSession();
    String session_user = "";
    String session_isadmin = "";
    String session_fullName = "";
    String session_email = "";

    //String isadmin = (String) request.getAttribute("isadmin");
    if (session.getAttribute("session_user") == null || session.getAttribute("session_user") == "" || session.getAttribute("session_user").equals("")) {
        response.sendRedirect("/SFC/login");
    } else {
        session_user = session.getAttribute("session_user").toString();
        session_isadmin = session.getAttribute("session_isadmin").toString();
        session_fullName = session.getAttribute("commonName").toString();
        session_email = session.getAttribute("email").toString();
    }

%>      
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="${pageContext.request.contextPath}/images/lbp.ico">        
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>        
        <link href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css"/>        
        <link href="${pageContext.request.contextPath}/jquery/jquery-ui.css" rel="stylesheet" type="text/css"/>              
        <script src="${pageContext.request.contextPath}/jquery/external/jquery/jquery.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/jquery/jquery-ui.js" type="text/javascript"></script>    
        <script src="${pageContext.request.contextPath}/jquery/tableToExcel.js" type="text/javascript"></script> 
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" type="text/javascript"></script>  
        <link href="${pageContext.request.contextPath}/css/modal/appModal.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/modal/appReportModal.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/main/home.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/main/main.css" rel="stylesheet" type="text/css"/>  
        <link href="${pageContext.request.contextPath}/css/main/sidemenu.css" rel="stylesheet" type="text/css"/>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        
        <title>SFC Main Page</title>
    </head>    
    <body>
    <div class="main-container mt-5">
        <div class="header"> 
            <h1>Sustainable Finance Checklist System</h1>
            <form id="logout-form" action="/SFC/logout" method="POST">
                <input type="hidden" id="username" name="username" value="<%= session_user%>">
                <div id="app-header-nav">
                    <span id="app-user-details">
                        <span id="app-user-role">
                            <%= session_email%>
                        </span>
                        <span id="app-user-name"><%= session_fullName%></span>
                        <span id="app-date-time"></span>
                        <!-- Logout link -->
                        <span id="app-logout" onclick="confirmLogout()">Logout</span>
                    </span>
                </div>
            </form>
        </div>
                            
                        
        <div id="myModal" class="modal">            
            <div class="modal-content">
                <span class="close">&times;</span>     
                <p>The system has been idle for 14 minutes. The user will be logged out after another minute of inactivity.</p>
                <input type='submit' name="btnStayLoggedIn" id="btnStayLoggedIn" class="col-1-4" value="Stay Logged in">
            </div>
        </div>

        <div class="menu" overflow:auto>
            <div id="app-sub-menu-content"></div>
            <div id="app-menu-content">
                <div id="app-menu-search">
                    <span class="fa fa-search"></span>
                    <input autocomplete="off" id="app-menu-search-item-quick-access-input" placeholder="Menu Quick Access" name="sideMenuSearchFilter">
                        <span class="fa fa-times"></span>
               </div>
                <ul id="filtered-menu-tree" class="menu-tree toggle-hide"></ul>
                <ul id="menu-tree" class="menu-tree">
                            <li class="tree-item">
                                <span class="fa fa-chevron-right"></span>
                                    <a aria-current="page" style="color: #fff;" class="app-item-name active" href="${pageContext.request.contextPath}/welcome"><span>Home</span></a>
                            </li>
                            <li class="tree-item">
                                <span class="fa fa-chevron-right"></span>
                                <span data-page="userMaintenance" class="app-item-name menu-link">User Maintenance</span>
                            </li>  
                         
                            <li class="tree-item">
                                <span class="fa fa-chevron-right"></span>
                                <span id="roleMaintenance" data-page="roleMaintenance" class="app-item-name menu-link">Role Maintenance</span>
                                
                            </li>
                            <li class="tree-item">
                                <span class="fa fa-chevron-right"></span>
                                <span id="lending" data-page="lending" class="app-item-name menu-link">E&S Sustainable Finance and Compliance Assessment</span>
                                
                            </li>
<!--                            <li class="tree-item">
                                <span class="fa fa-chevron-right"></span>
                                <span id="lending" data-page="lending" class="app-item-name menu-link">Sustainable Finance Checklist</span>
                                
                            </li>-->
                            <li class="tree-item">
                                <span class="fa fa-chevron-down"></span>
                                <span id="reports" class="app-item-name">Reports</span>
                                <li class="tree-item menu-sub-tree">
                                    <span class="fa fa-chevron-right"></span>
                                    <span id="listUsers" data-page="reports/listUsers" class="app-item-name menu-link">List of Users</span>
                                </li>
                                <li class="tree-item menu-sub-tree">
                                    <span class="fa fa-chevron-right"></span>
                                    <span id="activityLogs" data-page="reports/activityLogs" class="app-item-name menu-link">Activity Logs</span>
                                </li> 
                                <li class=" tree-item menu-sub-tree">
                                    <span class="fa fa-chevron-right"></span>
                                    <span id="reports/checkList" data-page="reports/checkList" class="app-item-name menu-link">E&S Sustainable Finance Checklist</span>
                                </li>
                                <li class=" tree-item menu-sub-tree">
                                    <span class="fa fa-chevron-right"></span>
                                    <span id="reports/complianceAssessment" data-page="reports/complianceAssessment" class="app-item-name menu-link">E&S Sustainable Finance and Compliance Assessment</span>
                                </li>
                          
                               
                    </ul>
<!--                            <li class="tree-item">
                                <span class="fa fa-spinner fa-pulse"></span>
                                <span class="app-item-name">E&S Sustainable Finance and Compliance Assessment</span>
                            </li>
                            <li class="tree-item">
                                <span class="fa fa-spinner fa-pulse"></span>
                                <span class="app-item-name">E&S Sustainable Finance and Compliance Assessment Module</span>
                            </li>
                            <li class="tree-item">
                                <span class="fa fa-spinner fa-pulse"></span>
                                <span class="app-item-name">Reports</span>
                            </li>
                            <li class="tree-item">
                                <span class="fa fa-spinner fa-pulse"></span>
                                <span class="app-item-name">List of Users Report</span>
                            </li>
                             <li class="tree-item">
                                <span class="fa fa-spinner fa-pulse"></span>
                                <span class="app-item-name">Activity Log Report</span>
                            </li>
                             <li class="tree-item">
                                <span class="fa fa-spinner fa-pulse"></span>
                                <span class="app-item-name">E&S Checklist Report</span>
                            </li>
                             <li class="tree-item">
                                <span class="fa fa-spinner fa-pulse"></span>
                                <span class="app-item-name">E&S Assessment Report</span>
                            </li>-->
                            
            </div>
        </div>
        <div class='main'>     
            <div class="app-container">
                <div id="homePageGreetingContainer">
                    <div class="contents">

                        <div id="main-content">
                            <div id="home-page">
                                <div class="contents2">
                                <h1>"Hi! "
                                    <%= session_fullName%>
                                    ". Welcome to Sustainable Finance Checklist System!"</h1>
                                <h4 class="mb-5">Sustainable Finance Checklist</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>        
                        
 
    </<div>
        
    
        
    </div>
    </body>
   
    
</html>

<script src="${pageContext.request.contextPath}/pageScripts/main.js" type="text/javascript"></script>