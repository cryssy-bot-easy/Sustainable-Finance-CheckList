<%-- 
    Document   : activityLogs
    Created on : Dec 3, 2024, 12:31:33 PM
    Author     : N680
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="${pageContext.request.contextPath}/css/reports/activityLogs.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <div id="activityLogReports">
            <h3 class="module-title" align="left">Generate Activity Log Report</h3>
            <fieldset class="activityLogReportTopFieldSet">
            <div class="flex-row mt-3">
                <div class="flex-8">
                <div class="flex-row">
                    <div class="flex-8">
                        <label className="label-colored">User ID</label>
                    </div>
                    <div class="flex-16">
                      <input style="font-size: 100%;" type="text" class="form-control" id="userId" name="userId" required>
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
                        <label className="label-colored">Log Date From</label>
                    </div>
                    <div class="flex-16">
                      <input style="font-size: 100%;" type="text" class="form-control" id="logDateFrom" name="logDateFrom" required>
                    </div>
                </div>
                </div>
            </div>
            <div class="flex-row mt-3">
                <div class="flex-8">
                <div class="flex-row">
                    <div class="flex-8">
                        <label className="label-colored">Log Date To</label>
                    </div>
                    <div class="flex-16">
                      <input style="font-size: 100%;" type="text" class="form-control" id="logDateTo" name="logDateTo" required>
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
