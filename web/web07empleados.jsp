<%-- Esto es una directiva --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="oracle.jdbc.OracleDriver"%>
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
    </head>
    <body>
        <h1>Empleados Oracle</h1>
        <%
        String sql = "select * from emp";
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery(sql);
        %>
        <ul>
        <%
        while (rs.next()) {
            String apellido = rs.getString("APELLIDO");
            %>
            <li><%=apellido%></li>
            <%
        } // end while
        %>
        </ul>
        <%
        rs.close();
        cn.close();
        %>
    </body>
</html>
