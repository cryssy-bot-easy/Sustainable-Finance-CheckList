<%-- 
    Document   : ViewProducts
    Created on : Jun 7, 2017, 1:49:11 PM
    Author     : Active Learning
--%>
 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sustainable Finance CheckList System</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css"/>        
<link href="${pageContext.request.contextPath}/resources/css/index.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/jquery/jquery-ui.css" rel="stylesheet" type="text/css"/> 

<link href="${pageContext.request.contextPath}/css/login/submit.css" rel="stylesheet" type="text/css"/>
<script src="${pageContext.request.contextPath}/jquery/external/jquery/jquery.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/jquery/jquery-ui.js" type="text/javascript"></script>    
<script src="${pageContext.request.contextPath}/jquery/tableToExcel.js" type="text/javascript"></script>  


<%  String message = (String) request.getAttribute("message");
            System.out.println("login" + message);
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);%>          
</head>
<body>        


<div id="loginLayout" class="login-container">
            <div class="login-logo2">
                <img class="img-center" src="${pageContext.request.contextPath}/images/login/LANDBANK Logo - Combined Horizontal Full Color v2.png" />
            </div>
            <div class="login-logo">
                <img class="logo-trust-fund" src="${pageContext.request.contextPath}/images/login/logs.jpg" />
            </div>
            <div class="login-header-forms">
               
                <label class="login-header-lbl">Sustainable Finance Checklist System Login</label>
                <span style="margin-top: -2%;float: right; padding-right: 3%; color: ghostwhite">version < Major >.< Minor >.< Patch ></span>
            </div>    
    
            <div class="login-forms">
                <form action="/SFC/login" method = "POST">
                    <div class="offset-1 flex-row">
                        <div class="flex-7">
                            <label class="login-forms-label">User Name</label>
                        </div>
                        <div class="flex-15">
                            <input style="font-size: 100%;" type="text" class="form-control" id="username" name="username" required>
                        </div>
                    </div>
                    <div class="offset-1 flex-row mt-2">
                        <div class="flex-7">
                            <label class="login-forms-label">Password</label>
                        </div>
                        <div class="flex-15">
                            <input style="font-size: 100%;" type="password" class="form-control" id="password"  name="password"  required>
                            
                        </div>
                        <span id="toggle_pwd" class="fa fa-fw fa-eye field_icon">
                    </div>
                    <div class="offset-1 flex-row mt-2">
                        <div class="flex-7">
                            <label class="login-forms-label">Domain</label>
                        </div>
                        <div class="flex-15">
                            <input style="font-size: 100%;" type="text" class="form-control" id="domain" value="corp.landbank.com"  name="domain"  required>
                        </div>
                    </div>
                    <div class="flex-row mt-10">
                        <div class="offset-11 flex-6">
                            <button type="button" class="btn btn-primary" onclick="resetForm()">Reset</button>
                        </div>
                         <div class="flex-6">
                            <button type="submit" class="btn btn-primary">Log In</button>
                        </div>
                    </div>
                    <input type="hidden" id="message" name="message" value ="<%= message%>" >
                </form>
            </div>
                 <span id="messageDiv" style="display:none;" class="form-error-control error-forms-message">
<!--                    <div class="tooltip-content">-->
                        <span class="error-span-message">Invalid username or password!</span>
                    <!--</div>-->
                </span>
            
            <div class="login-footer">
                <label>
                    You are attempting to access a Bank system. Unauthorized access, or access in
                    excess of your authority, may<br></br> result in administrative and criminal penalties.
                    Your activities are being logged and monitored.
                </label>
            </div>
        </div>
</body>
</html>

<script src="${pageContext.request.contextPath}/pageScripts/login.js" type="text/javascript"></script>
