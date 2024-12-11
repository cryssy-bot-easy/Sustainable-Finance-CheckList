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
            
        fillroletable();
        
          
});

function fillroletable() {
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

        function fillroletable() {
            $('#roletable tbody').remove();
            $.ajax({
                url: "RoleDataServlet",
                dataType: 'json',
                success: function (json) {
                    var list = [];
                    list = json.res;
                    var trHTML = '';

                    for (var i = 0; i < list.length; i++) {      
                        trHTML += '<tr><td id="tabroleid">'
                                + list[i].roleID + '</td><td>'
                                + list[i].roleDesc + '</td><td>';
                    }
                    $('#roletable').append(trHTML);
                    $('#roletable td:nth-child(5) ,#usertable th:nth-child(5)').hide();
                    $('#roletable td:nth-child(7) ,#usertable th:nth-child(7)').hide();
                }
            });
        }

        function sortTableuser(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("roletable");
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
            table = document.getElementById("roletable");
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