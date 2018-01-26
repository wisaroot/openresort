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
    <head>

        <title>Void Transaction</title>
    </head>
    <body>
        <%
            String folno = request.getParameter("id1");
            String trnseq = request.getParameter("id2");
            String Void = request.getParameter("id3");
            String room = request.getParameter("id4");
            String folseq=request.getParameter("id5");
            Statement stmt = null;
            Connection con = null;
            Double Debit = 0.0, Credit = 0.0, FolBal;
            if (folno != null && Void.equals("N")) {
                try {
                    Class.forName("org.postgresql.Driver");
                    con = DriverManager.getConnection(url, user1, pw);
                } catch (Exception ex) {

                    out.println("exeSQL Error1 : " + ex.getMessage());
                }
                try {

                    stmt = con.createStatement();
                    String sql = "update  gtran set gt_corrflag='Y'  where gt_folno= '" + folno + "' and gt_trnseq= '" + trnseq + "' and gt_folseq = '" + folseq + "'";
                    int row = stmt.executeUpdate(sql);
                    if (row != 0) {
                        ResultSet r = stmt.executeQuery("Select coalesce(sum(gt_Amount), 0) From gtran "
                                + " Where gt_FolNo = '" + folno + "' and gt_FolSeq = '" + folseq + "' and "
                                + " gt_DeptType = 'D' and upper(gt_CorrFlag) <> 'Y' and upper(gt_TxOutFlag) <> 'Y' ");
                        while (r.next()) {
                            Debit = r.getDouble(1);

                        }

                        /* Sum Credit Amount  */
                        r = stmt.executeQuery(" Select coalesce(sum(gt_Amount), 0) From gtran "
                                + " Where gt_FolNo = '" + folno + "' and gt_FolSeq = '" + folseq + "' and "
                                + " gt_DeptType = 'C' and upper(gt_CorrFlag) <> 'Y' and upper(gt_TxOutFlag) <> 'Y' ");
                        while (r.next()) {
                            Credit = r.getDouble(1);

                        }
                        FolBal = Debit - Credit;

                        sql = "Update gfolseq Set gfs_folbal = '" + FolBal + "' Where gfs_folno = '" + folno + "' and gfs_folseq = '" + folseq + "' ";
                        stmt.executeUpdate(sql);
                        out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=GuestFolio.jsp?id=" + folno + "'>");

                        // out.println("<br><a href='SetBedType.jsp'>finish</a>");
                    } else {
                        out.println("Can't Void ");
                    }

                    // close all the connections.

                    stmt.close();
                    con.close();
                } catch (Exception ex) {

                    out.println("exeSQL Error2 : " + ex.getMessage());
                }
            } else {
                out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=GuestFolio.jsp?id=" + folno + "'>");
            }
        %>
    </body>
</html>
