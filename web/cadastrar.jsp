<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String codigo, nome, endereco;
            double renda;
            Connection con;
            PreparedStatement st;
            
            //Recebe os dados vindos do formulário cadcli.html
            codigo = request.getParameter("codigo");
            nome = request.getParameter("nome");
            endereco = request.getParameter("endereco");
            renda = Double.parseDouble(request.getParameter("renda"));
            try{
               //Conecta com o banco de dados
               Class.forName("com.mysql.jdbc.Driver");
               con =  DriverManager.getConnection("jdbc:mysql://localhost:3306/bancoclientes","root","nagito");
            //Executando o comando INSERT que insere os dados o Banco de dados
               st = con.prepareStatement("INSERT INTO CLIENTE VALUES (?,?,?,?)");
               st.setString(1, codigo);
               st.setString(2, nome);
               st.setString(3, endereco);
               st.setDouble(4, renda);
               st.executeUpdate();
               out.print("Dados cadastrados com sucesso");
            }catch (ClassNotFoundException ex){
                out.print("Driver de conexão não encontrado " + ex.getMessage());
            }catch (SQLException ex){
                 if(ex.getErrorCode()==1062){
                  out.print("Este código de cliente já estpa cadastrado");        
                } else {
                  out.print ("Erro o cadastro. Entre em contato com o adm do site")
                }
        %>   
    
    </body>
</html>
