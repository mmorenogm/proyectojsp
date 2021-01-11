

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Informacion con Post</h1>
        <!-- si ponemos
            <form method="get">
            en vez de post, el valor de dato
            se mostrara en la url 
        -->
        <form method="post">
            <label>Nombre: </label>
            <input type="text" name="cajanombre"/>
            <button type="submit">Enviar información</button>
        </form>
        <%
            //capturamos la informacion del input
            String dato = request.getParameter("cajanombre");
            //debemos comprobar si hemos recibido el dato
            //antes de pintarlo (sino veremos un null)
            if(dato != null) {
                //debemos de pintar codigo HTML
                //de java entre HTML
                //debemos cerrar java y abrir java
                %>
                <!-- esto es codigo HTML -->
                <h1 style="color:red">
                    <%=dato%>
                </h1>
                <%
            }
        %>
<!--        <h1 style="color:red">
            <%=dato%>
        </h1>-->
            
    </body>
</html>
