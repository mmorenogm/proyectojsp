



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
Connection cn = 
    DriverManager.getConnection(cadena, "system","oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Empleados por Oficio Dinamico - JSP</h1>
        <%
        //defino query para localizar los oficios
        Statement st = cn.createStatement();
        String sqloficios = "select distinct oficio from emp";
        ResultSet rs = st.executeQuery(sqloficios);
        %>
        <ul>
        <%
        while(rs.next()) {
            String oficios = rs.getString("OFICIO");
            %>
            <li>
                <a href="web11empleadosoficios.jsp?oficio=<%=oficios%>"><%=oficios%></a>
            </li>
            <%
        } // end while sqloficios
        rs.close();

        //ahora hacemos la selección en empleado para el oficio seleccionado
        String oficio = request.getParameter("oficio");
        if (oficio != null) {
            //hacemos el query para sacar los empleados
            String sqlemp = "select * from emp where oficio = ?";
            PreparedStatement pst = cn.prepareStatement(sqlemp);
            pst.setString(1, oficio);
            rs = pst.executeQuery();
            %>
            <ul>
            <%
            while(rs.next()) {
                String ape = rs.getString("APELLIDO");
                %>
                <li><%=ape%></li>
                <%
            } // end while sqlemp
            %>
            </ul>
            <%
        } // end if dato null
        %>
        </ul>
        <%
        rs.close();
        cn.close();
        %>
    </body>
</html>
