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

<html xmlns="http://www.w3.org/1999/xhtml">
    <%@ include file ="config.jsp"%>

    <body>
        <%

            Statement stmt = null;
            ResultSet rs = null;
            Connection con = null;


            try {
                Class.forName("org.postgresql.Driver");
                con = DriverManager.getConnection(url, user1, pw);
            } catch (Exception ex) {

                out.println("exeSQL Error1 : " + ex.getMessage());
            }


            String[] postfol = request.getParameterValues("fol");
            String[] seq = request.getParameterValues("gc_seq");
            String[] acc = request.getParameterValues("acc");
            String[] postroom = request.getParameterValues("room");
            String[] dept = request.getParameterValues("deb");
            String[] posttotal = request.getParameterValues("totalnotpost");
            String sysdate1 = request.getParameter("sysdate");
            session.setAttribute("MySession1", postfol);
            String[] dataSet1 = (String[]) session.getAttribute("MySession1");
            session.setAttribute("MySession2", postroom);
            String[] dataSet2 = (String[]) session.getAttribute("MySession2");
            session.setAttribute("MySession3", dept);
            String[] dataSet3 = (String[]) session.getAttribute("MySession3");
            session.setAttribute("MySession4", posttotal);
            String[] dataSet4 = (String[]) session.getAttribute("MySession4");
             session.setAttribute("MySession5", seq);
            String[] dataSet5 = (String[]) session.getAttribute("MySession5");
            session.setAttribute("MySession6", acc);
            String[] dataSet6 = (String[]) session.getAttribute("MySession6");

            //loop for เพื่อนำข้อมูลแต่ละ array มาแสดง
            if (dataSet1 != null) {
                Date d = Date.valueOf(sysdate1);
                stmt = con.createStatement();
                String depttype = null, deptname = null, sql;
                int trnseq = 0;

                for (int i = 0; i < dataSet1.length; i++) {
                    rs = stmt.executeQuery("  select  d_name, d_depttype  FROM department where d_id = '" + dataSet3[i] + "'  ");
                    while (rs.next()) {
                        deptname = rs.getString(1);
                        depttype = rs.getString(2);

                    }

                    ResultSet r = stmt.executeQuery("  select max(gt_trnseq) FROM gtran where gt_FOLNO='" + dataSet1[i] + "' and  gt_folseq= 1 ");
                    while (r.next()) {
                        trnseq = r.getInt(1);

                    }

                    int fol = Integer.parseInt(dataSet1[i]);

                    Double amount = Double.parseDouble(dataSet4[i]), Debit = 0.00, Credit = 0.00, FolBal;
                    trnseq = trnseq + 1;
                    PreparedStatement ps2 = con.prepareStatement("INSERT INTO gtran (gt_FOLNO,gt_FOLSEQ,gt_TRNSEQ,gt_ROOMNO,gt_REFNO,gt_TRNDATE,gt_TRNTIME,gt_POSTTYPE,gt_CORRFLAG,gt_DEPTNO,gt_DEPTDESC,gt_DEPTTYPE,gt_QTY,gt_AMOUNT,gt_TXINFLAG,gt_TXOUTFLAG,gt_SHIFT,gt_USERNO,gt_TRNDETAIL) VALUES ( ?,1,?,?,?,?,CURRENT_TIME,?,'N',?,?,?,?,?,'N','N','B',?,'N')");
                    ps2.setInt(1, fol);
                    ps2.setInt(2, trnseq);
                    ps2.setString(3, dataSet2[i]);
                    ps2.setString(4, "Auto");
                    ps2.setDate(5, d);

                    ps2.setString(6, "P");
                    ps2.setString(7, dataSet3[i]);
                    ps2.setString(8, deptname);
                    ps2.setString(9, depttype);
                    ps2.setInt(10, 1);
                    ps2.setDouble(11, amount);
                    ps2.setString(12, "admin1");

                    ps2.executeUpdate();
                    r = stmt.executeQuery("Select coalesce(sum(gt_Amount), 0) From gtran "
                            + " Where gt_FolNo = '" + fol + "' and gt_FolSeq = 1 and "
                            + " gt_DeptType = 'D' and upper(gt_CorrFlag) <> 'Y' and upper(gt_TxOutFlag) <> 'Y' ");
                    while (r.next()) {
                        Debit = r.getDouble(1);

                    }


                    r = stmt.executeQuery(" Select coalesce(sum(gt_Amount), 0) From gtran "
                            + " Where gt_FolNo = '" + fol + "' and gt_FolSeq = 1 and "
                            + " gt_DeptType = 'C' and upper(gt_CorrFlag) <> 'Y' and upper(gt_TxOutFlag) <> 'Y' ");
                    while (r.next()) {
                        Credit = r.getDouble(1);

                    }
                    FolBal = Debit - Credit;

                    sql = "Update gfolseq Set gfs_folbal = '" + FolBal + "' Where gfs_folno = '" + fol + "' and gfs_folseq = 1 ";
                    stmt.executeUpdate(sql);

                    sql = "Update gcharge Set gc_postflag = 'Y' Where gc_seq = '" + dataSet5[i] + "' and gc_accno = '" + dataSet6[i] + "' ";
                    stmt.executeUpdate(sql);
 
                }
                sql = "Update autoexpense Set expensedate = '" + d + "'  ";
                stmt.executeUpdate(sql);

                out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=AutoPostExpense.jsp'>");
            } else {
                out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=AutoPostExpense.jsp'>");
            }


        %>
    </body>
</html>
