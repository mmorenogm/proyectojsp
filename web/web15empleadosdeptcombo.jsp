

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
    DriverManager.getConnection(cadena, "system", "oracle");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Empleados departamentos Select</h1>
        <form>            
            <select name="selectdeptno">
                <option value="-1"></option>
                <%
                String sqldept = "select * from dept";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sqldept);
                while (rs.next()) {
                    String nombre = rs.getString("DNOMBRE");
                    String deptno = rs.getString("DEPT_NO");
                    %>
                    <option value="<%=deptno%>"><%=nombre%></option>
                    <%
                } // end while rs.next
                rs.close();            
                %>
            </select>
            <button type="submit"> Mostrar Empleados</button>
        </form>
        <hr/>
        <table border="1">
            <thead>
                <tr>
                    <th>APELLIDO</th>
                    <th>OFICIO</th>
                    <th>DEPARTAMENTO</th>
                </tr>
            </thead>
        <tbody>
             <%
             String dato = request.getParameter("selectdeptno");
             if (dato != null) {
                 int num = Integer.parseInt(dato);
                 String sqlemp = "select * from emp where dept_no = ?";
                 PreparedStatement pst = cn.prepareStatement(sqlemp);
                 pst.setInt(1, num);
                 rs = pst.executeQuery();
                 while (rs.next()) {
                     String ape = rs.getString("APELLIDO");
                     String ofi = rs.getString("OFICIO");
                     String numero = rs.getString("DEPT_NO");
                     %>
                     <tr>
                         <td><%=ape%></td>
                         <td><%=ofi%></td>
                         <td><%=numero%></td>
                     </tr>
                     <%
                 } // end while sqlemp
                 rs.close();
             }// end dato null
             cn.close();
             %>      
        </tbody>
        </table>          
    </body>
</html>
