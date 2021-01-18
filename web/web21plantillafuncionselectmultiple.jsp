

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
//para que se queden seleccionadas las opciones

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        </head>
    <body>
        <h1>Plantilla Funcion con SELECT multiple - JSP</h1>
        <p>Mostramos la plantilla de las funciones seleccionadas</p>
        <p>estas selecciones se harán a traves del control select</p>
        <form method="post">
            <%
            String sqlfuncion = "select distinct funcion from plantilla";
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sqlfuncion);
            %>
            <select name="funcion" size="5" multiple>
            <%
            while (rs.next()){
            String fun = rs.getString("FUNCION");
            %>
            <option value="<%=fun%>" /><%=fun%></option>
            <%
            }
            rs.close();
            %>
            </select> 
            <button type="submit">Mostrar Plantilla</button>
        </form>
        <hr/>
        <%
        String[] trabajos = request.getParameterValues("funcion");
        if(trabajos != null){
        //generamos el parantesis del IN (?,?,...) segun las funciones seleccionadas
        String parametros = "(";
        for (String f: trabajos) {
            parametros += "?,";
        } // end for generar (?,?,..,?,
        //quitamos la ultima coma y cerramos parentesis
        int ultimacoma = parametros.lastIndexOf(",");
        parametros = parametros.substring(0, ultimacoma);
        parametros += ")";
        //creamos la consulta
        String sqlplantilla = "select * from plantilla where funcion IN" + parametros;
        PreparedStatement pst = cn.prepareStatement(sqlplantilla);
        //pasamos los parametros. hay que generar un for para asignar los 
        // valores del array trabajo a las ?
        int posicion = 1;
        for (String t: trabajos){
            pst.setString(posicion, t);
            posicion ++;
        } // end for recorre trabajos para generar los parametros
        rs = pst.executeQuery();
        %>
        <div style="height: 100px; width: 100%; overflow: auto">
        <table border="1">
            <thead>
                <tr>
                    <th>Apellido</th>
                    <th>Funcion</th>                    
                </tr>
            </thead>
            <tbody>
        <%
        while (rs.next()) {
            String ape = rs.getString("APELLIDO");
            String fun = rs.getString("FUNCION");
            %>
            <tr>
                <td><%=ape%></td>
                <td><%=fun%></td>
            </tr>
            <%
        } // end while recorre sqlplantilla
        rs.close();
        cn.close();
        %>
            </tbody>
        </table>
        <div>
        <%
        } // end if trabajos es null        
        %>
    </body>
</html>
