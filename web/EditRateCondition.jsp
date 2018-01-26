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
                    String code = "";
                    String desc = "";
                    String ncharge = "";
                    String nfree = "";
                    String dmin = "";
                    String dmax = "";
                    String dstart = "";
                    String dend = "";
                    String QueryString1 = "";
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
                            QueryString1 = "Select * FROM ratecondition WHERE rct_Id ='" + id + "'";
                            rs = stmt.executeQuery(QueryString1);
                            while (rs.next()) {
                                code = rs.getString(1);
                                desc = rs.getString(2);
                                dstart = rs.getString("rct_startdate");
                                dend = rs.getString("rct_enddate");
                                ncharge = rs.getString("rct_chargenight");
                                nfree = rs.getString("rct_freenight");
                                dmax = rs.getString("rct_maxday");
                                dmin = rs.getString("rct_minday");

                            }

                            // close all the connections.
                            rs.close();
                            stmt.close();
                            con.close();
                        } catch (Exception ex) {

                            //      out.println("Unable to connect to database.");
                            // table.getSelectedRow();


                            out.println("exeSQL Error : " + ex.getMessage());
                        }



        %>
        <form method="post" action="EditRateCondition.jsp">
            <table>
                <tr><td>Code</td><td><input type="text" name ="code" value="<%=code%>"/></td></tr>
                <tr><td>Description</td><td><input type="text" name ="desc" value="<%=desc%>"/></td></tr>
                <tr><td colspan="4">Night</td> </tr>
                <tr>
                    <td>Charge</td>
                    <td><input type="number" name="ncharge"  value="<%=ncharge%>" />
                    </td>
                    <td>Free</td>
                    <td><input type="number" name="nfree"  value="<%=nfree%>" />
                    </td>
                </tr>
                <tr><td colspan="4">Day</td> </tr>
                <tr>
                    <td>Min</td>
                    <td><input type="number" name="dmin" value="<%=dmin%>" />
                    </td>
                    <td>Max</td>
                    <td><input type="number" name="dmax" value="<%=dmax%>" />
                    </td>
                </tr>
                <tr><td colspan="4">Date</td> </tr>
                <tr>
                    <td>Start</td>
                    <td><input type="text" name="dateInput" id="dateInput" value="<%=dstart%>" />
                    </td>
                </tr>
                <tr>
                    <td>End</td>
                    <td><input id="datepicker" type="text" name="dend" value="<%=dend%>" />
                    </td>
                </tr>
                <tr><td colspan="2" align="center"><input type="submit" name="submit" value="update"></input>
                        <input type="hidden" name="id" value="<%=id%>"></input></td></tr>
            </table>
        </form>
        <%
                    }
                    if (request.getParameter("submit") != null) {
                        code = request.getParameter("code");
                        desc = request.getParameter("desc");
                        ncharge = request.getParameter("ncharge");
                        nfree = request.getParameter("nfree");
                        dmax = request.getParameter("dmax");
                        dmin = request.getParameter("dmin");
                        dstart = request.getParameter("dateInput");
                        dend = request.getParameter("dend");
                        stmt = con.createStatement();
                        try{
                        String sql = "UPDATE ratecondition SET rct_Id='" + code + "', rct_Descr='" + desc + "', rct_startdate='" + dstart + "', rct_enddate='" + dend + "', rct_chargenight='" + ncharge + "', rct_freenight='" + nfree + "', rct_maxday='" + dmax + "', rct_minday='" + dmin + "' WHERE rct_Id='" + id + "'";

                        int row = stmt.executeUpdate(sql);

                        if (row != 0) {
                            out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=SetRateCondition.jsp'>");
                            // out.println("<br><a href='SetBedType.jsp'>finish</a>");
                        } else {
                            out.println("Can't update");
                        }
                        stmt.close();
                        con.close();
                        }catch(Exception e){   out.println(e);
             }

                    }

        %>
    </body>
</html>
