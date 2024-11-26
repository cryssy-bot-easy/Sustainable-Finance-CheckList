<%-- 
    Document   : UserMaintenance
    Created on : 05 4, 21, 10:42:12 AM
    Author     : F862
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
        
        <div class="main-container mt-5">
        <div id="myModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>     
                <p>The system has been idle for 14 minutes. The user will be logged out after another minute of inactivity.</p>
                <input type='submit' name="btnStayLoggedIn" id="btnStayLoggedIn" class="col-1-4" value="Stay Logged in">
            </div>
        </div> 

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
        <div class='menu' overflow:auto> 
            <div id="accordion">
                <h3 text-align:left><a id="accordionmaintenance">LOV Maintenance</a></h3>
                <div id="divlovmaintenance">                    
                    <a id="DEPTdivView">Department</a> <br>
                    <a id="URdivView">User Role</a> <br>                    
                </div>    
                <h3 text-align:left><a id="accordionmaintenance">User Maintenance</a></h3>
                <div>                    
                    <a id="UMdivView">User</a>  <br>                          
                </div>
                <h3 text-align:left><a id="accordionreport">User Maintenance Reports</a></h3>
                <div>
                    <a id="UAdivView">User Activity</a> <br>
                    <a id="ULdivView">User List</a> <br>
                </div>
                <h3><a id="accordiontools">SFC Tool</a></h3>
                <div>
                    <form action="/SFC/welcome"  id="formviewmain"  method="post">
                        <input type="hidden" id="username" name="username" value ="<%= session_user%>" >
                        <input type="hidden" id="isadmin" name="isadmin" value ="<%= session_isadmin%>" >
                        <input type='submit' name="bmainpage" id="bmainpage" class="col-1-4" value="Main Page">                        
                        <!--button name="bmainpage" id="bmainpage" class="col-1-4" onclick="location.href = '/RMLG/ViewMain'" >Main Page</button-->                                                
                    </form>

                </div>    
            </div>                           
            <input type="hidden" id="depid" name="depid">        
            <input type="hidden" id="roleid" name="roleid">
            <input type="hidden" id="teamid" name="teamid">                        
            <input type="hidden" id="groupid" name="groupid">       
            <input type="hidden" id="sdesignationid" name="sdesignationid" value ="<%= session_isadmin%>"> 

            <br>            
        </div>

        <div class='main' overflow:auto> 

            <div id="DIVUMVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" class="moduleHeader" align="left"><h4>User Maintenance</h4></td>
                        <td width="50%" class="moduleHeader" align="right"><input class='block' type="submit" id="saveuser" name="saveuser" value="Add User"/>
                            <input class='block' type="submit" id="updateuser" name="updateuser" value="Update User"/>
                            <input class='block' type="submit" id="liftuser" name="liftuser" value="Lift"/>
                            <input class='block' type="submit" id="resetuser" name="resetuser" value="Lift & Reset"/>
                            <input class='block' type="submit" id="deactivateuser" name="deactivate" value="Deactivate User"/>
                            <input class='block' type="submit" id="clearuser" name="clearuser" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
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
                        <td width="15%"><input class='block' type="submit" id="searchusermaint" name="searchusermaint" value="Search"/></td>
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
                        <!--table table-bordered table-striped--> 

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

            <div id="DIVUSERACCOUNTLISTVIEW" style="display:none">
                <br>                                   
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>User Account List</h4></td>                        
                    </tr>
                </table>   
                <hr>              
                <table style="width:100%"> 
                    <tr>                                             
                        <td width="25%"><button id="btnuseraccountlist" onclick="exportReportToExcel(this)">EXPORT REPORT</button></td>                                           
                        <td width="10%" align="left">File Name</td>
                        <td width="30%"><input type="text" id="useraccountlistfilename" name="useraccountlistfilename" class='form-control' pattern="[^\\/:\x22*?<>|]+" required ></td>
                        <td width="35%"></td>
                    </tr>                   
                </table>                
                <hr>             

                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >                    
                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="useraccountlisttable" >
                        <!--table table-bordered table-striped--> 

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr> 
                                <th>User Account List</th>                                
                            </tr>                            
                            <tr> 
                                <th><p id="dateToday"></p></th>                                
                            </tr>                                                        
                            <tr>                                                                                                           
                                <th>USERNAME</th>
                                <th>FIRSTNAME</th>
                                <th>LASTNAME</th>
                                <th>USER DESIGNATION</th>
                                <th>DEPARTMENT</th>
                                <th>TEAM</th>
                                <th>USER ROLE</th>
                                <th>IS ADMIN</th>
                                <th>INITITAL LOGIN</th>                            
                                <th>PASSWORD RESET DATE</th>                            
                                <th>LOCKED</th>
                                <th>ACTIVE</th>
                                <th>CREATED BY</th>
                                <th>CREATION DATE</th>

                            </tr>
                        </thead>
                        <tbody id="useraccountlisttable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                                                                                
            </div>                        

            <div id="DIVUSERACTIVITYLISTVIEW" style="display:none">
                <br>                                   
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>User Activity List</h4></td>                        
                    </tr>
                </table>   
                <hr>
                <table style="width:100%">                     
                    <tr>
                        <td width="10%"><label>Username</label></td>                                           
                        <td width="25%">
                            <input type="text" id="useractivityusername" name="useractivityusername" class='form-control' onkeyup="this.value = this.value.toUpperCase();" autocomplete="off">
                        </td>
                        <td width="5%"></td>                                           
                        <td width="10%"><label>Activity Date</label></td>                                           
                        <td width="25%"><input type="date" id="useractivitydate" name="useractivitydate" class='form-control'>
                            <i class="fa fa-calendar"></i>
                        </td>
                        <td width="5%"></td>
                        <td width="20%"><button id="btnGenerateUA" onclick="exportReportToExcel(this)">Populate Table</button></td>                                                                                                                   
                    </tr>                
                </table>   
                <hr>              
                <table style="width:100%"> 
                    <tr>                                             
                        <td width="25%"><button id="btnuseractlist" onclick="exportReportToExcel(this)">EXPORT REPORT</button></td>                                           
                        <td width="10%" align="left"><label id="filenamelabel">File Name</label></td>
                        <td width="30%"><input type="text" id="useractlistfilename" name="useractlistfilename" class='form-control' pattern="[^\\/:\x22*?<>|]+" required></td>
                        <td width="35%"></td>
                    </tr>                   
                </table>                
                <hr>             

                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >                    
                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="useractlisttable" >
                        <!--table table-bordered table-striped--> 

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr> 
                                <th>User Activity List</th>                                
                            </tr>                            
                            <tr> 
                                <th><p id="dateuaToday"></p></th>                                
                            </tr>                                                        
                            <tr>                                                                                                           
                                <th>USERNAME</th>
                                <th>USER ACTIVITY</th>
                                <th>TABLE NAME</th>
                                <th>COLUMN NAME</th>
                                <th>VALUE FROM</th>
                                <th>VALUE TO</th>
                                <th>RECORD ID</th>   
                                <th>STATUS</th> 
                                <th>ACTIVITY TIME</th>                            
                            </tr>
                        </thead>
                        <tbody id="useractlisttable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                                                                                
            </div>                      

            <div id="DIVDEPTVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" class="moduleHeader" align="left"><h4>Department Maintenance</h4></td>
                        <td width="50%" class="moduleHeader" align="right"><input class='block' type="submit" id="savedept" name="savedept" value="Add Record"/>
                            <input class='block' type="submit" id="updatedept" name="updatedept" value="Update Record"/>
                            <input class='block' type="submit" id="deletedept" name="deletedept" value="Delete Record"/>
                            <input class='block' type="submit" id="cleardept" name="cleardept" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>
                        <td width="15%"><label>Department Name</label></td>
                        <td width="30%"><input type="text" id="departmentname" name="departmentname" class='form-control' onkeyup="this.value = this.value.toUpperCase();" autocomplete="off"></td>
                        <td width="2%"></td>
                        <td width="5%"><input type="text" id="departmentid" name="departmentid" class='form-control' readonly></td>
                        <td width="48%"></td>       
                    </tr>                   
                    <tr height = 10px></tr>	    
                </table>                
                <hr>

                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfil" name="tfil" class='form-control' onchange="myFunction()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>Department Name</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInput" class='form-control' onkeyup="myFunction()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                </br>                 


                <div class='well' style="height:350px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="deptable" >
                        <!--table table-bordered table-striped--> 

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th onclick="sortTable(1)"><a href="#" class="sort-by">Department Name</a></th>
                            </tr>
                        </thead>
                        <tbody id="deptable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                       

            </div>     

            <div id="DIVUSERROLEVIEW" style="display:none">
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

            <div id="DIVTEAMVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>Teams Maintenance</h4></td>
                        <td width="50%" align="right"><input class='block' type="submit" id="saveteam" name="saveteam" value="Add Record"/>
                            <input class='block' type="submit" id="updateteam" name="updateteam" value="Update Record"/>
                            <input class='block' type="submit" id="deleteteam" name="deleteteam" value="Delete Record"/>
                            <input class='block' type="submit" id="clearteam" name="clearteam" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>

                        <td width="15%"><label>Team</label></td>
                        <td width="30%"><input type="text" id="teamname" name="teamname" class='form-control'></td>
                        <td width="2%"></td>
                        <td width="5%"><input type="text" id="teamid" name="teamid" class='form-control' readonly></td>
                        <td width="48%"></td>       

                    </tr>                   
                </table>                
                <hr>

                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfilteam" name="tfilteam" class='form-control' onchange="myFunctionteam()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>Team</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputteam" class='form-control' onkeyup="myFunctionteam()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                </br>                 


                <div class='well' style="height:350px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="teamtable" >
                        <!--table table-bordered table-striped--> 

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th onclick="sortTable(1)"><a href="#" class="sort-by">Team</a></th>
                            </tr>
                        </thead>
                        <tbody id="teamtable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                       

            </div>                                    
          
            </div>          
        </div>    

    </body>
    <script src="${pageContext.request.contextPath}/pageScripts/userMaintenance.js" type="text/javascript"></script>

</html>
