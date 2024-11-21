var modal = document.getElementById("myModal");
var span = document.getElementsByClassName("close")[0];
modal.style.display = "none";
var warningTimeout = 840000;
var timoutNow = 60000;
var warningTimerID, timeoutTimerID;
var departmentloaded = false;
var userroleloaded = false;

$(document).ready(function () {
    initYes();
    $("#accordion").accordion();

    $('#updateuser').hide();
    $('#deleteuser').hide();
    $('#deactivateuser').hide();
    $('#liftuser').hide();
    $('#resetuser').hide();
    $('#useractlistfilename').hide();
    $('#btnuseractlist').hide();
    $('#filenamelabel').hide();
    $('#updatedept').hide();
    $('#deletedept').hide();
    $('#updateuserrole').hide();
    $('#deleteuserrole').hide();
    $('#updateteam').hide();
    $('#deleteteam').hide();
    $('#updategroup').hide();
    $('#deletegroup').hide();
    
    $("#URdivView").on('click', function () {
         clearalldiv();
         document.getElementById("DIVUSERROLEVIEW").style.display = "block";
    });
    
    $("#UMdivView").on('click', function () {
            clearalldiv();
            departmentloaded = false;
            //teamloaded = false;
            //userdesignationloaded = false;
            clearuserdiv();
            fillusertable();
            hideuserbuttons();
            document.getElementById("DIVUMVIEW").style.display = "block";

        });
        
        $("#DEPTdivView").on('click', function () {
            clearalldiv();
            document.getElementById("DIVDEPTVIEW").style.display = "block";
            cleardepdiv();
            hidebuttons();
            filltable();

        });
        
        $('#clearuser').click(function () {
            clearuserdiv();
            hideuserbuttons();
            fillusertable();

        });
        
        $("#deactivateuser").on('click', function () {
            var uname = $("#uname").val();
            var status = $("#userrole").val() === "Active" ? "A" : "I";
            //var createdby = $("#createdby").val();
            //var activestat = $("#sisactive").val();

            if (uname === "") {
                $('#messageDiv').css("display", "none");
                alert("Please Select a User");
                event.preventDefault();
                return false;
            }

            $.ajax({
                url: "DeactivateUserServlet",
                dataType: 'json',
                data: {uname: uname},
                success: function (json) {
                    if (json.res !== null) {
                        alert(json.res);
                        fillusertable();
                        clearuserdiv();
                        hideuserbuttons();
                        //showMessage(json);
                        //$('#messageDiv').css("display", "block");
                    } else {
                        event.preventDefault();
                        //$('#messageDiv').css("display", "none");
                        //$('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });
        
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
        
                // When the user clicks on <span> (x), close the modal
        span.onclick = function () {
            modal.style.display = "none";
        };
        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target === modal) {
                modal.style.display = "none";
            }
        };
        
        $("#btnStayLoggedIn").on('click', function () {
            resetTimer();
            modal.style.display = "none";
            event.preventDefault();
            //window.location.replace("/RMLG/ViewUserMaintenance");
        });
        
        $('#deptable').click(function (e) {
            cleardepdiv();
            var depid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var depname = $(e.target).closest('tr').find("td:nth-child(2)").text();
            $('#departmentname').val(depname);
            $('#departmentid').val(depid);
            hidebuttons();
        });

        $("#savedept").on('click', function () {
            var depname = $("#departmentname").val();
        
            if (depname === "") {                
                alert("Department Name is required");
                event.preventDefault();
                return false;
            }
            
            $.ajax({
                url: "DepartmentAddServlet",
                dataType: 'json',
                data: {depname: depname},
                success: function (json) {
                    if (json.res !== null) {
                        alert((json.res).substring(0, 5));
                        //alert((json.res));
                        $("#departmentid").val((json.res).substring((json.res).length, 5));
                        filltable();
                        cleardepdiv();
                        hidebuttons();                     
                    } else {
                        event.preventDefault();
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#updatedept").on('click', function () {
            var depid = $("#departmentid").val();
            var depname = $("#departmentname").val();

            if (depid === "") {                
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (depname === "") {                
                alert("Department Name is required");
                event.preventDefault();
                return false;
            }
 
            $.ajax({
                url: "DepartmentUpdateServlet",
                dataType: 'json',
                data: {depid: depid,
                    depname: depname},
                success: function (json) {
                    if (json.res !== null) {
                        alert(json.res);
                        filltable();
                        cleardepdiv();
                        hidebuttons();                        
                    } else {
                        event.preventDefault();
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

        $("#deletedept").on('click', function () {
            var depid = $("#departmentid").val();

            var confirmation = confirm("are you sure you want to delete this record?");
            if (depid === "") {
                $('#messageDiv').css("display", "none");
                alert("Record ID is blank");
                event.preventDefault();
            }
            if (confirmation) {
                $.ajax({
                    url: "DepartmentDeleteServlet",
                    dataType: 'json',
                    data: {depid: depid},
                    success: function (json) {
                        if (json.res !== null) {
                            alert(json.res);
                            filltable();
                            cleardepdiv();
                            hidebuttons();

                        } else {
                            event.preventDefault();
                            alert("Some exception occurred! Please try again.");
                        }
                    }
                });
            }
        });

        $('#cleardept').click(function () {
            cleardepdiv();
            hidebuttons();
            filltable();

        });
        
        $("#searchusermaint").on('click', function () {
            var uname = $("#uname").val();
            var nusername = uname.length;
            if (nusername < 4) {
                alert("Username should at least contain 4 characters");
                event.preventDefault();
                return false;
            }
            if (uname === "") {
                alert("Username is required");
                event.preventDefault();
                return false;
            }
            $.ajax({
                url: "UserDetailsServlet",
                dataType: 'json',
                data: {uname: uname},
                success: function (json) {
                    if (json.res !== null) {
                        if (json.message === "User already enrolled") {
                            alert("User already enrolled!");
                            $("#fullname").val(json.fullname.toString());
                            $("#email").val(json.email.toString());
                            //$("#department").text(json.department.toString());     
                        } else if (json.message === "User Not Found") {
                            alert("User not found!");
                        } else {
                            $("#fullname").val(json.fullname.toString());
                            $("#email").val(json.email.toString());
                            //$("#department").text(json.department.toString()); 
                            alert((json.message));
                        }
                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });
        
        $("#department").click(function () {

            $.ajax({
                url: "DDDepartmentServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    if (departmentloaded)
                        return;
                    $("#department").empty();
                    $("#department").append("<option value=blank>Select Value</option>");
                    for (var i = 0; i < list.length; i++) {
                        $("#department").append("<option>" + list[i].depDesc + "</option>");
                    }
                    departmentloaded = true;
                }
            });
        });
        
        $("#department").change(function () {
            supplydepid();
        });
        
        $("#userrole").click(function () {

            $.ajax({
                url: "DDUserRoleServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    if (userroleloaded)
                        return;
                    $("#userrole").empty();
                    $("#userrole").append("<option value=blank>Select Value</option>");
                    for (var i = 0; i < list.length; i++) {
                        $("#userrole").append("<option>" + list[i].roleDesc + "</option>");
                    }
                    userroleloaded = true;
                }
            });
        });
        
         $("#userrole").change(function () {
            supplyroleid();
        });
        
        $('#usertable').click(function (e) {
            clearuserdiv();
            var userid = $(e.target).closest('tr').find("td:nth-child(1)").text();
            var uname = $(e.target).closest('tr').find("td:nth-child(2)").text();
            var fullname = $(e.target).closest('tr').find("td:nth-child(3)").text();
            var email = $(e.target).closest('tr').find("td:nth-child(4)").text();
            var department = $(e.target).closest('tr').find("td:nth-child(5)").text();
            var departmentdescription = $(e.target).closest('tr').find("td:nth-child(6)").text();
            var userrole = $(e.target).closest('tr').find("td:nth-child(7)").text();
            var userroledescription = $(e.target).closest('tr').find("td:nth-child(8)").text();
            var status = $(e.target).closest('tr').find("td:nth-child(9)").text();
            var useraccess = $(e.target).closest('tr').find("td:nth-child(10)").text();                        
            $('#uname').val(uname);
            $('#fullname').val(fullname);
            $('#email').val(email);
            $('#userid').val(userid);
            //$('#depid').val(department);
            //$('#roleid').val(userrole);            
            $('#department option[value=blank]').text(departmentdescription);
            $('#userrole option[value=blank]').text(userroledescription);
            //$('#status option[value=blank]').text(status);
            $('#status').val(status);
            $('#useraccess').val(useraccess);
            supplydepid();
            supplyroleid();
            //supplyteamid();          
            hideuserbuttons();
        });            
            
        $("#updateuser").on('click', function () {
            var userid = $("#userid").val();
            var uname = $("#uname").val();
            var nusername = uname.length;
            var fullname = $("#fullname").val();
            var email = $("#email").val();
            var userrole = $("#roleid").val();            
            var department = $("#depid").val();
            var useraccess = $("#useraccess").val() == "Administrator" ? "Y" : "N";
            var status = $("#status").val() == "Active" ? "A" : "I";

            if (userid == "") {                
                alert("Record ID is required");
                event.preventDefault();
                return false;
            }
            if (nusername < 4) {                
                alert("Username should at least contain 4 characters");
                event.preventDefault();
                return false;
            }
            if (uname === "") {                
                alert("Username is required");
                event.preventDefault();
                return false;
            }
            if (fullname === "") {                
                alert("Fullname is required");
                event.preventDefault();
                return false;
            }
            if (email === "") {                
                alert("email is required");
                event.preventDefault();
                return false;
            }
            if (userrole === "") {                
                alert("User Role is required");
                event.preventDefault();
                return false;
            }
            if (department === "") {                
                alert("Department is required");
                event.preventDefault();
                return false;
            }
            if (status === "") {                
                alert("Status is required");
                event.preventDefault();
                return false;
            }
            if (useraccess === "") {                
                alert("User Access Type is required");
                event.preventDefault();
                return false;
            }
            //alert(status);
            //alert(useraccess);
            $.ajax({
                url: "UserUpdateServlet",
                dataType: 'json',
                data: {userid: userid,
                    uname: uname,
                    fullname: fullname,
                    email: email,
                    userrole: userrole,
                    department: department,
                    status: status,
                    useraccess: useraccess},
                success: function (json) {
                    if (json.res !== null) {
                        alert(json.res);
                        fillusertable();
                        //clearuserdepdiv();
                        hideuserbuttons();
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
            
        
    
    
    
        $("#saveuser").on('click', function () {
            var uname = $("#uname").val();
            var nusername = uname.length;
            var fullname = $("#fullname").val();
            var email = $("#email").val();
            var userrole = $("#roleid").val();            
            var department = $("#depid").val();
            var useraccess = $("#useraccess").val() === "Administrator" ? "Y" : "N";
            var status = $("#status").val() === "Active" ? "A" : "I";
            var createdby = $("#createdby").val();

            if (nusername < 4) {                
                alert("Username should at least contain 4 characters");
                event.preventDefault();
                return false;
            }
            if (uname === "") {
                
                alert("Username is required");
                event.preventDefault();
                return false;
            }
            if (fullname === "") {
                
                alert("Fullname is required");
                event.preventDefault();
                return false;
            }
            if (email === "") {
                
                alert("email is required");
                event.preventDefault();
                return false;
            }
            if (userrole === "") {                
                alert("User Role is required");
                event.preventDefault();
                return false;
            }
            if (department === "") {
                
                alert("Department is required");
                event.preventDefault();
                return false;
            }
            if (status == "") {
                
                alert("Status is required");
                event.preventDefault();
                return false;
            }
            if (useraccess === "") {
                
                alert("User Access Type is required");
                event.preventDefault();
                return false;
            }


            $.ajax({
                url: "UserAddServlet",
                dataType: 'json',
                data: {uname: uname,
                    fullname: fullname,
                    email: email,
                    userrole: userrole,
                    department: department,
                    status: status,
                    createdby: createdby,
                    useraccess: useraccess},
                success: function (json) {
                    if (json.res !== null) {
                        if (json.res === "Exist") {
                            alert("Username already exists!");
                        } else {
                            alert((json.res).substring(0, 5));
                            fillusertable();
                            clearuserdiv();
                            hideuserbuttons();
                        }

                    } else {
                        event.preventDefault();
                        $('#messageDiv').css("display", "none");
                        $('#messageDiv').html("");
                        alert("Some exception occurred! Please try again.");
                    }
                }
            });
        });

});

function initYes(){

const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]; 
const date = new Date();
const year = date.getFullYear();
const day = String(date.getDate()).padStart(2, '0');
let month = months[date.getMonth()];

const formattedDate = `${month} ${day}, ${year}`; 
document.getElementById('app-date-time').textContent = formattedDate;       
}

function confirmLogout() {
//    if (confirm('Are you sure you want to logout?')) {
        document.getElementById('logout-form').submit();
//    }
}

 function clearalldiv() {
            document.getElementById("DIVUMVIEW").style.display = "none";
            document.getElementById("DIVUSERACCOUNTLISTVIEW").style.display = "none";
            document.getElementById("DIVUSERACTIVITYLISTVIEW").style.display = "none";
            document.getElementById("DIVDEPTVIEW").style.display = "none";
            document.getElementById("DIVUSERROLEVIEW").style.display = "none";
            document.getElementById("DIVTEAMVIEW").style.display = "none";
};

function clearuserdiv() {
            $('#uname').val('');
            $('#userid').val('');
            $('#fullname').val('');
            $('#depid').val('');
            $('#roleid').val('');
            $('#email').val('');
            $('#myInputuser').val('');
            $('#tfiluser option:contains("Select Filter")').prop('selected', true);
            $('#department').text('');
            $('#useraccess').text('');
            $('#userrole').text('');
            $('#status').text('');
            $('#useraccess').append("<option value=blank>Select Value</option>");
            $('#useraccess').append("<option>Administrator</option>");
            $('#useraccess').append("<option>User</option>");
            $('#department').append("<option value=blank>Select Value</option>");
            $('#userrole').append("<option value=blank>Select Value</option>");
            $('#status').append("<option value=blank>Select Value</option>");
            $('#status').append("<option>Active</option>");
            $('#status').append("<option>Inactive</option>");
            $('#status option:contains("Select Value")').prop('selected', true);
            $('#department option:contains("Select Value")').prop('selected', true);
            $('#useraccess option:contains("Select Value")').prop('selected', true);
            $('#userrole option:contains("Select Value")').prop('selected', true);
            departmentloaded = false;
}

function hideuserbuttons() {
            if ($("#userid").val() != '' || $("#userid").val() != 'blank') {
                $('#saveuser').hide();
                //$('#pword').hide();
                //$('#lblpword').hide();
                //$('#liftuser').show();
                //$('#resetuser').show();
                $('#updateuser').show();
                //$('#deleteuser').show();
                $('#deactivateuser').show();
                $("#uname").prop("readonly", true);
            }
            if ($("#userid").val() == '' || $("#userid").val() == 'blank') {
                $('#saveuser').show();
                //$('#lblpword').show();
                //$('#pword').show();
                $('#updateuser').hide();
                //$('#deleteuser').hide();
                $('#deactivateuser').hide();
                //$('#liftuser').hide()
                //$('#resetuser').hide()
                $("#uname").prop("readonly", false);
            }
        }

        function fillusertable() {
            $('#usertable tbody').remove();
            $.ajax({
                url: "UserDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    var isadmin = "";
                    var accountstatus = "";

                    for (var i = 0; i < list.length; i++) {                        
                        isadmin = list[i].isAdmin == 'Y' ? 'Administrator' : 'User';
                        accountstatus = list[i].accountStatus == 'A' ? 'Active' : 'Inactive';
                        trHTML += '<tr><td id="tabuserid">'
                                + list[i].userID + '</td><td>'
                                + list[i].username + '</td><td>'
                                + list[i].fullname + '</td><td>'
                                + list[i].email + '</td><td>'
                                + list[i].deptID + '</td><td>'
                                + list[i].depDesc + '</td><td>'
                                + list[i].roleID + '</td><td>'
                                + list[i].roleDesc + '</td><td>'
                                + accountstatus + '</td><td>'
                                + isadmin + '</td><td>'
                                + list[i].createdBy + '</td><td>'
                                + list[i].dateCreated + '</td></tr>';
                    }
                    $('#usertable').append(trHTML);
                    $('#usertable td:nth-child(5) ,#usertable th:nth-child(5)').hide();
                    $('#usertable td:nth-child(7) ,#usertable th:nth-child(7)').hide();
                }
            });
        }

        function sortTableuser(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("usertable");
            switching = true;
            //Set the sorting direction to ascending:
            dir = "asc";
            //Make a loop that will continue until
            //no switching has been done:
            while (switching) {
                //start by saying: no switching is done:
                switching = false;
                rows = table.getElementsByTagName("TR");
                //Loop through all table rows (except the
                //first, which contains table headers):
                for (i = 1; i < (rows.length - 1); i++) {
                    //start by saying there should be no switching:
                    shouldSwitch = false;
                    //Get the two elements you want to compare,
                    //one from current row and one from the next:
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    //check if the two rows should switch place,
                    // based on the direction, asc or desc:
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
                    //If a switch has been marked, make the switch
                    //and mark that a switch has been done:
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    //Each time a switch is done, increase this count by 1:
                    switchcount++;
                } else {
                    //If no switching has been done AND the direction is "asc",
                    //set the direction to "desc" and run the while loop again.
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        function myFunctionuser() {
            // Declare variables 
            var input, filter, table, tr, td, i;
            //int tabfilter;
            //tabfil = document.getElementById("tablefilter").value;
            //tabfilter = tabfil.value();

            input = document.getElementById("myInputuser");
            filter = input.value.toUpperCase();
            table = document.getElementById("usertable");
            tr = table.getElementsByTagName("tr");
            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {

                td = tr[i].getElementsByTagName("td")[document.getElementById("tfiluser").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
        
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
            window.location.replace("/SFC/login");
        }

        function setupTimers() {
            document.addEventListener("mousemove", resetTimer, false);
            document.addEventListener("mousedown", resetTimer, false);
            document.addEventListener("keypress", resetTimer, false);
            document.addEventListener("touchmove", resetTimer, false);
            document.addEventListener("onscroll", resetTimer, false);
            startTimer();
        }

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
        

function cleardepdiv() {
            $('#departmentname').val('');
            $('#departmentid').val('');
            $('#myInput').val('');
            $('#tfil option:contains("Select Filter")').prop('selected', true);            
        }

        function hidebuttons() {
            if ($("#departmentid").val() != '' || $("#departmentid").val() != 'blank') {
                $('#savedept').hide()
                $('#updatedept').show()
                $('#deletedept').show()
            }
            if ($("#departmentid").val() == '' || $("#departmentid").val() == 'blank') {
                $('#savedept').show()
                $('#updatedept').hide()
                $('#deletedept').hide()
            }
        }

        function filltable() {
            $('#deptable tbody').remove();
            $.ajax({
                url: "DepartmentDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';
                    for (var i = 0; i < list.length; i++) {
                        trHTML += '<tr><td id="tabdepid">' + list[i].depID + '</td><td>' + list[i].depDesc + '</td></tr>';
                    }
                    $('#deptable').append(trHTML);
                }
            });
        }

        function sortTable(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("deptable");
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

        function myFunction() {
            // Declare variables 
            var input, filter, table, tr, td, i;
            //int tabfilter;
            //tabfil = document.getElementById("tablefilter").value;
            //tabfilter = tabfil.value();

            input = document.getElementById("myInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("deptable");
            tr = table.getElementsByTagName("tr");
            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {

                td = tr[i].getElementsByTagName("td")[document.getElementById("tfil").value];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }
        
function supplydepid() {
            var depname = $("#department option:selected").text();
            $.ajax({
                url: "DDDepartmentCodeServlet",
                dataType: 'json',
                data: {x: depname},
                success: function (json) {
                    $('#depid').val(json.depid);
                }
            });
        }
        
function supplyroleid() {
            var userrolename = $("#userrole option:selected").text();
            $.ajax({
                url: "DDUserRoleCodeServlet",
                dataType: 'json',
                data: {x: userrolename},
                success: function (json) {
                    $('#roleid').val(json.roleid);
                }
            });
        }    