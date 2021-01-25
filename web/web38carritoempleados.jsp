<%-- 
    Document   : web00plantilla
    Created on : 19-ene-2021, 19:20:15
    Author     : mayte
--%>


<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
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
                    <h1>CARRITO</h1>
                    <%
                        //primero miramos si se quiere eliminar a alguine
                        String dato = request.getParameter("empleado");
                        if (dato!=null){
                            //recupreo el numero
                            int numempleado = Integer.parseInt(dato);
                            //recupero en un array los empleados almacenados
                            ArrayList<Integer> empleados = 
                                    (ArrayList) session.getAttribute("EMPLEADOS");
                            //borro el empleado indicado
                            empleados.remove((Integer)numempleado);
                            if (empleados.size() == 0){
                                //tenemos el carrito vacio.
                                //por lo tanto borramos la session
                                session.setAttribute("EMPLEADOS", null);
                            } else {
                            //vuelvo a cargar los empleados restantes en la session
                            session.setAttribute("EMPLEADOS", empleados);
                            }
                        }
                       //session.setAttribute("EMPLEADOS", null);
                    //miramos si dentro de la session hay datos almacenados
                    if(session.getAttribute("EMPLEADOS") == null){
                        //no tenemos almacenado a nadie.
                        // carrito vacio.
                        //damos mensajes
                        %>
                        <p style="color: red">No tenemos empleados almacenados</p>
                        <%
                    } else {
                        //hay datos. los recupero en un arrayList
                        //para poder trabajar
                        ArrayList<Integer> empleados =
                            (ArrayList) session.getAttribute("EMPLEADOS");
                        //genero u for para crear los ?
                        String condicion = "";
                        for (int i:empleados){
                            condicion += i + ",";
                        }
                        int ultimacoma = condicion.lastIndexOf(",");
                        condicion = condicion.substring(0, ultimacoma);
                        //genero la consulta
                        String sqlcarrito = "select * from empleadoshospital where idempleado IN ("
                            + condicion + ")";
                        Statement st = cn.createStatement();
                        ResultSet rs = st.executeQuery(sqlcarrito);
                        %>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Apellido</th>
                                    <th>Especialidad</th>
                                    <th>Cod. Hospital</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                        <%
                        while (rs.next()) {
                            String codemp = rs.getString("IDEMPLEADO");
                            String ape = rs.getString("APELLIDO");
                            String espe = rs.getString("FUNCION");
                            String hospitalcod = rs.getString("HOSPITAL_COD");
                            %>
                            <tr>
                                <td><%=ape%></td>
                                <td><%=espe%></td>
                                <td><%=hospitalcod%></td>
                                <td>
                                    <a class="btn btn-danger"
                                       href="web38carritoempleados.jsp?empleado=<%=codemp%>">Eliminar</a>
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
                    }
                    %>
                </div>
            </main><!-- /.container -->
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
