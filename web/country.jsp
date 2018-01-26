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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.ArrayList,net.sf.json.*" %>
<%@ page language = "java" import = "java.util.*, java.lang.*,
         java.text.*, java.text.DateFormat.*,java.util.Locale " %>
<%@ include file ="config.jsp"%>
 <html>
 <head>  
 <script language="javascript" type="text/javascript">  
 var xmlHttp  
 var xmlHttp
function showState(str){ 
       if (typeof XMLHttpRequest != "undefined"){
   xmlHttp= new XMLHttpRequest();
       }
       else if (window.ActiveXObject){
   xmlHttp= new ActiveXObject("Microsoft.XMLHTTP");
       }
if (xmlHttp==null){
    alert ("Browser does not support XMLHTTP Request")
return
} 
var url= "city.jsp";
url += "?count=" +str;
xmlHttp.onreadystatechange = stateChange;
xmlHttp.open("GET", url, true);
xmlHttp.send(null);
}
 function stateChange(){   
 if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
 document.getElementById("state").innerHTML=xmlHttp.responseText   
 }   
 }   
 </script>  
 </head>  
 <body>  
 <select name='country' onchange="showState(this.value)">  
  <option value="none">Select</option>  
 <%
  Connection connect = null;
            Statement statement = null;
            ResultSet rs = null;
 try {
                Class.forName("org.postgresql.Driver").newInstance();
                connect = DriverManager.getConnection(url, user1, pw);
                statement = connect.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);


            } catch (Exception ex) {

                out.println("exeSQL Error : " + ex.getMessage());
            }
 
 rs = statement.executeQuery("SELECT l_id, l_descr FROM location");
 while(rs.next()){
     %>
 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>  
 <%
 }
     %>
 </select>  
 <br>  
 <div id='state'>  
 <select name='state' >  
 <option value='-1'></option>  
 </select>  
 </div>  
 </body> 
 </html>