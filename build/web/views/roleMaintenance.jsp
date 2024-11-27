<%-- 
    Document   : roleMaintenance
    Created on : Nov 27, 2024, 5:04:51 PM
    Author     : N680
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session = request.getSession();
    String session_user = "";
    String session_isadmin = "";
    String session_fullName = "";
    String session_email = "";
    

    String username = request.getParameter("username");
    String isadmin = (String) request.getAttribute("isadmin");

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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" type="text/javascript"></script>  

        <link href="${pageContext.request.contextPath}/css/main/home.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/css/main/main.css" rel="stylesheet" type="text/css"/>
        <title>Role Maintenance</title>
    </head>
    <body>
        
        <!--<div class="main-container mt-5">-->
            <div id="myModal" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>     
                    <p>The system has been idle for 14 minutes. The user will be logged out after another minute of inactivity.</p>
                    <input type='submit' name="btnStayLoggedIn" id="btnStayLoggedIn" class="col-1-4" value="Stay Logged in">
                </div>
            </div> 
            

            <div id="DIVUSERROLEVIEW">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" class="moduleHeader" align="left"><h4>User Role Maintenance</h4></td>
                        <td width="50%" class="moduleHeader" align="right"><input class='block' type="submit" id="saveuserrole" name="saveuserrole" value="Add Record"/>
                            <input class='block' type="submit" id="updateuserrole" name="updateuserrole" value="Update Record"/>
                            <input class='block' type="submit" id="deleteuserrole" name="deleteuserrole" value="Delete Record"/>
                            <input class='block' type="submit" id="clearuserrole" name="clearuserrole" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>
                        <td width="15%"><label>User Role</label></td>
                        <td width="30%"><input type="text" id="userrolename" name="userrolename" class='form-control' autocomplete="off"></td>
                        <td width="2%"></td>
                        <td width="5%"><input type="text" id="userroleid" name="userroleid" class='form-control' readonly></td>
                        <td width="48%"></td>       
                    </tr>   
                    <tr height = 10px></tr>
                </table>                
                <hr>

                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfiluserrole" name="tfiluserrole" class='form-control' onchange="myFunctionuserrole()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>User Role</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputuserrole" class='form-control' onkeyup="myFunctionuserrole()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                </br>                 


                <div class='well' style="height:330px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="userroletable" >
                        <!--table table-bordered table-striped--> 

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th onclick="sortTable(1)"><a href="#" class="sort-by">User Role</a></th>                                                                
                            </tr>
                        </thead>
                        <tbody id="userroletable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                       

            </div>                        

            <!--</div>-->      

    </body>
    <script src="${pageContext.request.contextPath}/pageScripts/userMaintenance.js" type="text/javascript"></script>
</html>

