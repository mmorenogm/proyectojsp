
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Ejemplo Simple de Session</h1>
        <p>vamos pinta un contador cada vez que damos un boton</p>
        <form method="post">
            <button type="submit">Incrementar contador</button>   
        </form>
        <%
        int contador = 1;
        //para tener info permaneten neesitamos un objeto session
        HttpSession sesion = request.getSession();
        //deseamos almacenar el num de forma permanente
        //por lo que haremos una variable de session
        //pero el contador va a tener dos posibilidades
        //1) que todavia no hemos almacenado info
        //2) si hemos almacenado info, debemos igualar el contador
        //a la session
        if(session.getAttribute("CONTADOR") != null){
            //hemos almacenad algo previamente
            contador = Integer.parseInt(session.getAttribute("CONTADOR").toString());            
        }

        %>
        <h1 style="color:blue">Contador : <%=contador%></h1>
        <%
        contador += 1;
        //almacenamos el numero en la session
        sesion.setAttribute("CONTADOR", contador);
        %>
    </body>
</html>
