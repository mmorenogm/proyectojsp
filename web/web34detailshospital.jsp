<%-- 
ESTA PAGINA ES UNA COPIA DE webindexhospital una vez diseñada con lo que se
indica a continuación:
copiamos esta pagina de web00plantilla 
y cambiamos la pagina webmenu por la webmenuhospital
creamos la cedean de conexion a Oracle y
COPIAMOS ESTA PAGINA AL RESTO DE PAGINAS WEB (CREATE, UPDATE, DETAILS)
PARA TENER TODAS LA MISMA ESTRUCTURA. AMIBAR LOS TITULOS
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
        <jsp:include page="includes/webmenuhospital.jsp"/>
        <section>
            <main role="main" class="container">
                <div class="starter-template">
                    <h1>Detalle hospital</h1>
                    <a href="web31indexhospital.jsp">volver a Index</a>
                    <br><br/>
                    <%
                    //Recupero el codigo de hospital que viene como parametro
                    // en la url
                    String dato = request.getParameter("hospitalcod");
                    if(dato != null) {
                        int cod = Integer.parseInt(dato);
                        //genero la consulta para recuperar los datos del hospital 
                        //preguntado y almacenado en cod.
                        String sqlhospital = "select * from hospital where hospital_cod = ?";
                        PreparedStatement pst = cn.prepareStatement(sqlhospital);
                        pst.setInt(1, cod);
                        ResultSet rs = pst.executeQuery();
                        //solo recupero 1 fila, por lo que me muevo a ella directamente
                        rs.next();
                        //almaceno los datos de la tabla y luego decido como pintarlos
                        String nombre = rs.getString("NOMBRE");
                        String direccion = rs.getString("DIRECCION");
                        String telefono = rs.getString("TELEFONO");
                        %>
                        <p>Los datos del hospital con código <strong><%=cod%></strong> son:</p>
                        <p><b>Nombre:</b> <%=nombre%></p><br/>
                        <p><b>Direccion:</b> <%=direccion%></p><br/>
                        <p><b>Telefono:</b> <%=telefono%></p>
                        <%
                        rs.close();
                        cn.close();
                    }
                    %>
                </div>
            </main><!-- /.container -->
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
