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

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.comis.frontsystem.util.Md5Utils"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file ="../config.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to Front System</title>
        <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem_popup.css" rel="stylesheet" type="text/css" />
    </head>
    <%@ include file="../login/isLogin.jsp" %>
    <body>
<div class="content">
    <div class="page-header offset1">
      <h1>New User</h1>
    </div>
    <div class="row">
      
      <div class="span13 columns">
          <% 
                    List<String> errorList=(ArrayList<String>)session.getAttribute("errors"+session.getId()); 
                    
                %>	
		<% if(errorList!=null&&errorList.size()>0){ %>	
                        <div class="alert-message block-message error offset1">
                                <p>
                                        <%
                                            
                                            if(errorList!=null){
                                                for(String error:errorList){
                                                    out.println(error+"<br/>");
                                                }
                                                errorList = new ArrayList<String>();
                                                session.setAttribute("errors" + session.getId(), errorList);
                                            }
                                        %>
                                </p>
                        </div>
        
		<% } %>	
          <form  method="post" action="newuser_1.jsp">
          <fieldset>
            <legend>User's Form</legend>
            <div class="clearfix">
              <label name="userid">Username</label>
              <div class="input">
                <input name="username" class="medium" />
              </div>
            </div>
            <div class="clearfix">
              <label name="password">Password</label>
              <div class="input">
                <input name="password" class="medium" />
              </div>
            </div>
            <div class="clearfix">
              <label name="name">Name</label>
              <div class="input">
                <input name="name" class="medium" />
              </div>
            </div>
            <div class="clearfix">
              <label name="group">Group</label>
              <div class="input">
                <select name="group" class="medium" >
                    <% 
                        Connection dbConnection = null;
                        PreparedStatement preparedStatementSelect = null;
                        String selectUserSQL="SELECT ugrpno, \"name\" FROM usergroup;";
                        
                        try{
                           dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
                            preparedStatementSelect = dbConnection.prepareStatement(selectUserSQL);
                            ResultSet rs=preparedStatementSelect.executeQuery();

                            while(rs.next()){
                    %><option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option><%
                            }

                        }catch(SQLException e){
                            errorList.add(e.getMessage());
                        }finally{
                            preparedStatementSelect.close();
                            if(dbConnection!=null)
                                dbConnection.close();
                        }
                    %>
                </select>
              </div>
            </div>
            <div class="clearfix">
              <label name="email">Email</label>
              <div class="input">
                <input class="medium" name="email" />
              </div>
            </div>
            <div class="actions">
              <input type="submit" class="btn primary" value="Save Changes"/>
              &nbsp;
              <button type="reset" class="btn">Cancel</button>
            </div>
          </fieldset>
          </form>
      </div>
    </div>
</div>
    </body>
</html>
