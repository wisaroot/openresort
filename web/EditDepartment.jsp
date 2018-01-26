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

                    String sql1;

                    String id = request.getParameter("id");
                    String code = "";
                    String desc = "";
                    String group = "";
                    String depttype = "";
                    String req = "";
                    String vat = "";
                    String inc = "";
                    String QueryString1 = "";
                    String k1 = "", k2 = "", k3 = "";
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
                            QueryString1 = "Select * FROM department WHERE d_Id ='" + id + "'";
                            rs = stmt.executeQuery(QueryString1);
                            while (rs.next()) {
                                code = rs.getString(1);
                                group = rs.getString(2);
                                desc = rs.getString(3);
                                depttype = rs.getString(4);
                                req = rs.getString(5);
                                inc = rs.getString(6);
                                vat = rs.getString(7);

                            }

                            // close all the connections.
                            //   rs.close();
                            //   stmt.close();
                            //  con.close();
                        } catch (Exception ex) {

                            //      out.println("Unable to connect to database.");
                            // table.getSelectedRow();


                            out.println("exeSQL Error : " + ex.getMessage());
                        }

                        if (req.equalsIgnoreCase("t")) {

                            k1 = " checked ";
                        }
                        if (inc.equalsIgnoreCase("t")) {
                            k2 = "checked";
                        }
                        if (vat.equalsIgnoreCase("t")) {
                            k3 = "checked";
                        }


        %>
        <form method="post" action="EditDepartment.jsp">
            <table>
                <tr><td>Code</td><td><input type="text" name ="code" value="<%=code%>"/></td></tr>
                <tr><td>Description</td><td><input type="text" name ="desc" value="<%=desc%>"/></td></tr>

                <tr> <td width="25%">Group</td>
                    <td width="75%">
                        <select name="group" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                            <%
                                                    String j1 = "", j2 = "";
                                                    sql1 = "select * from deptgroup  ";
                                                    rs = stmt.executeQuery(sql1);
                                                    while (rs.next()) {
                                                        j1 = rs.getString("dg_id");
                                                        j2 = rs.getString("dg_descr");

                            %>

                            <option value="<%=j1%>" name="group" <%if (group.equals(j1)) {
                                                                                        out.println("selected");
                                                                                    }%>><%=j2%></option>

                            <%    }
                            %>


                        </select>


                    </td>
                </tr>
                <tr> <td width="25%">Department Type</td>
                    <td width="75%">

                        <%int ij = 1;
                                                String o = "", m = "";
                                                while (ij < 3) {
                                                    if (ij == 1) {
                                                        o = "Debt";
                                                        m = "D";
                                                    } else if (ij == 2) {
                                                        o = "Credit";
                                                        m = "C";
                                                    }

                        %>
                        <label>
                            <input type="radio" name="RadioGroup1" value="<%=m%>"   <%if (m.equals(depttype)) {
                                                                                    out.println("CHECKED");
                                                                                }%> />
                            <%=o%></label>  <br />
                            <% ij++;
                                                    }%>



                    </td>
                </tr>
                <tr><td width="25%"></td><td width="75%">  <input name="req" type="checkbox"  value="true"  <%= k1%> />Request Information</td>
                </tr><tr><td width="25%"></td><td width="75%"> <input name="inc" type="checkbox"  value="true"  <%= k2%> />Link Income</td>
                </tr> <tr><td width="25%"></td><td width="75%"><input name="vat" type="checkbox"  value="true"  <%= k3%> />Vat Effect</td>
                </tr>

                <tr><td colspan="2" align="center"><input type="submit" name="submit" value="update"></input>
                        <input type="hidden" name="id" value="<%=id%>"></input></td></tr>
            </table>
        </form>
        <%
                    }
                    if (request.getParameter("submit") != null) {
                        if (request.getParameter("req") != null) {
                            req = "TRUE";
                           
                        } else {
                             req = "FALSE";
                        }
                          if (request.getParameter("inc") != null) {
                            inc = "TRUE";

                        } else {
                             inc = "FALSE";
                        }
                          if (request.getParameter("vat") != null) {
                            vat = "TRUE";

                        } else {
                             vat = "FALSE";
                        }


                        code = request.getParameter("code");
                        desc = request.getParameter("desc");
                        group = request.getParameter("group");
                        depttype = request.getParameter("RadioGroup1");
                        
                    
                   

                        stmt = con.createStatement();
                        String sql = "UPDATE department SET d_Id='" + code + "', d_group='" + group + "', d_name='" + desc + "', d_depttype='" + depttype + "', d_reqinfo='" + req + "', d_xferinc='" + inc + "', d_vateffect='" + vat + "' WHERE d_Id='" + id + "'";

                        int row = stmt.executeUpdate(sql);
                        if (row != 0) {
                            out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=SetDepartment.jsp'>");
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
