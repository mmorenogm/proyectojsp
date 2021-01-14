


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
Connection cn =
    DriverManager.getConnection(cadena, "system", "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title></head>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <body>
    <div Class="container">
        <%
        int modificados = 0;
        String oldname = request.getParameter("selectsalas");
        String newname= request.getParameter("cajanewsala");
        if(oldname != null && newname != null) {
            String sqlupdate = "update sala set nombre = ? where nombre = ?";
            PreparedStatement pst = cn.prepareStatement(sqlupdate);
            pst.setString(1, newname);
            pst.setString(2, oldname);
            modificados = pst.executeUpdate();
        } //end datos entrada distinto de vacios
        %>
        <h1>Modificar Salas Select - JSP</h1><br/>
        <form method="post">
            <label>Salas: </label>
            <select name="selectsalas" required>
                <option value="-1"></option>
                <%
                String sqlsalas = "select distinct nombre from sala";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sqlsalas);
                //necesito saber si tenemos datos seleccionado en el combo
                String seleccionado = request.getParameter("selectsalas");
                while (rs.next()) {
                    String nombre = rs.getString("NOMBRE");
                    if (seleccionado == null) {
                        // no ha enviado nada
                       %>
                        <option value="<%=nombre%>"><%=nombre%></option>
                        <%
                    }else {
                        //tenemos datos. Debemos comparar con
                        // lo que tiene value
                        if (seleccionado.equals(nombre)){
                            //seleccionamos el elemento
                        %>
                        <option value="<%=nombre%>" selected><%=nombre%></option>
                        <%
                        }else {
                            // pintamos sin seleccionar
                            %>
                            <option value="<%=nombre%>"><%=nombre%></option>
                            <%
                        }
                    }                            
                } // end while sqlsalas
                rs.close();
                %>
            </select>
            <label>Indicar nuevo nombre: </label>
            <input type="text" name="cajanewsala" required/>
            <button type="submit">Actualizar</button>
        </form>
        <%        
        if(oldname != null && newname != null) {
            %>
            <p>Registros Modificados: <%=modificados%></p>
            <%
        } // end if null para dibujar
        cn.close();
        %>        
    </div>
    </body>
    <script src="js/bootstrap.bundle.min.js" type="text/javascript"></script>
</html>
