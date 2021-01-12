

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Tabla multiplicar JSP</h1>
        <form method="post">
            <label>Indicar un numero: </label>
            <input type="number" name="cajanumero"/>
            <button type="submit">Mostrar tabla</button>
        </form>
        <br/>
        <%
        String dato = request.getParameter("cajanumero");
        if (dato != null) {
            int num = Integer.parseInt(dato);
            %>
            <table border='1'>
                <tr>
                    <td>Operación</td>
                    <td>Resultado</td>
                </tr>
                <%
                for (int i = 1; i<=10; i++) {
                    int producto = num * i;
                    %>
                    <tr>
                        <td><%=num%>*<%=i%></td>
                        <td><%=producto%></td>
                    </tr>
                    <%
                } // end for
                %>
            </table>
            <%
        } // end if dato null
        %>
       
        
    </body>
    
</html>
