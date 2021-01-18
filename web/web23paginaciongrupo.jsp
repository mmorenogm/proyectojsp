

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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            ul#menu li {
                display: inline;
            }
        </style>
    </head>
    <body>
        <h1>paginacion en grupo</h1>
        <p>nos moveremos por paginas</p>
        <%
        String sql = "select * from emp order by apellido";
        Statement st = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = st.executeQuery(sql);
        String dato = request.getParameter("posicion");
        int posicion = 1;
        if (dato != null){
            posicion = Integer.parseInt(dato);            
        }
        //averiguamos el numero de registros
        rs.last();
        int numregistros = rs.getRow();
        //posicionamos el cursor enla fila de la posicion
        rs.absolute(posicion);        
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>Apellido</th>
                    <th>Oficio</th>
                    <th>Salario</th>
                </tr>
            </thead>
            <tbody>
                <%
                // pintamos registros de 3 en 3
                for (int i=1; i<=5 && !rs.isAfterLast(); i++){
                    %>
                    <tr>
                        <td><%=rs.getString("APELLIDO")%></td>
                        <td><%=rs.getString("OFICIO")%></td>
                        <td><%=rs.getString("SALARIO")%></td>
                    </tr>
                    <%
                    rs.next();
                } // end for de 3 en 3
                rs.close();
                cn.close();
                %>
            </tbody>
        </table>
            <ul id="menu">
                <%
                int numeropagina = 1;
                for (int i = 1; i<=numregistros; i+=5) {
                    %>
                    <li>
                        <a href="web23paginaciongrupo.jsp?posicion=<%=i%>">
                            Página <%=numeropagina%>
                        </a>
                    </li>
                    <%
                    numeropagina += 1;
                }// bucle para crear la paginacion dinamica
                %>                
            </ul>
    </body>
</html>
