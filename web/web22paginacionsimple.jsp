

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
        <h1>Paginación Simple</h1>
        <%
        String sql = "select * from emp";
        Statement st = 
            cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
            ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = st.executeQuery(sql);
        //necesiamos realizar las variables para el movimiento
        int siguiente, anterior, ultimo;
        //el ultimo es fijo, seran el numero de elementos que tiene
        //la consulta.
        rs.last();
        //averiguamos la poscion de la fila
        ultimo = rs.getRow();
        //necesitamos saber la posicion en la que deseamos
        //el cursor
        int posicion = 1;
        if(request.getParameter("posicion") == null){
         siguiente = posicion + 1;
         anterior = 1;
        } else {
            String dato = request.getParameter("posicion");
            posicion = Integer.parseInt(dato);
            //comprobamos la posicion para no pasarnos
            if(posicion == 1){
                anterior = 1;
            }else{
                anterior = posicion - 1;
            }
            if (posicion == ultimo) {
                siguiente = ultimo;
            }else {
                siguiente = posicion + 1;
            }
        } // end if saber en que posicion estamos
        //ponemos el cursor en la posicion calculada
        rs.absolute(posicion);
        %>
        <dl>
            <dt>Apellido: <b><%=rs.getString("APELLIDO")%></b></dt>
            <dd>Oficio: <%=rs.getString("OFICIO")%></dd>
            <dd>Salario <%=rs.getString("SALARIO")%></dd>                                
        </dl>
        <h2 style="color:blue">
            Registro <%=posicion%> de <%=ultimo%>
        </h2>
        <%
        rs.close();
        cn.close();
        %>
        <hr/>
            <ul id="menu">
                <li>
                    <a href="web22paginacionsimple.jsp?posicion=1">Primero</a>
                </li>
                <li>
                    <a href="web22paginacionsimple.jsp?posicion=<%=siguiente%>">Siguiente</a>
                </li>
                <li>
                    <a href="web22paginacionsimple.jsp?posicion=<%=anterior%>">Anterior</a>
                </li>
                <li>
                    <a href="web22paginacionsimple.jsp?posicion=<%=ultimo%>">Ultimo</a>
                </li>
            </ul>  
    </body>
</html>
