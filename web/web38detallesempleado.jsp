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

<%@page import="java.util.ArrayList"%>
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
                    <h1>DETALLES</h1>
                    <%
                        //Comprobamos si se ha activado el botn almacenar 
                        // os simplemente estamos inicializando la pantalla
                        String dato = request.getParameter("almacenar");
                        if (dato != null){
                            int empleadoid = Integer.parseInt(dato);
                            //esto quiere decir que queremos almacenar 
                            // al empleado que estamos visualizando
                            //Ahora tenemos que saber si tenemos 
                            //empleados almacenados en una session o es el primero
                            //los guardaremos en un ArrayList
                            ArrayList<Integer> empleados;
                            if(session.getAttribute("EMPLEADOS") != null){
                                //tengo empleados, por lo que solo debo añadir
                                //recupero los empleados almacenados en la session
                                empleados = (ArrayList) session.getAttribute("EMPLEADOS");
                            }else {
                                //debo inicilizar el ArrayList ya que no tengo
                                //datos guardaros en el durante la session
                                empleados = new ArrayList<>();
                            }
                            //en cualquiera de los casos debo insertar el empleado
                            //en el array
                            empleados.add(empleadoid);
                            session.setAttribute("EMPLEADOS", empleados);
                            %>
                            <p>Empleado <%=empleadoid%> almacenado</p>
                            <%
                        }// end if dato != null (queremos almacenar a alguien
                        
                        
                                
                    //recibimos el idempleado y buscamos
                    //al empleado con su id y lo dibujamos
                    //en esta misma pagina, recibimos un parametro
                    //llamda almaenar con el id del empleado
                    // y lo debemos guardar en session
                    //recuperamos los datos del empleado indicado por parametro
                    String datoidempleado = request.getParameter("idempleado");
                    if (datoidempleado != null){
                        
                        //tenemos el id de un empleado, buscamos sus datos
                        int empleadocod = Integer.parseInt(datoidempleado);
                        //hacemos la consulta
                        String sqlempleado = "select * from empleadoshospital where idempleado = ?";
                        PreparedStatement pst = cn.prepareStatement(sqlempleado);
                        pst.setInt(1, empleadocod);
                        ResultSet rs = pst.executeQuery();
                        rs.next();
                        String ape = rs.getString("APELLIDO");
                        String espe = rs.getString("FUNCION");
                        String codhosp = rs.getString("HOSPITAL_COD");
                        String codemp = rs.getString("IDEMPLEADO");
                        %>
                        <p>Datos del empleado numero: <strong><%=codemp%></strong></p>
                        <p><strong>Nombre: </strong> <%=ape%></p>
                        <p><strong>Especialidad: </strong> <%=espe%></p>
                        <p><strong>Cod Hospital: </strong> <%=codhosp%></p>
                        <br/>
                        <a class="btn btn-info"
                        href="web38detallesempleado.jsp?almacenar=<%=codemp%>">
                           Almacenar empleado
                    </a>
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
