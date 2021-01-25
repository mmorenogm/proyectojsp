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
                    <h1>HOSPITALES</h1>
                    
                    <%
                     //debemos mostrar el num de perosnas almacenadas
                     // en todo momento
                     int personasalmacenadas = 0;
                     if (session.getAttribute("EMPLEADOS") != null){
                         //recupero los datos en un arrayList
                         // y busco la longitus del mismo
                         // pinto ese numero
                         ArrayList<Integer> empleados =
                                 (ArrayList) session.getAttribute("EMPLEADOS");
                         //recupero la longitud
                         personasalmacenadas = empleados.size();
                     }                        
                         %>
                         <h6>Personas Almacenadas: <%=personasalmacenadas%></h6>
                         <%

                    //cargamos los hospitales
                    String sqlhospital = "select * from hospital";
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery(sqlhospital);
                    %>
                    <ul class="list-group">
                    <%
                    while (rs.next()){
                        String idhospital = rs.getString("HOSPITAL_COD");
                        String nombre = rs.getString("NOMBRE");
                        %>
                        <li class="list-group-item">
                            <a href="web38empleadoshospital.jsp?idhospital=<%=idhospital%>">
                                <%=nombre%>
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