


<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
        <h1>Detalles Empleado - JSP</h1>
        <form method="post">
            <label>Num de Empleado: </label>
            <select name="cajaempno">
                <option value="-1">Todos</option>
              <%                
              String sql = "select * from emp";
              Statement st = cn.createStatement();
              ResultSet rs = st.executeQuery(sql);
              while(rs.next()) {
               String ape = rs.getString("APELLIDO");
               String emp_no = rs.getString("EMP_NO");
               %>
               <option value="<%=emp_no%>"><%=ape%></option>
                <%
              }
              rs.close();
              %> 
            </select>
                
            <button type="submit">Mostrar información</button>
            <br/><br/>
        </form>
        <%
        String dato = request.getParameter("cajaempno");
        if(dato != null) {
            int empno = Integer.parseInt(dato);
            String sqlemp = "select * from emp where emp_no = ?";
            PreparedStatement pst = cn.prepareStatement(sqlemp);
            pst.setInt(1, empno);
            rs = pst.executeQuery();
            %>
            <table>
                <tr>
                    <th>Empleado</th>
                    <th>Apellido</th>
                    <th>Oficio</th>
                    <th>Salario</th>
                </tr>
                
            <%
             if (rs.next()) {
                String empleado = rs.getString("EMP_NO");
                String apellido = rs.getString("APELLIDO");
                String oficio = rs.getString("OFICIO");
                String salario = rs.getString("SALARIO");
                %>
                <tr>
                    <td><%=empleado%></td>
                    <td><%=apellido%></td>
                    <td><%=oficio%></td>
                    <td><%=salario%></td>
                </tr>
                <%
            } else {
                %>
                <h1 style="color:red">No existe el empleado con id: <%=dato%></h1>
                <%

            } // end if 
            %>
            </table>
            <%
        }// end if null
        %>
    </body>
</html>
