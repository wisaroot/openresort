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
  
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <%@ include file ="config.jsp"%>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>SetDepartment</title>

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"
        type="text/javascript" charset="utf-8"></script>

        <script type="text/javascript">

            $(document).ready(function(){

                $("tr[id$='5']").click(function(){
                    $("tr[id$='5'] td").css({ 'background-color' : 'white'});
                    $('td', this).css({ 'background-color' : 'pink' });
                });

            });
            function popup(mylink, windowname)
            {
                if (! window.focus)return true;
                var href;
                if (typeof(mylink) == 'string')
                    href=mylink;
                else
                    href=mylink.href;
                window.open(href, windowname, 'width=400,height=500,scrollbars=yes');
                return false;

            }
        </script>

    </head>
    <body>
        <p><a
                HREF="SetNewDepartment.jsp"
                onClick="return popup(this, null)">New</a></p>

        <%
                    Statement stmt = null;
                    ResultSet rs = null;
                    Connection con = null;

                    try {
                        Class.forName("org.postgresql.Driver");
                        con = DriverManager.getConnection(url, user1, pw);
                    } catch (Exception ex) {

                        out.println("exeSQL Error : " + ex.getMessage());
                    }
                    /*      Class.forName("sun.jdbc.odbc.JdbcOdbc");
                    <b style="color:black;background-color:#a0ffff">Connection</b> con=DriverManager.getConnection("jdbc:odbc:MyDatabase","system","database");
                     */
                    try {
                        stmt = con.createStatement();
                        String QueryString = "Select * FROM department ";
                        rs = stmt.executeQuery(QueryString);


                        /*       } catch (Exception e) {

                        out.println("exeSQL Error : " + e.getMessage());
                        }
                        }*/
                        out.println("<table id='tblTest' width='300' border='1'>");
//<tr><td>Code </td><td>Description</td></tr>
                        out.println("<tr id='tbl' bgColor=#8080a6 ><td>Code </td><td  width='50%'>Department Group</td><td>Description </td><td>Type</td><td>Req. Info</td><td>Link Income</td><td>Vat Effect </td><td colspan='2'> </td></tr>");
                        int i = 1;
                        String k1 = "", k2 = "", k3 = "";
                        while (rs.next()) {
                            if (rs.getBoolean(5) == true) {
                                k1 = "checked";
                               
                            }else{k1="";}
                            if (rs.getBoolean(6) == true) {
                                k2 = "checked";
                                
                            }else{k2="";}
                            if (rs.getBoolean(7) == true) {
                                k3 = "checked";
                                 
                            }else{k3="";}


                            out.println("<TR id=5  ><TD>" + rs.getString(1) + "</TD><TD>" + rs.getString(2) + "</TD><TD>" + rs.getString(3) + "</TD><TD>" + rs.getString(4) + "</TD><TD> <input type='checkbox' name='id1'  ' " + k1 + " '> </TD><TD><input type='checkbox' name='id2'  ' " + k2 + " '></TD><TD><input type='checkbox' name='id3'  ' " + k3 + " '></TD>");
                            out.println("<TD><a href=EditDepartment.jsp?id=" + rs.getString(1) + ">edit</td>");
                            out.println("<TD><a href=DeleteDepartment.jsp?id=" + rs.getString(1) + ">delete</td></TR>");
                        }
                        //  out.println("<TR  ><TD> <input type='checkbox' name='id'  ' " + k + " ' > </TD><TD><input type='checkbox' name='id' value='"+i+"'></TD><TD><input type='checkbox' name='id' value='"+i+"'></TD>");


                        // close all the connections.
                        rs.close();
                        stmt.close();
                        con.close();
                    } catch (Exception ex) {

                        out.println("Unable to connect to database.");
                        // table.getSelectedRow();
                    }
                    out.println("</table>");
        %>







        <p>&nbsp;</p>
    </body>
</html>

