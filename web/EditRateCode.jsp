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
                    String room = "";
                    String rservice = "";
                    String rtax = "";
                    String rate = "";
                    String bservice = "";
                    String btax = "";
                    String abf = "";
                    String lunch = "";
                    String dinner = "";
                    String net = "";
                    String k1 = "";

                    String discount = "";
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
                            QueryString1 = "Select * FROM ratecode WHERE rc_id ='" + id + "'";
                            rs = stmt.executeQuery(QueryString1);
                            while (rs.next()) {
                                code = rs.getString(1);
                                desc = rs.getString(2);
                                room = rs.getString(3);
                                rservice = rs.getString(4);
                                rtax = rs.getString(5);
                                rate = rs.getString(6);
                                bservice = rs.getString(7);
                                btax = rs.getString(8);
                                abf = rs.getString(9);
                                lunch = rs.getString(10);
                                dinner = rs.getString(11);
                                discount = rs.getString(12);
                                net = rs.getString(13);
                            }

                            rs.close();
                            stmt.close();
                            con.close();
                        } catch (Exception ex) {

                            //      out.println("Unable to connect to database.");
                            // table.getSelectedRow();


                            out.println("exeSQL Error : " + ex.getMessage());
                        }
                        if (net.equalsIgnoreCase("t")) {

                            k1 = " checked ";
                        }



        %>
        <form method="post" action="EditRateCode.jsp">
            <table width="60%" border="1" align="center" cellpadding="0" style=" border-color: #00F" >
                <tr><td>Code</td><td><input type="text" name ="code" value="<%=code%>"/></td></tr>
                <tr><td>Description</td><td><input type="text" name ="desc" value="<%=desc%>"/></td></tr>
                <tr><td width="25%"></td><td width="75%"> <input name="net" type="checkbox"       value="true"  <%= k1%> />Net</td>
                </tr>
                <tr><td colspan="6">Room</td> </tr>
                <tr>
                    <td>Rate</td>
                    <td><input type="text" name="room" value="<%=room%>"  />
                    </td>
                    <td>Service</td>
                    <td><input type="text" name="rservice" value="<%=rservice%>"   />
                    </td>
                    <td>Tax</td>
                    <td><input type="text" name="rtax" value="<%=rtax%>"  />
                    </td>
                </tr>
                <tr><td colspan="6"> Extra Bed </td> </tr>
                <tr>
                    <td>Rate</td>
                    <td><input type="number" name="rate" value="<%=rate%>"  />
                    </td>
                    <td>Service</td>
                    <td><input type="number" name="bservice" value="<%=bservice%>"  />
                    </td>
                    <td>Tax</td>
                    <td><input type="number" name="btax" value="<%=btax%>"  />
                    </td>
                </tr>
                <tr><td colspan="6"> Meal </td></tr>
                <tr>
                    <td>ABF</td>
                    <td><input type="number" name="abf" value="<%=abf%>"  />
                    </td>
                    <td>Lunch</td>
                    <td><input type="number" name="lunch" value="<%=lunch%>" />
                    </td>
                    <td>Dinner</td>
                    <td><input type="number" name="dinner" value="<%=dinner%>" />
                    </td>
                </tr>
                <tr><td colspan="6"> Other </td></tr>
                <tr>
                   
                    <td>Discount</td>
                    <td><input type="number" name="discount" value="<%=discount%>" />
                    </td>

                </tr>


                <tr><td colspan="2" align="center"><input type="submit" name="submit" value="update"></input>
                        <input type="hidden" name="id" value="<%=id%>"></input></td></tr>
            </table>
        </form>
        <%
                    }

                    if (request.getParameter("submit") != null) {

                         if (request.getParameter("net") != null) {
                            net = "TRUE";

                        } else {
                             net = "FALSE";
                        }
                        code = request.getParameter("code");
                        desc = request.getParameter("desc");
                        room = request.getParameter("room");
                        rservice = request.getParameter("rservice");
                        rtax = request.getParameter("rtax");
                        rate = request.getParameter("rate");
                        bservice = request.getParameter("bservice");
                        btax = request.getParameter("btax");
                        abf = request.getParameter("abf");
                        lunch = request.getParameter("lunch");
                        dinner = request.getParameter("dinner");
                        discount = request.getParameter("discount");
                       


                        stmt = con.createStatement();
                        String sql = "UPDATE ratecode SET rc_Id='" + code + "', rc_Descr='" + desc + "', rc_room='" + room + "', rc_service='" + rservice + "', rc_tax='" + rtax + "', rc_extrabed='" + rate + "', rc_extbedserv='" + bservice + "', rc_extbedtax='" + btax + "', rc_abf='" + abf + "', rc_lunch='" + lunch + "', rc_dinner='" + dinner + "', rc_discount='" + discount + "', rc_netflag='" + net + "' WHERE rc_Id='" + id + "'";

                        int row = stmt.executeUpdate(sql);
                        if (row != 0) {
                            out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=SetRateCode.jsp'>");
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

