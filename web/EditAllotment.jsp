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
    <link rel="stylesheet" type="text/css" href="css/smoothness/jquery-ui-1.7.2.custom.css"></link>
    <script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.7.2.custom.min.js"></script>
    <script type="text/javascript">
        $(function(){
            // แทรกโค้ต jquery
            $("#dateInput").datepicker({ dateFormat: 'yy-mm-dd' });
            $( "#datepicker" ).datepicker({ dateFormat: 'yy-mm-dd' });
            $("#dend").datepicker();
            $('.datepicker').datepicker(options);

        });
    </script>
    <style type="text/css">
        .ui-datepicker{
            width:150px;
            font-family:tahoma;
            font-size:11px;
            text-align:center;
        }
    </style>

    <body>

        <%
                    Statement stmt = null;
                    ResultSet rs = null;
                    Connection con = null;
                    String id = request.getParameter("id");

                    String[] arr = id.split("\\|");
                    String id1 = arr[0];
                    String id2 = arr[1];
                    String agent = "";
                    String room = "";
                    String cutoff = "";
                    String dstart = "";
                    String dend = "";
                    String QueryString1 = "";
                    String sqll = "";
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
                            QueryString1 = "Select * FROM allotment WHERE am_Id ='" + id2 + "'and ag_Id='" + id1 + "'";
                            rs = stmt.executeQuery(QueryString1);
                            while (rs.next()) {
                                agent = rs.getString(2);
                                room = rs.getString(5);
                                dstart = rs.getString(3);
                                dend = rs.getString(4);
                                cutoff = rs.getString(6);
                            }
                        } catch (Exception ex) {
                            out.println("exeSQL Error : " + ex.getMessage());
                        }



        %>
        <form method="post" action="EditAllotment.jsp?id=<%=id%>">
            <table>

                <tr><td>Agent</td>  <td width="75%">
                        <select name="agent" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                            <%
                                                    String j1 = "", j2 = "";
                                                    sqll = "select * from agent  ";
                                                    rs = stmt.executeQuery(sqll);
                                                    while (rs.next()) {
                                                        j1 = rs.getString("a_id");
                                                        j2 = rs.getString("a_name");

                            %>

                            <option value="<%=j1%>" name="agent" <%if (agent.equals(j1)) {
                                                                                        out.println("selected");
                                                                                    }%>><%=j2%></option>

                            <%    }
                            %>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td>Start Date</td>
                    <td><input type="text" name="dateInput" id="dateInput" value="<%=dstart%>" />
                    </td>
                </tr>
                <tr>
                    <td>End Date</td>
                    <td><input id="datepicker" type="text" name="dend" value="<%=dend%>" />
                    </td>
                </tr>
                <tr>
                    <td>Room Qty</td>
                    <td><input type="number" name="room" value="<%=room%>"  />
                    </td>
                </tr>
                <tr>
                    <td>Cut off days</td>
                    <td><input type="number" name="cutoff" value="<%=cutoff%>"  />
                    </td>
                </tr>


                <tr><td colspan="2" align="center"><input type="submit" name="submit" value="update"></input>
                        <input type="hidden" name="id" value="<%=id%>"></input></td></tr>
            </table>
        </form>
        <%
                    }
                    if (request.getParameter("submit") != null) {


                        agent = request.getParameter("agent");
                        room = request.getParameter("room");
                        cutoff = request.getParameter("cutoff");
                      
                        dstart = request.getParameter("dateInput");
                        dend = request.getParameter("dend");
                        stmt = con.createStatement();
                        if(room.equals("")){
                            room="0";
                        }
                         if(cutoff.equals("")){
                            cutoff="0";
                        }
                        try {
                            String sql = "UPDATE allotment SET ag_id='" + agent + "', am_dstart='" + dstart + "', am_dend='" + dend + "', am_qty='" + room + "', cutoff1='" + cutoff + "' WHERE am_Id='" + id2 + "'and ag_id ='" + id1 + "'";

                            int row = stmt.executeUpdate(sql);

                            if (row != 0) {
                                out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=SetAllotment.jsp?id=" + id2 + "'>");
                                // out.println("<br><a href='SetBedType.jsp'>finish</a>");
                            } else {
                                out.println("Can't update");
                            }
                            stmt.close();
                            con.close();
                        } catch (Exception e) {
                            out.println(e);
                        }

                    }

        %>
    </body>
</html>