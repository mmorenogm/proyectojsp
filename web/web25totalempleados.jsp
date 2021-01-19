<%--
Vista utilizada para esta practica
create or replace view todosempleados as
select apellido, oficio, salario
from emp
union
select apellido, funcion, salario
from plantilla
union
select apellido, especialidad, salario
from doctor;
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn = DriverManager.getConnection(cadena, "system", "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            ul#menu li {
                display: inline;
            }
        </style>
    </head>
    <body>
        <h1>Total empleados hospital paginado en grupos</h1>
        <%
        String sqlempleados = "select * from todosempleados";
        Statement st = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = st.executeQuery(sqlempleados);
        
        //buscamos la posicion del cursor
         String dato = request.getParameter("posicion");
         int posicion = 1;
         if (dato != null){
             posicion = Integer.parseInt(dato);
         }
         // averiguamos el num de registros
         rs.last();
         int numregistros = rs.getRow();
         //posicionamos el cursor en la posicion en la que se encuentra
         rs.absolute(posicion);
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>Apellido</th>
                    <th>Funcion</th>
                    <th>Salario</th>
                </tr>
            </thead>
            <tbody>
                <%
                //vamos a pintar de 5 en 5
                for (int i=1; i<=5 && !rs.isAfterLast(); i++) {
                    String ape = rs.getString("APELLIDO");
                    String fun = rs.getString("OFICIO");
                    String sal = rs.getString("SALARIO");
                    %>
                    <tr>
                        <td><%=ape%></td>
                        <td><%=fun%></td>
                        <td><%=sal%></td>
                    </tr>
                    <%
                    rs.next();
                } // end pintar de 5 en 5
                rs.close();
                cn.close();
                %>
            </tbody>
        </table>
            <ul id="menu">
                <%
                int numeropagina = 1;
                for (int i = 1; i<=numregistros; i+=5){
                    %>
                    <li>
                        <a href="web25totalempleados.jsp?posicion=<%=i%>">
                        pagina <%=numeropagina%>
                        </a>
                    </li>
                    <%
                    numeropagina += 1;
                }// end for paginar
                %>
            </ul>
    </body>
</html>
