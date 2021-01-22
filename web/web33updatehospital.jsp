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
        <%
        String datopasado = request.getParameter("cajahospitalcod");
        if(datopasado != null) {
            int cod = Integer.parseInt(datopasado);
            String nombre = request.getParameter("cajanombre");
            String direccion = request.getParameter("cajadireccion");
            String telefono = request.getParameter("cajatelefono");
            // genero la consulta update
            String sqlupdate = "update hospital set nombre=?, direccion=?, telefono=? " +
                    " where hospital_cod = ?";
            PreparedStatement pst = cn.prepareStatement(sqlupdate);
            pst.setString(1, nombre);
            pst.setString(2, direccion);
            pst.setString(3, telefono);
            pst.setInt(4, cod);
            pst.executeUpdate();
            cn.close();
            %>
            <jsp:forward page="web31indexhospital.jsp"/>
            <%
            
            
        }
        %>
        <jsp:include page="includes/webmenuhospital.jsp"/>
        <section>
            <main role="main" class="container">
                <div class="starter-template">
                    <h1>Modificar hospital</h1>
                    <a href="web31indexhospital.jsp">volver a Index</a>
                    <br></br>
                    <%
                    //recuperamos los datos del cod de hospital que pasamos por parametro
                    // y lo mostramos en pantalla para que sean modificados
                    String dato = request.getParameter("hospitalcod");
                    
                    if(dato != null) {
                        //hacemos el query para recuperar los datos
                        int cod = Integer.parseInt(dato);
                        String nombre = request.getParameter("nombre");
                        String direccion = request.getParameter("direccion");
                        String telefono = request.getParameter("telefono");
                        %>
                        <form method="post">
                            <label> Codigo Hospital a ser actualizado</label>
                            <input type="number" name="cajahospitalcod" readonly value="<%=cod%>"/><br/>
                            <label>Nombre: </label>
                            <input type="text" name="cajanombre" value="<%=nombre%>"/><br/>
                            <label>Direccion: </label>
                            <input type="text" name="cajadireccion" value="<%=direccion%>"/><br/>
                            <label>telefono: </label>
                            <input type="text" name="cajatelefono" value="<%=telefono%>"/><br/>
                            <button type="submit">Actualizar</button>
                               
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
