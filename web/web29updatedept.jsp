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
        <%
        // aqui podríamos pintar un mensje diciendo que hemos 
        //modificado un dato, como vimos al principio
        String cajanumero = request.getParameter("cajanumero");
        String cajanombre = request.getParameter("cajanombre");
        String cajalocalidad = request.getParameter("cajalocalidad");
        if(cajanumero != null ){
            int num = Integer.parseInt(cajanumero);
            String sqlupdate = "update dept set dnombre = ?, loc = ? " +
                   " where dept_no=?"; 
            PreparedStatement pst = cn.prepareStatement(sqlupdate);
            pst.setString(1, cajanombre);;
            pst.setString(2, cajalocalidad);
            pst.setInt(3, num);
            pst.executeUpdate();
            cn.close();
            %>
            <jsp:forward page="web27indexdept.jsp"/>
            <%
        }
        
        %>
        <jsp:include page="includes/webmenudepartamentos.jsp"/>
        <section>
            <main role="main" class="container">
                <div class="starter-template">
                    <h1>Modificar Departamento</h1>
                    <a href="web27indexdept.jsp">volver a index</a>
                    <%
                    String dato = request.getParameter("deptno");
                    if (dato != null){
                        int numero = Integer.parseInt(dato);
                        String sqlselect = "select * from dept where dept_no = ?";
                        PreparedStatement pst = cn.prepareStatement(sqlselect);
                        pst.setInt(1, numero);
                        ResultSet rs = pst.executeQuery();
                        rs.next();
                        String nombre = rs.getString("DNOMBRE");
                        String localidad = rs.getString("LOC");
                        rs.close();
                        //cerramos aqui si vamos a utilizar el jsp:forward
                        
                        %>
                    
                        <form method="post">
                            <input type="hidden" value="<%=numero%>" name="cajanumero"/>
                            <label>Nombre : </label>
                            <input type="text" name="cajanombre"
                                   value="<%=nombre%>" class="form-control"/><br/>
                            <label>Localidad :</label>
                            <input type="text" name="cajalocalidad"
                                   value="<%=localidad%>" class="form-control"/><br/>
                            <button type="submit" class="btn-info">Modificar</button>
                        </form>
                        <%
                    }
                    %>
                </div>
            </main><!-- /.container -->
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
