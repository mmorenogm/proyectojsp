

<%@page import="java.sql.PreparedStatement"%>
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
        <h1>Maestro Detalle paginación</h1>
        <p>Pagina por cada hospital</p>
        <p>una vez visualizado los hospitales, que se vean los doctores</p>
        <%
        String sql = "Select * from hospital order by hospital_cod";
        Statement st = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = st.executeQuery(sql);
        int posicion = 1;
        //declaramos la variables siguiente y anterior
        int siguiente, anterior, ultimo;
        //calculamos la ultima posicion        
        rs.last();
        ultimo = rs.getRow();
        //calculamos siguiente y anterior

        if(request.getParameter("posicion") == null){
            siguiente = posicion + 1;
            anterior = 1;
        } else {
            String dato = request.getParameter("posicion");
            posicion = Integer.parseInt(dato);
            if (posicion == 1){
                anterior = 1;
            } else {
                anterior = posicion - 1;
            }
            if(posicion == ultimo){
                siguiente = ultimo;
            } else {
                siguiente = posicion + 1;
            }
            //comprobamos la posicion para no pasarnos
        }
        rs.absolute(posicion);
   
        String hospitalnombre = rs.getString("NOMBRE");
        String hospitalid = rs.getString("HOSPITAL_COD");
        String hospitaldir = rs.getString("DIRECCION");
        
        
        %>
        <dl>
            <dt>Nombre: <b><%=hospitalnombre%></b></dt>
            <dd>Cod Hospital: <%=hospitalid%></dd>
            <dd>Direccion: <%=hospitaldir%></dd>
        </dl>
        
        <ul id="menu">
            <li>
                <a href="web24maestrodetallepaginacion.jsp?posicion=1">Primero</a>
            </li>
            <li>
                <a href="web24maestrodetallepaginacion.jsp?posicion=<%=siguiente%>">Siguiente</a>
            </li>
            <li>
                <a href="web24maestrodetallepaginacion.jsp?posicion=<%=anterior%>">Anterior</a>
            </li>
            <li>
                <a href="web24maestrodetallepaginacion.jsp?posicion=<%=ultimo%>">Ultimo</a>
            </li>
        </ul>
        <%
        rs.close();
        
        if(hospitalid != null) {
            int hospitalcod = Integer.parseInt(hospitalid);
            String sqldoctor = "Select * from doctor where hospital_cod = ?";
            PreparedStatement pst = cn.prepareStatement(sqldoctor);
            pst.setInt(1, hospitalcod);
            rs = pst.executeQuery();
            %>
            <ul>
            <%
            while (rs.next()) {
                String ape = rs.getString("APELLIDO");
                String espe = rs.getString("ESPECIALIDAD");
                %>
                <li><%=ape%>, <%=espe%></li>
                <%
            }
            %>
            </ul>   
            <%
        }
        rs.close();
        cn.close();
        %>
    </body>
</html>
