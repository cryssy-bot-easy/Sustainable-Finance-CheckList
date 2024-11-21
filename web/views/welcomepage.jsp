<%-- 
    Document   : welcomepage
    Created on : 09 6, 24, 3:34:10 PM
    Author     : F862
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <h2>Username <%= session.getAttribute("username")%>
         <h2>Distinguished Name: <%= session.getAttribute("distinguishedName")%>  
         <h2>Common Name: <%= session.getAttribute("commonName")%>
         <h2>Email: <%= session.getAttribute("email")%>
         <h2>Member of: <%= session.getAttribute("memberof")%>
         <h2>User Principal: <%= session.getAttribute("userprincipal")%>    
                             
    </body>
</html>
