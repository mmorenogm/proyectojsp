<%-- 
    Document   : web00plantilla
    Created on : 19-ene-2021, 19:20:15
    Author     : mayte
--%>

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
                    <a href="web36almacenarsalarios.jsp">Almacenar salarios</a>
                    <h1>Mostrar Salarios</h1>
                    <a href="web36mostrarsalarios.jsp?eliminar=algo"
                       class="btn btn-dark">
                           Borrar datos Session
                    </a>
                    <%
                    //solo quier saber si hay algo en la session guardado o no.
                    //solo pintamos
                    //si recibimos eliminar, borramos la session
                    // una session siempre debe borrarse antes de dibujar
                    if (request.getParameter("eliminar") != null) {
                        session.setAttribute("SUMASALARIAL", null);
                    }
                    if(session.getAttribute("SUMASALARIAL") == null){
                        //no hay nada en la session
                        %>
                        <h1 style="color:red">No hay datos en la sesion</h1>
                        <%
                    }else {
                        //tenemos datos
                        String datos = session.getAttribute("SUMASALARIAL").toString();
                        %>
                        <h1 style="color:blue">
                            suma salarial: <%=datos%>
                        </h1>
                        <%
                    }
                    %>
                </div>
            </main><!-- /.container -->
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>