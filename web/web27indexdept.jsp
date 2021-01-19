<%-- 
    Sustituimos esta pagina por la web00plantilla
    solo tenemos que cambiar webmenu por webmenudepartamentos
En este caso incluimos la cadena de conexion
    Document   : web00plantilla
    Created on : 19-ene-2021, 19:20:15
    Author     : mayte
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
        <jsp:include page="includes/webhead.jsp"/>
        <title>JSP include Page</title>
    </head>
    <body>
        <jsp:include page="includes/webmenudepartamentos.jsp"/>
        <section>
            <main role="main" class="container">
                <div class="starter-template">
                    <h1>Home Departamentos</h1>
                    <%
                    String sql = "select * from dept";
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery(sql);                    
                    %>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Numero</th>
                                <th>Nombre</th>
                                <th>Localidad</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            while (rs.next()){
                                String num = rs.getString("DEPT_NO");
                                String nom = rs.getString("DNOMBRE");
                                String loc = rs.getString("LOC");
                                %>
                                <tr>
                                    <td><%=num%></td>
                                    <td><%=nom%></td>
                                    <td><%=loc%></td>
                                    <td>
                                        <a class="btn btn-primary"
                                           href="web30detailsdept.jsp?deptno=<%=num%>">Detalles</a>
                                    </td>
                                </tr>
                                <%
                            }
                            rs.close();
                            cn.close();
                            %>
                        </tbody>                    
                    </table>
                </div>
            </main><!-- /.container -->
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
