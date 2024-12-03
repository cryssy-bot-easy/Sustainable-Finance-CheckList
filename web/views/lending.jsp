<%-- 
    Document   : lending
    Created on : Nov 27, 2024, 1:56:55 PM
    Author     : N680
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    </head> 
    <body>
    
<!--        <div class='main' overflow:auto>     -->
         <div id="DIVSFCTABS" class="ui-tabs ui-corner-all ui-widget ui-widget">
             
                <h3 class="module-title" align="left">Create Sustainability Finance Checklist - Lending</h3>
                <fieldset>
                <div>
                    <table style="width:100%">
<!--                        <tr >
                            <td width="50%" class="moduleHeader"><h4 class="manager">&nbsp;Create Sustainability Finance Checklist - Lending</h4></td>
                        </tr>-->
                        <tr>               
                            <td>    
                                <label>&nbsp;Is this a Lending or an Investment?*</label>
                            </td>                                                                                          
                        </tr>
                        <tr>     
                            <td width="50%">
                                <p>
                                    <input type="radio" name="lendinv" id="lendinv" checked="checked" value="Lending">Lending    
                                    <br>
                                    <input type="radio" name="lendinv" id="lendinv" value="Investment">Investment<br> 
                                </p>    
                            </td>
                        </tr>
                    </table>    
                    <table style="width:100%">
                        <tr>     
                            <td width="15%"><label>E&S Request ID:</label></td>
                            <td width="25%"><input type="text" id="esrequestid" name="esrequestid" class='form-control' autocomplete="off" disabled></td>
                            <td width="40%"></td>
                            <td width="10%"></td>
                            <td width="10%"></td>                        
                        </tr>     
                        <tr height = 5px></tr>
                        <tr>     
                            <td width="15%"><label id="lblinvestmentloanid">Loan ID:*</label></td>
                            <td width="25%"><input type="text" id="investmentloanid" name="investmentloanid" class='form-control' autocomplete="off"></td>
                            <td width="40%"></td>
                            <td width="10%"></td>
                            <td width="10%"> <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#generateReportModal">
                                Open Generate Report Modal
                            </button>
                                <!--<input class='block' type="submit" id="downloadchecklist" name="downloadchecklist" value="Download Checklist"/></td>-->      
                            
                           
                            
                            
                        </tr>      
                        <tr height = 5px></tr>	
                    </table>
                </div>    
                <ul>
                    <li><a href="#tabs-1" id="I">I. Account Information<br><br></a></li>
                    <li><a href="#tabs-2" id="II">II. Contribution to Sustainable<br> Development of the Financed <br> Project/Investment</a></li>
                    <li><a href="#tabs-3" id ="III">III. Environmental & Social (E&S)<br>Negative/Exclusion List Screening <br>(per EO No. 007 s. 2023)</a></li>
                    <li><a href="#tabs-4" id="IV">IV. Environmental Impact <br> Assessment and Compliance</a></li>
                    <li><a href="#tabs-5" id="V">V. Social Aspects <br> and Impact</a></li>
                    <li><a href="#tabs-6" id="VI">VI. Project/Project Site <br>Exposure to Natural/<br>Climate Change Hazards</a></li>                    
                </ul>
                <div id="tabs-1">
                    <div class='well' style="height:360px;overflow-y:auto;overflow-x:auto;"  >
                        <div id="part1_inv" style="display:none">
                            <table style="width:100%">                        
                                <tr>     
                                    <td width="15%"><label>Security Name*</label></td>
                                    <td width="25%"><input type="text" id="securityname" name="securityname" class='form-control' autocomplete="off"></td>
                                    <td width="40%"></td>
                                    <td width="10%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>
                                <tr>     
                                    <td width="15%"><label>Issuer*</label></td>
                                    <td width="25%"><input type="text" id="issuer" name="issuer" class='form-control' autocomplete="off"></td>
                                    <td width="40%"></td>
                                    <td width="10%"></td>
                                    <td width="10%"></td>                                
                                </tr>      
                                <tr height = 5px></tr>
                                <tr>     
                                    <td width="15%"><label>Use of Proceeds*</label></td>
                                    <td width="25%"><input type="text" id="useofproceeds" name="useofproceeds" class='form-control' autocomplete="off"></td>
                                    <td width="40%"></td>
                                    <td width="10%"></td>
                                    <td width="10%"></td>                                
                                </tr>      
                                <tr height = 50px></tr>
                                <tr>     
                                    <td width="15%"></td>
                                    <td width="25%"></td>
                                    <td width="40%"></td>
                                    <td colspan="2" align="right"><input class='block' type="submit" id="savesecinfo" name="savesecinfo" value="Save"/>
                                        <input class='block' type="submit" id="updatesecinfo" name="updatesecinfo" value="Update"/>
                                        <input class='block' type="submit" id="clearsecinfo" name="clearsecinfo" value="Clear"/>
                                    </td>                                
                                </tr>                                                              
                            </table>
                        </div>
                        <div id="part1_lend">
                            <table style="width:100%">
                                <tr>     
                                    <td width="15%"><label>Account Name*</label></td>
                                    <td width="25%"><input type="text" id="accountname" name="accountname" class='form-control' autocomplete="off"></td>
                                    <td width="40%"></td>
                                    <td width="10%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>
                                <tr>     
                                    <td width="15%"></td>
                                    <td width="25%"><p>
                                            <input type="radio" name="indvcorp" id="indvcorp" checked="checked" value="Individual">Individual &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <input type="radio" name="indvcorp" id="indvcorp" value="Corporate">Corporate</p>    
                                    </td>
                                    <td width="40%"></td>
                                    <td width="10%"></td>
                                    <td width="10%"></td>                                
                                </tr>      
                                <tr height = 5px></tr>      
                                <tr> 
                                    <td width="15%"><label id="lblfirstname">First Name</label></td>
                                    <td width="25%"><input type="text" id="firstname" name="firstname" class='form-control' autocomplete="off"></td>
                                    <td width="40%"></td>
                                    <td width="10%"></td>
                                    <td width="10%"></td>
                                </tr>                                 
                                <tr height = 5px></tr>      
                                <tr> 
                                    <td width="15%"><label id="lblmiddlename">Middle Name</label></td>
                                    <td width="25%"><input type="text" id="middlename" name="middlename" class='form-control' autocomplete="off"></td>
                                    <td width="40%"></td>
                                    <td width="10%"></td>
                                    <td width="10%"></td>
                                </tr>                                     
                                <tr height = 5px></tr>      
                                <tr> 
                                    <td width="15%"><label id="lbllastname">Last Name</label></td>
                                    <td width="25%"><input type="text" id="lastname" name="lastname" class='form-control' autocomplete="off"></td>
                                    <td width="40%"></td>
                                    <td width="10%"></td>
                                    <td width="10%"></td>
                                </tr>                                     
                                <tr height = 5px></tr>      
                                <tr> 
                                    <td width="15%"><label id="lblsuffix">Suffix</label></td>
                                    <td width="25%"><input type="text" id="suffix" name="suffix" class='form-control' autocomplete="off"></td>
                                    <td width="40%"></td>
                                    <td width="10%"></td>
                                    <td width="10%"></td>
                                </tr>   
                                <tr height = 5px></tr> 
                                <tr>
                                    <td width="15%"><label>Business Address*</label></td>
                                    <td width="25"><textarea class="form-control" rows="4" id="businessaddress" name="businessaddress" required="required" pattern="^[^ ']+( [^ ']+)*$" disabled></textarea></td>                                
                                </tr>                            
                            </table>    
                            <h2 class="heading">Business Address Details</h2>  
                            <table style="width:100%">                            
                                <tr>     
                                    <td width="15%"><label>Address ID:</label></td>
                                    <td width="25%"><input type="text" id="addressid" name="addressid" class='form-control' autocomplete="off" disabled></td>
                                    <td width="5%"></td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>                                
                                </tr>                   
                                <tr height = 5px></tr>     
                                <tr>     
                                    <td width="15%"><label>Room/Unit/Floor</label></td>
                                    <td width="25%"><input type="text" id="room" name="room" class='form-control' autocomplete="off"></td>
                                    <td width="5%"></td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>                                
                                </tr>     
                                <tr height = 5px></tr>
                                <tr>     
                                    <td width="15%"><label>Lot/Block/House No./Building No.</label></td>
                                    <td width="25%"><input type="text" id="lot" name="lot" class='form-control' autocomplete="off"></td>
                                    <td width="5%"></td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>            
                                <tr>     
                                    <td width="15%"><label>Building Name</label></td>
                                    <td width="25%"><input type="text" id="buildingname" name="buildingname" class='form-control' autocomplete="off"></td>
                                    <td width="5%"></td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>     
                                <tr>     
                                    <td width="15%"><label>Street</label></td>
                                    <td width="25%"><input type="text" id="street" name="street" class='form-control' autocomplete="off"></td>
                                    <td width="5%"></td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>                               
                                <tr>     
                                    <td width="15%"><label>Subdivision</label></td>
                                    <td width="25%"><input type="text" id="subdivision" name="subdivision" class='form-control' autocomplete="off"></td>
                                    <td width="5%"></td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>                      
                                <tr>     
                                    <td width="15%"><label>Region*</label></td>
                                    <td width="25%">
                                        <select id="region" name="region" class='form-control'>                                                                                                         
                                            <option selected="selected" value=blank>Select Value</option>
                                        </select></td>
                                    <td width="5%"><input type="text" name='regioncode' id="regioncode" class='form-control' disabled> </td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>            
                                <tr>     
                                    <td width="15%"><label>Province*</label></td>
                                    <td width="25%">
                                        <select id="province" name="province" class='form-control'>                                                                                                         
                                            <option selected="selected" value=blank>Select Value</option>
                                        </select></td>
                                    <td width="5%"><input type="text" name='provincecode' id="provincecode" class='form-control' disabled> </td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>  
                                <tr>     
                                    <td width="15%"><label>City/Municipality/SubMunicipality*</label></td>
                                    <td width="25%">
                                        <select id="city" name="city" class='form-control'>                                                                                                         
                                            <option selected="selected" value=blank>Select Value</option>
                                        </select></td>
                                    <td width="5%"><input type="text" name='citycode' id="citycode" class='form-control' disabled> </td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>     
                                <tr>     
                                    <td width="15%"><label>District</label></td>
                                    <td width="25%"><input type="text" id="district" name="district" class='form-control' autocomplete="off"></td>
                                    <td width="5%"></td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>                                    
                                <tr>     
                                    <td width="15%"><label>Barangay*</label></td>
                                    <td width="25%">
                                        <select id="brgy" name="brgy" class='form-control'>                                                                                                         
                                            <option selected="selected" value=blank>Select Value</option>
                                        </select></td>
                                    <td width="5%"><input type="text" name='brgycode' id="brgycode" class='form-control' disabled> </td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>                                
                                <tr>     
                                    <td width="15%"><label>Postal Code</label></td>
                                    <td width="25%"><input type="text" id="postalcode" name="postalcode" class='form-control' autocomplete="off"></td>
                                    <td width="5%"></td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>         
                                <tr height = 5px></tr>                                
                                <tr>     
                                    <td width="15%"><label>Financed Project*</label></td>
                                    <td width="25%"><input type="text" id="financedproject" name="financedproject" class='form-control' autocomplete="off"></td>
                                    <td width="5%"></td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>              
                                <tr height = 5px></tr>                                
                                <tr>
                                    <td width="15%"><label>Project Address*</label></td>
                                    <td width="25"><textarea class="form-control" rows="4" id="projectaddress" name="projectaddress" required="required" pattern="^[^ ']+( [^ ']+)*$" disabled></textarea></td>                                
                                </tr>                                       
                            </table>         
                            <h2 class="heading">Project Address Details</h2>  
                            <table style="width:100%">
                                <tr>     
                                    <td width="15%"><label>Room/Unit/Floor</label></td>
                                    <td width="25%"><input type="text" id="roomproj" name="roomproj" class='form-control' autocomplete="off"></td>
                                    <td width="5%"></td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>                                
                                </tr>     
                                <tr height = 5px></tr>
                                <tr>     
                                    <td width="15%"><label>Lot/Block/House No./Building No.</label></td>
                                    <td width="25%"><input type="text" id="lotproj" name="lotproj" class='form-control' autocomplete="off"></td>
                                    <td width="5%"></td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>            
                                <tr>     
                                    <td width="15%"><label>Building Name</label></td>
                                    <td width="25%"><input type="text" id="buildingnameproj" name="buildingnameproj" class='form-control' autocomplete="off"></td>
                                    <td width="5%"></td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>     
                                <tr>     
                                    <td width="15%"><label>Street</label></td>
                                    <td width="25%"><input type="text" id="streetproj" name="streetproj" class='form-control' autocomplete="off"></td>
                                    <td width="5%"></td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>                               
                                <tr>     
                                    <td width="15%"><label>Subdivision</label></td>
                                    <td width="25%"><input type="text" id="subdivisionproj" name="subdivisionproj" class='form-control' autocomplete="off"></td>
                                    <td width="5%"></td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>                      
                                <tr>     
                                    <td width="15%"><label>Region*</label></td>
                                    <td width="25%">
                                        <select id="regionproj" name="regionproj" class='form-control'>                                                                                                         
                                            <option selected="selected" value=blank>Select Value</option>
                                        </select></td>
                                    <td width="5%"><input type="text" name='regioncodeproj' id="regioncodeproj" class='form-control' disabled> </td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>            
                                <tr>     
                                    <td width="15%"><label>Province*</label></td>
                                    <td width="25%">
                                        <select id="provinceproj" name="provinceproj" class='form-control'>                                                                                                         
                                            <option selected="selected" value=blank>Select Value</option>
                                        </select></td>
                                    <td width="5%"><input type="text" name='provincecodeproj' id="provincecodeproj" class='form-control' disabled> </td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>  
                                <tr>     
                                    <td width="15%"><label>City/Municipality/SubMunicipality*</label></td>
                                    <td width="25%">
                                        <select id="cityproj" name="cityproj" class='form-control'>                                                                                                         
                                            <option selected="selected" value=blank>Select Value</option>
                                        </select></td>
                                    <td width="5%"><input type="text" name='citycodeproj' id="citycodeproj" class='form-control' disabled> </td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>     
                                <tr>     
                                    <td width="15%"><label>District</label></td>
                                    <td width="25%"><input type="text" id="districtproj" name="districtproj" class='form-control' autocomplete="off"></td>
                                    <td width="5%"></td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>                                    
                                <tr>     
                                    <td width="15%"><label>Barangay*</label></td>
                                    <td width="25%">
                                        <select id="brgyproj" name="brgyproj" class='form-control'>                                                                                                         
                                            <option selected="selected" value=blank>Select Value</option>
                                        </select></td>
                                    <td width="5%"><input type="text" name='brgycodeproj' id="brgycodeproj" class='form-control' disabled> </td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>     
                                <tr height = 5px></tr>                                
                                <tr>     
                                    <td width="15%"><label>Postal Code</label></td>
                                    <td width="25%"><input type="text" id="postalcodeproj" name="postalcodeproj" class='form-control' autocomplete="off"></td>
                                    <td width="5%"></td>
                                    <td width="35%"></td>
                                    <td width="10%"></td>
                                </tr>         
                                <tr height = 50px></tr>                                
                                <tr>     
                                    <td width="15%"></td>
                                    <td width="25%"></td>
                                    <td width="5%"></td>
                                    <td colspan="2" align="right"><input class='block' type="submit" id="saveaccinfo" name="saveaccinfo" value="Save"/>
                                        <input class='block' type="submit" id="updateaccinfo" name="updateaccinfo" value="Update"/>
                                        <input class='block' type="submit" id="clearaccinfo" name="clearaccinfo" value="Clear"/>
                                    </td>                               
                                </tr>                                     
                            </table>                                     
                        </div>
                    </div>
                </div>
                <div id="tabs-2" style="display:none">
                    <div class='well' style="height:360px;overflow-y:auto;overflow-x:auto;"  >
                        <table style="width:100%">
                            <tr>     
                                <td width="15%"><label>Record ID Part2</label></td>
                                <td width="25%"><input type="text" id="part2recordid" name="part2recordid" class='form-control' autocomplete="off" disabled></td>
                                <td width="5%"></td>
                                <td width="25%"></td>
                                <td width="20%"></td>                                
                            </tr><tr height = 5px></tr>                                                                 
                        </table>    
                        <div id="part2_main">
                            <div id="part2_inv" style="display:none">
                                <table style="width:100%">                            
                                    <tr>     
                                        <td width="15%"><label>Sector*</label></td>
                                        <td width="25%"><select id="sector" name="sector" class='form-control'>                                                                                                         
                                                <option selected="selected" value=blank>Select Value</option>
                                                <option value="Government">Government</option>
                                                <option value="Holding">Holding</option>
                                                <option value="Banking & Financial Services">Banking & Financial Services</option>
                                                <option value="Commercial-Industrial">Commercial-Industrial</option>
                                                <option value="Property">Property</option>
                                                <option value="Services">Services</option>
                                                <option value="Mining">Mining</option>
                                                <option value="Oil">Oil</option>
                                                <option value="Exchange Traded Funds (ETF)">Exchange Traded Funds (ETF)</option>                                                   
                                            </select></td>
                                        <td width="5%"></td>
                                        <td width="25%"></td>
                                        <td width="20%"></td>                                
                                    </tr><tr height = 5px></tr>                                                                 
                                    <tr>     
                                        <td width="15%"><label>Type of Investment*</label></td>
                                        <td width="25%"><select id="typeofinvestment" name="typeofinvestment" class='form-control'>                                                                                                         
                                                <option selected="selected" value=blank>Select Value</option>
                                                <option value="Debt">Debt</option>
                                                <option value="Listed Equity">Listed Equity</option>
                                                <option value="Unlisted Equity">Unlisted Equity</option>
                                                <option value="Others">Others</option>
                                            </select></td>
                                        <td width="5%"></td>
                                        <td width="25%"><input type="text" placeholder="Please Specify" id="typeinvothers" name="typeinvothers" class='form-control' autocomplete="off"></td>
                                        <td width="20%"></td>                                
                                    </tr><tr height = 5px></tr>                                      
                                </table>    
                            </div>    
                            <div id="part2_lend">
                                <table style="width:100%">
                                    <tr>     
                                        <td width="15%"><label>Priority Sector*</label></td>
                                        <td width="25%"><input type="text" id="prioritysector" name="prioritysector" class='form-control' autocomplete="off"></td>
                                        <td width="5%"></td>
                                        <td width="25%"></td>
                                        <td width="20%"></td>                                
                                    </tr><tr height = 5px></tr>                                                                 
                                    <tr>     
                                        <td width="15%"><label>Sub Sector*</label></td>
                                        <td width="25%"><input type="text" id="subsector" name="subsector" class='form-control' autocomplete="off"></td>
                                        <td width="5%"></td>
                                        <td width="25%"></td>
                                        <td width="20%"></td>                                
                                    </tr><tr height = 5px></tr>                
                                    <tr>     
                                        <td colspan="2"><label>Program Tagging according to the Rationalized Lending Programs/Investment Instruments including Legislated and Special/Off-Book Lending Programs</label></td>
                                        <td width="5%"></td>
                                        <td width="25%"></td>
                                        <td width="20%"></td>                                
                                    </tr><tr height = 5px></tr>         
                                    <tr>     
                                        <td width="15%"><label>Availing lending program*</label></td>
                                        <td width="25%"><p>
                                                <input type="radio" name="availlendprog" id="availlendprog" checked="checked" value="YES"> Yes &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <input type="radio" name="availlendprog" id="availlendprog" value="NO"> No</p>   
                                        </td>
                                        <td width="5%"></td>
                                        <td width="25%"></td>
                                        <td width="20%"></td>                              
                                    </tr><tr height = 5px></tr> 
                                    <tr>     
                                        <td colspan="2"><select id="program" name="program" class='form-control'>                                                                                                         
                                                <option selected="selected" value=blank>Select Value</option>
                                            </select></td>
                                        <td width="5%"><input type="text" name='programgroupcode' id="programgroupcode" class='form-control' disabled></td>                                        
                                        <td width="25%"><input type="text" name='lendingprogramcode' id="lendingprogramcode" class='form-control' disabled></td>
                                        <td width="20%"></td>                                
                                    </tr><tr height = 5px></tr>        
                                    <tr>     
                                        <td colspan="2"><label>Output/Results Indicator of the project based on the lending/investment program</label></td>
                                        <td width="5%"></td>
                                        <td width="25%"></td>
                                        <td width="20%"></td>                                
                                    </tr><tr height = 5px></tr>                                        

                                </table>                        
                            </div>     
                        </div>    
                        <div id="resultindicators">
                            <div id="group1" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[No. of ARBs/SFF assisted in crop production]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group1_1" name="group1_1" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>
                                    <tr> 
                                        <td width="48"><label>[No. of small palay and corn farmers assisted]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group1_2" name="group1_2" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                
                                    <tr> 
                                        <td width="48"><label>[Hectares planted]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group1_3" name="group1_3" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                    
                                </table>
                            </div>
                            <div id="group2" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[No. of LGUs benefitted]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group2_1" name="group2_1" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>
                                    <tr> 
                                        <td width="48"><label>[No. of projects financed]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group2_2" name="group2_2" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                
                                    <tr> 
                                        <td width="48"><label>[No. of barangays served by material recovery facilities]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group2_3" name="group2_3" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                    
                                    <tr> 
                                        <td width="48"><label>[No. of cities and/or municipalities served by sanitary landfill facilities]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group2_4" name="group2_4" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                                    
                                    <tr> 
                                        <td width="48"><label>[Amount of corn & palay procured by LGU from local farmers; No. of corn & palay farmers benefitted]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group2_5" name="group2_5" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>         
                                    <tr> 
                                        <td width="48"><label>[Eligible LGU projects]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group2_6" name="group2_6" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                                         
                                </table>
                            </div>               
                            <div id="group3" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[No. of CFIs, MFIs, Coops, Community-Based Organizations (CBOs), NGOs assisted]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group3_1" name="group3_1" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>
                                    <tr> 
                                        <td width="48"><label>[No. of projects financed addressing hunger, food & nutrition security, and poverty]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group3_2" name="group3_2" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                
                                    <tr> 
                                        <td width="48"><label>[No. of assisted Barangay Micro Business Enterprises and the poor sector through eligible Microfinance Institutions No. of ARBs/SFFs assisted through PFIs]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group3_3" name="group3_3" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                    
                                </table>
                            </div>   
                            <div id="group4" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[No. of FR/FVEs assisted]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group4_1" name="group4_1" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>
                                    <tr> 
                                        <td width="48"><label>[No. of small businesses and/or agri-enterprises established]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group4_2" name="group4_2" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                
                                    <tr> 
                                        <td width="48"><label>[No. of assisted individual borrowers in unserved areas in line with the Government’s thrust for financial inclusion and in pursuit of the Bank’s mandate]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group4_3" name="group4_3" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                    
                                    <tr> 
                                        <td width="48"><label>[No. of assisted Barangay Micro Business Enterprises and the poor sector through eligible Microfinance Institutions]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group4_4" name="group4_4" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                                    
                                    <tr> 
                                        <td width="48"><label>[No. of viable/sustainable agricultural and agri-business projects established that contributed to the increase of food security]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group4_5" name="group4_5" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>         
                                    <tr> 
                                        <td width="48"><label>[No. of women assisted in their business ventures such as traditional trade, e-commerce business, and food services activities, among others]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group4_6" name="group4_6" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                                                                     
                                </table>                            
                            </div>      
                            <div id="group5" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[Type of HVC, list of HVC, hectares planted]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group5_1" name="group5_1" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>
                                </table>
                            </div>          
                            <div id="group6" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[No. of poultry/piggery farms established/assisted]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group6_1" name="group6_1" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>
                                    <tr> 
                                        <td width="48"><label>[No. of heads produced (annual)]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group6_2" name="group6_2" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                
                                    <tr> 
                                        <td width="48"><label>[No. of domestic milk produced (in liters per year)]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group6_3" name="group6_3" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                    
                                </table>
                            </div>      
                            <div id="group7" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[No. of assisted institutional buyers or processing/canning companies linked with small fishers, micro, small and medium enterprises (MSME) as growers/suppliers]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group7_1" name="group7_1" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>
                                    <tr> 
                                        <td width="48"><label>[No. of inputs purchased for aquaculture/mariculture production]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group7_2" name="group7_2" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                
                                    <tr> 
                                        <td width="48"><label>[Area/hectares of fish ponds/cages]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group7_3" name="group7_3" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                    
                                    <tr> 
                                        <td width="48"><label>[No. of buldings, processing plants developed/improved]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group7_4" name="group7_4" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                                    
                                    <tr> 
                                        <td width="48"><label>[No. of fishing operators assisted]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group7_5" name="group7_5" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>         
                                    <tr> 
                                        <td width="48"><label>[No. of brand new or second-hand/ refurbished commercial fishing boats and related equipment purchased/acquired]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group7_6" name="group7_6" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                                                                     
                                </table>                            
                            </div>       
                            <div id="group8" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[No. of energy projects]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group8_1" name="group8_1" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>
                                    <tr> 
                                        <td width="48"><label>[No. of RE projects]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group8_2" name="group8_2" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                
                                    <tr> 
                                        <td width="48"><label>[No. of MW capacity]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group8_3" name="group8_3" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                    
                                    <tr> 
                                        <td width="48"><label>[No. of electric cooperatives asssited]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group8_4" name="group8_4" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                                    
                                    <tr> 
                                        <td width="48"><label>[No. of households and businesses gained access to electricity]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group8_5" name="group8_5" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                                                                             
                                </table>                            
                            </div>         
                            <div id="group9" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[No. of Climate Adaptation projects assisted]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group9_1" name="group9_1" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>
                                    <tr> 
                                        <td width="48"><label>[No. of climate change adaptation initiatives towards climate resilient agriculture]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group9_2" name="group9_2" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                
                                    <tr> 
                                        <td width="48"><label>[No. of farmers assisted]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group9_3" name="group9_3" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                    
                                    <tr> 
                                        <td width="48"><label>[No. of high value crops produced by adopting greenhouse farming technology]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group9_4" name="group9_4" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                                    
                                </table>                            
                            </div>        
                            <div id="group10" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[Type of educational institution]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><select id="group10_1" name="group10_1" class='form-control'>                                                                                                         
                                                <option selected="selected" value=blank>Select Value</option>
                                                <option value="SUC">SUC</option>
                                                <option value="K-12">K-12</option>                                            
                                                <option value="Tertiary">Tertiary</option>
                                                <option value="Technical-Vocational">Technical-Vocational</option>
                                            </select></td>                                    
                                    </tr><tr height = 5px></tr>
                                    <tr> 
                                        <td width="48"><label>[No. of students assisted]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group10_2" name="group10_2" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                
                                </table>                            
                            </div>        
                            <div id="group11" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[Type of tourism project]</label></td>
                                        <td width="2%"></td>
                                        <td width="25%"><select id="group11_1" name="group11_1" class='form-control'>                                                                                                         
                                                <option selected="selected" value=blank>Select Value</option>
                                                <option value="Farm/Eco-Tourism">Farm/Eco-Tourism</option>
                                                <option value="Sustainable Tourism">Sustainable Tourism</option>                                            
                                                <option value="Others">Others</option>
                                            </select></td>
                                        <td width="25%"><input type="text" placeholder="Please Specify" id="group11_1_others" name="group11_1_others" class='form-control' autocomplete="off"></td>
                                    </tr><tr height = 5px></tr>
                                    <tr> 
                                        <td width="48"><label>[Hectares of farm/eco-tourism and/or protected area managed]</label></td>
                                        <td width="2%"></td>
                                        <td colspan="2"><input type="text" id="group11_2" name="group11_2" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                
                                    <tr> 
                                        <td width="48"><label>[No. of project tourists/visitors per year]</label></td>
                                        <td width="2%"></td>
                                        <td colspan="2"><input type="text" id="group11_3" name="group11_3" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                                
                                </table>                            
                            </div>
                            <div id="group12" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[Type of emergency assistance project]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><select id="group12_1" name="group12_1" class='form-control'>                                                                                                         
                                                <option selected="selected" value=blank>Select Value</option>
                                                <option value="Calamity Assistance">Calamity Assistance</option>
                                                <option value="Business Economic Rehabilitation">Business Economic Rehabilitation</option>                                            
                                                <option value="Bridge Financing to Electric Provider Companies">Bridge Financing to Electric Provider Companies</option>
                                            </select></td>                                    
                                    </tr><tr height = 5px></tr>
                                    <tr> 
                                        <td width="48"><label>[No. of beneficiaries (MSMEs, Cooperatives, MFIs and Large Enterprises)]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group12_2" name="group12_2" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                
                                    <tr> 
                                        <td width="48"><label>[No. of borrowers/household assisted/rehabiliated that were affected by disasters]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group12_3" name="group12_3" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                    
                                </table>
                            </div>     
                            <div id="group13" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[No. of housing projects financed]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group13_1" name="group13_1" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>
                                    <tr> 
                                        <td width="48"><label>[No. of housing units financed]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group13_2" name="group13_2" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                
                                    <tr> 
                                        <td width="48"><label>[No. of individual borrowers/household assisted]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group13_3" name="group13_3" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                    
                                </table>
                            </div>              
                            <div id="group14" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[Type of hospital financed]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><select id="group14_1" name="group14_1" class='form-control'>                                                                                                         
                                                <option selected="selected" value=blank>Select Value</option>
                                                <option value="Level 1">Level 1</option>
                                                <option value="Level 2">Level 2</option>                                            
                                                <option value="Level 3">Level 3</option>
                                            </select></td>                                    
                                    </tr><tr height = 5px></tr>
                                    <tr> 
                                        <td width="48"><label>[No. of hospital buildings financed]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group14_2" name="group14_2" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                
                                    <tr> 
                                        <td width="48"><label>[No. of hospital beds financed]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group14_3" name="group14_3" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>     
                                    <tr> 
                                        <td width="48"><label>[Type of other health facilities/services financed]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><select id="group14_4" name="group14_4" class='form-control'>                                                                                                         
                                                <option selected="selected" value=blank>Select Value</option>
                                                <option value="Infirmary">Infirmary</option>
                                                <option value="Clinical Laboratories">Clinical Laboratories</option>                                            
                                                <option value="Pharmacy">Pharmacy</option>
                                                <option value="Dialysis Clinic/Center">Dialysis Clinic/Center</option>
                                            </select></td>                                    
                                    </tr><tr height = 5px></tr>                                    
                                    <tr> 
                                        <td width="48"><label>[No. of other health facilities/services financed]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group14_5" name="group14_5" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                                    
                                </table>
                            </div>       
                            <div id="group15" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[No. of viable technology projects financed]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group15_1" name="group15_1" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>
                                </table>
                            </div>    
                            <div id="group16" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[No. of modern PUV units financed]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group16_1" name="group16_1" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                
                                    <tr> 
                                        <td width="48"><label>[No. of modern PUB units financed]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group16_2" name="group16_2" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                         
                                    <tr> 
                                        <td width="48"><label>[No. of Ferry Boats financed]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group16_3" name="group16_3" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>     
                                    <tr> 
                                        <td width="48"><label>[No. of TRANSPORT cooperatives assisted]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group16_4" name="group16_4" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                                              
                                </table>
                            </div>           
                            <div id="group17" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[No. of Water Districts financed]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group17_1" name="group17_1" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                
                                    <tr> 
                                        <td width="48"><label>[No. of households connected with potable water]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group17_2" name="group17_2" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                         
                                    <tr> 
                                        <td width="48"><label>[No. of watewater treatment facility (WTF) financed]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group17_3" name="group17_3" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>     
                                    <tr> 
                                        <td width="48"><label>[Cubic Meters per Day (CMD) treatment capacity of the WTF]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group17_4" name="group17_4" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                                              
                                </table>
                            </div>        
                            <div id="group18" style="display:none">
                                <table style="width:100%">
                                    <tr> 
                                        <td width="48"><label>[Type of infrastructure project (pls pecify ___ (i.e. roads/bridges)]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group18_1" name="group18_1" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                
                                    <tr> 
                                        <td width="48"><label>[Length of road constructed (in km.)]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group18_2" name="group18_2" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                         
                                    <tr> 
                                        <td width="48"><label>[No. of economic zones developed]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group18_3" name="group18_3" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>     
                                    <tr> 
                                        <td width="48"><label>[No. of Contractors/borrowers]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group18_4" name="group18_4" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                                              
                                    <tr> 
                                        <td width="48"><label>[No. of of Jobs generated]</label></td>
                                        <td width="2%"></td>
                                        <td width="50%"><input type="text" id="group18_5" name="group18_5" class='form-control' autocomplete="off"></td>                                    
                                    </tr><tr height = 5px></tr>                                                                                                              
                                </table>
                            </div>      
                        </div>    
                        <div>    
                            <table style="width:100%"> 
                                <tr height = 5px></tr>  
                                <tr>     
                                    <td colspan="2"><label>Contribution to sustainable & low-emission /climate-resilient development. (based on the DOF-BSP Sustainable Finance Guiding Principles)*</label></td>
                                    <td width="5%"></td>
                                    <td width="25%"></td>
                                    <td width="20%"></td>                                
                                </tr>     
                                <tr height = 5px></tr>    
                                <tr>     
                                    <td colspan="2"><input type="checkbox" name="GP1" id="GP1" value="GP1"> GP 1: Climate Change Mitigation and Adaptation</td>
                                    <td width="5%"></td>
                                    <td width="25%"></td>
                                    <td width="20%"></td>                                
                                </tr>     
                                <tr height = 5px></tr>                                    
                                <tr>     
                                    <td colspan="2"><input type="checkbox" name="GP2" id="GP2" value="GP2"> GP 2: Promoting Transition to a Low Carbon Economy</td>
                                    <td width="5%"></td>
                                    <td width="25%"></td>
                                    <td width="20%"></td>                                
                                </tr>     
                                <tr height = 5px></tr>  
                                <tr>     
                                    <td colspan="2"><input type="checkbox" name="GP3" id="GP3" value="GP3"> GP 3: Resilient Food Systems</td>
                                    <td width="5%"></td>
                                    <td width="25%"></td>
                                    <td width="20%"></td>                                
                                </tr>     
                                <tr height = 5px></tr>   
                                <tr>     
                                    <td colspan="2"><input type="checkbox" name="GP4" id="GP4" value="GP4"> GP 4: Sustainable Cities</td>
                                    <td width="5%"></td>
                                    <td width="25%"></td>
                                    <td width="20%"></td>                                
                                </tr>     
                                <tr height = 5px></tr>     
                                <tr>     
                                    <td colspan="2"><input type="checkbox" name="GP5" id="GP5" value="GP5"> GP 5: Sustainable and Resilient Infrastructure for Inclusive Growth and Poverty Reduction</td>
                                    <td width="5%"></td>
                                    <td width="25%"></td>
                                    <td width="20%"></td>                                
                                </tr>     
                                <tr height = 5px></tr>                                                                       
                                <tr>     
                                    <td colspan="2"><input type="checkbox" name="GP6" id="GP6" value="GP6"> GP 6: Environmental Management and Conservation</td>
                                    <td width="5%"></td>
                                    <td width="25%"></td>
                                    <td width="20%"></td>                                
                                </tr>     
                                <tr height = 5px></tr>                                                                                                       
                                <tr>     
                                    <td id="COLGPNA" colspan="2"><input type="checkbox" name="GP7" id="GP7" value="N/A"> Not Applicable</td>
                                    <td width="5%"></td>
                                    <td width="25%"></td>
                                    <td width="20%"></td>                                
                                </tr>     
                                <tr height = 5px></tr>        
                                <tr>     
                                    <td colspan="2"><label>Alignment with UN Sustainable Development Goals (SDGs)*</label></td>
                                    <td width="5%"></td>
                                    <td width="25%"></td>
                                    <td width="20%"></td>                                
                                </tr>     
                                <tr height = 5px></tr>                                    
                                <tr>     
                                    <td colspan="5">
                                        <table style="width:100%">
                                            <tr>     
                                                <td width="25%"><input type="checkbox" name="SDG1" id="SDG1" value="SDG1"> 1 - No Poverty</td>
                                                <td width="25%"><input type="checkbox" name="SDG11" id="SDG11" value="SDG11"> 11 - Sustainable cities and communities</td>
                                                <td width="50%"></td>                                                
                                            </tr>  
                                        </table>
                                    </td>                                
                                </tr><tr height = 5px></tr>  
                                <tr>     
                                    <td colspan="5">
                                        <table style="width:100%">
                                            <tr>     
                                                <td width="25%"><input type="checkbox" name="SDG2" id="SDG2" value="SDG2"> 2 - Zero Hunger</td>
                                                <td colspan="2"><input type="checkbox" name="SDG12" id="SDG12" value="SDG12"> 12 - Responsible consumption and production</td>                                                    
                                            </tr>  
                                        </table>
                                    </td>                                
                                </tr><tr height = 5px></tr>  
                                <tr>     
                                    <td colspan="5">
                                        <table style="width:100%">
                                            <tr>     
                                                <td width="25%"><input type="checkbox" name="SDG3" id="SDG3" value="SDG3"> 3 - Good health and well-being</td>
                                                <td width="25%"><input type="checkbox" name="SDG13" id="SDG13" value="SDG13"> 13 - Climate action</td>     
                                                <td width="50%"></td>   
                                            </tr>  
                                        </table>
                                    </td>                                
                                </tr><tr height = 5px></tr>             
                                <tr>     
                                    <td colspan="5">
                                        <table style="width:100%">
                                            <tr>     
                                                <td width="25%"><input type="checkbox" name="SDG4" id="SDG4" value="SDG4"> 4 - Quality education</td>
                                                <td width="25%"><input type="checkbox" name="SDG14" id="SDG14" value="SDG14"> 14 - Life below water</td>     
                                                <td width="50%"></td>   
                                            </tr>  
                                        </table>
                                    </td>                                
                                </tr><tr height = 5px></tr>                                    
                                <tr>     
                                    <td colspan="5">
                                        <table style="width:100%">
                                            <tr>     
                                                <td width="25%"><input type="checkbox" name="SDG5" id="SDG5" value="SDG5"> 5 - Gender equality</td>
                                                <td width="25%"><input type="checkbox" name="SDG15" id="SDG15" value="SDG15"> 15 - Life on land</td>     
                                                <td width="50%"></td>   
                                            </tr>  
                                        </table>
                                    </td>                                
                                </tr><tr height = 5px></tr>       
                                <tr>     
                                    <td colspan="5">
                                        <table style="width:100%">
                                            <tr>     
                                                <td width="25%"><input type="checkbox" name="SDG6" id="SDG6" value="SDG6"> 6 - Clean water and sanitation</td>
                                                <td width="25%"><input type="checkbox" name="SDG16" id="SDG16" value="SDG16"> 16 - Peace, justice and strong institutions</td>     
                                                <td width="50%"></td>   
                                            </tr>  
                                        </table>
                                    </td>                                
                                </tr><tr height = 5px></tr>                                
                                <tr>     
                                    <td colspan="5">
                                        <table style="width:100%">
                                            <tr>     
                                                <td width="25%"><input type="checkbox" name="SDG7" id="SDG7" value="SDG7"> 7 - Affordable and clean energy</td>
                                                <td width="25%"><input type="checkbox" name="SDG17" id="SDG17" value="SDG17"> 17 - Partnerships for the goals</td>     
                                                <td width="50%"></td>   
                                            </tr>  
                                        </table>
                                    </td>                                
                                </tr><tr height = 5px></tr>     
                                <tr>     
                                    <td colspan="5">
                                        <table style="width:100%">
                                            <tr>     
                                                <td width="25%"><input type="checkbox" name="SDG8" id="SDG8" value="SDG8"> 8 - Decent work and economic growth</td>
                                                <td colspan="2" id="COLSDGNA"><input type="checkbox" name="SDG18" id="SDG18" value="N/A"> Not Applicable</td>                                                     
                                            </tr>  
                                        </table>
                                    </td>                                
                                </tr><tr height = 5px></tr>         
                                <tr>     
                                    <td colspan="5">
                                        <table style="width:100%">
                                            <tr>     
                                                <td width="25%"><input type="checkbox" name="SDG9" id="SDG9" value="SDG9"> 9 - Industry, innovation and infrastructure</td>
                                                <td width="25%"></td>     
                                                <td width="50%"></td>   
                                            </tr>  
                                        </table>
                                    </td>                                
                                </tr><tr height = 5px></tr>                
                                <tr>     
                                    <td colspan="5">
                                        <table style="width:100%">
                                            <tr>     
                                                <td width="25%"><input type="checkbox" name="SDG10" id="SDG10" value="SDG10"> 10 - Reduced inequalities</td>
                                                <td width="25%"></td>     
                                                <td width="50%"></td>   
                                            </tr>  
                                        </table>
                                    </td>                                
                                </tr><tr height = 5px></tr>       
                                <tr>     
                                    <td colspan="5">
                                        <table style="width:100%">
                                            <tr>     
                                                <td width="25%"></td>
                                                <td width="25%"></td>     
                                                <td width="50%" align="right"><input class='block' type="submit" id="savepart2inv" name="savepart2inv" value="Save"/>
                                                    <input class='block' type="submit" id="updatepart2inv" name="updatpart2inv" value="Update"/>
                                                    <input class='block' type="submit" id="clearpart2inv" name="clearpart2inv" value="Clear"/></td>   
                                            </tr>  
                                        </table>
                                    </td>                                
                                </tr><tr height = 5px></tr>                                  
                            </table>
                        </div>

                    </div>
                </div>
                <div id="tabs-3">
                    <div id="part3">
                        <div>                            
                            <table style="width:100%">
                                <tr>     
                                    <td colspan="4"><label>III. Environmental & Social (E&S) Negative/Exclusion List Screening (per EO No. 007 s. 2023)</label></td>
                                </tr>                                                              
                                <tr>     
                                    <td colspan="2"><label>Alignment with UN Sustainable Development Goals (SDGs)*</label></td>                                    
                                    <td width="20%"><input type="text" id="part3recordid" name="part3recordid" class='form-control' autocomplete="off" disabled></td>     
                                    <td width="30%"></td>  
                                    <td width="20%"></td>                                     
                                </tr>                                             
                                <tr>     
                                    <td width="5%">                            
                                        <p>
                                            <input type="radio" name="alignsdg" id="alignsdg" checked="checked" value="Yes">Yes    
                                            <br>
                                            <input type="radio" name="alignsdg" id="alignsdg" value="No">No<br> 
                                        </p>    
                                    </td>
                                    <td colspan="3">
                                        <select id="lguproject" name="lguproject" class='form-control'>                                                                                                         
                                            <option selected="selected" value=blank>Select Value</option>
                                        </select></td>                                                                                
                                    <td width="20%"><input type="text" name='lguprojectcode' id="lguprojectcode" class='form-control' disabled></td>
                                    
                                </tr>                              
                            </table>                                                    
                        </div>                        
                        <table style="width:100%">
                            <tr>     
                                <td width="5%"></td>
                                <td width="25%"></td>     
                                <td width="20%"></td>     
                                <td width="50%" align="right"><input class='block' type="submit" id="savepart3" name="savepart3" value="Save"/>
                                    <input class='block' type="submit" id="updatepart3" name="updatpart3" value="Update"/>
                                    <input class='block' type="submit" id="clearpart3" name="clearpart3" value="Clear"/></td>   
                            </tr>                              
                        </table>                        
                    </div>    
                </div>
                <div id="tabs-4">
                    <div id="part4">
                        <div>                            
                            <table style="width:100%">
                                <tr>     
                                    <td colspan="4"><label>IV. Environmental Impact Assessment and Compliance </label></td>
                                </tr>                                                              
                                <tr>     
                                    <td colspan="2"><label>Potential impact to the environment and compliance to environmental laws and regulations*</label></td>                                    
                                    <td width="20%"><input type="text" id="part4recordid" name="part4recordid" class='form-control' autocomplete="off" disabled></td>     
                                    <td width="50%"></td>   
                                </tr>                                             
                                <tr>     
                                    <td colspan="2">                            
                                        <p>
                                            <input type="radio" name="environmentalimpact" id="environmentalimpact" checked="checked" value="Yes"> Yes                                                
                                            <br>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="ecc" id="ecc1" value="Yes"> With ECC &nbsp;&nbsp; <input type="radio" name="ecc" id="ecc2" value="No"> No ECC <br>   
                                            <input type="radio" name="environmentalimpact" id="environmentalimpact" value="No"> No<br> 
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="cnc" id="cnc1" value="Yes"> With CNC &nbsp;&nbsp; <input type="radio" name="cnc" id="cnc2" value="No"> No CNC <br>   
                                        </p>    
                                    </td>
                                    <td width="20%"></td>     
                                    <td width="50%"></td>   
                                </tr>                              
                            </table>                                                    
                        </div>                        
                        <table style="width:100%">
                            <tr>     
                                <td width="5%"></td>
                                <td width="25%"></td>     
                                <td width="20%"></td>     
                                <td width="50%" align="right"><input class='block' type="submit" id="savepart4" name="savepart4" value="Save"/>
                                    <input class='block' type="submit" id="updatepart4" name="updatpart4" value="Update"/>
                                    <input class='block' type="submit" id="clearpart4" name="clearpart4" value="Clear"/></td>   
                            </tr>                              
                        </table>                        
                    </div>                      
                </div>
                <div id="tabs-5">
                    <div class='well' style="height:360px;overflow-y:auto;overflow-x:auto;"  >
                    <table style="width:100%">
                         <tr><td colspan="4"><h2 class="heading">V.1 Labor & Employment </h2></td>
                    </table>
                    <table style="width:100%">
                        <tr><td width="50%">
                                <table  class="table table-bordered table-striped" style="white-space:nowrap; width:100%" id="noemptable">                        
                                    <thead style='tr:first-child th { position: sticky; top: 0; }'>                             
                                        <tr><td width="40%"><input type="text" id="part5recordid" name="part5recordid" class='form-control' autocomplete="off" disabled></td>
                                            <td width="20%"><label>Male </label></td>
                                            <td width="20%"><label>Female </label></td>
                                            <td width="20%"><label>Total </label></td>
                                        </tr>                        
                                    </thead>                        
                                            <tr><td width="40%"><label>No. of Regular Employees* </label></td>
                                                <td width="20%"><input type="number" id="M_NO_REG_EMPLOYEES" name="M_NO_REG_EMPLOYEES" class='form-control' autocomplete="off"></td>
                                                <td width="20%"><input type="number" id="F_NO_REG_EMPLOYEES" name="F_NO_REG_EMPLOYEES" class='form-control' autocomplete="off"></td>
                                                <td width="20%"><input type="numbert" id="NO_REG_EMPLOYEES" name="NO_REG_EMPLOYEES" class='form-control' autocomplete="off" disabled=""></td>
                                            </tr>     
                                            <tr><td width="40%"><label>No. of Contractual Employees* </label></td>
                                                <td width="20%"><input type="number" id="M_NO_CONTRACT_EMPLOYEES" name="M_NO_CONTRACT_EMPLOYEES" class='form-control' autocomplete="off"></td>
                                                <td width="20%"><input type="number" id="F_NO_CONTRACT_EMPLOYEES" name="F_NO_CONTRACT_EMPLOYEES" class='form-control' autocomplete="off"></td>
                                                <td width="20%"><input type="number" id="NO_CONTRACT_EMPLOYEES" name="NO_CONTRACT_EMPLOYEES" class='form-control' autocomplete="off" disabled></td>
                                            </tr>                             
                                            <tr><td width="40%"><label>No. of Sub-Contractual Employees* </label></td>
                                                <td width="20%"><input type="number" id="M_NO_SUBCON_EMPLOYEES" name="M_NO_SUBCON_EMPLOYEES" class='form-control' autocomplete="off"></td>
                                                <td width="20%"><input type="number" id="F_NO_SUBCON_EMPLOYEES" name="F_NO_SUBCON_EMPLOYEES" class='form-control' autocomplete="off"></td>
                                                <td width="20%"><input type="number" id="NO_SUBCON_EMPLOYEES" name="NO_SUBCON_EMPLOYEES" class='form-control' autocomplete="off" disabled></td>
                                            </tr>                                              
                                </table>                                
                            </td>
                            <td width="50%"></td>
                        </tr>                                                
                    </table>
                    <table style="width:100%">
                        <tr><td width="50%">
                                <table style="width:100%">
                                    <tr>
                                      <td width="60%"><label>Is the borrower/issuer engaged in hiring of minors? Or practice of child labor?</label></td>  
                                      <td width="40%"><input type="radio" name="PRAC_CHILD_LABOR" id="PRAC_CHILD_LABOR1" value="Y"> Yes &nbsp;&nbsp; <input type="radio" name="PRAC_CHILD_LABOR" id="PRAC_CHILD_LABOR2" value="N"> No </td>  
                                    </tr>
                                    </tr><tr height = 5px></tr>   
                                    <tr>
                                      <td width="60%"><label>Is the borrower/issuer paying below minimum wage?</label></td>  
                                      <td width="40%"><input type="radio" name="PAYING_BELOW_MIN_WAGE" id="PAYING_BELOW_MIN_WAGE1" value="Y"> Yes &nbsp;&nbsp; <input type="radio" name="PAYING_BELOW_MIN_WAGE" id="PAYING_BELOW_MIN_WAGE2" value="N"> No </td>  
                                    </tr>                                                             
                                </table>
                            </td>
                            <td width="50%"></td>
                        </tr>                            
                    </table>    
                    <table style="width:100%">
                        <tr><td colspan="2"><h2 class="heading">V.2 Indigenous Peoples (IP) </h2></td>
                        <tr><td width="50%">
                                <table style="width:100%">
                                    <tr>
                                      <td width="60%"><label>Does the project require land used by IPs for productive (food gathering, gardening, farming, pasture, fishing, forests) and/or cultural purposes (sacred ground, place of rites, etc.)?</label></td>  
                                      <td width="40%"><input type="radio" name="LAND_USED_IP" id="LAND_USED_IP1" value="Y"> Yes &nbsp;&nbsp; <input type="radio" name="LAND_USED_IP" id="LAND_USED_IP2" value="N"> No </td>  
                                    </tr><tr height = 5px></tr>   
                                    <tr>
                                      <td colspan="2"><textarea class="form-control" rows="4" id="LAND_USED_IP_DTL" name="LAND_USED_IP_DTL" placeholder="If Yes, Indicate details..." required="required" pattern="^[^ ']+( [^ ']+)*$"/></textarea></td>                                        
                                    </tr><tr height = 5px></tr>   
                                    <tr>
                                      <td width="60%"><label>Does the project area covered by a Certificate of Ancestral Domain Title (CADT) and/or Certificate of Ancestral Land Title (CALT) or existing claim to one?</label></td>  
                                      <td width="40%"><input type="radio" name="CADT_CALT" id="CADT_CALT1" value="Y"> Yes &nbsp;&nbsp; <input type="radio" name="CADT_CALT" id="CADT_CALT2" value="N"> No </td>  
                                    </tr><tr height = 5px></tr>   
                                    <tr>
                                      <td width="60%"><label>Region</label><input type="text" name='CADT_CALT_REGION_CODE' id="CADT_CALT_REGION_CODE" disabled></td>  
                                      <td width="40%"><select id="CADT_CALT_REGION" name="CADT_CALT_REGION" class='form-control'>                                                                                                         
                                                        <option selected="selected" value=blank>Select Value</option>
                                                      </select></td>    
                                    </tr><tr height = 5px></tr>            
                                    <tr>                         
                                      <td width="60%"><label>CADT No.</label></td>  
                                      <td width="40%"><select id="CADT_CALT_NO" name="CADT_CALT_NO" class='form-control'>                                                                                                         
                                                        <option selected="selected" value=blank>Select Value</option>
                                                      </select></td>    
                                    </tr><tr height = 5px></tr>   
                                    <tr>
                                      <td colspan="2"><textarea class="form-control" rows="4" id="CADT_CALT_LOCATION" name="CADT_CALT_LOCATION" placeholder="Location..." required="required" pattern="^[^ ']+( [^ ']+)*$" disabled></textarea></td>                                        
                                    </tr><tr height = 5px></tr>                                       
                                    <tr>                                      
                                      <td colspan="2"><input type="text" name='CADT_CALT_TRIBE' id="CADT_CALT_TRIBE" class='form-control' placeholder="Tribe" disabled></td>                                      
                                    </tr>                                         
                                    <tr><tr height = 5px></tr>
                                    <tr>                                      
                                      <td width="60%"><label>Are there IPs directly affected by the project operations?</label></td>  
                                      <td width="40%"><input type="radio" name="IP_AFFECTED" id="IP_AFFECTED1" value="Y"> Yes &nbsp;&nbsp; <input type="radio" name="IP_AFFECTED" id="IP_AFFECTED2" value="N"> No </td>  
                                    </tr><tr height = 5px></tr>                                       
                                    <tr>
                                      <td width="60%"></td>                                        
                                      <td width="40%"><input type="text" id="IP_AFFECTED_DTL" name="IP_AFFECTED_DTL" placeholder="If Yes, How many?" class='form-control' autocomplete="off"></td>
                                    </tr><tr height = 5px></tr>   
                                </table>
                            </td>
                            <td width="50%"></td>
                        </tr>                                                     
                    </table>
                    <table style="width:100%">
                        <tr><td colspan="2"><h2 class="heading">V.3 Agrarian Reform Beneficiaries (ARBs)/Farmers</h2></td>
                        <tr><td width="50%">
                                <table style="width:100%">
                                    <tr>
                                       <td width="60%"><label>Are there ARBs/Farmer beneficiaries?</label></td>  
                                       <td width="40%"><input type="radio" name="ARB_BENE" id="ARB_BENE1" value="Y"> Yes &nbsp;&nbsp; <input type="radio" name="ARB_BENE" id="ARB_BENE2" value="N"> No </td>  
                                    </tr><tr height = 5px></tr>   
                                    <tr>
                                       <td width="60%"></td>                                        
                                       <td width="40%"><input type="text" id="ARB_BENE_DTL" name="ARB_BENE_DTL" placeholder="If Yes, How many?" class='form-control' autocomplete="off"></td>
                                    </tr><tr height = 5px></tr>   
                                    <tr>
                                       <td width="60%"><label>Is the borrower an ARB/Farmer? (n/a for investment)</label></td>  
                                       <td width="40%"><input type="radio" name="ARB_BORROWER" id="ARB_BORROWER1" value="Y"> Yes &nbsp;&nbsp; <input type="radio" name="ARB_BORROWER" id="ARB_BORROWER2" value="N"> No </td>  
                                    </tr><tr height = 5px></tr>   
                                    <tr>
                                       <td width="60%"></td>                                        
                                       <td width="40%"><input type="text" id="ARB_BORROWER_DTL" name="ARB_BORROWER_DTL" placeholder="If Yes, How many?" class='form-control' autocomplete="off"></td>
                                    </tr><tr height = 5px></tr>        
                                    <tr>
                                       <td width="60%"><label>Does the borrower/issuer operate without authentic or genuine land titles?</label></td>  
                                       <td width="40%"><input type="radio" name="OPERATE_WO_AUTH_LAND_TITLE" id="OPERATE_WO_AUTH_LAND_TITLE1" value="Y"> Yes &nbsp;&nbsp; <input type="radio" name="OPERATE_WO_AUTH_LAND_TITLE" id="OPERATE_WO_AUTH_LAND_TITLE2" value="N"> No </td>  
                                    </tr><tr height = 5px></tr>   
                                    <tr>
                                       <td width="60%"><label>Are there ARBs affected in the purchase of agricultural lands?</label></td>  
                                       <td width="40%"><input type="radio" name="ARB_AFFECTED" id="ARB_AFFECTED1" value="Y"> Yes &nbsp;&nbsp; <input type="radio" name="ARB_AFFECTED" id="ARB_AFFECTED2" value="N"> No </td>  
                                    </tr><tr height = 5px></tr>                                       
                                    <tr>
                                       <td width="60%"></td>                                        
                                       <td width="40%"><input type="text" id="ARB_AFFECTED_DTL" name="ARB_AFFECTED_DTL" placeholder="If Yes, How many?" class='form-control' autocomplete="off"></td>
                                    </tr><tr height = 5px></tr>                                            
                                </table>
                            </td>
                            <td width="50%"></td>
                        </tr>                                                     
                    </table>
                    <table style="width:100%">
                        <tr><td colspan="2"><h2 class="heading">V.4 Gender and Development</h2></td>
                        <tr><td width="50%">
                                <table style="width:100%">
                                    <tr>
                                       <td width="60%"><label>Does the project promote gender equality and women’s empowerment or has it formulated/documented a Gender Policy?</label></td>  
                                       <td width="40%"><input type="radio" name="PROMOTE_GENDER_EQUALITY" id="PROMOTE_GENDER_EQUALITY1" value="Y"> Yes &nbsp;&nbsp; <input type="radio" name="PROMOTE_GENDER_EQUALITY" id="PROMOTE_GENDER_EQUALITY2" value="N"> No </td>  
                                    </tr><tr height = 5px></tr>   
                                    <tr>
                                       <td colspan="2"><textarea class="form-control" rows="4" id="PROMOTE_GENDER_EQUALITY_DTL" name="PROMOTE_GENDER_EQUALITY_DTL" placeholder="Indicate the Details..." required="required" pattern="^[^ ']+( [^ ']+)*$"></textarea></td>                                         
                                    </tr><tr height = 5px></tr>   
                                    <tr>
                                       <td width="60%"><label>What is the number or percentage of women involved in the ownership of the company?</label></td>  
                                       <td width="40%"><input type="text" id="NO_WOMEN_OWNERSHIP" name="NO_WOMEN_OWNERSHIP" class='form-control' autocomplete="off"></td>  
                                    </tr><tr height = 5px></tr>   
                                    <tr>
                                       <td width="60%"><label>What is the number or percentage of women involved in the decision making/leadership of the company?</label></td>                                        
                                       <td width="40%"></td>
                                    </tr><tr height = 5px></tr>                                          
                                    <tr>
                                       <td width="60%"><label>Board*</label></td>                                        
                                       <td width="40%"><input type="text" id="NO_WOMEN_DECISION_BOARD" name="NO_WOMEN_DECISION_BOARD" class='form-control' autocomplete="off"></td>
                                    </tr><tr height = 5px></tr>        
                                    <tr>
                                    <tr>
                                       <td width="60%"><label>Senior Management*</label></td>                                        
                                       <td width="40%"><input type="text" id="NO_WOMEN_DECISION_SENIOR_MGMT" name="NO_WOMEN_DECISION_SENIOR_MGMT" class='form-control' autocomplete="off"></td>
                                    </tr><tr height = 5px></tr>        
                                    <tr>                                        
                                       <td width="60%"><label>Are women and female children among the direct or indirect beneficiaries?</label></td>  
                                       <td width="40%"><input type="radio" name="WOMEN_BENE" id="WOMEN_BENE1" value="Y"> Yes &nbsp;&nbsp; <input type="radio" name="WOMEN_BENE" id="WOMEN_BENE2" value="N"> No </td>  
                                    </tr><tr height = 5px></tr>   
                                    <tr>
                                       <td width="60%"></td>                                        
                                       <td width="40%"><input type="text" id="WOMEN_BENE_DTL" name="WOMEN_BENE_DTL" placeholder="If Yes, How many?" class='form-control' autocomplete="off"></td>
                                    </tr><tr height = 5px></tr>                                            
                                    <tr>
                                       <td width="60%"><label>Has the project considered its long-term impact on women’s socioeconomic status and empowerment?</label></td>  
                                       <td width="40%"><input type="radio" name="WOMEN_LONG_TERM_IMPACT" id="WOMEN_LONG_TERM_IMPACT1" value="Y"> Yes &nbsp;&nbsp; <input type="radio" name="WOMEN_LONG_TERM_IMPACT" id="WOMEN_LONG_TERM_IMPACT2" value="N"> No </td>  
                                    </tr><tr height = 5px></tr>   
                                    <tr>
                                       <td colspan="2"><textarea class="form-control" rows="4" id="WOMEN_LONG_TERM_IMPACT_DTL" name="WOMEN_LONG_TERM_IMPACT_DTL" placeholder="Indicate the Details..." required="required" pattern="^[^ ']+( [^ ']+)*$"></textarea></td>                                         
                                    </tr><tr height = 5px></tr>   
                                    <tr>
                                       <td width="60%"><label>Has the project included strategies/programs for avoiding or minimizing negative impact on women’s status and welfare?</label></td>  
                                       <td width="40%"><input type="radio" name="WOMEN_MIN_IMPACT" id="WOMEN_MIN_IMPACT1" value="Y"> Yes &nbsp;&nbsp; <input type="radio" name="WOMEN_MIN_IMPACT" id="WOMEN_MIN_IMPACT2" value="N"> No </td>  
                                    </tr><tr height = 5px></tr>   
                                    <tr>
                                       <td colspan="2"><textarea class="form-control" rows="4" id="WOMEN_MIN_IMPACT_DTL" name="WOMEN_MIN_IMPACT_DTL" placeholder="Indicate the Details..." required="required" pattern="^[^ ']+( [^ ']+)*$"></textarea></td>                                         
                                    </tr><tr height = 5px></tr>  
                                    <tr>
                                       <td width="60%"><label>Does the project consistently gather and analyze sex disaggregated data and use this information to improve practice?</label></td>  
                                       <td width="40%"><input type="radio" name="IMPROVE_PRAC" id="IMPROVE_PRAC1" value="Y"> Yes &nbsp;&nbsp; <input type="radio" name="IMPROVE_PRAC" id="IMPROVE_PRAC2" value="N"> No </td>  
                                    </tr><tr height = 5px></tr>   
                                    <tr>
                                       <td colspan="2"><textarea class="form-control" rows="4" id="IMPROVE_PRAC_DTL" name="IMPROVE_PRAC_DTL" placeholder="Indicate the Details..." required="required" pattern="^[^ ']+( [^ ']+)*$"></textarea></td>                                         
                                    </tr><tr height = 5px></tr>  
                                </table>
                            </td>
                            <td width="50%"></td>
                        </tr>                                                     
                    </table>                        
                        <table style="width:100%">
                            <tr>     
                                <td width="50%"></td>
                                <td width="50%" align="right"><input class='block' type="submit" id="savepart5" name="savepart5" value="Save"/>
                                    <input class='block' type="submit" id="updatepart5" name="updatpart5" value="Update"/>
                                    <input class='block' type="submit" id="clearpart5" name="clearpart5" value="Clear"/></td>   
                            </tr>                              
                        </table>                                   
                        
                    </div>    
                </div>                
                <div id="tabs-6">
                    <div class='well' style="height:360px;overflow-y:auto;overflow-x:auto;"  >
                        <table style="width:100%">
                            <tr><td colspan="4"><h2 class="heading">VI.1 Labor & Employment </h2></td>
                        </table>
                        <table style="width:100%">
                            <tr><td width="50%">
                                    <table style="width:100%">
                                        <tr>
                                          <td width="30%"><input type="text" id="partvirecordId" name="partvirecordId" class='form-control' autocomplete="off" disabled></td>  
                                          <td width="70%"></td>  
                                        </tr><tr height = 5px></tr>                                           
                                        <tr>
                                          <td width="30%"><label>Project Name</label></td>  
                                          <td width="70%"><input type="text" id="partviProjectName" name="partviProjectName" class='form-control' autocomplete="off"></td>  
                                        </tr><tr height = 5px></tr>   
                                        <tr>
                                          <td width="30%"><label>Project Address</label></td>  
                                          <td width="70%"><textarea class="form-control" rows="4" id="partviProjectAddress" name="partviProjectAddress" required="required" pattern="^[^ ']+( [^ ']+)*$"></textarea></td>  
                                        </tr><tr height = 5px></tr>                                                             
                                        <tr>
                                          <td colspan="2"><label>Geographical Coordinates*</label></td>                                            
                                        </tr><tr height = 5px></tr>                                                                                                     
                                        <tr>
                                          <td width="30%"><label>Longitude</label></td>  
                                          <td width="70%"><input type="text" id="LONGITUDE" name="LONGITUDE" class='form-control' autocomplete="off"></td>  
                                        </tr><tr height = 5px></tr>   
                                        <tr>
                                          <td width="30%"><label>Latitude</label></td>  
                                          <td width="70%"><input type="text" id="LATITUDE" name="LATITUDE" class='form-control' autocomplete="off"></td>  
                                        </tr><tr height = 5px></tr>                                           
                                        <tr>
                                          <td colspan="2"><label>Likely to be adversely affected by seismic hazards*</label></td>                                            
                                        </tr><tr height = 5px></tr>                                                
                                    </table>
                                </td>
                                <td width="50%"></td>
                            </tr>                                                        
                        </table>
                    </div>        
                </div>           
                <div id="tabs-7">

                </div>     
            </fieldset>
            </div>

    </body>
</html>
<script src="${pageContext.request.contextPath}/pageScripts/lending.js" type="text/javascript"></script>