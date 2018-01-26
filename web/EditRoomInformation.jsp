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

                    String sql = "";
                    String id = request.getParameter("id");
                    String room = "";
                    String roomtype = "";
                    String bedtype = "";
                    String location = "";
                    String exposure = "";


                    String QueryString1 = "";
                    //  if (request.getParameter("submit") != null) {
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
                            QueryString1 = "Select * FROM roominfo WHERE ri_room ='" + id + "'";
                            rs = stmt.executeQuery(QueryString1);
                            while (rs.next()) {
                                room = rs.getString(1);
                                roomtype = rs.getString(2);
                                bedtype = rs.getString(3);
                                location = rs.getString(4);
                                exposure = rs.getString(5);

                            }

                        } catch (Exception ex) {
                            out.println("exeSQL Error : " + ex.getMessage());
                        }



        %>
        <form method="post" action="EditRoomInformation.jsp">
            <table>
                <tr><td>Room No.</td><td><input type="text" name="room" value="<%=room%>"  /></td></tr>
                <tr><td>Room Type</td>  <td width="75%">
                        <select name="roomtype" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                            <%
                                                    String j1 = "", j2 = "";
                                                    sql = "select * from roomtype  ";
                                                    rs = stmt.executeQuery(sql);
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


                <tr><td>Bedtype</td>  <td width="75%">
                        <select name="bedtype" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                            <%
                                                    String j3 = "", j4 = "";
                                                    sql = "select * from bedtype  ";
                                                    rs = stmt.executeQuery(sql);
                                                    while (rs.next()) {
                                                        j3 = rs.getString("bt_id");
                                                        j4 = rs.getString("bt_descr");
                            %>

                            <option value="<%=j3%>"name="bedtype" <%if (bedtype.equals(j3)) {
                                                                                        out.println("selected");
                                                                                    }%>><%=j4%></option>
                            <%    }
                            %>

                        </select>
                    </td></tr>

                <tr><td>Location</td>  <td width="75%">
                        <select name="location" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                            <%
                                                    String j5 = "", j6 = "";
                                                    sql = "select * from location  ";
                                                    rs = stmt.executeQuery(sql);
                                                    while (rs.next()) {
                                                        j5 = rs.getString("l_id");
                                                        j6 = rs.getString("l_descr");

                            %>

                            <option value="<%=j5%>"name="location" <%if (location.equals(j5)) {
                                                                                        out.println("selected");
                                                                                    }%>><%=j6%></option>
                            <%    }
                            %>



                        </select>


                    </td></tr>

                <tr><td>Exposure</td>  <td width="75%">
                        <select name="exposure" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                            <%
                                                    String j7 = "", j8 = "";
                                                    sql = "select * from exposure  ";
                                                    rs = stmt.executeQuery(sql);
                                                    while (rs.next()) {
                                                        j7 = rs.getString("e_id");
                                                        j8 = rs.getString("e_descr");

                            %>

                            <option value="<%=j7%>"name="exposure"  <%if (exposure.equals(j7)) {
                                                                                        out.println("selected");
                                                                                    }%>><%=j8%></option>
                            <%    }
                            %>


                        </select>


                    </td></tr>

               


                <tr><td colspan="2" align="center"><input type="submit" name="submit" value="update"></input>
                        <input type="hidden" name="id" value="<%=id%>"></input></td></tr>
            </table>
        </form>
        <%
                    }
                    if (request.getParameter("submit") != null) {
                        room = request.getParameter("room");
                        roomtype = request.getParameter("roomtype");
                        bedtype = request.getParameter("bedtype");
                        location = request.getParameter("location");
                        exposure = request.getParameter("exposure");
                        
                        stmt = con.createStatement();


                       
                        String sql1 = "UPDATE roominfo SET  ri_room='" + room + "', ri_type='" + roomtype + "', ri_bedtype='" + bedtype + "', ri_location='" + location + "', ri_exposure='" + exposure + "' WHERE ri_room='" + id + "'";

                        int row = stmt.executeUpdate(sql1);
                        if (row != 0) {
                            out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=SetRoomInformation.jsp'>"); // out.println("<br><a href='SetBedType.jsp'>finish</a>");
                        } else {
                            out.println("Can't update");
                        }
                        stmt.close();
                        con.close();

                    }

        %>
    </body>
</html>

