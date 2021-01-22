<%-- 
copiamos esta pagina de web00plantilla 
y cambiamos la pagina webmenu por la webmenuhospital
creamos la cedean de conexion a Oracle y
COPIAMOS ESTA PAGINA AL RESTO DE PAGINAS WEB (CREATE, UPDATE, DETAILS)
PARA TENER TODAS LA MISMA ESTRUCTURA. AMIBAR LOS TITULOS
    Document   : web00plantilla
    Created on : 19-ene-2021, 19:20:15
    Author     : mayte
--%>

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
Connection cn = DriverManager.getConnection(cadena, "system", "oracle");
%>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/webhead.jsp"/>
        <title>JSP include Page</title>
        <%-- custom sweetalert para 
        mensaje de borrar
        --%>
        <link href="css/sweetalert2.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%--
        String datoeliminar = request.getParameter("hospitalcod");
        if (datoeliminar != null) {
            int eliminar = Integer.parseInt(datoeliminar);
            // escribo la consulta
            String sqldelete = "delete from hospital where hospital_cod = ?";
            PreparedStatement pst = cn.prepareStatement(sqldelete);
            pst.setInt(1, eliminar);
            pst.executeUpdate();
        }
        --%>
        <jsp:include page="includes/webmenuhospital.jsp"/>
        <section>
            <main role="main" class="container">
                <div class="starter-template" >
                    <h1>HOME hospitales</h1>
                    
                    <table class="table table-bordered">
                        <thead>
                            <tr class="bg-primary">
                                <th>Cod. Hospital</th>
                                <th>Nombre</th>
                                <th>Dirección</th>
                                <th>telefono</th>
                                <th>ACCIONES</th>
                            </tr>
                        </thead
                        <tbody>
                        <%
                        String sqlselect = "select * from hospital";
                        Statement st = cn.createStatement();
                        ResultSet rs = st.executeQuery(sqlselect);
                        while (rs.next()) {
                            String cod = rs.getString("HOSPITAL_COD");
                            String nombre = rs.getString("NOMBRE");
                            String direccion = rs.getString("DIRECCION");
                            String telefono = rs.getString("TELEFONO");
                            %>
                            <tr>
                                <td><%=cod%></td>
                                <td><%=nombre%></td>
                                <td><%=direccion%></td>
                                <td><%=telefono%></td>
                                <td>
                                    <a href="web34detailshospital.jsp?hospitalcod=<%=cod%>" 
                                       class="btn btn-outline-secondary">Detalle</a>
                                       <a href="web33updatehospital.jsp?hospitalcod=<%=cod%>&nombre=<%=nombre%>&direccion=<%=direccion%>&telefono=<%=telefono%>"                                          
                                       class="btn btn-outline-secondary">Modificar</a>
                                       <%--
                                       <a href="web31indexhospital.jsp?hospitalcod=<%=cod%>"
                                          class="btn btn-outline-secondary">Suprimir</a>
                                       --%>
                                       <button id="botonsuprimir">Borrar</button>
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
