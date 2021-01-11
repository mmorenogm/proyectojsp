

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Numeros pares</h1>
        <ul>
        <%
            for (int i = 2; i<=20; i++) {
                if(i%2 == 0) {
                %>
                <li><%=i%></li>
                <%
                } // end if
            } // end for
        %>
        </ul>
        
        <!-- version 2.0 con caja de dato -->
        <p>Ahora pedimos el valor del numero final</p>
        
        <form method="post">
            <input type="number" name="cajanumero"/>
            <button type="submit"> Mostrar los pares</button>
            
        </form>
        <ul>
         <%
             String dato = request.getParameter("cajanumero");
             if(dato != null) {
             int num = Integer.parseInt(dato);
                for (int i = 1; i<= num; i++) {
                    if(i%2 == 0 ) {
                    %>
                    <li><%=i%></li>
                     <%
                    } // end if
                } // end for
             } // end if dato null
         %>  
        </ul>         
    </body>
</html>
