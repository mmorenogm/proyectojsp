

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Titulos Dinámicos</h1>
        <%
            for (int i = 1; i<=6; i++){
                //cerramos java y abrimos java
                %>
                 <h<%=i%>>Titulo <%=i%></h<%=i%>>   
                <%
            }//end for
        %>
        <h1>Titulo 1</h1>
        <h2>Titulo 2</h2>
        <h3>Titulo 3</h3>
        <h4>Titulo 4</h4>
        <h5>Titulo 5</h5>
        <h6>Titulo 6</h6>
        
    </body>
</html>
