<%-- 
    -- rownum solo puede filtrar cuando ya ha geenrado los numeros
-- priemero ;se hace la consulta
-- despues contrar las filas de las conulsta
-- por ultimo haremos la consulta para filtrar todo

select * from (
select rownum as posicion, apellido
from 
(select apellido from emp) empleados) consulta
where posicion >=6 and posicion < (6+5);
--%>

<%@page import="java.sql.PreparedStatement"%>
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
                display : inline;
            }
        </style>
    </head>
    <body>
        <h1>Paginacion grupo con Oracle</h1>
        <%
        //no tenemos el numero de registro total a dibujar
        String sqlregistros = "select count(emp_no) as personas from emp";
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery(sqlregistros);
        rs.next();
        int registros = rs.getInt("PERSONAS");
        rs.close();
        // ahora el sql principal
        String sqlemp = "select * from " +
                " (select rownum as posicion, empleados.* from " + 
                " (select apellido, oficio, salario from emp) empleados) consulta " +
                " where posicion >=? and posicion < ?";
        int posicion = 1;
        String dato = request.getParameter("posicion");
        if(dato != null){
            posicion = Integer.parseInt(dato);
        }
        //ejecutamos la consulta
        PreparedStatement pst = cn.prepareStatement(sqlemp);
        pst.setInt(1, posicion);
        pst.setInt(2, posicion + 5);
        rs = pst.executeQuery();
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>Posicion</th>
                    <th>Apellido</th>
                    <th>Oficio</th>
                    <th>Salario</th>
                </tr>
            </thead>
            <tbody>
                <%
                while (rs.next()){
                    String pos = rs.getString("POSICION");
                    String ape = rs.getString("APELLIDO");
                    String ofi = rs.getString("OFICIO");
                    String sal = rs.getString("SALARIO");
                %>
                <tr>
                    <td><%=pos%></td>
                    <td><%=ape%></td>                    
                    <td><%=ofi%></td>
                    <td><%=sal%></td>
                </tr> 
                <%
                }
                rs.close();
                cn.close();
                %>
            </tbody>
        </table>
        <hr/>
        <ul id="menu">
            <%
            int numeropagina = 1;
            for (int i = 1; i<=registros; i+=5){
                %>
                <li>
                    <a href="web26paginaciongrupooracle.jsp?posicion=<%=i%>"><%=numeropagina%></a>
                </li>
                <%
                numeropagina +=1;
            }
            %>
        </ul>
    </body>
</html>
