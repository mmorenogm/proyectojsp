

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
        <%
        //recupero los 3 datos
        String datodeptno = request.getParameter("cajanumdepto");
        String departamento = request.getParameter("cajadepartamento");
        String localidad = request.getParameter("cajalocalidad");
        int insertados = 0;
        if (datodeptno != null && departamento != null && localidad != null) {
            int deptno = Integer.parseInt(datodeptno);
            String sqlinsert = "insert into dept values (?,upper(?),upper(?))";
            PreparedStatement pst = cn.prepareStatement(sqlinsert);
            pst.setInt(1, deptno);
            pst.setString(2, departamento);
            pst.setString(3, localidad);
            insertados = pst.executeUpdate();
        } // end if 3 parametros distintos de null
        %>
        <h1>Insertar Departamento - JSP</h1>
        <div>
        <form method="post">
            <table>
                <tr>
                    <td>Indicar Num Departamento:</td>
                    <td><input type="number" name="cajanumdepto" required/></td>
                </tr>
                <tr>
                    <td>Indicar Nombre Departamento:</td>
                    <td><input type="text" name="cajadepartamento" required/></td>
                </tr>
                <tr>
                    <td>Indicar Localidad: </td>
                    <td><input type="text" name="cajalocalidad" required/></td>
                </tr>
            </table>
            <button type="submit">Alta</button>
        </form>
        <br/>
        </div>
        
        <%
        String sqldepto = "select * from dept";
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery(sqldepto);
        %>
        <div>
            <table border="1">
            <tr>
                <th>Num Depto</th>
                <th>Departamento</th>
                <th>Localidad</th>
            </tr>
        <%
        while(rs.next()) {
            String deptno = rs.getString("DEPT_NO");
            String dnombre = rs.getString("DNOMBRE");
            String loc = rs.getString("LOC");
            %>
            <tr>
                <td><%=deptno%></td>
                <td><%=dnombre%></td>
                <td><%=loc%></td>
            </tr>
            <%
        } // end while sqldepto
       
        %>
        </table>
        </div>
        <%
        if (datodeptno != null && departamento != null && localidad != null){
        %>
        <h1 style="color:blue"> Registros insertados: <%=insertados%></h1>
        <%
        } // end if null 3 parametros otra vez
        rs.close();
        cn.close();
        %>
    </body>
</html>
