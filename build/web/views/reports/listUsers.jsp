<%-- 
    Document   : listUsers
    Created on : Dec 3, 2024, 11:20:09 AM
    Author     : N680
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="${pageContext.request.contextPath}/css/reports/listUsers.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
         <div id="usersReports">
            <h3 class="module-title" align="left">Generate List of Users Report</h3>
            <fieldset class="usersReportTopFieldSet">
            <div class="flex-row mt-3">
                <div class="flex-8">
                <div class="flex-row">
                    <div class="flex-8">
                        <label className="label-colored">Role</label>
                    </div>
                    <div class="flex-16">
                      <input style="font-size: 100%;" type="text" class="form-control" id="role" name="role" required>
                    </div>
                </div>
                </div>
            </div>
            <div class="flex-row mt-3">
                <div class="flex-8">
                <div class="flex-row">
                    <div class="flex-8">
                        <label className="label-colored">Unit/RC Code</label>
                    </div>
                    <div class="flex-16">
                      <input style="font-size: 100%;" type="text" class="form-control" id="unitCode" name="username" required>
                    </div>
                </div>
                </div>
            </div>
            <div class="flex-row mt-3">
                <div class="flex-8">
                <div class="flex-row">
                    <div class="flex-8">
                        <label className="label-colored">Account Status</label>
                    </div>
                    <div class="flex-16">
                      <input style="font-size: 100%;" type="text" class="form-control" id="accountStatus" name="accountStatus" required>
                    </div>
                </div>
                </div>
            </div>
                
                <div className="flex-row">
                    <div className="flex-6">
                          <div align="right">
                            <input class='block' type="submit" id="generateReport" name="generateReport" value="Generate"/>   
                            <input class='block' type="submit" id="clearFields" name="clearFields" value="Clear"/>
                          </div>
                    </div>
                </div>
                
                
            </fieldset>
        </div>
    </body>
</html>
