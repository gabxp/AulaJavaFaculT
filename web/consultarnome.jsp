<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="config.css">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String nome;
            Connection con;
            PreparedStatement st;
            ResultSet rs;
            
            //Recebe o código do formulário connome.html
            nome = request.getParameter("nome");

            try{
               //Conecta com o banco de dados
               Class.forName("com.mysql.jdbc.Driver");
               con =  DriverManager.getConnection("jdbc:mysql://localhost:3306/bancoclientes","root","nagito");
            //Executando o comando SELECT
               st = con.prepareStatement("SELECT * FROM CLIENTE WHERE NOME LIKE ?");
               st.setString(1, "%" + nome + "%");
               rs = st.executeQuery();
               
               out.print("<table border='1'>");
               out.print("<tr><th>Código</th><th>Nome</th><th>Endereço</th><th>Renda</th></tr>");
               while (rs.next()){ //Se encontrou o nome do cliente
                    out.print("<tr>");
                        out.print("<td>" + rs.getString("codigo") + "</td>");
                        out.print("<td>" +rs.getString("nome") + "</td>");
                        out.print("<td>" +rs.getString("endereco") + "</td>");
                        out.print("<td>" +rs.getString("renda")  + "</td>");
                    out.print("</tr>");
               }
               
            }catch (ClassNotFoundException ex){
                out.print("Driver de conexão não encontrado " + ex.getMessage());
            }catch (SQLException ex){
                out.print ("Erro na consulta. Entre em contato com o administrador do site");
            }
        %>   
 
    </body>
</html>