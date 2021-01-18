
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
//para que se queden marcados los campso seleccionados
String[] datosseleccionados = request.getParameterValues("funcion");
ArrayList<String> listaseleccion = new ArrayList<>();
if (datosseleccionados != null) {
    for (String dato:datosseleccionados){
        listaseleccion.add(dato);
    } // end for dar valores a listaseleccion
} // end if datosseleccionados no null
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Plantilla Funcion Multiple - JSP</h1>
        <p>Mostrar la plantilla de las funciones seleccionadas</p>
        <form method='post'>
            <ul>
                <%
                //buscamos los funciones de la plantilla para mostrarlas
                String sqlfunciones = "select distinct funcion from plantilla";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sqlfunciones);
                while (rs.next()){
                    String fun = rs.getString("FUNCION");
                    if (listaseleccion.size() == 0 ){
                        //pantalla inicio. NO seleccion
                        %>
                        <li>
                            <input type="checkbox" name="funcion" 
                                   value="<%=fun%>"/><%=fun%>
                        </li>
                        <%
                    } else {
                        //ya hemos seleccionado algo
                        if(listaseleccion.contains(fun)){
                            //checkbox seleccionada
                            %>
                            <li>
                                <input type="checkbox" name="funcion" 
                                       value="<%=fun%>" checked/><%=fun%>
                            </li>
                            <%
                        }else {
                            //checkbox NO seleccionada
                            %>
                            <li>
                                <input type="checkbox" name="funcion" 
                                       value="<%=fun%>"/><%=fun%>
                            </li>
                            <%
                        }// end if listaseleccion(fun)
                    }// end if listaseleccion.size                    
                } // end while sqlfunciones
                rs.close();
                %>
            </ul>
            <button type="submit">Mostrar Plantilla</button>            
        </form>
        <hr/>
        <%
        String[] funciones = request.getParameterValues("funcion");
        if(funciones != null){
            //hacemos la consulta con parametros
            // el select sera con IN, por lo que tenemos que 
            // construir la cadena de las interrogaciones (?,?..)
            // segun el numero de casillas marcadas. Para ello
            //nos recorremos el array de funciones para saber el num
            String parametros = "(";
            for (String empleo: funciones){
                parametros += "?,";
            } // end for recorre funciones y num parametros
            //Nos sobra la ultima coma y hay que quitarla
            //para ello ocalizamos la posición de la ultima coma
            // y lo quitamos de la cadena parametros construida
            int ultimacoma = parametros.lastIndexOf(",");
            //ahora sustraigo la parte de la cadena parametros sin incluir
            //la ultima coma
            parametros = parametros.substring(0, ultimacoma);
            parametros += ")";
            //ahora construyo el query
            String sqlplantilla = 
                    "select * from plantilla where funcion IN " + parametros;
            PreparedStatement pst = cn.prepareStatement(sqlplantilla);
            //ahora tenemos que pasar los parametros. Son dinamicos, están
            // en el array funciones, por lo que tenemos que haer un bucle
            // para extraerlos
            int posicion = 1;
            for (String f: funciones){
                pst.setString(posicion, f);
                posicion ++;
            } // end for pasar los paramentros al pst
            rs = pst.executeQuery();
            %>
            <table border="1">
                <thead>
                    <tr>
                        <td>Apellido</td>
                        <td>Funcion</td>
                        <td>Turno</td>
                    </tr>
                </thead>
                <tbody>
            <%
            while (rs.next()){
                String ape = rs.getString("APELLIDO");
                String trabajo = rs.getString("FUNCION");
                String turno = rs.getString("TURNO");
                %>
                <tr>
                    <td><%=ape%></td>
                    <td><%=trabajo%></td>
                    <td><%=turno%></td>
                </tr>
                <%
            }//end while sqlplantilla
            %>
                </tbody>
            </table>
            <%
            rs.close();
            cn.close();
        } // end if funciones distinto de null
        %>
    </body>
</html>
