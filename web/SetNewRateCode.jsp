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
        window.opener.location.href="SetRateCode.jsp";

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
                    String head1 = mrequest.getParameter("code");
                    String co = new String(head1.getBytes("ISO8859_1"), "utf-8");

                    String descr1 = mrequest.getParameter("desc");
                    String des = new String(descr1.getBytes("ISO8859_1"), "utf-8");


                    String room1 = mrequest.getParameter("room");
                    String room = new String(room1.getBytes("ISO8859_1"), "utf-8");

                    String rservice1 = mrequest.getParameter("rservice");
                    String rservice = new String(rservice1.getBytes("ISO8859_1"), "utf-8");

                    String rtax1 = mrequest.getParameter("rtax");
                    String rtax = new String(rtax1.getBytes("ISO8859_1"), "utf-8");

                    String rate1 = mrequest.getParameter("rate");
                    String rate = new String(rate1.getBytes("ISO8859_1"), "utf-8");

                    String bservice1 = mrequest.getParameter("bservice");
                    String bservice = new String(bservice1.getBytes("ISO8859_1"), "utf-8");

                    String btax1 = mrequest.getParameter("btax");
                    String btax = new String(btax1.getBytes("ISO8859_1"), "utf-8");

                    String abf1 = mrequest.getParameter("abf");
                    String abf = new String(abf1.getBytes("ISO8859_1"), "utf-8");

                    String lunch1 = mrequest.getParameter("lunch");
                    String lunch = new String(lunch1.getBytes("ISO8859_1"), "utf-8");

                    String dinner1 = mrequest.getParameter("dinner");
                    String dinner = new String(dinner1.getBytes("ISO8859_1"), "utf-8");

                    String other1 = mrequest.getParameter("other");
                    String other = new String(other1.getBytes("ISO8859_1"), "utf-8");

                    String discount1 = mrequest.getParameter("discount");
                    String discount = new String(discount1.getBytes("ISO8859_1"), "utf-8");

                    String total1 = mrequest.getParameter("total");
                    String total = new String(total1.getBytes("ISO8859_1"), "utf-8");

                  


                    String net5 = mrequest.getParameter("link");
                    String net;
                    if (net5 != null) {
                        net = "true";
                    } else {
                        net = "false";
                    }
                    if (co.equals("")) {
                        errors.add("check code");
                    }
                    if (des.equals("")) {
                        errors.add("check details");
                    }


                    if (errors.size() > 0) {
    %><%@include file="ckError.jsp" %><% } else {

                            sql = "insert into ratecode (rc_Id,rc_Descr,rc_room,rc_service,rc_tax,rc_extrabed,rc_extbedserv,rc_extbedtax,rc_abf,rc_lunch,rc_dinner,rc_discount,rc_netflag) VALUES ( '" + co + "','" + des + "','" + room + "','" + rservice + "','" + rtax + "','" + rate + "','" + bservice + "','" + btax + "','" + abf + "','" + lunch + "','" + dinner + "','" + discount + "','" + net + "' )";

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
                        <div align="left"><strong>RateCode</strong></div>
                    </div></td>
            </tr>

            <tr>
                <td>Code</td>
                <td><input type="text" name="code"  />
                    *</td>
            </tr>
            <tr>
                <td>Description</td>
                <td><input type="text" name="desc"  />
                    *</td>
            </tr>
            <tr><td width="25%"></td><td width="75%"><p>  <input name="link" type="checkbox"  value="checkbox" >Net</td>
            </tr>
            <tr><td colspan="6">Room</td> </tr>
            <tr>
                <td>Rate</td>
                <td><input type="text" name="room"  />
                    *</td>
                <td>Service</td>
                <td><input type="text" name="rservice"  />
                    *</td>
                <td>Tax</td>
                <td><input type="text" name="rtax"  />
                    *</td>
            </tr>
            <tr><td colspan="6"> Extra Bed </td> </tr>
            <tr>
                <td>Rate</td>
                <td><input type="number" name="rate"  />
                    *</td>
                <td>Service</td>
                <td><input type="number" name="bservice"  />
                    *</td>
                <td>Tax</td>
                <td><input type="number" name="btax"  />
                    *</td>
            </tr>
            <tr><td colspan="6"> Meal </td></tr>
            <tr>
                <td>ABF</td>
                <td><input type="number" name="abf"  />
                    *</td>
                <td>Lunch</td>
                <td><input type="number" name="lunch"  />
                    *</td>
                <td>Dinner</td>
                <td><input type="number" name="dinner"  />
                    *</td>
            </tr>
            <tr><td colspan="6"> Other </td></tr>
            <tr>
                <td>Ratetype</td>
                <td><input type="text" name="other"  />
                    *</td>
                <td>Discount</td>
                <td><input type="number" name="discount"  />
                    *</td>
                <td>Total</td>
                <td><input type="number" name="total"  />
                    *</td>
            </tr>

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



