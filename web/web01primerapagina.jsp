<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .rojo {color:red;}
        </style>
    </head>
    <body>
        <h1>Primera página JSP</h1>
        <%
            //CODIGO JAVA DENTRO DE UN SERVLET
            //out NOS PERMITE ESCRIBIR CODIGO JAVA DENTRO DE LA PAGINA
            out.println("Esto es Java!!!");
            out.println("<h1 class='rojo'>Titulo de Java</h1>");
            String texto = "Soy un texto escrito en Java";
        %>
        <p>Podemos escribir código Java entre etiquetas HTML</p>
        <h2 style="color:blue">
            <%=texto%>
        </h2>
    </body>
</html>
