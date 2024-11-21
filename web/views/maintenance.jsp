<%-- 
    Document   : maintenance
    Created on : 10 20, 21, 8:59:16 AM
    Author     : F862
--%>

<%@page import="gov.landbank.SFC.models.Department"%>
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
    String session_isactive = "";
    String session_designation = "";
    String session_team = "";
    String session_department = "";
    String username = request.getParameter("username");
    String isadmin = (String) request.getAttribute("isadmin");

    if (session.getAttribute("session_user") == null || session.getAttribute("session_user") == "" || session.getAttribute("session_user").equals("")) {
        response.sendRedirect("/SFC/login");
    } else {
        session_user = session.getAttribute("session_user").toString();
        session_isadmin = session.getAttribute("session_isadmin").toString();
        session_isactive = session.getAttribute("session_isactive").toString();
        session_designation = session.getAttribute("session_designation").toString();
        session_team = session.getAttribute("session_team").toString();
        session_department = session.getAttribute("session_department").toString();

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
        <style>
            .deptable {
                overflow-y: auto;
                height: 106px;
            }
            .deptable thead th {
                position: sticky;
                top: 0;
            }
            .deptable {
                border-collapse: collapse;
                width: 100%;
            }
            .deptable th,
            .deptable td {
                padding: 8px 16px;
                border: 1px solid #ccc;
            }
            .deptable th {
                background: #eee;
            }
            h4 {
                background-color: green
            }

            input[type=text] {
                text-transform: uppercase;
            }            
        </style>

        <style>                     
            body {font-family: Arial, Helvetica, sans-serif;}

            /* The Modal (background) */
            .modal {
                display: none; /* Hidden by default */
                position: fixed; /* Stay in place */
                z-index: 1; /* Sit on top */
                padding-top: 100px; /* Location of the box */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                overflow: auto; /* Enable scroll if needed */
                background-color: rgb(0,0,0); /* Fallback color */
                background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            }

            /* Modal Content */
            .modal-content {
                background-color: #fefefe;
                margin: auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
            }

            /* The Close Button */
            .close {
                color: #aaaaaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: #000;
                text-decoration: none;
                cursor: pointer;
            }
        </style>        



        <title>RMLG Tool Maintenance Page</title>
    </head>
    <body>
        <div id="myModal" class="modal">            
            <div class="modal-content">
                <span class="close">&times;</span>     
                <p>The system has been idle for 14 minutes. The user will be logged out after another minute of inactivity.</p>
                <input type='submit' name="btnStayLoggedIn" id="btnStayLoggedIn" class="col-1-4" value="Stay Logged in">
            </div>
        </div>        
        <div class='col-md-2' overflow:auto> 
            <table style="width:100%">
                <tr >
                    <td width="50%"><img src='${pageContext.request.contextPath}/images/lbp.ico' alt="lbp" width="100" height="100"></td>
                    <td width="50%"><h4>SFC Maintenance Page</h4></td>
                <input type="hidden" id="isadmin" name="isadmin" value ="<%= session_isadmin%>" >
                </tr>    
            </table>
            <div id="accordion">
                <h3 text-align:left><a>LOV Maintenance</a></h3>
                <div>
                    <a id="BTdivView">Borrower Type</a><br>
                    <a id="CTdivView">Client Type</a><br>
                    <a id="CAMdivView">Credit Approval Medium</a><br>
                    <a id="CFdivView">Credit Facility</a><br>
                    <a id="CRdivView">Credit Rating</a><br>                    
                    <a id="DDdivView">Due Date</a><br>                    
                    <a id="ASdivView">Interest Basis</a><br>
                    <a id="LAGdivView">LAG</a> <br>
                    <a id="LCdivView">Loan Classification</a> <br>
                    <a id="PFdivView">Payment Frequency</a> <br>
                    <a id="PRIOdivView">Priority</a> <br>
                    <a id="PTdivView">Program Tagging</a> <br>
                    <a id="PSICdivView">PSIC</a> <br>
                    <a id="SECdivView">Security</a> <br>
                    <a id="SBdivView">Servicing Branch</a> <br>
                    <a id="SOAdivView">Status Of Account</a>
                </div>                           
                <h3><a id="accordiontool">RMLG Monitoring Tool</a></h3>
                <div>
                    <form action="/RMLG/ViewMain"  id="formviewmain"  method="post">
                        <input type="hidden" id="uname" name="uname" value ="<%= session_user%>" >
                        <input type="hidden" id="username" name="username" value ="<%= session_user%>" >
                        <input type="hidden" id="isadmin" name="isadmin" value ="<%= session_isadmin%>" >
                        <input type='submit' name="breportspage" id="breportspage" class="col-1-4" value="Main Page">                        
                        <!--button name="bmainpage" id="bmainpage" class="col-1-4" onclick="location.href = '/RMLG/ViewMain'" >Main Page</button-->                  
                    </form>
                </div>                
            </div>   
            <br>     
            <input type="hidden" id="sdesignationid" name="sdesignationid" value ="<%= session_designation%>"> 
            <input type="hidden" id="sisactive" name="sisactive" value ="<%= session_isactive%>">
            <input type="hidden" id="steamid" name="steamid" value ="<%= session_team%>"> 
            <input type="hidden" id="sdepid" name="steamid" value ="<%= session_department%>">                         
            <input type="hidden" id="depid" name="depid">        
            <input type="hidden" id="teamid" name="teamid">     

            <div class='well'> 
                <p>Logged in as <%= session_user.toUpperCase()%></p>
                <form action="/RMLG/logout" method = "POST" onsubmit="return confirm('Are you sure you want to logout?');"> 
                    <input type="hidden" id="username" name="username" value ="<%= session_user%>" >
                    <input type='submit' name="blogout" id="blogout" class="col-1-4" value="Logout">
                </form>                                              
            </div>                          
        </div>
        <div class='col-md-10' overflow:auto> 
            
            <div id="DIVBTVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>Borrower Type Maintenance</h4></td>
                        <td width="50%" align="right"><input class='block' type="submit" id="savebt" name="savebt" value="Add Record"/>
                            <input class='block' type="submit" id="updatebt" name="updatebt" value="Update Record"/>
                            <input class='block' type="submit" id="deletebt" name="deletebt" value="Delete Record"/>
                            <input class='block' type="submit" id="clearbt" name="clearbt" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>
                        <td width="15%"><label>Borrower Type</label></td>
                        <td width="30%"><input type="text" id="btdesc" name="btdesc" class='form-control'></td>
                        <td width="2%"></td>
                        <td width="8%"><input type="text" id="btid" name="btid" class='form-control' readonly></td>
                        <td width="45%"></td>       
                    </tr>                   
                </table>                
                <hr>

                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfilbt" name="tfilbt" class='form-control' onchange="myFunctionbt()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>Borrower Type</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputbt" class='form-control' onkeyup="myFunctionbt()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                </br>                 


                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="bttable" >

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th>Borrower Type</th>
                            </tr>
                        </thead>
                        <tbody id="bttable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                                                                                
            </div>            

            <div id="DIVPTVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>Program Tagging Maintenance</h4></td>
                        <td width="50%" align="right"><input class='block' type="submit" id="savept" name="savept" value="Add Record"/>
                            <input class='block' type="submit" id="updatept" name="updatept" value="Update Record"/>
                            <input class='block' type="submit" id="deletept" name="deletept" value="Delete Record"/>
                            <input class='block' type="submit" id="clearpt" name="clearpt" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>
                        <td width="15%"><label>Program Tagging</label></td>
                        <td width="30%"><input type="text" id="ptdesc" name="ptdesc" class='form-control'></td>
                        <td width="2%"></td>
                        <td width="8%"><input type="text" id="ptid" name="ptid" class='form-control' readonly></td>
                        <td width="45%"></td>       
                    </tr>                   
                </table>                
                <hr>

                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfilpt" name="tfilpt" class='form-control' onchange="myFunctionpt()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>Program Tagging</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputpt" class='form-control' onkeyup="myFunctionpt()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                </br>                 


                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="pttable" >

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th>Program Tagging</th>
                            </tr>
                        </thead>
                        <tbody id="pttable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                                                                                
            </div>            
                       
            <div id="DIVSOAVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>Status of Account Maintenance</h4></td>
                        <td width="50%" align="right"><input class='block' type="submit" id="savesoa" name="savesoa" value="Add Record"/>
                            <input class='block' type="submit" id="updatesoa" name="updatesoa" value="Update Record"/>
                            <input class='block' type="submit" id="deletesoa" name="deletesoa" value="Delete Record"/>
                            <input class='block' type="submit" id="clearsoa" name="clearsoa" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>
                        <td width="15%"><label>Status of Account</label></td>
                        <td width="30%"><input type="text" id="soadesc" name="soadesc" class='form-control'></td>
                        <td width="2%"></td>
                        <td width="8%"><input type="text" id="soaid" name="soaid" class='form-control' readonly></td>
                        <td width="45%"></td>       
                    </tr>                   
                </table>                
                <hr>

                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfilsoa" name="tfilsoa" class='form-control' onchange="myFunctionsoa()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>Status of Account</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputsoa" class='form-control' onkeyup="myFunctionsoa()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                </br>                 


                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="soatable" >

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th>Status of Account</th>
                            </tr>
                        </thead>
                        <tbody id="soatable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                                                                                
            </div>            
            
            
            <div id="DIVCTVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>Client Type Maintenance</h4></td>
                        <td width="50%" align="right"><input class='block' type="submit" id="savect" name="savect" value="Add Record"/>
                            <input class='block' type="submit" id="updatect" name="updatect" value="Update Record"/>
                            <input class='block' type="submit" id="deletect" name="deletect" value="Delete Record"/>
                            <input class='block' type="submit" id="clearct" name="clearct" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>
                        <td width="15%"><label>Client Type</label></td>
                        <td width="30%"><input type="text" id="ctdesc" name="ctdesc" class='form-control'></td>
                        <td width="2%"></td>
                        <td width="8%"><input type="text" id="ctid" name="ctid" class='form-control' readonly></td>
                        <td width="45%"></td>       
                    </tr>                   
                </table>                
                <hr>

                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfilct" name="tfilct" class='form-control' onchange="myFunctionct()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>Client Type</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputct" class='form-control' onkeyup="myFunctionct()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                </br>                 


                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="cttable" >

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th>Client Type</th>
                            </tr>
                        </thead>
                        <tbody id="cttable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                                                                                
            </div>                        
            
            <div id="DIVCAMVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>Credit Approval Medium Maintenance</h4></td>
                        <td width="50%" align="right"><input class='block' type="submit" id="savecam" name="savecam" value="Add Record"/>
                            <input class='block' type="submit" id="updatecam" name="updatecam" value="Update Record"/>
                            <input class='block' type="submit" id="deletecam" name="deletecam" value="Delete Record"/>
                            <input class='block' type="submit" id="clearcam" name="clearcam" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>     
                <table style="width:100%"> 
                    <tr>
                        <td width="15%"><label>Credit Approval Medium Code</label></td>
                        <td width="30%"><input type="text" id="camcode" name="camcode" class='form-control'></td>
                        <td width="2%"></td>
                        <td width="8%"><input type="text" id="camid" name="camid" class='form-control' readonly></td>
                        <td width="45%"></td>       
                    </tr>                   
                    <tr>
                        <td colspan="5"><label> </label></td>
                    </tr>
                    <tr>
                        <td width="15%"><label>Credit Approval Medium</label></td>
                        <td colspan="4"><input type="text" id="camdesc" name="camdesc" class='form-control'></td>	
                    </tr>                   	

                </table>                
                <hr>
                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfilcam" name="tfilcam" class='form-control' onchange="myFunctioncam()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>Credit Approval Medium Code</option>
                                <option value = 2>Credit Approval Medium</option>
                            </select>                            
                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputcam" class='form-control' onkeyup="myFunctioncam()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>
                </table>        
                </br>                 
                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >
                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="camtable" >

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th>Credit Approval Medium Code</th>
                                <th>Credit Approval Medium</th>
                            </tr>
                        </thead>
                        <tbody id="camtable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                                                                                
            </div>            

            <div id="DIVCFVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>Credit Facility Maintenance</h4></td>
                        <td width="50%" align="right"><input class='block' type="submit" id="savecf" name="savecf" value="Add Record"/>
                            <input class='block' type="submit" id="updatecf" name="updatecf" value="Update Record"/>
                            <input class='block' type="submit" id="deletecf" name="deletecf" value="Delete Record"/>
                            <input class='block' type="submit" id="clearcf" name="clearcf" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>
                        <td width="15%"><label>Credit Facility</label></td>
                        <td width="30%"><input type="text" id="cfdesc" name="cfdesc" class='form-control'></td>
                        <td width="2%"></td>
                        <td width="8%"><input type="text" id="cfid" name="cfid" class='form-control' readonly></td>
                        <td width="45%"></td>       
                    </tr>                   
                </table>                
                <hr>
                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfilcf" name="tfilcf" class='form-control' onchange="myFunctioncf()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>Credit Facility</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputcf" class='form-control' onkeyup="myFunctioncf()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>
                </table>        
                </br>                 
                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="cftable" >

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th>Credit Facility</th>
                            </tr>
                        </thead>
                        <tbody id="cftable" style='height:50px;display:block;overflow:scroll;'>
                        </tbody>         
                    </table>
                </div>                                                                                
            </div>                        

            <div id="DIVCRVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>Credit Rating Maintenance</h4></td>
                        <td width="50%" align="right"><input class='block' type="submit" id="savecr" name="savecr" value="Add Record"/>
                            <input class='block' type="submit" id="updatecr" name="updatecr" value="Update Record"/>
                            <input class='block' type="submit" id="deletecr" name="deletecr" value="Delete Record"/>
                            <input class='block' type="submit" id="clearcr" name="clearcr" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>
                        <td width="15%"><label>Credit Rating</label></td>
                        <td width="30%"><input type="text" id="crdesc" name="crdesc" class='form-control'></td>
                        <td width="2%"></td>
                        <td width="8%"><input type="text" id="crid" name="crid" class='form-control' readonly></td>
                        <td width="45%"></td>       
                    </tr>                   
                </table>                
                <hr>

                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfilcr" name="tfilcr" class='form-control' onchange="myFunctioncr()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>Credit Rating</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputcr" class='form-control' onkeyup="myFunctioncr()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                </br>                 

                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="crtable" >

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th>Credit Rating</th>
                            </tr>
                        </thead>
                        <tbody id="crtable" style='height:50px;display:block;overflow:scroll;'>
                        </tbody>         
                    </table>
                </div>                                                                                
            </div>                                    

            <div id="DIVDDVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>Due Date Maintenance</h4></td>
                        <td width="50%" align="right"><input class='block' type="submit" id="savedd" name="savedd" value="Add Record"/>
                            <input class='block' type="submit" id="updatedd" name="updatedd" value="Update Record"/>
                            <input class='block' type="submit" id="deletedd" name="deletedd" value="Delete Record"/>
                            <input class='block' type="submit" id="cleardd" name="cleardd" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>
                        <td width="15%"><label>Due Date</label></td>
                        <td width="30%"><input type="text" id="dddesc" name="dddesc" class='form-control'></td>
                        <td width="2%"></td>
                        <td width="8%"><input type="text" id="ddid" name="ddid" class='form-control' readonly></td>
                        <td width="45%"></td>       
                    </tr>                   
                </table>                
                <hr>

                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfildd" name="tfildd" class='form-control' onchange="myFunctiondd()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>Due Date</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputdd" class='form-control' onkeyup="myFunctiondd()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                </br>                 


                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="ddtable" >

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th>Due Date</th>
                            </tr>
                        </thead>
                        <tbody id="ddtable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                                                                                
            </div>                        
            
            <div id="DIVLAGVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>LAG Maintenance</h4></td>
                        <td width="50%" align="right"><input class='block' type="submit" id="savelag" name="savelag" value="Add Record"/>
                            <input class='block' type="submit" id="updatelag" name="updatelag" value="Update Record"/>
                            <input class='block' type="submit" id="deletelag" name="deletelag" value="Delete Record"/>
                            <input class='block' type="submit" id="clearlag" name="clearlag" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>
                        <td width="15%"><label>LAG</label></td>
                        <td width="30%"><input type="text" id="lagdesc" name="lagdesc" class='form-control'></td>
                        <td width="2%"></td>
                        <td width="8%"><input type="text" id="lagid" name="lagid" class='form-control' readonly></td>
                        <td width="45%"></td>       
                    </tr>                   
                </table>                
                <hr>

                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfillag" name="tfillag" class='form-control' onchange="myFunctionlag()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>LAG</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputlag" class='form-control' onkeyup="myFunctionlag()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                </br>                 


                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="lagtable" >

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th>LAG</th>
                            </tr>
                        </thead>
                        <tbody id="lagtable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                                                                                
            </div>                        

            <div id="DIVPFVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>Payment Frequency Maintenance</h4></td>
                        <td width="50%" align="right"><input class='block' type="submit" id="savepf" name="savepf" value="Add Record"/>
                            <input class='block' type="submit" id="updatepf" name="updatepf" value="Update Record"/>
                            <input class='block' type="submit" id="deletepf" name="deletepf" value="Delete Record"/>
                            <input class='block' type="submit" id="clearpf" name="clearpf" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>
                        <td width="15%"><label>Payment Frequency</label></td>
                        <td width="30%"><input type="text" id="pfdesc" name="pfdesc" class='form-control'></td>
                        <td width="2%"></td>
                        <td width="8%"><input type="text" id="pfid" name="pfid" class='form-control' readonly></td>
                        <td width="45%"></td>       
                    </tr>                   
                </table>                
                <hr>

                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfilpf" name="tfilpf" class='form-control' onchange="myFunctionpf()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>Payment Frequency</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputpf" class='form-control' onkeyup="myFunctionpf()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                </br>                 


                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="pftable" >

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th>Payment Frequency</th>
                            </tr>
                        </thead>
                        <tbody id="pftable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                                                                                
            </div>            

            <div id="DIVPRIOVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>Priority Maintenance</h4></td>
                        <td width="50%" align="right"><input class='block' type="submit" id="saveprio" name="saveprio" value="Add Record"/>
                            <input class='block' type="submit" id="updateprio" name="updateprio" value="Update Record"/>
                            <input class='block' type="submit" id="deleteprio" name="deleteprio" value="Delete Record"/>
                            <input class='block' type="submit" id="clearprio" name="clearprio" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>
                        <td width="15%"><label>Priority</label></td>
                        <td width="30%"><input type="text" id="pdesc" name="pdesc" class='form-control'></td>
                        <td width="2%"></td>
                        <td width="8%"><input type="text" id="pid" name="pid" class='form-control' readonly></td>
                        <td width="45%"></td>       
                    </tr>                   
                </table>                
                <hr>

                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfilprio" name="tfilprio" class='form-control' onchange="myFunctionprio()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>Priority Type</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputprio" class='form-control' onkeyup="myFunctionprio()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                </br>                 


                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="priotable" >

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th>Priority Type</th>
                            </tr>
                        </thead>
                        <tbody id="priotable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                                                                                

            </div>    

            <div id="DIVPSICVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>PSIC Maintenance</h4></td>
                        <td width="50%" align="right"><input class='block' type="submit" id="savepsic" name="savepsic" value="Add Record"/>
                            <input class='block' type="submit" id="updatepsic" name="updatepsic" value="Update Record"/>
                            <input class='block' type="submit" id="deletepsic" name="deletepsic" value="Delete Record"/>
                            <input class='block' type="submit" id="clearpsic" name="clearpsic" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>

                        <td width="15%"><label>PSIC Code</label></td>
                        <td width="30%"><input type="text" id="psiccode" name="psiccode" class='form-control'></td>
                        <td width="2%"></td>
                        <td width="8%"><input type="text" id="psicid" name="psicid" class='form-control' readonly></td>
                        <td width="45%"></td>       
                    </tr>                   
                    <tr>
                        <td colspan="5"><label> </label></td>
                    </tr>
                    <tr>
                        <td width="15%"><label>Industry</label></td>
                        <td colspan="4"><input type="text" id="psicdesc" name="psicdesc" class='form-control'></td>	
                    </tr>                   	

                </table>                
                <hr>

                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfilpsic" name="tfilpsic" class='form-control' onchange="myFunctionpsic()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>PSIC Code</option>
                                <option value = 2>Industry</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputpsic" class='form-control' onkeyup="myFunctionpsic()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                </br>                 

                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="psictable" >

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th>PSIC Code</th>
                                <th>Industry</th>
                            </tr>
                        </thead>
                        <tbody id="psictable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                                             
            </div>

            <div id="DIVSECVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>Security Maintenance</h4></td>
                        <td width="50%" align="right"><input class='block' type="submit" id="savesec" name="savesec" value="Add Record"/>
                            <input class='block' type="submit" id="updatesec" name="updatesec" value="Update Record"/>
                            <input class='block' type="submit" id="deletesec" name="deletesec" value="Delete Record"/>
                            <input class='block' type="submit" id="clearsec" name="clearsec" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>
                        <td width="15%"><label>Security Description</label></td>
                        <td width="30%"><input type="text" id="secdesc" name="secdesc" class='form-control'></td>
                        <td width="2%"></td>
                        <td width="8%"><input type="text" id="secid" name="secid" class='form-control' readonly></td>
                        <td width="45%"></td>       
                    </tr>                   
                </table>                
                <hr>

                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfilsec" name="tfilsec" class='form-control' onchange="myFunctionsec()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>Security Description</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputsec" class='form-control' onkeyup="myFunctionsec()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                </br>                 


                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="sectable" >

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th>Security Description</th>
                            </tr>
                        </thead>
                        <tbody id="sectable" style='height:50px;display:block;overflow:scroll;'>
                        </tbody>         
                    </table>
                </div>                                                                                
            </div>                    

            <div id="DIVSBVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>Servicing Branch Maintenance</h4></td>
                        <td width="50%" align="right"><input class='block' type="submit" id="savesb" name="savesb" value="Add Record"/>
                            <input class='block' type="submit" id="updatesb" name="updatesb" value="Update Record"/>
                            <input class='block' type="submit" id="deletesb" name="deletesb" value="Delete Record"/>
                            <input class='block' type="submit" id="clearsb" name="clearsb" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>

                        <td width="15%"><label>Branch Code</label></td>
                        <td width="30%"><input type="text" id="sbcode" name="sbcode" class='form-control'></td>
                        <td width="2%"></td>
                        <td width="8%"><input type="text" id="sbid" name="sbid" class='form-control' readonly></td>
                        <td width="2%"></td>
                        <td width="15%"><label>Branch Short</label></td>       
                        <td width="28%"><input type="text" id="sbshort" name="sbshort" class='form-control'></td>
                    </tr>                   
                    <tr>
                        <td colspan="5"><label> </label></td>
                    </tr>
                    <tr>
                        <td width="15%"><label>Branch Name</label></td>
                        <td colspan="4"><input type="text" id="sbdesc" name="sbdesc" class='form-control'></td>	
                    </tr>                   	

                </table>                
                <hr>

                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfilsb" name="tfilsb" class='form-control' onchange="myFunctionsb()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>Branch Code</option>
                                <option value = 2>Branch Short</option>
                                <option value = 3>Branch Name</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputsb" class='form-control' onkeyup="myFunctionsb()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                </br>                 


                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="sbtable" >

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th>Branch Code</th>
                                <th>Branch Short</th>
                                <th>Branch Name</th>
                            </tr>
                        </thead>
                        <tbody id="sbtable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                                             
            </div>
            
            <div id="DIVASVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>Interest Basis Maintenance</h4></td>
                        <td width="50%" align="right"><input class='block' type="submit" id="saveas" name="saveas" value="Add Record"/>
                            <input class='block' type="submit" id="updateas" name="updateas" value="Update Record"/>
                            <input class='block' type="submit" id="deleteas" name="deleteas" value="Delete Record"/>
                            <input class='block' type="submit" id="clearas" name="clearas" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>
                        <td width="15%"><label>Interest Basis</label></td>
                        <td width="30%"><input type="text" id="asdesc" name="asdesc" class='form-control'></td>
                        <td width="2%"></td>
                        <td width="8%"><input type="text" id="asid" name="asid" class='form-control' readonly></td>
                        <td width="45%"></td>       
                    </tr>                   
                </table>                
                <hr>

                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfilas" name="tfilas" class='form-control' onchange="myFunctionas()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>Interest Basis</option>
                            </select>                            

                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputas" class='form-control' onkeyup="myFunctionas()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                </br>                 


                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="astable" >

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th>Interest Basis</th>
                            </tr>
                        </thead>
                        <tbody id="astable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                                                                                
            </div>                                 
               
            <div id="DIVLCVIEW" style="display:none">
                <br>                
                <table style="width:100%">
                    <tr>
                        <td width="50%" align="left"><h4>Loan Classification Maintenance</h4></td>
                        <td width="50%" align="right"><input class='block' type="submit" id="savelc" name="savelc" value="Add Record"/>
                            <input class='block' type="submit" id="updatelc" name="updatelc" value="Update Record"/>
                            <input class='block' type="submit" id="deletelc" name="deletelc" value="Delete Record"/>
                            <input class='block' type="submit" id="clearlc" name="clearlc" value="Clear Fields"/></td>                        
                    </tr>
                </table>    
                <hr>                
                <table style="width:100%"> 
                    <tr>
                        <td width="15%"><label>Loan Classification</label></td>
                        <td width="30%"><input type="text" id="lcdesc" name="lcdesc" class='form-control'></td>
                        <td width="2%"></td>
                        <td width="8%"><input type="text" id="lcid" name="lcid" class='form-control' readonly></td>
                        <td width="45%"></td>       
                    </tr>                   
                </table>                
                <hr>

                <table style="width:100%">                     
                    <tr>
                        <td width="25%">
                            <select id="tfillc" name="tfillc" class='form-control' onchange="myFunctionlc()">
                                <option selected="selected" value = 0>Select Filter</option>
                                <option value = 0>Record ID</option>
                                <option value = 1>Loan Classification</option>
                            </select>                            
                        </td>
                        <td width="2%"></td>                   
                        <td width="25%">
                            <input type="text" id="myInputlc" class='form-control' onkeyup="myFunctionlc()" placeholder="Search for..">    
                        </td>
                        <td width="48%"></td>
                    </tr>

                </table>        
                </br>                 

                <div class='well' style="height:300px;overflow-y:auto;overflow-x:auto;"  >

                    <table  class="table table-bordered table-striped" style="white-space:nowrap;" id="lctable" >

                        <thead style='tr:first-child th { position: sticky; top: 0; }'>
                            <tr>
                                <th>Record ID</th>                                            
                                <th>Loan Classification</th>
                            </tr>
                        </thead>
                        <tbody id="lctable" style='height:50px;display:block;overflow:scroll;'>

                        </tbody>         
                    </table>
                </div>                                                                                
            </div>            
            
        </div>	        

    </body>

    <!--DIV bt -->
    <script>

        $('#bttable').click(function (e) {
            var btid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var btdesc = $(e.target).closest('tr').find("td:nth-child(2)").text();
            $('#btdesc').val(btdesc);
            $('#btid').val(btid);
            hidebtbuttons()
        });

        $("#savebt").on('click', function () {
            var btdesc = $("#btdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (btdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Borrower Type is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "BTAddServlet",
                dataType: 'json',
                data: {btdesc: btdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        fillbttable();
                        clearbtdiv();
                        hidebtbuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#updatebt").on('click', function () {
            var btid = $("#btid").val();
            var btdesc = $("#btdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (btid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (btdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Borrower Type is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "BTUpdateServlet",
                dataType: 'json',
                data: {btid: btid,
                    btdesc: btdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert(json.res);
                        fillbttable();
                        clearbtdepdiv();
                        hidebtbuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#deletebt").on('click', function () {
            var btid = $("#btid").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            var confirmation = confirm("are you sure you want to delete this record?");
            if (btid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is blank");
                event.preventDefault();
            }
            if (confirmation) {
                $.ajax({
                    url: "BTDeleteServlet",
                    dataType: 'json',
                    data: {btid: btid,
                        uname: uname,
                        activestat: activestat},

                    success: function (json) {
                        if (json.res != null) {
                            alert(json.res);
                            fillbttable();
                            clearbtdiv();
                            hidebtbuttons();
                        } else {
                            event.preventDefault();
                            $('#messageDiv').css("display", "none");
                            $('#messageDiv').html("");
                            alert("Some exception occurred! Please try again.");
                        }
                    }
                });
            }
        });

        $('#clearbt').click(function () {
            clearbtdiv()
            hidebtbuttons()
            fillbttable()

        });

        function clearbtdiv() {
            $('#btdesc').val('');
            $('#btid').val('');
            $('#myInputbt').val('');
            $('#tfilbt option:contains("Select Filter")').prop('selected', true);
            $('#messageDiv').css("display", "none");
            $('#messageDiv').html("");
        }

        function clearbtdivtran() {
            $('#btdesc').val('');
            $('#btid').val('');
            $('#myInputbt').val('');
            $('#tfilbt option:contains("Select Filter")').prop('selected', true);
        }

        function hidebtbuttons() {
            if ($("#btid").val() != '' || $("#btid").val() != 'blank') {
                $('#savebt').hide()
                $('#updatebt').show()
                $('#deletebt').show()
            }
            if ($("#btid").val() == '' || $("#btid").val() == 'blank') {
                $('#savebt').show()
                $('#updatebt').hide()
                $('#deletebt').hide()
            }
        }

        function fillbttable() {
            $('#bttable tbody').remove();
            $.ajax({
                url: "BTDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    for (var i = 0; i < list.length; i++) {
                        trHTML += '<tr><td id="tabbtid">' + list[i].btID + '</td><td>' + list[i].btDesc + '</td></tr>';
                    }
                    $('#bttable').append(trHTML);
                }
            });
        }

        function sortTablebt(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("bttable");
            switching = true;
            dir = "asc";
            while (switching) {
                switching = false;
                rows = table.getElementsByTagName("TR");
                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchcount++;
                } else {
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        function myFunctionbt() {
            var input, filter, table, tr, td, i;
            input = document.getElementById("myInputbt");
            filter = input.value.toUpperCase();
            table = document.getElementById("bttable");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[document.getElementById("tfilbt").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>         

    <!--DIV dd -->
    <script>

        $('#ddtable').click(function (e) {
            var ddid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var dddesc = $(e.target).closest('tr').find("td:nth-child(2)").text();
            $('#dddesc').val(dddesc);
            $('#ddid').val(ddid);
            hideddbuttons()
        });

        $("#savedd").on('click', function () {
            var dddesc = $("#dddesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (dddesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Due Date is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "DDAddServlet",
                dataType: 'json',
                data: {dddesc: dddesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        fillddtable();
                        cleardddiv();
                        hideddbuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#updatedd").on('click', function () {
            var ddid = $("#ddid").val();
            var dddesc = $("#dddesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (ddid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (dddesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Due Date is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "DDUpdateServlet",
                dataType: 'json',
                data: {ddid: ddid,
                    dddesc: dddesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert(json.res);
                        fillddtable();
                        cleardddepdiv();
                        hideddbuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#deletedd").on('click', function () {
            var ddid = $("#ddid").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            var confirmation = confirm("are you sure you want to delete this record?");
            if (ddid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is blank");
                event.preventDefault();
            }
            if (confirmation) {
                $.ajax({
                    url: "DDDeleteServlet",
                    dataType: 'json',
                    data: {ddid: ddid,
                        uname: uname,
                        activestat: activestat},

                    success: function (json) {
                        if (json.res != null) {
                            alert(json.res);
                            fillddtable();
                            cleardddiv();
                            hideddbuttons();
                        } else {
                            event.preventDefault();
                            $('#messageDiv').css("display", "none");
                            $('#messageDiv').html("");
                            alert("Some exception occurred! Please try again.");
                        }
                    }
                });
            }
        });

        $('#cleardd').click(function () {
            cleardddiv()
            hideddbuttons()
            fillddtable()

        });

        function cleardddiv() {
            $('#dddesc').val('');
            $('#ddid').val('');
            $('#myInputdd').val('');
            $('#tfildd option:contains("Select Filter")').prop('selected', true);
            $('#messageDiv').css("display", "none");
            $('#messageDiv').html("");
        }

        function cleardddivtran() {
            $('#dddesc').val('');
            $('#ddid').val('');
            $('#myInputdd').val('');
            $('#tfildd option:contains("Select Filter")').prop('selected', true);
        }

        function hideddbuttons() {
            if ($("#ddid").val() != '' || $("#ddid").val() != 'blank') {
                $('#savedd').hide()
                $('#updatedd').show()
                $('#deletedd').show()
            }
            if ($("#ddid").val() == '' || $("#ddid").val() == 'blank') {
                $('#savedd').show()
                $('#updatedd').hide()
                $('#deletedd').hide()
            }
        }

        function fillddtable() {
            $('#ddtable tbody').remove();
            $.ajax({
                url: "DDDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    for (var i = 0; i < list.length; i++) {
                        trHTML += '<tr><td id="tabddid">' + list[i].dueDateID + '</td><td>' + list[i].dueDateDesc + '</td></tr>';
                    }
                    $('#ddtable').append(trHTML);
                }
            });
        }

        function sortTabledd(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("ddtable");
            switching = true;
            dir = "asc";
            while (switching) {
                switching = false;
                rows = table.getElementsByTagName("TR");
                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchcount++;
                } else {
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        function myFunctiondd() {
            var input, filter, table, tr, td, i;
            input = document.getElementById("myInputdd");
            filter = input.value.toUpperCase();
            table = document.getElementById("ddtable");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[document.getElementById("tfildd").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>             
    
    
    <!--DIV cam -->
    <script>

        $('#camtable').click(function (e) {
            var camid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var camdesc = $(e.target).closest('tr').find("td:nth-child(3)").text();
            var camcode = $(e.target).closest('tr').find("td:nth-child(2)").text();
            $('#camdesc').val(camdesc);
            $('#camcode').val(camcode);
            $('#camid').val(camid);
            hidecambuttons()
        });

        $("#savecam").on('click', function () {
            var camcode = $("#camcode").val();
            var camdesc = $("#camdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (camcode == "") {
                $('#messageDivDep').css("display", "none");
                alert("Credit Approval Medium Code is required");
                event.preventDefault();
                return false;
            }
            if (camdesc == "") {
                $('#messageDivDep').css("display", "none");
                alert("Credit Approval Medium is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "CAMAddServlet",
                dataType: 'json',
                data: {camcode: camcode
                    , camdesc: camdesc
                    , uname: uname
                    , activestat: activestat},

                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        fillcamtable();
                        clearcamdiv();
                        hidecambuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#updatecam").on('click', function () {
            var camid = $("#camid").val();
            var camcode = $("#camcode").val();
            var camdesc = $("#camdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (camid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (camcode == "") {
                $('#messageDiv').css("display", "none");
                alert("Credit Approval Medium Code is required");
                event.preventDefault();
                return false;
            }
            if (camdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Credit Approval Medium is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "CAMUpdateServlet",
                dataType: 'json',
                data: {camid: camid,
                    camcode: camcode,
                    camdesc: camdesc,
                    uname: uname,
                    activestat: activestat},

                success: function (json) {
                    if (json.res != null) {
                        alert(json.res);
                        fillcamtable();
                        clearcamdepdiv();
                        hidecambuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#deletecam").on('click', function () {
            var camid = $("#camid").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();
            var confirmation = confirm("are you sure you want to delete this record?");
            if (camid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is blank");
                event.preventDefault();
            }
            if (confirmation) {
                $.ajax({
                    url: "CAMDeleteServlet",
                    dataType: 'json',
                    data: {camid: camid
                        , uname: uname
                        , activestat: activestat},
                    success: function (json) {
                        if (json.res != null) {
                            alert(json.res);
                            fillcamtable();
                            clearcamdiv();
                            hidecambuttons();
                        } else {
                            event.preventDefault();
                            $('#messageDiv').css("display", "none");
                            $('#messageDiv').html("");
                            alert("Some exception occurred! Please try again.");
                        }
                    }
                });
            }
        });

        $('#clearcam').click(function () {
            clearcamdiv()
            hidecambuttons()
            fillcamtable()

        });

        function clearcamdiv() {
            $('#camdesc').val('');
            $('#camid').val('');
            $('#camcode').val('');
            $('#myInputcam').val('');
            $('#tfilcam option:contains("Select Filter")').prop('selected', true);
            $('#messageDiv').css("display", "none");
            $('#messageDiv').html("");
        }

        function clearcamdivtran() {
            $('#camdesc').val('');
            $('#camid').val('');
            $('#camcode').val('');
            $('#myInputcam').val('');
            $('#tfilcam option:contains("Select Filter")').prop('selected', true);
        }

        function hidecambuttons() {
            if ($("#camid").val() != '' || $("#camid").val() != 'blank') {
                $('#savecam').hide()
                $('#updatecam').show()
                $('#deletecam').show()
            }
            if ($("#camid").val() == '' || $("#camid").val() == 'blank') {
                $('#savecam').show()
                $('#updatecam').hide()
                $('#deletecam').hide()
            }
        }

        function fillcamtable() {
            $('#camtable tbody').remove();
            $.ajax({
                url: "CAMDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    for (var i = 0; i < list.length; i++) {
                        trHTML += '<tr><td id="tabcamid">' + list[i].camID + '</td><td>' + list[i].camCode + '</td><td>' + list[i].camDesc + '</td></tr>';
                    }
                    $('#camtable').append(trHTML);
                }
            });
        }

        function sortTablecam(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("camtable");
            switching = true;

            dir = "asc";

            while (switching) {
                switching = false;
                rows = table.getElementsByTagName("TR");

                for (i = 1; i < (rows.length - 1); i++) {

                    shouldSwitch = false;

                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];

                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {

                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;

                    switchcount++;
                } else {

                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        function myFunctioncam() {
            var input, filter, table, tr, td, i;

            input = document.getElementById("myInputcam");
            filter = input.value.toUpperCase();
            table = document.getElementById("camtable");
            tr = table.getElementsByTagName("tr");

            for (i = 0; i < tr.length; i++) {

                td = tr[i].getElementsByTagName("td")[document.getElementById("tfilcam").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>              

    <!--DIV cf -->
    <script>

        $('#cftable').click(function (e) {
            var cfid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var cfdesc = $(e.target).closest('tr').find("td:nth-child(2)").text();
            $('#cfdesc').val(cfdesc);
            $('#cfid').val(cfid);
            hidecfbuttons()
        });

        $("#savecf").on('click', function () {
            var cfdesc = $("#cfdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (cfdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Credit Facility is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "CreditFacilityAddServlet",
                dataType: 'json',
                data: {cfdesc: cfdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        fillcftable();
                        clearcfdiv();
                        hidecfbuttons();
                        //showMessage(json);
                        //$('#messageDiv').css("display", "block");
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#updatecf").on('click', function () {
            var cfid = $("#cfid").val();
            var cfdesc = $("#cfdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (cfid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (cfdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Credit Facility is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "CreditFacilityUpdateServlet",
                dataType: 'json',
                data: {cfid: cfid,
                    cfdesc: cfdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert(json.res);
                        fillcftable();
                        clearcfdepdiv();
                        hidecfbuttons();
                        //showMessage(json);
                        //$('#messageDiv').css("display", "block");
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#deletecf").on('click', function () {
            var cfid = $("#cfid").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            var confirmation = confirm("are you sure you want to delete this record?");
            if (cfid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is blank");
                event.preventDefault();
            }
            if (confirmation) {
                $.ajax({
                    url: "CreditFacilityDeleteServlet",
                    dataType: 'json',
                    data: {cfid: cfid,
                        uname: uname,
                        activestat: activestat},
                    success: function (json) {
                        if (json.res != null) {
                            alert(json.res);
                            fillcftable();
                            clearcfdiv();
                            hidecfbuttons();
                            //showMessage(json);
                            //$('#messageDiv').css("display", "block");

                        } else {
                            event.preventDefault();
                            $('#messageDiv').css("display", "none");
                            $('#messageDiv').html("");
                            alert("Some exception occurred! Please try again.");
                        }
                    }
                });
            }
        });

        $('#clearcf').click(function () {
            clearcfdiv()
            hidecfbuttons()
            fillcftable()

        });

        function clearcfdiv() {
            $('#cfdesc').val('');
            $('#cfid').val('');
            $('#myInputcf').val('');
            $('#tfilcf option:contains("Select Filter")').prop('selected', true);
            $('#messageDiv').css("display", "none");
            $('#messageDiv').html("");
        }

        function clearcfdivtran() {
            $('#cfdesc').val('');
            $('#cfid').val('');
            $('#myInputcf').val('');
            $('#tfilcf option:contains("Select Filter")').prop('selected', true);
        }

        function hidecfbuttons() {
            if ($("#cfid").val() != '' || $("#cfid").val() != 'blank') {
                $('#savecf').hide()
                $('#updatecf').show()
                $('#deletecf').show()
            }
            if ($("#cfid").val() == '' || $("#cfid").val() == 'blank') {
                $('#savecf').show()
                $('#updatecf').hide()
                $('#deletecf').hide()
            }
        }

        function fillcftable() {
            $('#cftable tbody').remove();
            $.ajax({
                url: "CreditFacilityDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    for (var i = 0; i < list.length; i++) {
                        trHTML += '<tr><td id="tabcfid">' + list[i].cfID + '</td><td>' + list[i].cfDesc + '</td></tr>';
                    }
                    $('#cftable').append(trHTML);
                }
            });
        }

        function sortTablecf(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("cftable");
            switching = true;
            //Set the sorting direction to ascending:
            dir = "asc";
            /*Make a loop that will continue until
             no switching has been done:*/
            while (switching) {
                //start by saying: no switching is done:
                switching = false;
                rows = table.getElementsByTagName("TR");
                /*Loop through all table rows (except the
                 first, which contains table headers):*/
                for (i = 1; i < (rows.length - 1); i++) {
                    //start by saying there should be no switching:
                    shouldSwitch = false;
                    /*Get the two elements you want to compare,
                     one from current row and one from the next:*/
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    /*check if the two rows should switch place,
                     based on the direction, asc or desc:*/
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    /*If a switch has been marked, make the switch
                     and mark that a switch has been done:*/
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    //Each time a switch is done, increase this count by 1:
                    switchcount++;
                } else {
                    /*If no switching has been done AND the direction is "asc",
                     set the direction to "desc" and run the while loop again.*/
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        function myFunctioncf() {
            // Declare variables 
            var input, filter, table, tr, td, i;
            //int tabfilter;
            //tabfil = document.getElementById("tablefilter").value;
            //tabfilter = tabfil.value();

            input = document.getElementById("myInputcf");
            filter = input.value.toUpperCase();
            table = document.getElementById("cftable");
            tr = table.getElementsByTagName("tr");
            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {

                td = tr[i].getElementsByTagName("td")[document.getElementById("tfilcf").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>              

    <!--DIV cr -->
    <script>

        $('#crtable').click(function (e) {
            var crid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var crdesc = $(e.target).closest('tr').find("td:nth-child(2)").text();
            $('#crdesc').val(crdesc);
            $('#crid').val(crid);
            hidecrbuttons()
        });

        $("#savecr").on('click', function () {
            var crdesc = $("#crdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (crdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Credit Rating is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "CreditRatingAddServlet",
                dataType: 'json',
                data: {crdesc: crdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        fillcrtable();
                        clearcrdiv();
                        hidecrbuttons();
                        //showMessage(json);
                        //$('#messageDiv').css("display", "block");
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#updatecr").on('click', function () {
            var crid = $("#crid").val();
            var crdesc = $("#crdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (crid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (crdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Credit Rating is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "CreditRatingUpdateServlet",
                dataType: 'json',
                data: {crid: crid,
                    crdesc: crdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert(json.res);
                        fillcrtable();
                        clearcrdepdiv();
                        hidecrbuttons();
                        //showMessage(json);
                        //$('#messageDiv').css("display", "block");
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#deletecr").on('click', function () {
            var crid = $("#crid").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            var confirmation = confirm("are you sure you want to delete this record?");
            if (crid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is blank");
                event.preventDefault();
            }
            if (confirmation) {
                $.ajax({
                    url: "CreditRatingDeleteServlet",
                    dataType: 'json',
                    data: {crid: crid,
                        uname: uname,
                        activestat: activestat},
                    success: function (json) {
                        if (json.res != null) {
                            alert(json.res);
                            fillcrtable();
                            clearcrdiv();
                            hidecrbuttons();
                            //showMessage(json);
                            //$('#messageDiv').css("display", "block");

                        } else {
                            event.preventDefault();
                            $('#messageDiv').css("display", "none");
                            $('#messageDiv').html("");
                            alert("Some exception occurred! Please try again.");
                        }
                    }
                });
            }
        });

        $('#clearcr').click(function () {
            clearcrdiv()
            hidecrbuttons()
            fillcrtable()

        });

        function clearcrdiv() {
            $('#crdesc').val('');
            $('#crid').val('');
            $('#myInputcr').val('');
            $('#tfilcr option:contains("Select Filter")').prop('selected', true);
            $('#messageDiv').css("display", "none");
            $('#messageDiv').html("");
        }

        function clearcrdivtran() {
            $('#crdesc').val('');
            $('#crid').val('');
            $('#myInputcr').val('');
            $('#tfilcr option:contains("Select Filter")').prop('selected', true);
        }

        function hidecrbuttons() {
            if ($("#crid").val() != '' || $("#crid").val() != 'blank') {
                $('#savecr').hide()
                $('#updatecr').show()
                $('#deletecr').show()
            }
            if ($("#crid").val() == '' || $("#crid").val() == 'blank') {
                $('#savecr').show()
                $('#updatecr').hide()
                $('#deletecr').hide()
            }
        }

        function fillcrtable() {
            $('#crtable tbody').remove();
            $.ajax({
                url: "CreditRatingDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    for (var i = 0; i < list.length; i++) {
                        trHTML += '<tr><td id="tabcrid">' + list[i].crID + '</td><td>' + list[i].crDesc + '</td></tr>';
                    }
                    $('#crtable').append(trHTML);
                }
            });
        }

        function sortTablecr(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("crtable");
            switching = true;
            //Set the sorting direction to ascending:
            dir = "asc";
            /*Make a loop that will continue until
             no switching has been done:*/
            while (switching) {
                //start by saying: no switching is done:
                switching = false;
                rows = table.getElementsByTagName("TR");
                /*Loop through all table rows (except the
                 first, which contains table headers):*/
                for (i = 1; i < (rows.length - 1); i++) {
                    //start by saying there should be no switching:
                    shouldSwitch = false;
                    /*Get the two elements you want to compare,
                     one from current row and one from the next:*/
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    /*check if the two rows should switch place,
                     based on the direction, asc or desc:*/
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    /*If a switch has been marked, make the switch
                     and mark that a switch has been done:*/
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    //Each time a switch is done, increase this count by 1:
                    switchcount++;
                } else {
                    /*If no switching has been done AND the direction is "asc",
                     set the direction to "desc" and run the while loop again.*/
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        function myFunctioncr() {
            // Declare variables 
            var input, filter, table, tr, td, i;
            //int tabfilter;
            //tabfil = document.getElementById("tablefilter").value;
            //tabfilter = tabfil.value();

            input = document.getElementById("myInputcr");
            filter = input.value.toUpperCase();
            table = document.getElementById("crtable");
            tr = table.getElementsByTagName("tr");
            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {

                td = tr[i].getElementsByTagName("td")[document.getElementById("tfilcr").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>           

    <!--DIV lag -->
    <script>

        $('#lagtable').click(function (e) {
            var lagid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var lagdesc = $(e.target).closest('tr').find("td:nth-child(2)").text();
            $('#lagdesc').val(lagdesc);
            $('#lagid').val(lagid);
            hidelagbuttons()
        });

        $("#savelag").on('click', function () {
            var lagdesc = $("#lagdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (lagdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("LAG is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "LAGAddServlet",
                dataType: 'json',
                data: {lagdesc: lagdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        filllagtable();
                        clearlagdiv();
                        hidelagbuttons();
                        //showMessage(json);
                        //$('#messageDiv').css("display", "block");
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#updatelag").on('click', function () {
            var lagid = $("#lagid").val();
            var lagdesc = $("#lagdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (lagid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (lagdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("LAG is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "LAGUpdateServlet",
                dataType: 'json',
                data: {lagid: lagid,
                    lagdesc: lagdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert(json.res);
                        filllagtable();
                        clearlagdepdiv();
                        hidelagbuttons();
                        //showMessage(json);
                        //$('#messageDiv').css("display", "block");
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#deletelag").on('click', function () {
            var lagid = $("#lagid").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();
            var confirmation = confirm("are you sure you want to delete this record?");
            if (lagid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is blank");
                event.preventDefault();
            }
            if (confirmation) {
                $.ajax({
                    url: "LAGDeleteServlet",
                    dataType: 'json',
                    data: {lagid: lagid,
                        uname: uname,
                        activestat: activestat},
                    success: function (json) {
                        if (json.res != null) {
                            alert(json.res);
                            filllagtable();
                            clearlagdiv();
                            hidelagbuttons();
                            //showMessage(json);
                            //$('#messageDiv').css("display", "block");

                        } else {
                            event.preventDefault();
                            $('#messageDiv').css("display", "none");
                            $('#messageDiv').html("");
                            alert("Some exception occurred! Please try again.");
                        }
                    }
                });
            }
        });

        $('#clearlag').click(function () {
            clearlagdiv()
            hidelagbuttons()
            filllagtable()

        });

        function clearlagdiv() {
            $('#lagdesc').val('');
            $('#lagid').val('');
            $('#myInputlag').val('');
            $('#tfillag option:contains("Select Filter")').prop('selected', true);
            $('#messageDiv').css("display", "none");
            $('#messageDiv').html("");
        }

        function clearlagdivtran() {
            $('#lagdesc').val('');
            $('#lagid').val('');
            $('#myInputlag').val('');
            $('#tfillag option:contains("Select Filter")').prop('selected', true);
        }

        function hidelagbuttons() {
            if ($("#lagid").val() != '' || $("#lagid").val() != 'blank') {
                $('#savelag').hide()
                $('#updatelag').show()
                $('#deletelag').show()
            }
            if ($("#lagid").val() == '' || $("#lagid").val() == 'blank') {
                $('#savelag').show()
                $('#updatelag').hide()
                $('#deletelag').hide()
            }
        }

        function filllagtable() {
            $('#lagtable tbody').remove();
            $.ajax({
                url: "LAGDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    for (var i = 0; i < list.length; i++) {
                        trHTML += '<tr><td id="tablagid">' + list[i].lagID + '</td><td>' + list[i].lagDesc + '</td></tr>';
                    }
                    $('#lagtable').append(trHTML);
                }
            });
        }

        function sortTablelag(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("lagtable");
            switching = true;
            //Set the sorting direction to ascending:
            dir = "asc";
            /*Make a loop that will continue until
             no switching has been done:*/
            while (switching) {
                //start by saying: no switching is done:
                switching = false;
                rows = table.getElementsByTagName("TR");
                /*Loop through all table rows (except the
                 first, which contains table headers):*/
                for (i = 1; i < (rows.length - 1); i++) {
                    //start by saying there should be no switching:
                    shouldSwitch = false;
                    /*Get the two elements you want to compare,
                     one from current row and one from the next:*/
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    /*check if the two rows should switch place,
                     based on the direction, asc or desc:*/
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    /*If a switch has been marked, make the switch
                     and mark that a switch has been done:*/
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    //Each time a switch is done, increase this count by 1:
                    switchcount++;
                } else {
                    /*If no switching has been done AND the direction is "asc",
                     set the direction to "desc" and run the while loop again.*/
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        function myFunctionlag() {
            // Declare variables 
            var input, filter, table, tr, td, i;
            //int tabfilter;
            //tabfil = document.getElementById("tablefilter").value;
            //tabfilter = tabfil.value();

            input = document.getElementById("myInputlag");
            filter = input.value.toUpperCase();
            table = document.getElementById("lagtable");
            tr = table.getElementsByTagName("tr");
            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {

                td = tr[i].getElementsByTagName("td")[document.getElementById("tfillag").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>                  

    <!--DIV soa -->
    <script>

        $('#soatable').click(function (e) {
            var soaid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var soadesc = $(e.target).closest('tr').find("td:nth-child(2)").text();
            $('#soadesc').val(soadesc);
            $('#soaid').val(soaid);
            hidesoabuttons()
        });

        $("#savesoa").on('click', function () {
            var soadesc = $("#soadesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (soadesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Status of Account is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "SOAAddServlet",
                dataType: 'json',
                data: {soadesc: soadesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        fillsoatable();
                        clearsoadiv();
                        hidesoabuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#updatesoa").on('click', function () {
            var soaid = $("#soaid").val();
            var soadesc = $("#soadesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (soaid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (soadesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Status of Account is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "SOAUpdateServlet",
                dataType: 'json',
                data: {soaid: soaid,
                    soadesc: soadesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert(json.res);
                        fillsoatable();
                        clearsoadepdiv();
                        hidesoabuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#deletesoa").on('click', function () {
            var soaid = $("#soaid").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            var confirmation = confirm("are you sure you want to delete this record?");
            if (soaid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is blank");
                event.preventDefault();
            }
            if (confirmation) {
                $.ajax({
                    url: "SOADeleteServlet",
                    dataType: 'json',
                    data: {soaid: soaid,
                        uname: uname,
                        activestat: activestat},

                    success: function (json) {
                        if (json.res != null) {
                            alert(json.res);
                            fillsoatable();
                            clearsoadiv();
                            hidesoabuttons();
                        } else {
                            event.preventDefault();
                            $('#messageDiv').css("display", "none");
                            $('#messageDiv').html("");
                            alert("Some exception occurred! Please try again.");
                        }
                    }
                });
            }
        });

        $('#clearsoa').click(function () {
            clearsoadiv()
            hidesoabuttons()
            fillsoatable()

        });

        function clearsoadiv() {
            $('#soadesc').val('');
            $('#soaid').val('');
            $('#myInputsoa').val('');
            $('#tfilsoa option:contains("Select Filter")').prop('selected', true);
            $('#messageDiv').css("display", "none");
            $('#messageDiv').html("");
        }

        function clearsoadivtran() {
            $('#soadesc').val('');
            $('#soaid').val('');
            $('#myInputsoa').val('');
            $('#tfilsoa option:contains("Select Filter")').prop('selected', true);
        }

        function hidesoabuttons() {
            if ($("#soaid").val() != '' || $("#soaid").val() != 'blank') {
                $('#savesoa').hide()
                $('#updatesoa').show()
                $('#deletesoa').show()
            }
            if ($("#soaid").val() == '' || $("#soaid").val() == 'blank') {
                $('#savesoa').show()
                $('#updatesoa').hide()
                $('#deletesoa').hide()
            }
        }

        function fillsoatable() {
            $('#soatable tbody').remove();
            $.ajax({
                url: "SOADataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    for (var i = 0; i < list.length; i++) {
                        trHTML += '<tr><td id="tabsoaid">' + list[i].soaID + '</td><td>' + list[i].soaDesc + '</td></tr>';
                    }
                    $('#soatable').append(trHTML);
                }
            });
        }

        function sortTablesoa(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("soatable");
            switching = true;
            dir = "asc";
            while (switching) {
                switching = false;
                rows = table.getElementsByTagName("TR");
                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchcount++;
                } else {
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        function myFunctionsoa() {
            var input, filter, table, tr, td, i;
            input = document.getElementById("myInputsoa");
            filter = input.value.toUpperCase();
            table = document.getElementById("soatable");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[document.getElementById("tfilsoa").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>         
    
    
    <!--DIV pf -->
    <script>

        $('#pftable').click(function (e) {
            var pfid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var pfdesc = $(e.target).closest('tr').find("td:nth-child(2)").text();
            $('#pfdesc').val(pfdesc);
            $('#pfid').val(pfid);
            hidepfbuttons()
        });

        $("#savepf").on('click', function () {
            var pfdesc = $("#pfdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (pfdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Payment Frequency is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "PaymentFrequencyAddServlet",
                dataType: 'json',
                data: {pfdesc: pfdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        fillpftable();
                        clearpfdiv();
                        hidepfbuttons();
                        //showMessage(json);
                        //$('#messageDiv').css("display", "block");
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#updatepf").on('click', function () {
            var pfid = $("#pfid").val();
            var pfdesc = $("#pfdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();
            if (pfid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (pfdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Payment Frequency is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "PaymentFrequencyUpdateServlet",
                dataType: 'json',
                data: {pfid: pfid,
                    pfdesc: pfdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert(json.res);
                        fillpftable();
                        clearpfdepdiv();
                        hidepfbuttons();
                        //showMessage(json);
                        //$('#messageDiv').css("display", "block");
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#deletepf").on('click', function () {
            var pfid = $("#pfid").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();
            var confirmation = confirm("are you sure you want to delete this record?");
            if (pfid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is blank");
                event.preventDefault();
            }
            if (confirmation) {
                $.ajax({
                    url: "PaymentFrequencyDeleteServlet",
                    dataType: 'json',
                    data: {pfid: pfid,
                        uname: uname,
                        activestat: activestat},
                    success: function (json) {
                        if (json.res != null) {
                            alert(json.res);
                            fillpftable();
                            clearpfdiv();
                            hidepfbuttons();
                            //showMessage(json);
                            //$('#messageDiv').css("display", "block");

                        } else {
                            event.preventDefault();
                            $('#messageDiv').css("display", "none");
                            $('#messageDiv').html("");
                            alert("Some exception occurred! Please try again.");
                        }
                    }
                });
            }
        });

        $('#clearpf').click(function () {
            clearpfdiv()
            hidepfbuttons()
            fillpftable()

        });

        function clearpfdiv() {
            $('#pfdesc').val('');
            $('#pfid').val('');
            $('#myInputpf').val('');
            $('#tfilpf option:contains("Select Filter")').prop('selected', true);
            $('#messageDiv').css("display", "none");
            $('#messageDiv').html("");
        }

        function clearpfdivtran() {
            $('#pfdesc').val('');
            $('#pfid').val('');
            $('#myInputpf').val('');
            $('#tfilpf option:contains("Select Filter")').prop('selected', true);
        }

        function hidepfbuttons() {
            if ($("#pfid").val() != '' || $("#pfid").val() != 'blank') {
                $('#savepf').hide()
                $('#updatepf').show()
                $('#deletepf').show()
            }
            if ($("#pfid").val() == '' || $("#pfid").val() == 'blank') {
                $('#savepf').show()
                $('#updatepf').hide()
                $('#deletepf').hide()
            }
        }

        function fillpftable() {
            $('#pftable tbody').remove();
            $.ajax({
                url: "PaymentFrequencyDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    for (var i = 0; i < list.length; i++) {
                        trHTML += '<tr><td id="tabpfid">' + list[i].pfID + '</td><td>' + list[i].pfDesc + '</td></tr>';
                    }
                    $('#pftable').append(trHTML);
                }
            });
        }

        function sortTablepf(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("pftable");
            switching = true;
            //Set the sorting direction to ascending:
            dir = "asc";
            /*Make a loop that will continue until
             no switching has been done:*/
            while (switching) {
                //start by saying: no switching is done:
                switching = false;
                rows = table.getElementsByTagName("TR");
                /*Loop through all table rows (except the
                 first, which contains table headers):*/
                for (i = 1; i < (rows.length - 1); i++) {
                    //start by saying there should be no switching:
                    shouldSwitch = false;
                    /*Get the two elements you want to compare,
                     one from current row and one from the next:*/
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    /*check if the two rows should switch place,
                     based on the direction, asc or desc:*/
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    /*If a switch has been marked, make the switch
                     and mark that a switch has been done:*/
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    //Each time a switch is done, increase this count by 1:
                    switchcount++;
                } else {
                    /*If no switching has been done AND the direction is "asc",
                     set the direction to "desc" and run the while loop again.*/
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        function myFunctionpf() {
            // Declare variables 
            var input, filter, table, tr, td, i;
            //int tabfilter;
            //tabfil = document.getElementById("tablefilter").value;
            //tabfilter = tabfil.value();

            input = document.getElementById("myInputpf");
            filter = input.value.toUpperCase();
            table = document.getElementById("pftable");
            tr = table.getElementsByTagName("tr");
            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {

                td = tr[i].getElementsByTagName("td")[document.getElementById("tfilpf").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>                  

    <!--DIV prio -->
    <script>

        $('#priotable').click(function (e) {
            var pid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var pdesc = $(e.target).closest('tr').find("td:nth-child(2)").text();
            $('#pdesc').val(pdesc);
            $('#pid').val(pid);
            hidepriobuttons()
        });

        $("#saveprio").on('click', function () {
            var pdesc = $("#pdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (pdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Priority Description is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "PriorityAddServlet",
                dataType: 'json',
                data: {pdesc: pdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        fillpriotable();
                        clearpriodiv();
                        hidepriobuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#updateprio").on('click', function () {
            var pid = $("#pid").val();
            var pdesc = $("#pdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (pid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (pdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Priority Description is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "PriorityUpdateServlet",
                dataType: 'json',
                data: {pid: pid,
                    pdesc: pdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert(json.res);
                        fillpriotable();
                        clearpriodepdiv();
                        hidepriobuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });
        $("#deleteprio").on('click', function () {
            var pid = $("#pid").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            var confirmation = confirm("are you sure you want to delete this record?");
            if (pid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is blank");
                event.preventDefault();
            }
            if (confirmation) {
                $.ajax({
                    url: "PriorityDeleteServlet",
                    dataType: 'json',
                    data: {pid: pid,
                        uname: uname,
                        activestat: activestat},
                    success: function (json) {
                        if (json.res != null) {
                            alert(json.res);
                            fillpriotable();
                            clearpriodiv();
                            hidepriobuttons();
                            //showMessage(json);
                            //$('#messageDiv').css("display", "block");

                        } else {
                            event.preventDefault();
                            $('#messageDiv').css("display", "none");
                            $('#messageDiv').html("");
                            alert("Some exception occurred! Please try again.");
                        }
                    }
                });
            }
        });

        $('#clearprio').click(function () {
            clearpriodiv()
            hidepriobuttons()
            fillpriotable()

        });

        function clearpriodiv() {
            $('#pdesc').val('');
            $('#pid').val('');
            $('#myInputprio').val('');
            $('#tfilprio option:contains("Select Filter")').prop('selected', true);
            $('#messageDiv').css("display", "none");
            $('#messageDiv').html("");
        }

        function clearpriodivtran() {
            $('#pdesc').val('');
            $('#pid').val('');
            $('#myInputprio').val('');
            $('#tfilprio option:contains("Select Filter")').prop('selected', true);
        }

        function hidepriobuttons() {
            if ($("#pid").val() != '' || $("#pid").val() != 'blank') {
                $('#saveprio').hide()
                $('#updateprio').show()
                $('#deleteprio').show()
            }
            if ($("#pid").val() == '' || $("#pid").val() == 'blank') {
                $('#saveprio').show()
                $('#updateprio').hide()
                $('#deleteprio').hide()
            }
        }

        function fillpriotable() {
            $('#priotable tbody').remove();
            $.ajax({
                url: "PriorityDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    for (var i = 0; i < list.length; i++) {
                        trHTML += '<tr><td id="tabprioid">' + list[i].priorityID + '</td><td>' + list[i].priorityDesc + '</td></tr>';
                    }
                    $('#priotable').append(trHTML);
                }
            });
        }

        function sortTableprio(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("priotable");
            switching = true;
            //Set the sorting direction to ascending:
            dir = "asc";
            /*Make a loop that will continue until
             no switching has been done:*/
            while (switching) {
                //start by saying: no switching is done:
                switching = false;
                rows = table.getElementsByTagName("TR");
                /*Loop through all table rows (except the
                 first, which contains table headers):*/
                for (i = 1; i < (rows.length - 1); i++) {
                    //start by saying there should be no switching:
                    shouldSwitch = false;
                    /*Get the two elements you want to compare,
                     one from current row and one from the next:*/
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    /*check if the two rows should switch place,
                     based on the direction, asc or desc:*/
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    /*If a switch has been marked, make the switch
                     and mark that a switch has been done:*/
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    //Each time a switch is done, increase this count by 1:
                    switchcount++;
                } else {
                    /*If no switching has been done AND the direction is "asc",
                     set the direction to "desc" and run the while loop again.*/
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        function myFunctionprio() {
            // Declare variables 
            var input, filter, table, tr, td, i;
            //int tabfilter;
            //tabfil = document.getElementById("tablefilter").value;
            //tabfilter = tabfil.value();

            input = document.getElementById("myInputprio");
            filter = input.value.toUpperCase();
            table = document.getElementById("priotable");
            tr = table.getElementsByTagName("tr");
            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {

                td = tr[i].getElementsByTagName("td")[document.getElementById("tfilprio").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>              

    <!--DIV psic -->
    <script>

        $('#psictable').click(function (e) {
            var psicid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var psicdesc = $(e.target).closest('tr').find("td:nth-child(3)").text();
            var psiccode = $(e.target).closest('tr').find("td:nth-child(2)").text();
            $('#psicdesc').val(psicdesc);
            $('#psiccode').val(psiccode);
            $('#psicid').val(psicid);
            hidepsicbuttons()
        });

        $("#savepsic").on('click', function () {
            var psiccode = $("#psiccode").val();
            var psicdesc = $("#psicdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (psiccode == "") {
                $('#messageDivDep').css("display", "none");
                alert("PSIC Code is required");
                event.preventDefault();
                return false;
            }
            if (psicdesc == "") {
                $('#messageDivDep').css("display", "none");
                alert("Industry is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "PSICAddServlet",
                dataType: 'json',
                data: {psiccode: psiccode
                    , psicdesc: psicdesc
                    , uname: uname
                    , activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        fillpsictable();
                        clearpsicdiv();
                        hidepsicbuttons();

                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#updatepsic").on('click', function () {
            var psicid = $("#psicid").val();
            var psiccode = $("#psiccode").val();
            var psicdesc = $("#psicdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (psicid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (psiccode == "") {
                $('#messageDiv').css("display", "none");
                alert("PSIC Code is required");
                event.preventDefault();
                return false;
            }
            if (psicdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Industry is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "PSICUpdateServlet",
                dataType: 'json',
                data: {psicid: psicid,
                    psiccode: psiccode,
                    psicdesc: psicdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert(json.res);
                        fillpsictable();
                        clearpsicdepdiv();
                        hidepsicbuttons();

                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#deletepsic").on('click', function () {
            var psicid = $("#psicid").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            var confirmation = confirm("are you sure you want to delete this record?");
            if (psicid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is blank");
                event.preventDefault();
            }
            if (confirmation) {
                $.ajax({
                    url: "PSICDeleteServlet",
                    dataType: 'json',
                    data: {psicid: psicid,
                        uname: uname,
                        activestat: activestat},
                    success: function (json) {
                        if (json.res != null) {
                            alert(json.res);
                            fillpsictable();
                            clearpsicdiv();
                            hidepsicbuttons();

                        } else {
                            event.preventDefault();
                            $('#messageDiv').css("display", "none");
                            $('#messageDiv').html("");
                            alert("Some exception occurred! Please try again.");
                        }
                    }
                });
            }
        });

        $('#clearpsic').click(function () {
            clearpsicdiv()
            hidepsicbuttons()
            fillpsictable()

        });

        function clearpsicdiv() {
            $('#psicdesc').val('');
            $('#psicid').val('');
            $('#psiccode').val('');
            $('#myInputpsic').val('');
            $('#tfilpsic option:contains("Select Filter")').prop('selected', true);
            $('#messageDiv').css("display", "none");
            $('#messageDiv').html("");
        }

        function clearpsicdivtran() {
            $('#psicdesc').val('');
            $('#psicid').val('');
            $('#psiccode').val('');
            $('#myInputpsic').val('');
            $('#tfilpsic option:contains("Select Filter")').prop('selected', true);
        }

        function hidepsicbuttons() {
            if ($("#psicid").val() != '' || $("#psicid").val() != 'blank') {
                $('#savepsic').hide()
                $('#updatepsic').show()
                $('#deletepsic').show()
            }
            if ($("#psicid").val() == '' || $("#psicid").val() == 'blank') {
                $('#savepsic').show()
                $('#updatepsic').hide()
                $('#deletepsic').hide()
            }
        }

        function fillpsictable() {
            $('#psictable tbody').remove();
            $.ajax({
                url: "PSICDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    for (var i = 0; i < list.length; i++) {
                        trHTML += '<tr><td id="tabpsicid">' + list[i].psicID + '</td><td>' + list[i].psicCode + '</td><td>' + list[i].psicDesc + '</td></tr>';
                    }
                    $('#psictable').append(trHTML);
                }
            });
        }

        function sortTablepsic(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("psictable");
            switching = true;
            dir = "asc";

            while (switching) {
                switching = false;
                rows = table.getElementsByTagName("TR");
                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;

                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchcount++;
                } else {
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        function myFunctionpsic() {
            var input, filter, table, tr, td, i;
            input = document.getElementById("myInputpsic");
            filter = input.value.toUpperCase();
            table = document.getElementById("psictable");
            tr = table.getElementsByTagName("tr");

            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[document.getElementById("tfilpsic").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>            

    <!--DIV sec -->
    <script>

        $('#sectable').click(function (e) {
            var secid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var secdesc = $(e.target).closest('tr').find("td:nth-child(2)").text();
            $('#secdesc').val(secdesc);
            $('#secid').val(secid);
            hidesecbuttons()
        });

        $("#savesec").on('click', function () {
            var secdesc = $("#secdesc").val();
            var action = "add";
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (secdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Security Description is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "SecurityTableAddServlet",
                dataType: 'json',
                data: {secdesc: secdesc,
                    action: action,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        fillsectable();
                        clearsecdiv();
                        hidesecbuttons();
                        //showMessage(json);
                        //$('#messageDiv').css("display", "block");
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#updatesec").on('click', function () {
            var secid = $("#secid").val();
            var secdesc = $("#secdesc").val();
            var action = "update";
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (secid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (secdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Security Description is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "SecurityTableUpdateServlet",
                dataType: 'json',
                data: {secid: secid,
                    secdesc: secdesc,
                    action: action,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert(json.res);
                        fillsectable();
                        clearsecdepdiv();
                        hidesecbuttons();
                        //showMessage(json);
                        //$('#messageDiv').css("display", "block");
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#deletesec").on('click', function () {
            var secid = $("#secid").val();
            var action = "delete";
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            var confirmation = confirm("are you sure you want to delete this record?");
            if (secid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is blank");
                event.preventDefault();
            }
            if (confirmation) {
                $.ajax({
                    url: "SecurityTableDeleteServlet",
                    dataType: 'json',
                    data: {secid: secid,
                        action: action,
                        uname: uname,
                        activestat: activestat},
                    success: function (json) {
                        if (json.res != null) {
                            alert(json.res);
                            fillsectable();
                            clearsecdiv();
                            hidesecbuttons();
                            //showMessage(json);
                            //$('#messageDiv').css("display", "block");

                        } else {
                            event.preventDefault();
                            $('#messageDiv').css("display", "none");
                            $('#messageDiv').html("");
                            alert("Some exception occurred! Please try again.");
                        }
                    }
                });
            }
        });

        $('#clearsec').click(function () {
            clearsecdiv()
            hidesecbuttons()
            fillsectable()

        });

        function clearsecdiv() {
            $('#secdesc').val('');
            $('#secid').val('');
            $('#myInputsec').val('');
            $('#tfilsec option:contains("Select Filter")').prop('selected', true);
            $('#messageDiv').css("display", "none");
            $('#messageDiv').html("");
        }

        function clearsecdivtran() {
            $('#secdesc').val('');
            $('#secid').val('');
            $('#myInputsec').val('');
            $('#tfilsec option:contains("Select Filter")').prop('selected', true);
        }

        function hidesecbuttons() {
            if ($("#secid").val() != '' || $("#secid").val() != 'blank') {
                $('#savesec').hide()
                $('#updatesec').show()
                $('#deletesec').show()
            }
            if ($("#secid").val() == '' || $("#secid").val() == 'blank') {
                $('#savesec').show()
                $('#updatesec').hide()
                $('#deletesec').hide()
            }
        }

        function fillsectable() {
            $('#sectable tbody').remove();
            $.ajax({
                url: "SecurityTableDataServlet",
                data: {action: "data"},
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    for (var i = 0; i < list.length; i++) {
                        trHTML += '<tr><td id="tabsecid">' + list[i].secID + '</td><td>' + list[i].secDesc + '</td></tr>';
                    }
                    $('#sectable').append(trHTML);
                }
            });
        }

        function sortTablesec(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("sectable");
            switching = true;
            //Set the sorting direction to ascending:
            dir = "asc";
            /*Make a loop that will continue until
             no switching has been done:*/
            while (switching) {
                //start by saying: no switching is done:
                switching = false;
                rows = table.getElementsByTagName("TR");
                /*Loop through all table rows (except the
                 first, which contains table headers):*/
                for (i = 1; i < (rows.length - 1); i++) {
                    //start by saying there should be no switching:
                    shouldSwitch = false;
                    /*Get the two elements you want to compare,
                     one from current row and one from the next:*/
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    /*check if the two rows should switch place,
                     based on the direction, asc or desc:*/
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    /*If a switch has been marked, make the switch
                     and mark that a switch has been done:*/
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    //Each time a switch is done, increase this count by 1:
                    switchcount++;
                } else {
                    /*If no switching has been done AND the direction is "asc",
                     set the direction to "desc" and run the while loop again.*/
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        function myFunctionsec() {
            // Declare variables 
            var input, filter, table, tr, td, i;
            //int tabfilter;
            //tabfil = document.getElementById("tablefilter").value;
            //tabfilter = tabfil.value();

            input = document.getElementById("myInputsec");
            filter = input.value.toUpperCase();
            table = document.getElementById("sectable");
            tr = table.getElementsByTagName("tr");
            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {

                td = tr[i].getElementsByTagName("td")[document.getElementById("tfilsec").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>                      

    <!--DIV servicing branch -->    
    <script>
        function fillsbtable() {
            $('#sbtable tbody').remove();
            $.ajax({
                url: "ServicingBranchDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    for (var i = 0; i < list.length; i++) {
                        trHTML += '<tr><td id="tabsbid">' + list[i].sbID + '</td><td>' + list[i].sbCode + '</td><td>' + list[i].sbShort + '</td><td>' + list[i].sbDesc + '</td></tr>';
                    }
                    $('#sbtable').append(trHTML);
                }
            });
        }
        ;

        $('#sbtable').click(function (e) {
            var sbid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var sbdesc = $(e.target).closest('tr').find("td:nth-child(4)").text();
            var sbcode = $(e.target).closest('tr').find("td:nth-child(2)").text();
            var sbshort = $(e.target).closest('tr').find("td:nth-child(3)").text();
            $('#sbdesc').val(sbdesc);
            $('#sbcode').val(sbcode);
            $('#sbid').val(sbid);
            $('#sbshort').val(sbshort);
            hidesbbuttons()
        });

        function hidesbbuttons() {
            if ($("#sbid").val() != '' || $("#sbid").val() != 'blank') {
                $('#savesb').hide();
                $('#updatesb').show();
                $('#deletesb').show();
            }
            if ($("#sbid").val() == '' || $("#sbid").val() == 'blank') {
                $('#savesb').show();
                $('#updatesb').hide();
                $('#deletesb').hide();
            }
        }
        ;

        function sortTableprio(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("sbtable");
            switching = true;
            //Set the sorting direction to ascending:
            dir = "asc";
            /*Make a loop that will continue until
             no switching has been done:*/
            while (switching) {
                //start by saying: no switching is done:
                switching = false;
                rows = table.getElementsByTagName("TR");
                /*Loop through all table rows (except the
                 first, which contains table headers):*/
                for (i = 1; i < (rows.length - 1); i++) {
                    //start by saying there should be no switching:
                    shouldSwitch = false;
                    /*Get the two elements you want to compare,
                     one from current row and one from the next:*/
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    /*check if the two rows should switch place,
                     based on the direction, asc or desc:*/
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            //if so, mark as a switch and break the loop:
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    /*If a switch has been marked, make the switch
                     and mark that a switch has been done:*/
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    //Each time a switch is done, increase this count by 1:
                    switchcount++;
                } else {
                    /*If no switching has been done AND the direction is "asc",
                     set the direction to "desc" and run the while loop again.*/
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }
        ;

        function myFunctionsb() {
            var input, filter, table, tr, td, i;
            input = document.getElementById("myInputsb");
            filter = input.value.toUpperCase();
            table = document.getElementById("sbtable");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[document.getElementById("tfilsb").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
        ;

        $("#updatesb").on('click', function () {
            var sbid = $("#sbid").val();
            var sbcode = $("#sbcode").val();
            var sbshort = $("#sbshort").val();
            var sbdesc = $("#sbdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();
            if (sbid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (sbcode == "") {
                $('#messageDiv').css("display", "none");
                alert("Branch Code is required");
                event.preventDefault();
                return false;
            }
            if (sbshort == "") {
                $('#messageDiv').css("display", "none");
                alert("Branch Short is required");
                event.preventDefault();
                return false;
            }
            if (sbdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Branch Name is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "ServicingBranchUpdateServlet",
                dataType: 'json',
                data: {sbid: sbid,
                    sbcode: sbcode,
                    sbshort: sbshort,
                    sbdesc: sbdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert(json.res);
                        fillsbtable();
                        clearsbdepdiv();
                        hidesbbuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#savesb").on('click', function () {
            var sbcode = $("#sbcode").val();
            var sbshort = $("#sbshort").val();
            var sbdesc = $("#sbdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();
            if (sbcode == "") {
                $('#messageDivDep').css("display", "none");
                alert("Branch Code is required");
                event.preventDefault();
                return false;
            }
            if (sbshort == "") {
                $('#messageDivDep').css("display", "none");
                alert("Branch Short is required");
                event.preventDefault();
                return false;
            }
            if (sbdesc == "") {
                $('#messageDivDep').css("display", "none");
                alert("Branch Name is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "ServicingBranchAddServlet",
                dataType: 'json',
                data: {sbcode: sbcode
                    , sbshort: sbshort
                    , sbdesc: sbdesc
                    , uname: uname
                    , activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        fillsbtable();
                        clearsbdiv();
                        hidesbbuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $('#clearsb').click(function () {
            clearsbdiv()
            hidesbbuttons()
            fillsbtable()
        });

        function clearsbdiv() {
            $('#sbdesc').val('');
            $('#sbid').val('');
            $('#sbcode').val('');
            $('#sbshort').val('');
            $('#myInputsb').val('');
            $('#tfilsb option:contains("Select Filter")').prop('selected', true);
            $('#messageDiv').css("display", "none");
            $('#messageDiv').html("");
        }
        ;

        function clearsbdivtran() {
            $('#sbdesc').val('');
            $('#sbid').val('');
            $('#sbcode').val('');
            $('#sbshort').val('');
            $('#myInputsb').val('');
            $('#tfilsb option:contains("Select Filter")').prop('selected', true);
        }
        ;

        $("#deletesb").on('click', function () {
            var sbid = $("#sbid").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();
            var confirmation = confirm("are you sure you want to delete this record?");
            if (sbid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is blank");
                event.preventDefault();
            }
            if (confirmation) {
                $.ajax({
                    url: "ServicingBranchDeleteServlet",
                    dataType: 'json',
                    data: {sbid: sbid,
                        uname: uname,
                        activestat: activestat},
                    success: function (json) {
                        if (json.res != null) {
                            alert(json.res);
                            fillsbtable();
                            clearsbdiv();
                            hidesbbuttons();
                        } else {
                            event.preventDefault();
                            $('#messageDiv').css("display", "none");
                            $('#messageDiv').html("");
                            alert("Some exception occurred! Please try again.");
                        }
                    }
                });
            }
        });
    </script>

    <!--DIV as -->
    <script>

        $('#astable').click(function (e) {
            var asid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var asdesc = $(e.target).closest('tr').find("td:nth-child(2)").text();
            $('#asdesc').val(asdesc);
            $('#asid').val(asid);
            hideasbuttons()
        });

        $("#saveas").on('click', function () {
            var asdesc = $("#asdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (asdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Interest Basis is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "ASAddServlet",
                dataType: 'json',
                data: {asdesc: asdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        fillastable();
                        clearasdiv();
                        hideasbuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#updateas").on('click', function () {
            var asid = $("#asid").val();
            var asdesc = $("#asdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (asid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (asdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Borrower Type is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "ASUpdateServlet",
                dataType: 'json',
                data: {asid: asid,
                    asdesc: asdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert(json.res);
                        fillastable();
                        clearasdepdiv();
                        hideasbuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#deleteas").on('click', function () {
            var asid = $("#asid").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            var confirmation = confirm("are you sure you want to delete this record?");
            if (asid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is blank");
                event.preventDefault();
            }
            if (confirmation) {
                $.ajax({
                    url: "ASDeleteServlet",
                    dataType: 'json',
                    data: {asid: asid,
                        uname: uname,
                        activestat: activestat},

                    success: function (json) {
                        if (json.res != null) {
                            alert(json.res);
                            fillastable();
                            clearasdiv();
                            hideasbuttons();
                        } else {
                            event.preventDefault();
                            $('#messageDiv').css("display", "none");
                            $('#messageDiv').html("");
                            alert("Some exception occurred! Please try again.");
                        }
                    }
                });
            }
        });

        $('#clearas').click(function () {
            clearasdiv()
            hideasbuttons()
            fillastable()

        });

        function clearasdiv() {
            $('#asdesc').val('');
            $('#asid').val('');
            $('#myInputas').val('');
            $('#tfilas option:contains("Select Filter")').prop('selected', true);
            $('#messageDiv').css("display", "none");
            $('#messageDiv').html("");
        }

        function clearasdivtran() {
            $('#asdesc').val('');
            $('#asid').val('');
            $('#myInputas').val('');
            $('#tfilas option:contains("Select Filter")').prop('selected', true);
        }

        function hideasbuttons() {
            if ($("#asid").val() != '' || $("#asid").val() != 'blank') {
                $('#saveas').hide()
                $('#updateas').show()
                $('#deleteas').show()
            }
            if ($("#asid").val() == '' || $("#asid").val() == 'blank') {
                $('#saveas').show()
                $('#updateas').hide()
                $('#deleteas').hide()
            }
        }

        function fillastable() {
            $('#astable tbody').remove();
            $.ajax({
                url: "ASDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    for (var i = 0; i < list.length; i++) {
                        trHTML += '<tr><td id="tabasid">' + list[i].asID + '</td><td>' + list[i].asDesc + '</td></tr>';
                    }
                    $('#astable').append(trHTML);
                }
            });
        }

        function sortTableas(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("astable");
            switching = true;
            dir = "asc";
            while (switching) {
                switching = false;
                rows = table.getElementsByTagName("TR");
                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchcount++;
                } else {
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        function myFunctionas() {
            var input, filter, table, tr, td, i;
            input = document.getElementById("myInputas");
            filter = input.value.toUpperCase();
            table = document.getElementById("astable");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[document.getElementById("tfilas").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>             
    
    <!--DIV lc -->
    <script>

        $('#lctable').click(function (e) {
            var lcid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var lcdesc = $(e.target).closest('tr').find("td:nth-child(2)").text();
            $('#lcdesc').val(lcdesc);
            $('#lcid').val(lcid);
            hidelcbuttons()
        });

        $("#savelc").on('click', function () {
            var lcdesc = $("#lcdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (lcdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Borrower Type is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "LCAddServlet",
                dataType: 'json',
                data: {lcdesc: lcdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        filllctable();
                        clearlcdiv();
                        hidelcbuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#updatelc").on('click', function () {
            var lcid = $("#lcid").val();
            var lcdesc = $("#lcdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (lcid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (lcdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Borrower Type is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "LCUpdateServlet",
                dataType: 'json',
                data: {lcid: lcid,
                    lcdesc: lcdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert(json.res);
                        filllctable();
                        clearlcdepdiv();
                        hidelcbuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#deletelc").on('click', function () {
            var lcid = $("#lcid").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            var confirmation = confirm("are you sure you want to delete this record?");
            if (lcid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is blank");
                event.preventDefault();
            }
            if (confirmation) {
                $.ajax({
                    url: "LCDeleteServlet",
                    dataType: 'json',
                    data: {lcid: lcid,
                        uname: uname,
                        activestat: activestat},

                    success: function (json) {
                        if (json.res != null) {
                            alert(json.res);
                            filllctable();
                            clearlcdiv();
                            hidelcbuttons();
                        } else {
                            event.preventDefault();
                            $('#messageDiv').css("display", "none");
                            $('#messageDiv').html("");
                            alert("Some exception occurred! Please try again.");
                        }
                    }
                });
            }
        });

        $('#clearlc').click(function () {
            clearlcdiv()
            hidelcbuttons()
            filllctable()

        });

        function clearlcdiv() {
            $('#lcdesc').val('');
            $('#lcid').val('');
            $('#myInputlc').val('');
            $('#tfillc option:contains("Select Filter")').prop('selected', true);
            $('#messageDiv').css("display", "none");
            $('#messageDiv').html("");
        }

        function clearlcdivtran() {
            $('#lcdesc').val('');
            $('#lcid').val('');
            $('#myInputlc').val('');
            $('#tfillc option:contains("Select Filter")').prop('selected', true);
        }

        function hidelcbuttons() {
            if ($("#lcid").val() != '' || $("#lcid").val() != 'blank') {
                $('#savelc').hide()
                $('#updatelc').show()
                $('#deletelc').show()
            }
            if ($("#lcid").val() == '' || $("#lcid").val() == 'blank') {
                $('#savelc').show()
                $('#updatelc').hide()
                $('#deletelc').hide()
            }
        }

        function filllctable() {
            $('#lctable tbody').remove();
            $.ajax({
                url: "LCDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    for (var i = 0; i < list.length; i++) {
                        trHTML += '<tr><td id="tablcid">' + list[i].lcID + '</td><td>' + list[i].lcDesc + '</td></tr>';
                    }
                    $('#lctable').append(trHTML);
                }
            });
        }

        function sortTablelc(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("lctable");
            switching = true;
            dir = "asc";
            while (switching) {
                switching = false;
                rows = table.getElementsByTagName("TR");
                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchcount++;
                } else {
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        function myFunctionlc() {
            var input, filter, table, tr, td, i;
            input = document.getElementById("myInputlc");
            filter = input.value.toUpperCase();
            table = document.getElementById("lctable");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[document.getElementById("tfillc").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>             
    
    <!--DIV ct -->
    <script>

        $('#cttable').click(function (e) {
            var ctid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var ctdesc = $(e.target).closest('tr').find("td:nth-child(2)").text();
            $('#ctdesc').val(ctdesc);
            $('#ctid').val(ctid);
            hidectbuttons()
        });

        $("#savect").on('click', function () {
            var ctdesc = $("#ctdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (ctdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Client Type is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "CTAddServlet",
                dataType: 'json',
                data: {ctdesc: ctdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        fillcttable();
                        clearctdiv();
                        hidectbuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#updatect").on('click', function () {
            var ctid = $("#ctid").val();
            var ctdesc = $("#ctdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (ctid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (ctdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Client Type is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "CTUpdateServlet",
                dataType: 'json',
                data: {ctid: ctid,
                    ctdesc: ctdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert(json.res);
                        fillcttable();
                        clearctdepdiv();
                        hidectbuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#deletect").on('click', function () {
            var ctid = $("#ctid").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            var confirmation = confirm("are you sure you want to delete this record?");
            if (ctid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is blank");
                event.preventDefault();
            }
            if (confirmation) {
                $.ajax({
                    url: "CTDeleteServlet",
                    dataType: 'json',
                    data: {ctid: ctid,
                        uname: uname,
                        activestat: activestat},

                    success: function (json) {
                        if (json.res != null) {
                            alert(json.res);
                            fillcttable();
                            clearctdiv();
                            hidectbuttons();
                        } else {
                            event.preventDefault();
                            $('#messageDiv').css("display", "none");
                            $('#messageDiv').html("");
                            alert("Some exception occurred! Please try again.");
                        }
                    }
                });
            }
        });

        $('#clearct').click(function () {
            clearctdiv()
            hidectbuttons()
            fillcttable()

        });

        function clearctdiv() {
            $('#ctdesc').val('');
            $('#ctid').val('');
            $('#myInputct').val('');
            $('#tfilct option:contains("Select Filter")').prop('selected', true);
            $('#messageDiv').css("display", "none");
            $('#messageDiv').html("");
        }

        function clearctdivtran() {
            $('#ctdesc').val('');
            $('#ctid').val('');
            $('#myInputct').val('');
            $('#tfilct option:contains("Select Filter")').prop('selected', true);
        }

        function hidectbuttons() {
            if ($("#ctid").val() != '' || $("#ctid").val() != 'blank') {
                $('#savect').hide()
                $('#updatect').show()
                $('#deletect').show()
            }
            if ($("#ctid").val() == '' || $("#ctid").val() == 'blank') {
                $('#savect').show()
                $('#updatect').hide()
                $('#deletect').hide()
            }
        }

        function fillcttable() {
            $('#cttable tbody').remove();
            $.ajax({
                url: "CTDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    for (var i = 0; i < list.length; i++) {
                        trHTML += '<tr><td id="tabctid">' + list[i].ctID + '</td><td>' + list[i].ctDesc + '</td></tr>';
                    }
                    $('#cttable').append(trHTML);
                }
            });
        }

        function sortTablect(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("cttable");
            switching = true;
            dir = "asc";
            while (switching) {
                switching = false;
                rows = table.getElementsByTagName("TR");
                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchcount++;
                } else {
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        function myFunctionct() {
            var input, filter, table, tr, td, i;
            input = document.getElementById("myInputct");
            filter = input.value.toUpperCase();
            table = document.getElementById("cttable");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[document.getElementById("tfilct").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>             

    <!--DIV pt -->
    <script>

        $('#pttable').click(function (e) {
            var ptid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var ptdesc = $(e.target).closest('tr').find("td:nth-child(2)").text();
            $('#ptdesc').val(ptdesc);
            $('#ptid').val(ptid);
            hideptbuttons()
        });

        $("#savept").on('click', function () {
            var ptdesc = $("#ptdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (ptdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Program Tagging is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "PTAddServlet",
                dataType: 'json',
                data: {ptdesc: ptdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert((json.res).substring(0, 5));
                        fillpttable();
                        clearptdiv();
                        hideptbuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#updatept").on('click', function () {
            var ptid = $("#ptid").val();
            var ptdesc = $("#ptdesc").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            if (ptid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (ptdesc == "") {
                $('#messageDiv').css("display", "none");
                alert("Program Tagging is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "PTUpdateServlet",
                dataType: 'json',
                data: {ptid: ptid,
                    ptdesc: ptdesc,
                    uname: uname,
                    activestat: activestat},
                success: function (json) {
                    if (json.res != null) {
                        alert(json.res);
                        fillpttable();
                        clearptdepdiv();
                        hideptbuttons();
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#deletept").on('click', function () {
            var ptid = $("#ptid").val();
            var uname = $("#uname").val();
            var activestat = $("#sisactive").val();

            var confirmation = confirm("are you sure you want to delete this record?");
            if (ptid == "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is blank");
                event.preventDefault();
            }
            if (confirmation) {
                $.ajax({
                    url: "PTDeleteServlet",
                    dataType: 'json',
                    data: {ptid: ptid,
                        uname: uname,
                        activestat: activestat},

                    success: function (json) {
                        if (json.res != null) {
                            alert(json.res);
                            fillpttable();
                            clearptdiv();
                            hideptbuttons();
                        } else {
                            event.preventDefault();
                            $('#messageDiv').css("display", "none");
                            $('#messageDiv').html("");
                            alert("Some exception occurred! Please try again.");
                        }
                    }
                });
            }
        });

        $('#clearpt').click(function () {
            clearptdiv()
            hideptbuttons()
            fillpttable()

        });

        function clearptdiv() {
            $('#ptdesc').val('');
            $('#ptid').val('');
            $('#myInputpt').val('');
            $('#tfilpt option:contains("Select Filter")').prop('selected', true);
            $('#messageDiv').css("display", "none");
            $('#messageDiv').html("");
        }

        function clearptdivtran() {
            $('#ptdesc').val('');
            $('#ptid').val('');
            $('#myInputpt').val('');
            $('#tfilpt option:contains("Select Filter")').prop('selected', true);
        }

        function hideptbuttons() {
            if ($("#ptid").val() != '' || $("#ptid").val() != 'blank') {
                $('#savept').hide()
                $('#updatept').show()
                $('#deletept').show()
            }
            if ($("#ptid").val() == '' || $("#ptid").val() == 'blank') {
                $('#savept').show()
                $('#updatept').hide()
                $('#deletept').hide()
            }
        }

        function fillpttable() {
            $('#pttable tbody').remove();
            $.ajax({
                url: "PTDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    for (var i = 0; i < list.length; i++) {
                        trHTML += '<tr><td id="tabptid">' + list[i].ptID + '</td><td>' + list[i].ptDesc + '</td></tr>';
                    }
                    $('#pttable').append(trHTML);
                }
            });
        }

        function sortTablept(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("pttable");
            switching = true;
            dir = "asc";
            while (switching) {
                switching = false;
                rows = table.getElementsByTagName("TR");
                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchcount++;
                } else {
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        function myFunctionpt() {
            var input, filter, table, tr, td, i;
            input = document.getElementById("myInputpt");
            filter = input.value.toUpperCase();
            table = document.getElementById("pttable");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[document.getElementById("tfilpt").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
    </script>         
        
    <script>
        $("#accordion").accordion();

        $('#updatepsic').hide();
        $('#deletepsic').hide();
        $('#updatecam').hide();
        $('#deletecam').hide();
        $('#updatebt').hide();
        $('#deletebt').hide();
        $('#updatect').hide();
        $('#deletect').hide();        
        $('#updatesb').hide();
        $('#deletesb').hide();
        $('#updateprio').hide();
        $('#deleteprio').hide();
        $('#updatecf').hide();
        $('#deletecf').hide();
        $('#updatepf').hide();
        $('#deletepf').hide();
        $('#updatesec').hide();
        $('#deletesec').hide();
        $('#updatecr').hide();
        $('#deletecr').hide();
        $('#updatelag').hide();
        $('#deletelag').hide();
        $('#updateas').hide();
        $('#deleteas').hide();
        $('#updatelc').hide();
        $('#deletelc').hide();        
        $('#updatedd').hide();
        $('#deletedd').hide();          
        $('#updatesoa').hide();
        $('#deletesoa').hide();              
        $('#updatept').hide();
        $('#deletept').hide();            

        function clearalldiv() {
            document.getElementById("DIVSECVIEW").style.display = "none";
            document.getElementById("DIVBTVIEW").style.display = "none";
            document.getElementById("DIVPTVIEW").style.display = "none";
            document.getElementById("DIVSOAVIEW").style.display = "none";
            document.getElementById("DIVDDVIEW").style.display = "none";
            document.getElementById("DIVCTVIEW").style.display = "none";
            document.getElementById("DIVCAMVIEW").style.display = "none";
            document.getElementById("DIVPSICVIEW").style.display = "none";
            document.getElementById("DIVSBVIEW").style.display = "none";
            document.getElementById("DIVPRIOVIEW").style.display = "none";
            document.getElementById("DIVPFVIEW").style.display = "none";
            document.getElementById("DIVCFVIEW").style.display = "none";
            document.getElementById("DIVCRVIEW").style.display = "none";
            document.getElementById("DIVLAGVIEW").style.display = "none";
            document.getElementById("DIVASVIEW").style.display = "none";
            document.getElementById("DIVLCVIEW").style.display = "none";
        };

        $("#BTdivView").on('click', function () {
            clearalldiv();
            document.getElementById("DIVBTVIEW").style.display = "block";
            fillbttable();
        });

        $("#PTdivView").on('click', function () {
            clearalldiv();
            document.getElementById("DIVPTVIEW").style.display = "block";
            fillpttable();
        });    
    
        $("#SOAdivView").on('click', function () {
            clearalldiv();
            document.getElementById("DIVSOAVIEW").style.display = "block";
            fillsoatable();
        });        
        
        $("#DDdivView").on('click', function () {
            clearalldiv();
            document.getElementById("DIVDDVIEW").style.display = "block";
            fillddtable();
        });        

        $("#CTdivView").on('click', function () {
            clearalldiv();
            document.getElementById("DIVCTVIEW").style.display = "block";
            fillcttable();
        });            

        $("#ASdivView").on('click', function () {
            clearalldiv();
            document.getElementById("DIVASVIEW").style.display = "block";
            fillastable();
        });

        $("#LCdivView").on('click', function () {
            clearalldiv();
            document.getElementById("DIVLCVIEW").style.display = "block";
            filllctable();
        });
        
        $("#CAMdivView").on('click', function () {
            clearalldiv();
            document.getElementById("DIVCAMVIEW").style.display = "block";
            fillcamtable();
        });

        $("#CFdivView").on('click', function () {
            clearalldiv();
            document.getElementById("DIVCFVIEW").style.display = "block";
            fillcftable();
        });

        $("#CRdivView").on('click', function () {
            clearalldiv();
            document.getElementById("DIVCRVIEW").style.display = "block";
            fillcrtable();
        });

        $("#LAGdivView").on('click', function () {
            clearalldiv();
            document.getElementById("DIVLAGVIEW").style.display = "block";
            filllagtable();
        });

        $("#PFdivView").on('click', function () {
            clearalldiv();
            document.getElementById("DIVPFVIEW").style.display = "block";
            fillpftable();
        });

        $("#PRIOdivView").on('click', function () {
            clearalldiv();
            document.getElementById("DIVPRIOVIEW").style.display = "block";
            fillpriotable();
        });

        $("#PSICdivView").on('click', function () {
            clearalldiv();
            document.getElementById("DIVPSICVIEW").style.display = "block";
            fillpsictable();
        });

        $("#SECdivView").on('click', function () {
            clearalldiv();
            document.getElementById("DIVSECVIEW").style.display = "block";
            fillsectable();
        });

        $("#SBdivView").on('click', function () {
            clearalldiv();
            document.getElementById("DIVSBVIEW").style.display = "block";
            fillsbtable();
        });

    </script>        

    <script>
        $(document).ready(function () {
            setupTimers();
            function disableBack() {
                window.history.forward();
            }

            window.onload = disableBack();
            window.onpageshow = function (evt) {
                if (evt.persisted)
                    disableBack();                
                setupTimers();
            };
        });
    </script>      

    <script>
        var modal = document.getElementById("myModal");
        var span = document.getElementsByClassName("close")[0];
        modal.style.display = "none";

        // When the user clicks on <span> (x), close the modal
        span.onclick = function () {
            modal.style.display = "none";
        }
        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

        var warningTimeout = 840000;
        var timoutNow = 60000;
        var warningTimerID, timeoutTimerID;

        function startTimer() {
            // window.setTimeout returns an Id that can be used to start and stop a timer
            warningTimerID = window.setTimeout(warningInactive, warningTimeout);
        }

        function warningInactive() {
            window.clearTimeout(warningTimerID);
            timeoutTimerID = window.setTimeout(IdleTimeout, timoutNow);
            modal.style.display = "block";
        }

        function resetTimer() {
            window.clearTimeout(timeoutTimerID);
            window.clearTimeout(warningTimerID);
            startTimer();
        }
        // Logout the user.
        function IdleTimeout() {
            logoutUserStatusIdle();
            window.location.replace("/RMLG/login");
        }

        function setupTimers() {
            document.addEventListener("mousemove", resetTimer, false);
            document.addEventListener("mousedown", resetTimer, false);
            document.addEventListener("keypress", resetTimer, false);
            document.addEventListener("touchmove", resetTimer, false);
            document.addEventListener("onscroll", resetTimer, false);
            startTimer();
        }

        $("#btnStayLoggedIn").on('click', function () {

            resetTimer();
            modal.style.display = "none";
            event.preventDefault();
            //window.location.replace("/RMLG/ViewReports");
        });

        function logoutUserStatusIdle() {
            $.ajax({
                url: 'logout',
                async: true,
                type: 'POST',
                success: function (json) {
                    //localStorage.clear();
                }
            });
        }
    </script>           

    <script>
        $(document).ready(function () {
            $("input[type=text]").keyup(function () {
                $(this).val($(this).val().toUpperCase());
            });
        });

    </script>     

</html>
