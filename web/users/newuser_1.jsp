<%--
 * OpenResort PMS is a Web Application Properties Management (PMS) System that captures
 * all the essential functionalities required for any Front Office Hospitality.
 * Copyright (C) 2012 Holidays Network Co.,Ltd., http://www.openresort.net
 *
 * OpenResort PMS is free software; you can redistribute it and/or modify it under the terms of
 * GNU General Public License version 3.0 (GPLv3)
 * , or (at your option) any later version.
 *
 * OpenResort PMS is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with this program;
 * if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA  02110-1301, USA
 *
  --%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="com.comis.frontsystem.util.Md5Utils"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.comis.frontsystem.user.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="../errorPage.jsp"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file="../login/isLogin.jsp" %>
<%@ include file ="../config.jsp"%>
<%
    Users user=new Users(request.getParameter("username"),
            request.getParameter("password"),
            request.getParameter("name"),
            request.getParameter("group"),
            request.getParameter("email"));
    List<String> errorList=(ArrayList)session.getAttribute("errors"+session.getId());
            errorList=new ArrayList<String>();
            session.setAttribute("errors"+session.getId(), errorList);
            validate(user,errorList);
            if(errorList.size()>0){
                response.sendRedirect("newuser.jsp");
            }else{
                if(saveUser(user1, pw, url, driver,user,errorList)){
                    response.sendRedirect("setuser.jsp");
                }else{
                    response.sendRedirect("newuser.jsp");
                }
            }
%>
<%!
    private void validate(Users user,List errorList){
        String username=user.getUsername();
        String password=user.getPasswords();
        String name=user.getName();
        String usergroup=user.getUsergroup();
        String email=user.getEmail();
        
        if(username==null||username.equals(""))
            errorList.add("username is empty");
        if(password==null||password.equals(""))
            errorList.add("password is empty");
        if(name==null||name.equals(""))
            errorList.add("name is empty");
        if(usergroup==null||usergroup.equals(""))
            errorList.add("usergroup is empty");
        if(email==null||email.equals(""))
            errorList.add("email is empty");
    }
    private boolean saveUser(String user1,String pw,String url,String driver,Users user,List errorList)throws SQLException{
                Connection dbConnection = null;
                PreparedStatement preparedStatementInsert = null;
                String insertUserSQL="INSERT INTO users(userid, passwords, \"name\", positions, ugrpno, email)VALUES (?, ?, ?, (SELECT \"name\" FROM usergroup where ugrpno=?), ?, ?);";
                boolean isSave=false;
                try{
                    dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
                    dbConnection.setAutoCommit(false);
                    preparedStatementInsert = dbConnection.prepareStatement(insertUserSQL);
                    preparedStatementInsert.setString(1, user.getUsername());
                    preparedStatementInsert.setString(2, Md5Utils.encode(user.getPasswords().getBytes()));
                    preparedStatementInsert.setString(3, user.getName());
                    preparedStatementInsert.setString(4, user.getUsergroup());
                    preparedStatementInsert.setString(5, user.getUsergroup());
                    preparedStatementInsert.setString(6, user.getEmail());
                    preparedStatementInsert.executeUpdate();
                    dbConnection.commit();
                    isSave=true;
                    
                    
                }catch(SQLException e){
                    errorList.add(e.getMessage());
                    dbConnection.rollback();
                }finally{
                    preparedStatementInsert.close();
                    if(dbConnection!=null)
                        dbConnection.close();
                }
                return isSave;
    }
%>