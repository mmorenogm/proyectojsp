

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.beans.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    DriverManager.registerDriver(new OracleDriver());
    String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
    Connection cn =
        DriverManager.getConnection(cadena, "system", "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Buscador Oficios JSP</h1>
        <form method="post">
            <label>Indicar un oficio:</label>
            <input type="text" name="cajaoficio"/>   
            <button type="submit">Buscar empleados</button>
        </form>
        <br/>
        <%
        String oficio = request.getParameter("cajaoficio");
        if(oficio != null ) {
            String sql = "select * from emp where upper(oficio) = upper(?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, oficio);
            ResultSet rs = pst.executeQuery();
            %>
            <table border="1">
                <tr>
                    <td>Apellido</td><td>Salario</td><td>Oficio</td>
                </tr>
            <%
            while(rs.next()) {
                String apellido = rs.getString("APELLIDO");
                String salario = rs.getString("SALARIO");
                String ofi = rs.getString("OFICIO");
                %>
                <tr>
                    <td><%=apellido%></td>
                    <td><%=salario%></td>
                    <td><%=ofi%></td>
                </tr>
                <%
            } // end while
            %>
            </table>
            <%
            rs.close();
            cn.close();
        } // end if oficio null
        %>
    </body>
</html>
