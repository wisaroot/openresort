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
                    String name = "";
                    String agenttype = "";
                    String origin = "";
                    String folio = "";
                    String country = "";
                    String nationality = "";
                    String marketzone = "";
                    String address1 = "";
                    String telephone = "";
                    String fax = "";
                    String email = "";
                    String contact = "";
                    String credit = "";
                    String term = "";
                    String mobile = "";
                    String address2 = "";
                    String QueryString1 = "";
                    //  if (request.getParameter("submit") != null) {
                    try {
                        Class.forName("org.postgresql.Driver");
                        con = DriverManager.getConnection(url, user1, pw);
                    } catch (Exception ex) {

                        out.println("exeSQL Error : " + ex.getMessage());
                    }
                    

                    if ((id != null) && (request.getParameter("submit") == null)) {

                        try {

                            stmt = con.createStatement();
                            QueryString1 = "Select * FROM agent WHERE a_Id ='" + id + "'";
                            rs = stmt.executeQuery(QueryString1);
                            while (rs.next()) {

                                name = rs.getString(2);
                                agenttype = rs.getString(3);
                                origin = rs.getString(4);
                                marketzone = rs.getString(5);
                                folio = rs.getString(6);
                                nationality = rs.getString(7);
                                address1 = rs.getString(8);
                                address2 = rs.getString(9);
                                country = rs.getString(10);
                                telephone = rs.getString(11);
                                fax = rs.getString(12);
                                email = rs.getString(13);
                                contact = rs.getString(14);
                                term = rs.getString("a_crterm");
                                credit = rs.getString("a_crlimit");
                                mobile = rs.getString("a_mobile");
                            }

                        } catch (Exception ex) {
                            out.println("exeSQL Error : " + ex.getMessage());
                        }
                    


        %>
        <form method="post" action="EditAgent.jsp">
            <table>
                <tr><td>Name</td><td><input type="text" name="name" value="<%=name%>"  /></td></tr>
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

                            <option value="<%=j1%>" name="agenttype" <%if (agenttype.equals(j1)) {
                                                                                        out.println("selected");
                                                                                    }%>><%=j2%></option>

                            <%    }
                            %>
                        </select>
                    </td>
                </tr>


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

                            <option value="<%=j3%>" name="origin" <%if (origin.equals(j3)) {
                                                                                        out.println("selected");
                                                                                    }%>><%=j4%></option>
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

                                    <option value="<%=j5%>" name="folio" <%if (folio.equals(j5)) {
                                                                                        out.println("selected");
                                                                                    }%>><%=j6%></option>
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

                                    <option value="<%=j7%>" name="country"  <%if (country.equals(j7)) {
                                                                                        out.println("selected");
                                                                                    }%>><%=j8%></option>
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

                                    <option value="<%=j9%>" name="nationality"  <%if (nationality.equals(j9)) {
                                                                                        out.println("selected");
                                                                                    }%>><%=j10%></option>
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

                                    <option value="<%=j11%>" name="marketzone"  <%if (marketzone.equals(j11)) {
                                                                                        out.println("selected");
                                                                                    }%>><%=j12%></option>
                            <%    }
                            %>


                        </select>


                    </td></tr>

                <tr>
                    <td>Address</td>
                    <td><input type="text" name="address1"value="<%=address1%>"  />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td  ><input type="text" name="address2" value="<%=address2%>" />
                    </td>
                </tr>
                <tr>
                    <td>Telephone</td>
                    <td><input type="text" name="telephone" value="<%=telephone%>" />
                    </td>
                </tr>
                <tr>
                    <td>Mobile</td>
                    <td><input type="text" name="mobile" value="<%=mobile%>"  />
                    </td>
                </tr>
                <tr>
                    <td>Fax</td>
                    <td><input type="text" name="fax" value="<%=fax%>" />
                    </td>
                </tr>
                <tr>
                    <td>Email</td>
                    <td><input type="text" name="email" value="<%=email%>" />
                    </td>
                </tr>
                <tr>
                    <td>Contact</td>
                    <td><input type="text" name="contact" value="<%=contact%>" />
                    </td>
                </tr>
                <tr>
                    <td>Credit Limit</td>
                    <td><input type="number" name="credit" value="<%=credit%>" />
                    </td>
                </tr>
                <tr>
                    <td>Term</td>
                    <td><input type="number" name="term" value="<%=term%>" />
                    </td>
                </tr>


                <tr><td colspan="2" align="center"><input type="submit" name="submit" value="update"></input>
                        <input type="hidden" name="id" value="<%=id%>"></input></td></tr>
            </table>
        </form>
        <%
                    }
                    if (request.getParameter("submit") != null) {
                        name = request.getParameter("name");
                        agenttype = request.getParameter("agenttype");
                        origin = request.getParameter("origin");
                        marketzone = request.getParameter("marketzone");
                        folio = request.getParameter("folio");
                        nationality = request.getParameter("nationality");
                        address1 = request.getParameter("address1");
                        address2 = request.getParameter("address2");
                        country = request.getParameter("country");
                        telephone = request.getParameter("telephone");
                        fax = request.getParameter("fax");
                        email = request.getParameter("email");
                        contact = request.getParameter("contact");
                   String     term1 = request.getParameter("term");
                    term = new String(term1.getBytes("ISO8859_1"), "utf-8");
                     String     credit1 = request.getParameter("credit");
                        credit =  new String(credit1.getBytes("ISO8859_1"), "utf-8");
                        mobile = request.getParameter("mobile");
                        stmt = con.createStatement();

                   
                            if (term.equals("null")) {
                            term = null;
                        }else if(term.equals("")){
                            term="0";
                        }
                        if (credit.equals("null")) {
                            credit = null;
                        }else if(credit.equals("")){
                            credit="0";
                        }
                        String sql1 = "UPDATE agent SET  a_name='" + name + "', at_id='" + agenttype + "', o_id='" + origin + "', m_id='" + marketzone + "', fp_id='" + folio + "', n_id='" + nationality + "', a_address1='" + address1 + "',a_address2='" + address2 + "', ct_id='" + country + "', a_tel='" + telephone + "', a_fax='" + fax + "', a_email='" + email + "', a_contact='" + contact + "', a_crlimit='" + credit + "', a_crterm='" + term + "', a_mobile='" + mobile + "' WHERE a_Id='" + id + "'";

                        int row = stmt.executeUpdate(sql1);
                        if (row != 0) {
                            out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=SetAgent.jsp'>"); // out.println("<br><a href='SetBedType.jsp'>finish</a>");
                        } else {
                            out.println("Can't update");
                        }
                        stmt.close();
                        con.close();

                    }

        %>
    </body>
</html>

