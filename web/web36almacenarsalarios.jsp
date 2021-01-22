<%-- 
    Document   : web00plantilla
    Created on : 19-ene-2021, 19:20:15
    Author     : mayte
--%>


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
                    <a href="web36mostrarsalarios.jsp">Mostrar Salarios</a>
                    <h1>almacenar Salarios</h1>
                    <%
                    String sql = "select * from emp";
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery(sql);                    
                    %>
                    <ul class="list-group">
                       <%
                       while (rs.next()){
                           String apellido = rs.getString("APELLIDO");
                           String sal = rs.getString("SALARIO");
                           %>
                           <li class="list-group-item">
                               <a href="web36almacenarsalarios.jsp?salario=<%=sal%>">
                                   Almacenar salario <%=apellido%>
                               </a>
                           </li>
                            <%
                       }
                       rs.close();
                       cn.close();
                       %> 
                    </ul>
                    <%
                    //vamos a almacenar cada salario que venga de forma 
                    //persistente (session)
                    int sumasalarial;
                    //preguntamos si hemso recibido algun dato en session
                    if(session.getAttribute("SUMASALARIAL") != null){
                        //tenemos algo en session
                        sumasalarial = (Integer)session.getAttribute("SUMASALARIAL");
                    } else {
                        //no tenemos nada almacenado
                        sumasalarial = 0;
                    }//end if session.getAtribute(sumasalarial)
                    String dato = request.getParameter("salario");
                    if (dato != null) {
                        int salario = Integer.parseInt(dato);
                        //nos han mandado un salario y lo sumamos a sumasalarial
                        sumasalarial += salario;
                        // almacenamos la suma salarial en la session
                        //paa haerlo permanente
                        session.setAttribute("SUMASALARIAL", sumasalarial);
                        //la varaible saslario es la del enlace dela etuqueta <a>
                        %>
                        <h1 style="color:blue">Datos almacenados: <%=salario%></h1>
                        <%
                    }
                    %>
                    
                </div>
            </main><!-- /.container -->
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>