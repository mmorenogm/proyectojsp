

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Recuperar Informacion GET</title>
    
    </head>
    <body>
        <h1>Hello World!</h1>
        <a href="web02informacionservidor.jsp">volver a enviar informacion</a>
        <%
            //los parametros siempre se recuperar con String aunque sean numeros
            String nombre = request.getParameter("nombre");
            String apellidos = request.getParameter("apellidos");
            
        %>
    <h1 style="color:blue">
        Nombre: <%=nombre%>
    </h1>
    <h1 style="color:red">
        Apellidos: <%=apellidos%>
    </h1>
    </body>
</html>
