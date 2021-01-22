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
                    <h1>Mostrar Empleados</h1>
                    <a href="web37almacenarempleados.jsp">Ir ....Empleados Almacenados</a>                    
                    <%
                        //session.setAttribute("EMPLEADOS", null);
                        //para borrar un empleado de la session
                    String dato = request.getParameter("eliminar");
                    if (dato != null) {
                        int idempleado = Integer.parseInt(dato);
                        ArrayList<Integer> idempleados = (ArrayList)
                                session.getAttribute("EMPLEADOS");
                        //debemos eliminar el empleado que ha venido
                        //hay que decirle especificamente el tipo del dato, ya que es 
                        //un objeto, no un indice
                        idempleados.remove((Integer)idempleado);
                        //si hemos eliminado todos los empleados
                        //eliminamos la session
                        if(idempleados.size() == 0){
                            session.setAttribute("EMPLEADOS", null);
                        } else {
                        //refrescamos los valores de la session
                        session.setAttribute("EMPLEADOS", idempleados);
                        }
                    }
                     
                    if(session.getAttribute("EMPLEADOS") == null){
                        //no exite
                        %>
                        <h1 style="color: red">No existe empleados almacenados</h1>
                        <%
                    }else {
                        //tenemos empleados
                        //recuperamos los empleados almacenados
                        ArrayList<Integer> empleados = 
                            (ArrayList)session.getAttribute("EMPLEADOS");
                        //tenemos multiples ids de empleados
                        //debemos hacer una consulta para buscar
                        //los empleados por su id
                        //vamos a separar los empleados por , para
                        //hacer una consulta in()
                        //select * from emp where emp_no in (888,999)
                        //para poder utilizar join y separar un string por comas
                        //es necesario tener un array y nosotros tenemos una coleccion
                        //debemos convertir la coleccion en array de string
                        String datos = "";
                        for (int id: empleados){
                            datos += id + ",";
                        }
                        int ultimacoma = datos.lastIndexOf(",");
                        datos = datos.substring(0, ultimacoma);
                        String sqlselect =
                            "select * from emp where emp_no in (" + datos + ")";
                        Statement st = cn.createStatement();
                        ResultSet rs = st.executeQuery(sqlselect);
                        %>
                        <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Apellido</th>
                                        <th>Oficio</th>
                                        <th>Salario</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                        <%
                        while (rs.next()) {
                            String ape = rs.getString("APELLIDO");
                            String ofi = rs.getString("OFICIO");
                            String sal = rs.getString("SALARIO");
                            String id = rs.getString("EMP_NO");
                            %>
                            <tr>
                                <td><%=ape%></td>
                                <td><%=ofi%></td>
                                <td><%=sal%></td>
                                <td>
                                    <a class="btn btn-danger"
                                        href="web37mostrarempleados.jsp?eliminar=<%=id%>">
                                        Quitar
                                    </a>
                                </td>
                            </tr>
                            <%
                        }
                        %>
                                </tbody>
                        </table>
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
