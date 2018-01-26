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
        window.opener.location.href="SetMedia.jsp";

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
                    String group = new String(descr2.getBytes("ISO8859_1"), "utf-8");

                    String ty = mrequest.getParameter("mz");
                    String type = new String(ty.getBytes("ISO8859_1"), "utf-8");
                    String descr3 = mrequest.getParameter("info");
                    String info;
                    if (descr3 != null) {
                        info = "true";
                    } else {
                        info = "false";
                    }


                    String descr4 = mrequest.getParameter("vat");
                    String vat;
                    if (descr4 != null) {
                        vat = "true";
                    } else {
                        vat = "false";
                    }

                    String descr5 = mrequest.getParameter("income");
                    String income;
                    if (descr5 != null) {
                        income = "true";
                    } else {
                        income = "false";
                    }

                    String descr6 = mrequest.getParameter("ar");
                    String ar;
                    if (descr6 != null) {
                        ar = "true";
                    } else {
                        ar = "false";
                    }
                    String descr7 = mrequest.getParameter("drawer");
                    String drawer;
                    if (descr7 != null) {
                        drawer = "true";
                    } else {
                        drawer = "false";
                    }





                    if (co.equals("")) {
                        errors.add("check code");
                    }
                    if (des.equals("")) {
                        errors.add("check details");
                    }
                    if (group.equals("")) {
                        errors.add("check dept");
                    }
                    if (type.equals("")) {
                        errors.add("check group");
                    }
                    if (info.equals("")) {
                        errors.add("check info");
                    }
                    if (vat.equals("")) {
                        errors.add("check vat");
                    }
                    if (income.equals("")) {
                        errors.add("check income");
                    }
                    if (ar.equals("")) {
                        errors.add("check ar");
                    }
                     if (drawer.equals("")) {
                        errors.add("check drawer");
                    }

                    if (errors.size() > 0) {
    %><%@include file="ckError.jsp" %><% } else {

 
                            sql = "insert into Media (m_Id,m_grp,m_descr,m_type,m_info,m_vat,m_income,m_ar,m_drawer) VALUES ( '" + co + "','" + group + "','" + des + "','" + type + "','" + info + "','" + vat + "','" + income + "','" + ar + "','" + drawer + "' )";

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
                        <div align="left"><strong>Media</strong></div>
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
                                            sql = "select * from mediagroup  ";
                                            rs = stmt.executeQuery(sql);
                                            while (rs.next()) {
                                                j1 = rs.getString("mg_id");
                                                j2 = rs.getString("mg_descr");

                        %>

                        <option value="<%=j1%>" name="dept" ><%=j2%></option>

                        <%    }
                        %>


                    </select>


                </td>
            </tr>
            <tr> <td width="25%">Media Type</td>
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
                <td width="75%"><p>  <input name="info" type="checkbox"  value="checkbox" >Request Information</td>
            </tr><tr><td width="25%"></td><td width="75%"><p>  <input name="vat" type="checkbox"  value="checkbox" >Vat Effect</td>
            </tr> <tr><td width="25%"></td><td width="75%"><p>  <input name="income" type="checkbox"  value="checkbox" >Link Income</td>
            </tr>
             <tr><td width="25%"></td><td width="75%"><p>  <input name="ar" type="checkbox"  value="checkbox" >Link AR</td>
            </tr> <tr><td width="25%"></td><td width="75%"><p>  <input name="drawer" type="checkbox"  value="checkbox" >Open Drawer</td>
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



