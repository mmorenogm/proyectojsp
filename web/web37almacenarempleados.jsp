<%-- 
    Document   : web00plantilla
    Created on : 19-ene-2021, 19:20:15
    Author     : mayte
--%>

<%@page import="java.util.ArrayList"%>
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
    </head>
    <body>
        <jsp:include page="includes/webmenu.jsp"/>
        <section>
            <main role="main" class="container">
                <div class="starter-template">
                    <h1>almacenar Empleados</h1>
                    <a href="web37mostrarempleados.jsp">Ir ...Mostrar Empleados</a>
                    <%
                     //necesitamos almacenar variso id de empleado
                     //vamos a recibir un id y lo almacenamos en un arraylist al recibirlo
                    String dato = request.getParameter("idempleado");
                    if (dato != null) {
                         int idempleado = Integer.parseInt(dato);
                         ArrayList<Integer> empleados;
                         //preguntamos si ya tenemos empleados almacenados
                         if(session.getAttribute("EMPLEADOS") != null){
                             //tenemos empleados
                             //recuperamos los empleados
                             empleados = (ArrayList)session.getAttribute("EMPLEADOS");
                         } else {
                             //no tenemos empleados
                             empleados = new ArrayList<>();
                         }
                         //almacenamos el idempleado que viene enla peticion
                         empleados.add(idempleado);
                         //guardamos los nuevos datos en la session
                         session.setAttribute("EMPLEADOS", empleados);
                         %>
                         <h1 style="color: blue">Empleados almacenados: <%=empleados.size()%></h1>
                         <%
                    }
                        
                    String sql = "select * from emp";
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery(sql);
                    %>
                    <ul class="list-group">
                        <%
                        while (rs.next()) {
                            String ape = rs.getString("APELLIDO");
                            String empno = rs.getString("EMP_NO");
                            %>
                            <li class="list-group-item">
                                <a href="web37almacenarempleados.jsp?idempleado=<%=empno%>">
                                    Almacenar <%=ape%>
                                </a>
                            </li>
                            <%
                        }
                        rs.close();
                        cn.close();
                        %>
                    </ul>
                </div>
            </main><!-- /.container -->
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
