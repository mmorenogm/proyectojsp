<%-- 
    Sustituimos esta pagina por la web00plantilla
    solo tenemos que cambiar webmenu por webmenudepartamentos
En este caso incluimos la cadena de conexion
    Document   : web00plantilla
    Created on : 19-ene-2021, 19:20:15
    Author     : mayte
--%>

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
                    <h1>Nuevo Departamento</h1>
                    <form method="post">
                        <div>
                            <label>Numero: </label>
                            <input type="number" name="cajanumero"
                                   class="form-control"/>
                        </div>
                        <div>
                            <label>Nombre: </label>
                            <input type="text" name="cajanombre"
                                   class="form-control"/>
                        </div>
                        <div>
                            <label>Localidad: </label>
                            <input type="text" name="cajalocalidad"
                                   class="form-control"/>
                        </div>
                        <div>
                            <button type="submit" class="btn-lg btn-success">Insertar</button>
                        </div>
                    </form>
                    <%
                    String cajanumero = request.getParameter("cajanumero");
                    String cajanombre = request.getParameter("cajanombre");
                    String cajalocalidad = request.getParameter("cajalocalidad");
                    if(cajanumero != null ) {
                        int numero = Integer.parseInt(cajanumero);
                        String sql = "insert into dept values (?,?,?)";
                        PreparedStatement pst = cn.prepareStatement(sql);
                        pst.setInt(1, numero);
                        pst.setString(2, cajanombre);
                        pst.setString(3, cajalocalidad);
                        int insertados = pst.executeUpdate();
                        cn.close();
                        //tenemos dos opciones:
                        //1) mostramos un mensaje al usuario
                        %>
                        <h2 style="color:blue">Insertados = <%=insertados%></h2>
                       
                        //2) llevarnos a otra pagina, por ejemplo, index
                        //para hacer redirecciones en java se utiliza la etiqu
                        //eta forward que nos permite poder redireccionar a otra pagina
                       
                         <h2 style="color:blue">Insertados = <%=insertados%></h2>
                         
                         <jsp:forward page="web27indexdept.jsp"/>"
                        <%
                    }
                    %>
                </div>
            </main><!-- /.container -->
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>

