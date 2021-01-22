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
                    <h1>Alta hospital</h1>
                    <a href="web31indexhospital.jsp">volver a Index</a>
                    <br></br>
                    <%--
                    creamos un form para introducir los datos
                    --%>
                    <div class="container" style="width: 400px" >
                    <form method="post">
                        <table class="table table-active">
                            <thead>                                
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Cod Hospital:</td>
                                    <td>
                                        <input type="number" name="cajahospitalcod" required/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Nombre:</td>
                                    <td>
                                        <input type="text" name="cajanombre" required/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Direccion: </td>
                                    <td>
                                        <input type="text" name="cajadireccion" required/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Telefono </td>
                                    <td>
                                        <input type="text" name="cajatelefono" required/>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <br/>
                        <button type="submit" name="boton">Insertar</button>
                    </form>
                    </div> 
                    <%
                    String dato = request.getParameter("cajahospitalcod");
                    if(dato != null){
                        int cod = Integer.parseInt(dato);
                        String nombre = request.getParameter("cajanombre");
                        String direccion = request.getParameter("cajadireccion");
                        String telefono = request.getParameter("cajatelefono");
                        //genero la consulta de accion
                        String sqlinsert = "insert into hospital " +
                                "(hospital_cod, nombre, direccion, telefono)" + 
                                " values (?,?,?,?)";
                        PreparedStatement pst = cn.prepareStatement(sqlinsert);
                        pst.setInt(1, cod);
                        pst.setString(2, nombre);
                        pst.setString(3, direccion);
                        pst.setString(4, telefono);
                        int insertados = pst.executeUpdate();
                        %>
                        <h2 style="color:blue">Registros insertados: <%=insertados%></h2>
                        <%
                        cn.close();
                    }
                    %>
                </div>
            </main><!-- /.container -->
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>

