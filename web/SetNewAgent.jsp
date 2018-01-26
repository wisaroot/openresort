
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


        window.opener.location.href="SetAgent.jsp";

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
                    String head1 = mrequest.getParameter("name");
                    String name = new String(head1.getBytes("ISO8859_1"), "utf-8");


                    String descr2 = mrequest.getParameter("agenttype");
                    String agenttype = new String(descr2.getBytes("ISO8859_1"), "utf-8");

                    String descr3 = mrequest.getParameter("origin");
                    String origin = new String(descr3.getBytes("ISO8859_1"), "utf-8");



                    String descr4 = mrequest.getParameter("folio");
                    String folio = new String(descr4.getBytes("ISO8859_1"), "utf-8");

                    String descr5 = mrequest.getParameter("country");
                    String country = new String(descr5.getBytes("ISO8859_1"), "utf-8");

                    String descr6 = mrequest.getParameter("nationality");
                    String nationality = new String(descr6.getBytes("ISO8859_1"), "utf-8");

                    String descr7 = mrequest.getParameter("marketzone");
                    String marketzone = new String(descr7.getBytes("ISO8859_1"), "utf-8");

                    String descr8 = mrequest.getParameter("address1");
                    String address1 = new String(descr8.getBytes("ISO8859_1"), "utf-8");

                    String descr9 = mrequest.getParameter("telephone");
                    String telephone = new String(descr9.getBytes("ISO8859_1"), "utf-8");

                    String descr10 = mrequest.getParameter("fax");
                    String fax = new String(descr10.getBytes("ISO8859_1"), "utf-8");

                    String descr11 = mrequest.getParameter("email");
                    String email = new String(descr11.getBytes("ISO8859_1"), "utf-8");

                    String descr12 = mrequest.getParameter("contact");
                    String contact = new String(descr12.getBytes("ISO8859_1"), "utf-8");

                    String descr14 = mrequest.getParameter("credit");
                    String credit = new String(descr14.getBytes("ISO8859_1"), "utf-8");

                    String descr13 = mrequest.getParameter("term");
                    String term = new String(descr13.getBytes("ISO8859_1"), "utf-8");

                    /*   String descr15 = mrequest.getParameter("coa");
                    String coa = new String(descr15.getBytes("ISO8859_1"), "utf-8");
                    
                    String descr1 = mrequest.getParameter("ar");
                    String ar = new String(descr1.getBytes("ISO8859_1"), "utf-8");
                     */

                    String descr16 = mrequest.getParameter("mobile");
                    String mobile = new String(descr16.getBytes("ISO8859_1"), "utf-8");

                    String descr17 = mrequest.getParameter("address2");
                    String address2 = new String(descr17.getBytes("ISO8859_1"), "utf-8");


                    if (name.equals("")) {
                        errors.add("check name");
                    }

                    if (term.equals("")) {
                        term = "0";
                    }
                    if (credit.equals("")) {
                        credit = "0";
                    }

                    if (errors.size() > 0) {
    %><%@include file="ckError.jsp" %><% } else {

                            try {

                                sql = "insert into agent (a_name,at_id,o_id,m_id,fp_id,n_id,a_address1,a_address2,ct_id,a_tel,a_fax,a_email,a_contact,a_crlimit,a_crterm,a_mobile) VALUES ( '" + name + "','" + agenttype + "','" + origin + "','" + marketzone + "','" + folio + "','" + nationality + "','" + address1 + "','" + address2 + "','" + country + "','" + telephone + "','" + fax + "','" + email + "','" + contact + "','" + credit + "','" + term + "','" + mobile + "' )";

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
                <td>Name</td>
                <td><input type="text" name="name"  />
                    *</td>
            </tr>

            <tr><td>Agent Type</td>  <td width="75%">
                    <select name="agenttype" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                        <%
                                            String j1 = "", j2 = "";
                                            sql = "select * from agenttype  ";
                                            rs = stmt.executeQuery(sql);
                                            while (rs.next()) {
                                                j1 = rs.getString("at_id");
                                                j2 = rs.getString("at_descr");

                        %>

                        <option value="<%=j1%>" name="agenttype"  ><%=j2%></option>

                        <%    }
                        %>


                    </select>


                </td></tr>

            <tr><td>Origin</td>  <td width="75%">
                    <select name="origin" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                        <%
                                            String j3 = "", j4 = "";
                                            sql = "select * from origin  ";
                                            rs = stmt.executeQuery(sql);
                                            while (rs.next()) {
                                                j3 = rs.getString("o_id");
                                                j4 = rs.getString("o_descr");

                        %>

                        <option value="<%=j3%>" name="origin"  ><%=j4%></option>

                        <%    }
                        %>


                    </select>


                </td></tr>

            <tr><td>Folio Pattern</td>  <td width="75%">
                    <select name="folio" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                        <%
                                            String j5 = "", j6 = "";
                                            sql = "select * from folpattern  ";
                                            rs = stmt.executeQuery(sql);
                                            while (rs.next()) {
                                                j5 = rs.getString("fp_id");
                                                j6 = rs.getString("fp_descr");

                        %>

                        <option value="<%=j5%>" name="folio"  ><%=j6%></option>

                        <%    }
                        %>


                    </select>


                </td></tr>

            <tr><td>Country</td>  <td width="75%">
                    <select name="country" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                        <%
                                            String j7 = "", j8 = "";
                                            sql = "select * from country  ";
                                            rs = stmt.executeQuery(sql);
                                            while (rs.next()) {
                                                j7 = rs.getString("ct_id");
                                                j8 = rs.getString("ct_descr");

                        %>

                        <option value="<%=j7%>"name="country"  ><%=j8%></option>

                        <%    }
                        %>


                    </select>


                </td></tr>

            <tr><td>Nationality</td>  <td width="75%">
                    <select name="nationality" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                        <%
                                            String j9 = "", j10 = "";
                                            sql = "select * from nationality  ";
                                            rs = stmt.executeQuery(sql);
                                            while (rs.next()) {
                                                j9 = rs.getString("n_id");
                                                j10 = rs.getString("n_descr");

                        %>

                        <option value="<%=j9%>"name="nationality"  ><%=j10%></option>

                        <%    }
                        %>


                    </select>


                </td></tr>

            <tr><td>Market Zone</td>  <td width="75%">
                    <select name="marketzone" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                        <%
                                            String j11 = "", j12 = "";
                                            sql = "select * from marketzone  ";
                                            rs = stmt.executeQuery(sql);
                                            while (rs.next()) {
                                                j11 = rs.getString("mz_id");
                                                j12 = rs.getString("mz_descr");

                        %>

                        <option value="<%=j11%>"name="marketzone"  ><%=j12%></option>

                        <%    }
                        %>


                    </select>


                </td></tr>
            <tr>
                <td>Address</td>
                <td><input type="text" name="address1"  />
                </td>
            </tr>
            <tr>
                <td></td>
                <td  ><input type="text" name="address2"  />
                </td>
            </tr>
            <tr>
                <td>Telephone</td>
                <td><input type="text" name="telephone"  />
                </td>
            </tr>
            <tr>
                <td>Mobile</td>
                <td><input type="text" name="mobile"  />
                </td>
            </tr>
            <tr>
                <td>Fax</td>
                <td><input type="text" name="fax"  />
                </td>
            </tr>
            <tr>
                <td>Email</td>
                <td><input type="text" name="email"  />
                </td>
            </tr>
            <tr>
                <td>Contact</td>
                <td><input type="text" name="contact"  />
                </td>
            </tr>
            <tr>
                <td>Credit Limit</td>
                <td><input type="number" name="credit"  />
                </td>
            </tr>
            <tr>
                <td>Term</td>
                <td><input type="number" name="term"  />
                </td>
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



