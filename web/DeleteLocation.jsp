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

        <title>DeleteLocation</title>
    </head>
    <body>
        <%
                    String id = request.getParameter("id");
                    Statement stmt = null;
                    Connection con = null;

                    if (id != null) {
                        try {
                            Class.forName("org.postgresql.Driver");
                            con = DriverManager.getConnection(url, user1, pw);
                        } catch (Exception ex) {

                            out.println("exeSQL Error1 : " + ex.getMessage());
                        }
                        try {

                            stmt = con.createStatement();
                            String sql = "delete from location where L_Id='" + id + "'";
                            int row = stmt.executeUpdate(sql);
                            if (row != 0) {
                                out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=SetLocation.jsp'>");

                                // out.println("<br><a href='SetBedType.jsp'>finish</a>");
                            } else {
                                out.println("Can't Delete ");
                            }

                            // close all the connections.

                            stmt.close();
                            con.close();
                        } catch (Exception ex) {

                            out.println("exeSQL Error2 : " + ex.getMessage());
                        }
                    }
        %>
    </body>
</html>
