
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
<%@ page language="java" import="java.sql.*" %>
 <%@ include file ="config.jsp"%>
<% System.out.println("Exception is ;");
response.setContentType("text/html");
String userName=request.getParameter("user");
String userPass=request.getParameter("pass");
%>
<h2><font color=blue>
<%
   
  
    ResultSet rs;
    String userNam=new String("");
    String passwrd=new String("");
  String name=new String("");
    response.setContentType("text/html");
    int i=0;
    try {
       // Load the database driver
      Class.forName("org.postgresql.Driver");
      // Get a Connection to the database
     
      Connection con = DriverManager.getConnection(url, user1, pw);
      //Add the data into the database
 

      String sql = "select userid,passwords,positions from users where userid= '" + userName + "'and passwords = md5('" + userPass + "')";
      Statement s = con.createStatement();
      s.executeQuery (sql);
      rs = s.getResultSet();
      while (rs.next ()){
           session.setAttribute("status", rs.getString("positions"));
           session.setAttribute("j_username", rs.getString("userid"));
        userNam=rs.getString("userid");
        passwrd=rs.getString("passwords");
        i++;
    if(i==1){
        name=userNam;
      }
       }//out.println(i);
    rs.close ();
      s.close ();
      }catch(Exception e){
      System.out.println("Exception is ;"+e);
      }
      if(i==1)
    {
         // response.sendRedirect("home.html");
      
  %>
  <script type="text/javascript">

   window.location.href = "home.html";

 </script>

  <%
      //out.println(name);
   }
    else{
    out.println("You are not an authentic person");
      }
%>
</font></h2>