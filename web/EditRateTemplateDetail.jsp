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

                    String sql1;

                    String id = request.getParameter("id");
                    String[] arr = id.split("\\|");
                    String id1 = arr[0];
                    String id2 = arr[1];
                    String roomtype = "";
                    String one = "";
                    String two = "";
                    String three = "";
                    String four = "";
                    String QueryString1 = "";

                    try {
                        Class.forName("org.postgresql.Driver");
                        con = DriverManager.getConnection(url, user1, pw);
                    } catch (Exception ex) {

                        out.println("exeSQL Error : " + ex.getMessage());
                    }
                    if ((id != null) && (request.getParameter("submit") == null)) {

                        try {

                            stmt = con.createStatement();
                            QueryString1 = "Select * FROM ratetempdtl WHERE rtd_Id ='" + id1 + "' and rt_Id='" + id2 + "'";
                            rs = stmt.executeQuery(QueryString1);
                            while (rs.next()) {

                                roomtype = rs.getString(2);
                                one = rs.getString(3);
                                two = rs.getString(4);
                                three = rs.getString(5);
                                four = rs.getString(6);
                            }

                        } catch (Exception ex) {

                            out.println("exeSQL Error : " + ex.getMessage());
                        }
        %>
        <form method="post" action="EditRateTemplateDetail.jsp?id=<%=id%>">
            <table>

                <tr> <td width="25%">RoomType</td>
                    <td width="75%">
                        <select name="roomtype" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                            <%
                                                    String j1 = "", j2 = "";
                                                    sql1 = "select * from roomtype ";
                                                    rs = stmt.executeQuery(sql1);
                                                    while (rs.next()) {
                                                        j1 = rs.getString("rt_id");
                                                        j2 = rs.getString("rt_descr");

                            %>

                            <option value="<%=j1%>" name="roomtype" <%if (roomtype.equals(j1)) {
                                                                                        out.println("selected");
                                                                                    }%>><%=j2%></option>

                            <%    }
                            %>


                        </select>


                    </td>
                </tr>
                <tr> <td width="25%">One person</td>
                    <td width="75%">
                        <select name="one" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                            <%
                                                    String j3 = "", j4 = "";
                                                    sql1 = "select * from ratecode  ";
                                                    rs = stmt.executeQuery(sql1);
                                                    while (rs.next()) {
                                                        j3 = rs.getString("rc_id");
                                                        j4 = rs.getString("rc_descr");

                            %>

                            <option value="<%=j3%>" name="one" <%if (one.equals(j3)) {
                                                                                        out.println("selected");
                                                                                    }%>><%=j4%></option>

                            <%    }
                            %>


                        </select>


                    </td>
                </tr>
                <tr> <td width="25%">Two person</td>
                    <td width="75%">
                        <select name="two" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                            <%
                                                       String j5 = "", j6 = "";
                                                    sql1 = "select * from ratecode  ";
                                                    rs = stmt.executeQuery(sql1);
                                                    while (rs.next()) {
                                                        j5 = rs.getString("rc_id");
                                                        j6 = rs.getString("rc_descr");

                            %>

                            <option value="<%=j5%>" name="two" <%if (two.equals(j6)) {
                                                                                        out.println("selected");
                                                                                    }%>><%=j6%></option>

                            <%    }
                            %>


                        </select>


                    </td>
                </tr>
                <tr> <td width="25%">Three person</td>
                    <td width="75%">
                        <select name="three" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                            <%
                                                         String j7 = "", j8 = "";
                                                    sql1 = "select * from ratecode  ";
                                                    rs = stmt.executeQuery(sql1);
                                                    while (rs.next()) {
                                                        j7 = rs.getString("rc_id");
                                                        j8 = rs.getString("rc_descr");

                            %>

                            <option value="<%=j7%>" name="three" <%if (three.equals(j7)) {
                                                                                        out.println("selected");
                                                                                    }%>><%=j8%></option>

                            <%    }
                            %>


                        </select>


                    </td>
                </tr>
  <tr> <td width="25%">Four person</td>
                    <td width="75%">
                        <select name="four" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                            <%
                                                         String j9 = "", j10 = "";
                                                    sql1 = "select * from ratecode  ";
                                                    rs = stmt.executeQuery(sql1);
                                                    while (rs.next()) {
                                                        j9 = rs.getString("rc_id");
                                                        j10 = rs.getString("rc_descr");

                            %>

                            <option value="<%=j9%>" name="four" <%if (four.equals(j9)) {
                                                                                        out.println("selected");
                                                                                    }%>><%=j10%></option>

                            <%    }
                            %>


                        </select>


                    </td>
                </tr>
                <tr><td colspan="2" align="center"><input type="submit" name="submit" value="update"></input>
                        <input type="hidden" name="id1" value="<%=id%>"></input></td></tr>
            </table>
        </form>
        <%
                    }
                    if (request.getParameter("submit") != null) {

                        roomtype = request.getParameter("roomtype");
                        one = request.getParameter("one");
                        two = request.getParameter("two");
                        three = request.getParameter("three");
                        four = request.getParameter("four");
                        stmt = con.createStatement();
                        String sql = "UPDATE ratetempdtl SET rt_id='" + roomtype + "', rateno1='" + one + "', rateno2='" + two + "', rateno3='" + three + "', rateno4='" + four + "' WHERE rtd_Id ='" + id1 + "'and rt_id ='" + id2 + "'";

                        int row = stmt.executeUpdate(sql);
                        if (row != 0) {
                            out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=SetRateTemplateDetail.jsp?id=" + id1 + "'>");
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
