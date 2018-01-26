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
        window.opener.location.href="SetDepartment.jsp";

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
                    String descr2 = mrequest.getParameter("dept");
                    String dept = new String(descr2.getBytes("ISO8859_1"), "utf-8");
                    String mz1 = mrequest.getParameter("mz");
                    String mz = new String(mz1.getBytes("ISO8859_1"), "utf-8");
                    String descr3 = mrequest.getParameter("req");
                    String req;
                    if (descr3 != null) {
                        req = "true";
                    } else {
                        req = "false";
                    }


                    String descr4 = mrequest.getParameter("vat");
                    String vat;
                    if (descr4 != null) {
                        vat = "true";
                    } else {
                        vat = "false";
                    }

                    String descr5 = mrequest.getParameter("link");
                    String link;
                    if (descr5 != null) {
                        link = "true";
                    } else {
                        link = "false";
                    }





                    if (co.equals("")) {
                        errors.add("check code");
                    }
                    if (des.equals("")) {
                        errors.add("check details");
                    }
                    if (dept.equals("")) {
                        errors.add("check dept");
                    }
                    if (mz.equals("")) {
                        errors.add("check group");
                    }
                    if (link.equals("")) {
                        errors.add("check link");
                    }
                    if (vat.equals("")) {
                        errors.add("check vat");
                    }
                    if (req.equals("")) {
                        errors.add("check req");
                    }


                    if (errors.size() > 0) {
    %><%@include file="ckError.jsp" %><% } else {


                            sql = "insert into department (d_Id,d_group,d_name,d_depttype,d_reqinfo,d_xferinc,d_vateffect) VALUES ( '"+co+"','"+dept+"','"+des+"','" + mz + "','" + req + "','" + vat + "','" + link + "' )";

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
                        <div align="left"><strong>Department</strong></div>
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
            <tr> <td width="25%">Group</td>
                <td width="75%">
                    <select name="dept" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                        <%
                                            String j1 = "", j2 = "";
                                            sql = "select * from deptgroup  ";
                                            rs = stmt.executeQuery(sql);
                                            while (rs.next()) {
                                                j1 = rs.getString("dg_id");
                                                j2 = rs.getString("dg_descr");

                        %>

                        <option value="<%=j1%>" name="dept" ><%=j2%></option>

                        <%    }
                        %>


                    </select>


                </td>
            </tr>
            <tr> <td width="25%">Department Type</td>
                <td width="75%"><p>
                        <label>
                            <input type="radio" name="mz" value="D"  />
                            Debt</label>
                        <br />
                        <label>
                            <input type="radio" name="mz" value="C"  />
                            Credit
                        </label>
                        <br />

                    </p></td>
            </tr>
            <tr> <td width="25%"></td>
                <td width="75%"><p>  <input name="req" type="checkbox"  value="checkbox" >Request Information</td>
            </tr><tr><td width="25%"></td><td width="75%"><p>  <input name="vat" type="checkbox"  value="checkbox" >Vat Effect</td>
            </tr> <tr><td width="25%"></td><td width="75%"><p>  <input name="link" type="checkbox"  value="checkbox" >Link Income</td>
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



