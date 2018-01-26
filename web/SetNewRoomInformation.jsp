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
 <%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.util.*,javazoom.upload.*" errorPage="" %>


<%@ include file ="config.jsp"%>
<SCRIPT TYPE="text/javascript">
    function submitAndClose() {


        window.opener.location.href="SetRoomInformation.jsp";

        window.close();



    }
</SCRIPT>
<body>
    <%
                Class.forName("org.postgresql.Driver");
                Connection con = null;
                con = DriverManager.getConnection(url, user1, pw);
                Statement stmt = con.createStatement();
                String sql;
                ResultSet rs = null;
                Vector errors = new Vector();
                if (MultipartFormDataRequest.isMultipartFormData(request)) {
                    MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
                    String head1 = mrequest.getParameter("room");
                    String room = new String(head1.getBytes("ISO8859_1"), "utf-8");


                    String descr2 = mrequest.getParameter("roomtype");
                    String roomtype = new String(descr2.getBytes("ISO8859_1"), "utf-8");

                    String descr3 = mrequest.getParameter("bedtype");
                    String bedtype = new String(descr3.getBytes("ISO8859_1"), "utf-8");



                    String descr4 = mrequest.getParameter("location");
                    String location = new String(descr4.getBytes("ISO8859_1"), "utf-8");

                    String descr5 = mrequest.getParameter("exposure");
                    String exposure = new String(descr5.getBytes("ISO8859_1"), "utf-8");

                

                    if (errors.size() > 0) {
    %><%@include file="ckError.jsp" %><% } else {

                            try {

                                sql = "insert into roominfo (ri_room,ri_type,ri_bedtype,ri_location,ri_exposure) VALUES ( '" + room + "','" + roomtype + "','" + bedtype + "','" + location + "','" + exposure + "' )";

                                int row = stmt.executeUpdate(sql);

                            } catch (Exception ex) {

                                out.println("Unable to connect to database.");
                                // table.getSelectedRow();
                            }
    %>
    <script type="text/javascript" language="JavaScript">
        submitAndClose();
    </script>


    <%
                            //response.sendRedirect("clip.jsp");
                        }
                    } else {
    %>
    <form method="post" enctype="multipart/form-data">
        <table width="60%" border="1" align="center" cellpadding="0" style=" border-color: #00F" >
            <tr>
                <td colspan="2"><div align="center" style="">
                        <div align="left"><strong>Agent</strong></div>
                    </div></td>
            </tr>

            <tr>
                <td>Room No</td>
                <td><input type="text" name="room"  />
                    *</td>
            </tr>

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

                        <option value="<%=j1%>"name="roomtype"  ><%=j2%></option>

                        <%    }
                        %>


                    </select>


                </td></tr>

            <tr><td>bedtype</td>  <td width="75%">
                    <select name="bedtype" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                        <%
                                            String j3 = "", j4 = "";
                                            sql = "select * from bedtype  ";
                                            rs = stmt.executeQuery(sql);
                                            while (rs.next()) {
                                                j3 = rs.getString("bt_id");
                                                j4 = rs.getString("bt_descr");

                        %>

                        <option value="<%=j3%>"name="bedtype"  ><%=j4%></option>

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

                        <option value="<%=j5%>"name="location"  ><%=j6%></option>

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

                        <option value="<%=j7%>"name="exposure"  ><%=j8%></option>

                        <%    }
                        %>
                    </select>
                </td></tr>
          
            <tr>
                <td colspan="2"><div align="center">
                        <input type="Submit" name="Submit" value="OK"  />
                        <input name="Reset" type="reset" value="reset" />
                    </div></td>
            </tr>
        </table>
    </form>
    <%}%>
</body>



