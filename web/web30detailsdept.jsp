<%-- 
    Sustituimos esta pagina por la web00plantilla
    solo tenemos que cambiar webmenu por webmenudepartamentos
En este caso incluimos la cadena de conexion
    Document   : web00plantilla
    Created on : 19-ene-2021, 19:20:15
    Author     : mayte
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
        <jsp:include page="includes/webhead.jsp"/>
        <title>JSP include Page</title>
    </head>
    <body>
        <jsp:include page="includes/webmenudepartamentos.jsp"/>
        <section>
            <main role="main" class="container">
                <div class="starter-template">
                    <h1>Detalle Departamentos</h1>
                    <a href="web27indexdept.jsp">Volver a Index</a>
                    <%
                    String dato = request.getParameter("deptno");
                    if (dato != null){
                        int deptno = Integer.parseInt(dato);
                        String sql = "select * from dept where dept_no = ?";
                        PreparedStatement pst = cn.prepareStatement(sql);
                        pst.setInt(1, deptno);
                        ResultSet rs = pst.executeQuery();
                        rs.next();
                        String num = rs.getString("DEPT_NO");
                        String nom = rs.getString("DNOMBRE");
                        String loc = rs.getString("LOC");
                        rs.close();
                        cn.close();
                        %>
                        <ul class="list-group">
                            <li class="list-group-item">Numero <%=num%></li>
                            <li class="list-group-item">Nombre <%=nom%></li>
                            <li class="list-group-item">Localidad <%=loc%></li>
                        </ul>
                        <%
                    }
                    %>
                    
                </div>
            </main><!-- /.container -->
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
