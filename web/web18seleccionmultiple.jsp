

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Seleccion Multiple - Checkbox - JSP</h1>
        <p>valdira para cualquier seleccion multiple</p>
        <form method="post">
            <ul>
                <li>
                    <input type="checkbox" name="color" value="red"/>Rojo
                </li>
                <li>
                    <input type="checkbox" name="color" value="green"/>Verde
                </li>                
                <li>
                    <input type="checkbox" name="color" value="blue"/>Azul
                </li>
                <li>
                    <input type="checkbox" name="color" value="yellow"/>Amarillo
                </li>                
            </ul>
            <button type="submit">Mostrar seleccion</button>                
        </form>
        <hr/>
        <%
        //capturamos todos los seleccionados
        String[] colores = request.getParameterValues("color");
        //la pregunta es la misma. Si no recibimos nada es null
        if (colores != null) {
            //recorremos todo el array para mostrar los datos
            for (String color: colores) {
                %>
                <h2 Style="background-color: <%=color%>"><%=color%></h2>
                <%
            } // end for array colores
        } // end if colores null
        %>
    </body>
</html>
