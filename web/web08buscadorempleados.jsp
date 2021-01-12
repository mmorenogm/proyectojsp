

<%@page import="oracle.jdbc.OracleDriver"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

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
        <h1>Buscador Empleados JSP</h1>
        <form method="post">
            <label>Salario: </label>
            <input type="number" name="cajasalario"required/>
            <button type="submit">Buscar empleados</button>
        </form>
        <%
        String dato = request.getParameter("cajasalario");
        if(dato != null) {
            int salario = Integer.parseInt(dato);
            String sql = "select * from emp where salario > ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, salario);
            ResultSet rs = pst.executeQuery();
            %>
            <ul>
            <%
            while (rs.next()) {
                String apellido = rs.getString("APELLIDO");
                String sal = rs.getString("SALARIO");
                %>
                <li><%=apellido%>, <%=sal%></li>
                <%
            } // end while
            
            %>
            </ul>  
            <%
            rs.close();
            cn.close();
            
        } // end if dato null
        
        %>
    </body>
</html>
