<%-- 
    Document   : UserMaintenance
    Created on : 05 4, 21, 10:42:12 AM
    Author     : N680
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    /*
    response.setHeader("Cache-Control", "no-cache,no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
     */
%>  
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
        <title>User Maintenance</title>
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
            <div>
                
                <h3 class="module-title" align="left">User Maintenance</h3>
                
                
<!--                <table style="width:100%">
                    <tr>
                        
                        <td width="50%" class="moduleHeader" align="right"><input class='block' type="submit" id="saveuser" name="saveuser" value="Add User"/>
                            <input class='block' type="submit" id="updateuser" name="updateuser" value="Update User"/>
                            <input class='block' type="submit" id="liftuser" name="liftuser" value="Lift"/>
                            <input class='block' type="submit" id="resetuser" name="resetuser" value="Lift & Reset"/>
                            <input class='block' type="submit" id="deactivateuser" name="deactivate" value="Deactivate User"/>
                            <input class='block' type="submit" id="clearuser" name="clearuser" value="Clear Fields"/></td>                        
                    </tr>
                </table>    -->  
                <fieldset>
                <table style="width:100%"> 
                    <tr> 
                        <td width="15%"><label>Record ID</label></td>
                        <td width="34%"><input type="text" id="userid" name="userid" class='form-control' readonly></td>
                        <td width="2%"></td>
                        <td width="15%"></td>                        
                        <td width="34%">
                        </td>
                    </tr>    
                    <tr height = 10px></tr>	
                    <tr>
                        <td width="15%"><label>Username</label></td>
                        <td width="34%"><input type="text" id="uname" name="uname" class='form-control' onkeyup="this.value = this.value.toUpperCase();" autocomplete="off"></td>                                                                        
                        <td width="2%"></td>
                        <!--<td width="15%"><input class='block' type="submit" id="searchusermaint" name="searchusermaint" value="Search"/></td>-->
                        <td width="34%"></td>
                    </tr>                        
                    <tr height = 10px></tr>	
                    <tr>
                        <td width="15%"><label>Full Name</label></td>
                        <td width="34%"><input type="text" id="fullname" name="fullname" class='form-control' onkeyup="this.value = this.value.toUpperCase();" autocomplete="off"></td>                                                                        
                        <td width="2%"></td>
                        <td width="15%"><label>Email</label></td>
                        <td width="34%"><input type="text" id="email" name="email" class='form-control' onkeyup="this.value = this.value.toUpperCase();" autocomplete="off"></td>
                    </tr>                           
                    <tr height = 10px></tr>	
                    <tr>
                        <td width="15%"><label>User Role</label></td>
                        <td width="34%">                            
                            <select id="userrole" name="userrole" class='form-control'>                                                                                                         
                                <option value=blank></option>
                            </select>                            
                        </td>                        
                        <td width="2%"></td>
                        <td width="15%"><label>Department</label></td>
                        <td width="34%">
                            <select id="department" name="department" class='form-control'>                                                                                                         
                                <option selected="selected" value=blank>Select Value</option>
                            </select>
                        </td>        
                    </tr>         
                    <tr height = 10px></tr>	
                    <tr>
                        <td width="15%"><label>Status</label></td>
                        <td width="34%">
                            <select id="status" name="status" class='form-control'>                                      
                                <option selected="selected" value=blank>Select Value</option>
                                <option>Active</option>     
                                <option>Inactive</option>                                                           
                            </select>               
                        </td>                        
                        <td width="2%"></td>
                        <td width="15%"><label>User Access Type</label></td>
                        <td width="34%"><select id="useraccess" name="useraccess" class='form-control'>
                                <option selected="selected" value=blank>Select Value</option>
                                <option>Administrator</option>
                                <option>User</option>                                
                            </select>  
                        </td>
                    </tr>     
                </table> 
                    <br/>
                    <br/>
                    <div align="right">
                        <input class='block' type="submit" id="searchusermaint" name="searchusermaint" value="Search"/>
                        <input class='block' type="submit" id="clearuser" name="clearuser" value="Clear Fields"/>                  
                    </div>
                        
                </fieldset>
                <hr>
                
                
                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfiluser" name="tfiluser" class='form-control' onchange="myFunctionuser()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>User Name</option>
                                <option value = 2>Full Name</option>
                                <option value = 3>Email</option>                                
                                <option value = 5>Department Description</option>                                
                                <option value = 7>User Role</option>
                                <option value = 8>Status</option>
                                <option value = 9>User Access Type</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputuser" class='form-control' onkeyup="myFunctionuser()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                <br>                 
                
                <div class='well' style="height:200px;overflow-y:auto;overflow-x:auto;"  >
                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="usertable" >

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th>User Name</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Department ID</th>
                                <th>Department Description</th>
                                <th>User Role ID</th>
                                <th>User Role</th>
                                <th>Status</th>
                                <th>User Access Type</th>
                                <th>Created By</th>
                                <th>Created Date</th>                                
                            </tr>
                        </thead>
                        <tbody id="usertable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>    
             
            </div> 

    </body>
    <script src="${pageContext.request.contextPath}/pageScripts/userMaintenance.js" type="text/javascript"></script>

</html>
