

<%@page import="java.sql.PreparedStatement"%>
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
        <h1>Seleccion Doctores Hospital con parametros (?,?)</h1>
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
            //quiero hacer la consulta con parametros(?,?)
            // para ello tengo que hacer un bucle para ver cuantos parametros
            String valores = "(";
            for (String h: hospitales) {
                valores += "?,";
             } // end for para construir (?,?)   
            //debemos quitar la última coma
            //vamos a coger la cadena desde cero hasta antes
            // de la última coma
            // para elo recuperamos la posicion de la ultima coma
            int ultimacoma = valores.lastIndexOf(",");
            valores = valores.substring(0,ultimacoma);
            valores += ")";  
            String sqldoctores = "select * from doctor where hospital_cod in "
                    + valores;            
            PreparedStatement pst = cn.prepareStatement(sqldoctores);
            //pasamos los parametros  al pst. hay que hacerlo con un for
            int posicion = 1;
            //recorremos todos los parametros
            for (String h: hospitales){
                // convertimos cada texto hospital a numero hospital
                int hospitalcod = Integer.parseInt(h);
                //pasamos los parametros la objeto
                pst.setInt(posicion, hospitalcod);
                posicion ++;
            } // end for hospitales
            
            rs = pst.executeQuery();
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
