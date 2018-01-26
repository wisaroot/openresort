
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
 <%@page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.util.*" errorPage="" %>


<%@ include file ="config.jsp"%>
<% System.out.println("Exception is");
            Vector errors = new Vector();
            String j_username = request.getParameter("user");
            String j_password = request.getParameter("pass");
            Class.forName(
                    "org.postgresql.Driver");
            Connection con = DriverManager.getConnection(url, user1, pw);
            Statement stmt = con.createStatement();
            String sql;
            ResultSet rs = null;
            if (j_username.equals(
                    "") || j_password.equals("")) {
                errors.add("ตรวจสอบ username or password");

            } else {
                sql = "select * from users where userid ='" + j_username + "'and password=password('" + j_password + "')";
                rs = stmt.executeQuery(sql);
                if (rs.next()) {
                    session.setAttribute("status", "admin");
                    session.setAttribute("j_username", "j_username");
                    session.setAttribute("j_fname", new String(rs.getString("fname").getBytes("ISO8859_1"), "windows-874"));
                    session.setAttribute("j_lname", new String(rs.getString("lname").getBytes("ISO8859_1"), "windows-874"));
                    session.setAttribute("j_email", rs.getString("email"));
                } else {
                    errors.add(" username or password not correct!!");
                }
            }
            if (errors.size() > 0) {
%><%@ include file ="ckError.jsp"%><%            } else {
                response.sendRedirect("home.html");
            }
%>

