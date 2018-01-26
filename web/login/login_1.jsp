
<%-- 
    Document   : welcome
    Created on : Jan 8, 2012, 8:35:28 PM
    Author     : Administrator
--%>
<%@page import="com.comis.frontsystem.login.Login"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="com.comis.frontsystem.util.Md5Utils"%>
<%@page import="com.comis.frontsystem.user.WebUser,java.util.List,java.util.ArrayList"%>
<%@page errorPage="../errorPage.jsp"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file ="../config.jsp"%>
        <%! 
            private void validate(Login login,List errorList){
                String username=login.getUsername();
                String password=login.getPassword();
                
                if(username==null||username.equals(""))
                    errorList.add("Username is empty");
                if(password==null||password.equals(""))
                    errorList.add("Password is empty");
            }
            private boolean login(String user1,String pw,String url,String driver,WebUser user,List errorList)throws SQLException{
                Connection dbConnection = null;
                PreparedStatement preparedStatementSelect = null;
                String selectUserSQL="select * from users where userid=? and passwords=?";
                boolean isLogin=false;
                try{
                   dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
                    preparedStatementSelect = dbConnection.prepareStatement(selectUserSQL);
                    preparedStatementSelect.setString(1, user.getUsername());
                    preparedStatementSelect.setString(2, Md5Utils.encode(user.getPassword().getBytes()));
                    ResultSet rs=preparedStatementSelect.executeQuery();
                    
                    if(rs.next()){
                       if(rs.getString(4)!=null){ 
                            isLogin=true;
                            user.setGroup(rs.getString(4));
                       }else{
                           isLogin=false;
                           errorList.add("No user group");
                       }
                    }else{     
                       errorList.add("Invalid username or password");
                    }
                    
                }catch(SQLException e){
                    errorList.add(e.getMessage());
                }finally{
                    preparedStatementSelect.close();
                    if(dbConnection!=null)
                        dbConnection.close();
                }
                return isLogin;
            }
        %>
        <%
            List<String> errorList=(ArrayList)session.getAttribute("errors"+session.getId());
            errorList=new ArrayList<String>();
            session.setAttribute("errors"+session.getId(), errorList);
            String username=(String)request.getParameter("username");
            String password=request.getParameter("password");
            Login login=new Login(username,password);
            validate(login,errorList);
            
            if(errorList.size()>0){
                response.sendRedirect("login.jsp");
            }else{
                
                WebUser user=new WebUser();
                user.setUsername(username);
                user.setPassword(password);
                
                if(login(user1, pw, url, driver,user, errorList)){
                    session.setAttribute(""+session.getId(), user);
                    response.sendRedirect(request.getContextPath()+"/home.jsp");
                }else{
                    
                    response.sendRedirect("login.jsp");
                }
            }
   
            
        %>
         