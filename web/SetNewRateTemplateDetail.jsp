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
 <%
                String id1 = request.getParameter("id");
                %>
<SCRIPT TYPE="text/javascript">
    function submitAndClose() {


        window.opener.location.href="SetRateTemplateDetail.jsp?id=<%=id1%>";

        window.close();



    }
</SCRIPT>
<body>
    <% String id = request.getParameter("id");
                Class.forName("org.postgresql.Driver");
                Connection con = null;
                con = DriverManager.getConnection(url, user1, pw);
                Statement stmt = con.createStatement();
                String sql;
                ResultSet rs = null;
                Vector errors = new Vector();
                if (MultipartFormDataRequest.isMultipartFormData(request)) {
                    MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
                    String head1 = mrequest.getParameter("roomtype");
                    String roomtype = new String(head1.getBytes("ISO8859_1"), "utf-8");

                    String descr2 = mrequest.getParameter("one");
                    String one = new String(descr2.getBytes("ISO8859_1"), "utf-8");

                    String descr3 = mrequest.getParameter("two");
                    String two = new String(descr3.getBytes("ISO8859_1"), "utf-8");

                    String descr4 = mrequest.getParameter("three");
                    String three = new String(descr4.getBytes("ISO8859_1"), "utf-8");

                    String descr5 = mrequest.getParameter("four");
                    String four = new String(descr5.getBytes("ISO8859_1"), "utf-8");





                    if (roomtype.equals("")) {
                        errors.add("check roomtype");
                    }
                  


                    if (errors.size() > 0) {
    %><%@include file="ckError.jsp" %><% } else {


         sql = "insert into ratetempdtl (rtd_Id,rt_id,rateno1,rateno2,rateno3,rateno4) VALUES ( '" + id + "','" + roomtype + "','" + one + "','" + two + "','" + three + "','" + four + "' )";

         int row = stmt.executeUpdate(sql);

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
                        <div align="left"><strong>Requirement</strong></div>
                    </div></td>
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

             <tr><td>One person</td>  <td width="75%">
                    <select name="one" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                        <%
                            String j3 = "", j4 = "";
                            sql = "select * from ratecode  ";
                            rs = stmt.executeQuery(sql);
                            while (rs.next()) {
                                j3 = rs.getString("rc_id");
                                j4 = rs.getString("rc_descr");

                        %>

                        <option value="<%=j3%>"name="one"  ><%=j4%></option>

                        <%    }
                        %>
                    </select>
                </td></tr>
  <tr><td>Two person</td>  <td width="75%">
                    <select name="two" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                        <%
                            String j5 = "", j6 = "";
                            sql = "select * from ratecode  ";
                            rs = stmt.executeQuery(sql);
                            while (rs.next()) {
                                j5 = rs.getString("rc_id");
                                j6 = rs.getString("rc_descr");

                        %>

                        <option value="<%=j5%>"name="two"  ><%=j6%></option>

                        <%    }
                        %>
                    </select>
                </td></tr>
   <tr><td>Three person</td>  <td width="75%">
                    <select name="three" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                        <%
                            String j7 = "", j8 = "";
                            sql = "select * from ratecode  ";
                            rs = stmt.executeQuery(sql);
                            while (rs.next()) {
                                j7 = rs.getString("rc_id");
                                j8 = rs.getString("rc_descr");

                        %>

                        <option value="<%=j7%>"name="three"  ><%=j8%></option>

                        <%    }
                        %>
                    </select>
                </td></tr>

 <tr><td>Four person</td>  <td width="75%">
                    <select name="four" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                        <%
                            String j9 = "", j10 = "";
                            sql = "select * from ratecode  ";
                            rs = stmt.executeQuery(sql);
                            while (rs.next()) {
                                j9 = rs.getString("rc_id");
                                j10 = rs.getString("rc_descr");

                        %>

                        <option value="<%=j9%>"name="four"  ><%=j10%></option>

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



