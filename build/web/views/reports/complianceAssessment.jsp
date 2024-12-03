<%-- 
    Document   : complianceAssessment
    Created on : Dec 3, 2024, 2:14:04 PM
    Author     : N680
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="${pageContext.request.contextPath}/css/reports/compliance.css" rel="stylesheet" type="text/css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <div id="complianceReports">
            <h3 class="module-title" align="left">Generate E&S Sustainable Finance and Compliance Assessment</h3>
            <fieldset class="complianceReportTopFieldSet">
            <div class="flex-row mt-3">
                <div class="flex-8">
                <div class="flex-row">
                    <div class="flex-8">
                        <label className="label-colored">E&S Request ID</label>
                    </div>
                    <div class="flex-16">
                      <input style="font-size: 100%;" type="text" class="form-control" id="requestId" name="requestId" required>
                    </div>
                </div>
                </div>
            </div>
            <div class="flex-row mt-3">
                <div class="flex-8">
                <div class="flex-row">
                    <div class="flex-8">
                        <label className="label-colored">Loan/Investment ID</label>
                    </div>
                    <div class="flex-16">
                      <input style="font-size: 100%;" type="text" class="form-control" id="investmentId" name="investmentId" required>
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
                      <input style="font-size: 100%;" type="text" class="form-control" id="rcCode" name="rcCode" required>
                    </div>
                </div>
                </div>
            </div>
            <div class="flex-row mt-3">
                <div class="flex-8">
                <div class="flex-row">
                    <div class="flex-8">
                        <label className="label-colored">Created By</label>
                    </div>
                    <div class="flex-16">
                      <input style="font-size: 100%;" type="text" class="form-control" id="createdBy" name="createdBy" required>
                    </div>
                </div>
                </div>
            </div>
            <div class="flex-row mt-3">
                <div class="flex-8">
                <div class="flex-row">
                    <div class="flex-8">
                        <label className="label-colored">Created Date From</label>
                    </div>
                    <div class="flex-16">
                      <input style="font-size: 100%;" type="text" class="form-control" id="createdDateFrom" name="createdDateFrom" required>
                    </div>
                </div>
                </div>
            </div>
            <div class="flex-row mt-3">
                <div class="flex-8">
                <div class="flex-row">
                    <div class="flex-8">
                        <label className="label-colored">Created Date To</label>
                    </div>
                    <div class="flex-16">
                      <input style="font-size: 100%;" type="text" class="form-control" id="createdDateTo" name="createdDateTo" required>
                    </div>
                </div>
                </div>
            </div> 
            <div class="flex-row mt-3">
                <div class="flex-8">
                <div class="flex-row">
                    <div class="flex-8">
                        <label className="label-colored">Approved By</label>
                    </div>
                    <div class="flex-16">
                      <input style="font-size: 100%;" type="text" class="form-control" id="approvedBy" name="approvedBy" required>
                    </div>
                </div>
                </div>
            </div>
            <div class="flex-row mt-3">
                <div class="flex-8">
                <div class="flex-row">
                    <div class="flex-8">
                        <label className="label-colored">Approved Date From</label>
                    </div>
                    <div class="flex-16">
                      <input style="font-size: 100%;" type="text" class="form-control" id="approvedDateFrom" name="approvedDateFrom" required>
                    </div>
                </div>
                </div>
            </div>
             <div class="flex-row mt-3">
                <div class="flex-8">
                <div class="flex-row">
                    <div class="flex-8">
                        <label className="label-colored">Approved Date To</label>
                    </div>
                    <div class="flex-16">
                      <input style="font-size: 100%;" type="text" class="form-control" id="approvedDateTo" name="approvedDateTo" required>
                    </div>
                </div>
                </div>
            </div>
            <div class="flex-row mt-3">
                <div class="flex-8">
                <div class="flex-row">
                    <div class="flex-8">
                        <label className="label-colored">Approved Status</label>
                    </div>
                    <div class="flex-16">
                      <input style="font-size: 100%;" type="text" class="form-control" id="approvedStatus" name="approvedStatus" required>
                    </div>
                </div>
                </div>
            </div>
            <div class="flex-row mt-3">
                <div class="flex-8">
                <div class="flex-row">
                    <div class="flex-8">
                        <label className="label-colored">SFTG Classification</label>
                    </div>
                    <div class="flex-16">
                      <input style="font-size: 100%;" type="text" class="form-control" id="classification" name="classification" required>
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
