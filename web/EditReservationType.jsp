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

    <body>
        <%
                    Statement stmt = null;
                    ResultSet rs = null;
                    Connection con = null;
                    String id = request.getParameter("id");
                    String code = "";
                    String desc = "";
                    String QueryString1="";
                    try {
                        Class.forName("org.postgresql.Driver");
                        con = DriverManager.getConnection(url, user1, pw);
                    } catch (Exception ex) {

                        out.println("exeSQL Error : " + ex.getMessage());
                    }
                    /*      Class.forName("sun.jdbc.odbc.JdbcOdbc");
                    <b style="color:black;background-color:#a0ffff">Connection</b> con=DriverManager.getConnection("jdbc:odbc:MyDatabase","system","database");
                     */

                    if ((id != null) && (request.getParameter("submit") == null)) {

                       try {

                            stmt = con.createStatement();
                            QueryString1 = "Select * FROM reservationtype WHERE Rst_Id ='"+id+"'" ;
                             rs = stmt.executeQuery(QueryString1);
                            while (rs.next()) {
                                code = rs.getString(1);
                                desc = rs.getString(2);
                            }

                            // close all the connections.
                            rs.close();
                        stmt.close();
                        con.close();
                        } catch (Exception ex) {

                      //      out.println("Unable to connect to database.");
                            // table.getSelectedRow();


                        out.println("exeSQL Error : " + ex.getMessage());
                    }



        %>
        <form method="post" action="EditReservationType.jsp">
            <table>
                <tr><td>Code</td><td><input type="text" name ="code" value="<%=code%>"/></td></tr>
                <tr><td>Description</td><td><input type="text" name ="desc" value="<%=desc%>"/></td></tr>
                <tr><td colspan="2" align="center"><input type="submit" name="submit" value="update"></input>
                        <input type="hidden" name="id" value="<%=id%>"></input></td></tr>
            </table>
        </form>
        <%
                    }
                    if (request.getParameter("submit") != null) {
                        code = request.getParameter("code");
                        desc = request.getParameter("desc");


                        stmt = con.createStatement();
                        String sql = "UPDATE reservationtype SET RST_Id='"+code+"', RST_Descr='"+desc+"' WHERE RST_Id='"+id+"'";

                        int row = stmt.executeUpdate(sql);
                        if (row != 0) {
                            out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=SetReservationType.jsp'>");
                           // out.println("<br><a href='SetBedType.jsp'>finish</a>");
                        } else {
                            out.println("Can't update");
                        }
                        stmt.close();
                        con.close();

                    }

        %>
    </body>
</html>
