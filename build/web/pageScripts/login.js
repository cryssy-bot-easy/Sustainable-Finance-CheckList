$(document).ready(function () {
   initOne();
   $("#toggle_pwd").click(function () {
                $(this).toggleClass("fa-eye fa-eye-slash");
                var type = $(this).hasClass("fa-eye-slash") ? "text" : "password";
                $("#password").attr("type", type); });
    resetForm();
});

function initOne(){
    window.onload = disableBack();
    window.onload = showMessage();
    window.onpageshow = function (evt) {
    if (evt.persisted)
        disableBack();
        showMessage();
    };
}

function disableBack() {
    window.history.forward();
}

function showMessage() {
        var message = $("#message").val();
        if (message === 'Invalid Credentials') {
            $('#messageDiv').html("<font color='white'>Invalid Credentials!</font>");
            $('#messageDiv').css("display", "block");
        } else if (message === 'User Not Enrolled') {
            $('#messageDiv').html("<font color='white'>User Not Enrolled!</font>");
            $('#messageDiv').css("display", "block");
        } else if (message === 'User Inactive') {
            $('#messageDiv').html("<font color='white'>User Inactive!</font>");
            $('#messageDiv').css("display", "block");
        } else {
            $('#messageDiv').html("<font color='white'></font>");
        }
 
}

function resetForm() {
   // Clear all form fields
    document.getElementById("username").value = "";
    document.getElementById("password").value = "";
    document.getElementById("domain").value = "corp.landbank.com";  // Reset to default value if needed
}