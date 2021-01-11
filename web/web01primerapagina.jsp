

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            // codigo java dentro de un servlet
            //out nos permite escribir codigo java dentro de una`pag
            out.println("esto es java");
            out.println("<h1>titulo de java</h1>");
            //se puede declarar variables
            String texto = "Soy un texto escrito en java";
        %>
        <p>podemos escribir codigo java entre etiquetas HTML</p>
        <h2> style="color:blue">
            <%=texto%>
        </h2>
        
    </body>
</html>
