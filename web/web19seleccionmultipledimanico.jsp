

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String[] ingredientes = new String[] {"sal","Azucar","leche", "mandarinas", "cacao","avellanas"};
//recuperamos los elementos seleccionado
String[] datosseleccionados = request.getParameterValues("ingrediente");
//creamos uan collecion para simplificar el codigo
ArrayList<String> listaseleccion = new ArrayList<>();
//si existen elementos seleccionados los copiamos a al coleccion
//para trabajar posteriormente en el dibujo
if (datosseleccionados != null) {
    for (String dato: datosseleccionados){
        listaseleccion.add(dato);
    } // end for
}// end if 
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Seleccion Multiple dinamico - JSP</h1>
        <form method="post">
            <p>Dibujamos los ingredientes del array: ingredientes de la nocilla</p>
            <ul>
                <%
                for (String ing: ingredientes){
                    if(listaseleccion.size() == 0){
                        //dibujamos sin seleccionar
                        %>
                        <li>
                            <input type="checkbox" name="ingrediente" value="<%=ing%>"/><%=ing%>
                        </li>
                        <%
                    } else {
                        //preguntamos si hay algun dato en la lista de seleccion
                        if (listaseleccion.contains(ing)){
                            //seleccionamos
                        %>
                        <li>
                            <input type="checkbox" name="ingrediente" value="<%=ing%>" checked/><%=ing%>
                        </li>
                        <%
                        }else {
                            //sin selecion
                            %>
                            <li>
                                <input type="checkbox" name="ingrediente" value="<%=ing%>"/><%=ing%>
                            </li>
                            <%
                        } // end if listaseleccion contains
                    }// end if listaseleccion size
                } // end for array ing
                %>
            </ul>
            <button type="submit">Mostrar seleccionados</button>
        </form>
        <hr/>
        <%
        String[] datos = request.getParameterValues("ingrediente");
        if(datos != null){
            for (String dato: datos){
            %>
            <h3 style="color:blue"><%=dato%></h3>
           <%
            } // end for array dato
        } // end if datos null
        %> 
    </body>
</html>
