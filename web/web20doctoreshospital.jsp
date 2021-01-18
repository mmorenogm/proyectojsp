

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
String[] datosseleccionados = request.getParameterValues("hospital");
ArrayList<String> listaseleccion = new ArrayList<>();
if (datosseleccionados != null){
    for (String dato: datosseleccionados){
    listaseleccion.add(dato);
    } // end for datosseleccionados
}// end if datosseleccionados
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Seleccion Doctores Hospital</h1>
        <p>Mostrar los doctores de los hospitales seleccionados</p>
        <form method="post">
            <ul>
                <%
                String sqlhospital = "select * from hospital";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sqlhospital);
                while (rs.next()) {
                    String nombre = rs.getString("NOMBRE");
                    String codigo = rs.getString("HOSPITAL_COD");
                    if(listaseleccion.size() == 0){
                        // no seleccionamos
                        %>
                        <li>
                        <input type="checkbox" name="hospital"
                               value="<%=codigo%>"/><%=nombre%>
                        </li>
                        <%
                    } else {
                        // buscamos los datos en lista seleccion
                        if (listaseleccion.contains(codigo)){
                            //seleccionamos
                            %>
                            <li>
                            <input type="checkbox" name="hospital"
                                   value="<%=codigo%>" checked/><%=nombre%>
                            </li>
                            <%
                        } else {
                            // no seleccionamos
                            %>
                            <li>
                            <input type="checkbox" name="hospital"
                                   value="<%=codigo%>"/><%=nombre%>
                            </li>
                            <%
                        } // end if listaseleccion tiene datos
                    } // end id listaseleccion == 0                    
                } // end while
                rs.close();
                %>
            </ul>
            <button type="submit">Mostrar doctores</button>
        </form>
        <hr/>
        <%
        String[] hospitales = request.getParameterValues("hospital");
        if (hospitales != null ){
            //separamos todos los hospitales por comas en un string
            // para ello utilizamos el metodo join
            String valores = String.join(",", hospitales);
            String sqldoctores = "select * from doctor where hospital_cod in ("
                    + valores + ")";
            st = cn.createStatement();
            rs = st.executeQuery(sqldoctores);
            %>
            <table border="1">
                <thead>
                    <tr>
                        <th>Cod Hospital</th>
                        <th>Apellido</th>
                        <th>Especialidad</th>
                        <th>Salario</th>
                    </tr>
                </thead>
            <%
            while (rs.next()) {
                String cod = rs.getString("HOSPITAL_COD");
                String ape = rs.getString("APELLIDO");
                String espe = rs.getString("ESPECIALIDAD");
                String sal = rs.getString("SALARIO");
                %>
                <tr>
                    <td><%=cod%></td>
                    <td><%=ape%></td>
                    <td><%=espe%></td> 
                    <td><%=sal%></td>
                </tr>
                <%
            } // end while sqldoctores
            %>
            </table>
            <%
            rs.close();
            cn.close();
        } // end if hospitales no null
        %>
    </body>
</html>
