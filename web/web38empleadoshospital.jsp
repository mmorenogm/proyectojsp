<%-- 
    Document   : web00plantilla
    Created on : 19-ene-2021, 19:20:15
    Author     : mayte

Viene de la vista:
create or replace view empleadoshospital
as
select empleado_no as idempleado,
apellido, funcion, hospital_cod
from plantilla
union
select doctor_no, apellido,
especialidad, hospital_cod
from doctor;
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
        <jsp:include page="includes/webmenu.jsp"/>
        <section>
            <main role="main" class="container">
                <div class="starter-template">
                    <h1>EMPLEADOS HOSPITAL</h1>
                    <%
                    //recibimos un codigo de hospital y buscamos los empleados
                    //de ese hospital y los dibujamos
                    //comorpbamos si me han pasado un dato por parametro o no
                    // en caso posivito recuperamos los dato, en caso negativo
                    //indicamos que no debemos ir a hospialtes para seleccionar uno
                    String dato = request.getParameter("idhospital");
                    if (dato == null){
                        // no se ha seleccionado ningun hospital 
                        //poner enlace a pagina hospital
                        %>
                        <p><strong>Debe seleccionar un hospital</strong></p>
                        <a href="web38hospitales.jsp" class="alert">
                            ir a hospitales.....
                        </a>
                        <%
                    }else {
                        //tenemos un empleado, buscamos sus datos en la vista
                        //generamos la consulta
                        int hospitalcod = Integer.parseInt(dato);
                        String sqlempleados = "select * from empleadoshospital where hospital_cod = ?";
                        PreparedStatement pst = cn.prepareStatement(sqlempleados);
                        pst.setInt(1, hospitalcod);
                        ResultSet rs = pst.executeQuery();
                        %>
                        <table class="table table-borderless align-content-center">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                            while (rs.next()) {
                                String codempleado = rs.getString("IDEMPLEADO");
                                String ape = rs.getString("APELLIDO");
                                %>
                                <tr>
                                    <td><%=ape%></td>
                                    <td>
                                        <a class="btn btn-success"
                                           href="web38detallesempleado.jsp?idempleado=<%=codempleado%>">Detalles</a>
                                    </td>
                                </tr>
                                <%
                            }
                            rs.close();
                            cn.close();
                            %>                                
                            </tbody>
                        </table>
                        <%
                    } // end if dato == null
                    %> 
                </div>
            </main><!-- /.container -->
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
