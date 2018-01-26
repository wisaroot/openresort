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
    <%@ include file ="../config.jsp"%>

    <body>
        <%
            String bkacc = request.getParameter("bkacc");
            String dtl = request.getParameter("dtl");
            Statement stmt = null;

            Connection con = null;

            if (bkacc != null) {
                try {
                    Class.forName("org.postgresql.Driver");
                    con = DriverManager.getConnection(url, user1, pw);
                } catch (Exception ex) {

                    out.println("exeSQL Error1 : " + ex.getMessage());
                }
                try {
                    int row = 0, row1 = 0, room = 0;
                    stmt = con.createStatement();
                    String sql = "select count(nl_accno) from namelist where nl_accno= " + bkacc + " and  nl_dtlseq = " + dtl + " and nl_status  in ('I','O')";

                    ResultSet rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        row = rs.getInt(1);  // no of room alredy checkin
                    }
                    sql = "SELECT b_qty from booking where b_accno= " + bkacc + "and  b_seq = " + dtl + "  ;";

                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        room = rs.getInt(1);
                    }


                    if (row != 0 && row < room) {
                        //out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=EditSetHKPostting.jsp?hk=" + hk + "'>");

                        /*                    if (!createNameList(accountId, dtl, user, errorList)) {
                        errorList.add("This group has booking 0 room");
                        } else {
                        response.sendRedirect("namelist.jsp?bkacc=" + accountId + "&dtl=" + dtl);
                        }
                         */
                        response.sendRedirect("namelist.jsp?bkacc=" + bkacc + "&dtl=" + dtl);
                    } else if (row != 0 && row == room) {
                        
                          %>
                       <script language="javascript">
alert("Can't checkin again cause all rooms already check-in;")
 
  var acc='<%=(String) request.getParameter("bkacc")%>';
  location.href = 'checkin.jsp?acc='+acc+'';
</script>
                        <%
                         
                     
                    } else {
                        sql = "select count(nl_accno) from namelist where nl_accno= " + bkacc + " and  nl_dtlseq = " + dtl + "and nl_status not in ('I','O')";

                        rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                            row1 = rs.getInt(1);
                        }
                        if (row1 != 0) {  //have namelist, never check in
                            response.sendRedirect("namelist.jsp?bkacc=" + bkacc + "&dtl=" + dtl);
                        } else {

                            out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=newnamelist.jsp?bkacc=" + bkacc + "&dtl=" + dtl + "'>");
                        }

                    }

                    stmt.close();
                    con.close();
                } catch (Exception ex) {

                    out.println("exeSQL Error2 : " + ex.getMessage());
                }
            }
        %>
    </body>
</html>

