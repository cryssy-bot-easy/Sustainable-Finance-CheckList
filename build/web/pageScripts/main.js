

$(document).ready(function () {
   
    $('.menu-link').click(function (e) {
            e.preventDefault(); // Prevent default link behavior
            var page = $(this).data('page');

            $('#main-content').load('views/' + page + '.jsp');
    });
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
        
    function confirmLogout() {
//        if (confirm('Are you sure you want to logout?')) {
            document.getElementById('logout-form').submit();
//        }
    }
