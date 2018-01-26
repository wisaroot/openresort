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
        <script language="JavaScript">
            function isNumeric(elem, helperMsg)
            {
                var numericExpression = /^[0-9.]+$/;
                if(elem.value.match(numericExpression)){
                    return true;
                }else{
                    alert(helperMsg);
                    elem.value=elem.value.substr(0,elem.value.length-1);
                    elem.focus();
                    return false;
                }
            }
        </script>
        <%
            Statement stmt = null;
            ResultSet rs = null;
            Connection con = null;

            String sql1;

            String id = request.getParameter("id");
            String hk = request.getParameter("hk");
            String code = "";
            String deptno = "";
            String name = "";
            String category = "";
            String price = "";
            String service = "";
            String tax = "";
            String editamt = "";
            String pluactive = "";
            String QueryString1 = "";
            String k1 = "", k2 = "", k3 = "", k4 = "", k5 = "";
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
                    QueryString1 = "Select * FROM plu WHERE pl_pluno ='" + id + "'";
                    rs = stmt.executeQuery(QueryString1);
                    while (rs.next()) {
                        code = rs.getString(1);
                        deptno = rs.getString(2);
                        name = rs.getString(3);
                        category = rs.getString(4);
                        price = rs.getString(5);
                        service = rs.getString(6);
                        tax = rs.getString(7);
                        editamt = rs.getString(8);
                        pluactive = rs.getString(9);


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

                if (service.equalsIgnoreCase("t")) {

                    k1 = " checked ";
                }
                if (tax.equalsIgnoreCase("t")) {
                    k2 = "checked";
                }
                if (editamt.equalsIgnoreCase("t")) {
                    k3 = "checked";
                }
                if (pluactive.equalsIgnoreCase("t")) {
                    k4 = "checked";
                }




        %>
        <form method="post" action="EditPLU.jsp?id=<%=id%> " >
            <table>
                <tr><td>Name</td><td><input type="text" name ="name" value="<%=name%>"/></td></tr>

                <tr><td>Price</td><td><input type="text" name ="price" value="<%=price%>" onKeyup="JavaScript:return isNumeric(this,'Please enter only number');" /></td></tr>


                <tr><td width="25%"></td><td width="75%">  <input name="service" type="checkbox"  value="true"  <%= k1%> />service</td>
                </tr><tr><td width="25%"></td><td width="75%"> <input name="tax" type="checkbox"  value="true"  <%= k2%> />tax</td>
                </tr> <tr><td width="25%"></td><td width="75%"><input name="editamt" type="checkbox"  value="true"  <%= k3%> />editamt</td>
                </tr><tr><td width="25%"></td><td width="75%"><input name="pluactive" type="checkbox"  value="true"  <%= k4%> />active</td>
                </tr>

                <tr><td colspan="2" align="center"><input type="submit" name="submit" value="update"></input>
                        <input type="hidden" name="hk" value="<%=hk%>"></input>
                        <input type="hidden" name="id" value="<%=id%>"></input></td></tr>
            </table>
        </form>
        <%
            }
            if (request.getParameter("submit") != null) {
                if (request.getParameter("service") != null) {
                    service = "TRUE";

                } else {
                    service = "FALSE";
                }
                if (request.getParameter("tax") != null) {
                    tax = "TRUE";

                } else {
                    tax = "FALSE";
                }
                if (request.getParameter("editamt") != null) {
                    editamt = "TRUE";

                } else {
                    editamt = "FALSE";
                }
                if (request.getParameter("pluactive") != null) {
                    pluactive = "TRUE";

                } else {
                    pluactive = "FALSE";
                }

                String name11 = request.getParameter("name");
                 name = new String(name11.getBytes("ISO8859_1"), "utf-8");
                
                price = request.getParameter("price");





                stmt = con.createStatement();

                String sql = "UPDATE plu SET  pl_name='" + name + "', pl_price='" + price + "',  pl_service='" + service + "', pl_tax='" + tax + "', pl_editamt ='" + editamt + "', pl_pluactive ='" + pluactive + "' WHERE pl_pluno ='" + id + "'";
               
                    int row = stmt.executeUpdate(sql);
                

                  if (row != 0) {
                out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=EditSetHKPostting.jsp?hk=" + hk + "'>");
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
