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
  --%><%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <%@ include file ="config.jsp"%>
    <head>

       
    </head>
    <body>
        <%

            String id1 = "";
            String id[] = request.getParameterValues("item");
            String newroom = request.getParameter("txtroom");
            String oldroom = request.getParameter("oldroom");
            String oldfol = request.getParameter("oldfol");
            String folseq = null, trnseq = null,sql;
            String re = null,  Pt = null, deptNo = null, deptDes = null, deptT = null;
            Date trdate = null;
            Time trtime=null;
            Double Debit = 0.0, Credit = 0.0, FolBal;
            int qty = 0;
            Double amount = 0.00;

            int newtrnseq = 0, newfol = 0;

            Statement stmt = null;

            Connection con = null;
            ResultSet r = null;


            try {
                Class.forName("org.postgresql.Driver");
                con = DriverManager.getConnection(url, user1, pw);
                stmt = con.createStatement();
            } catch (Exception ex) {

                out.println("exeSQL Error1 : " + ex.getMessage());
            }
            r = stmt.executeQuery(" select max(gf_folno) from gfolio   where gf_roomno ='" + newroom + "' ");
            while (r.next()) {
                newfol = r.getInt(1);

            }



            for (int i = 0; i < id.length; i++) {
                id1 = id[i] + " ";


                String[] arr = id1.split("\\/"); // แยก String ที่ใช้ / คั่น



                for (int j = 0; j < arr.length; j++) { // พิมพ์ String ย่อยออกหน้าจอ{
                    if (j == 0) {
                        trnseq = arr[j];
                    }
                    if (j == 1) {
                        folseq = arr[j];
                    }

                }




                try {

                    r = stmt.executeQuery("  select max(gt_trnseq) FROM gtran where gt_FOLNO='" + newfol + "' and  gt_folseq='" + folseq + "' ");
                    while (r.next()) {
                        newtrnseq = r.getInt(1);
                    }



                     sql = "update  gtran set gt_txoutflag='Y',gt_txroom= " + newroom + " where gt_folno= '" + oldfol + "' and gt_trnseq= " + trnseq + " and gt_folseq = " + folseq + "";

                    //  String sql = "insert into student(languages) values('" + id1 + "')";
                    stmt.executeUpdate(sql);

                    r = stmt.executeQuery("  select gt_REFNO,gt_TRNDATE,gt_TRNTIME,gt_POSTTYPE,gt_DEPTNO,gt_DEPTDESC,gt_DEPTTYPE,gt_QTY,gt_AMOUNT FROM gtran where gt_FOLNO='" + oldfol + "'and gt_trnseq= " + trnseq + " and  gt_folseq='" + folseq + "' ");
                    while (r.next()) {
                        re = r.getString(1);
                        trdate = r.getDate(2);
                        trtime = r.getTime(3);
                        Pt = r.getString(4);
                        deptNo = r.getString(5);
                        deptDes = r.getString(6);
                        deptT = r.getString(7);
                        qty = r.getInt(8);
                        amount = r.getDouble(9);
                    }


                   // out.println(newfol + "," + newtrnseq + "," + newtrnseq + "," + newtrnseq + "," + newroom + "," + re + "," + Pt + "," + deptNo + "," + deptDes + "," + oldroom + "," + deptT + "," + amount + "," + qty);
                    newtrnseq = newtrnseq + 1;
                   folseq= folseq.trim();
                    int fseq = Integer.parseInt(folseq);
                    PreparedStatement ps2 = con.prepareStatement("INSERT INTO gtran (gt_FOLNO,gt_FOLSEQ,gt_TRNSEQ,gt_ROOMNO,gt_REFNO,gt_TRNDATE,gt_TRNTIME,gt_POSTTYPE,gt_CORRFLAG,gt_DEPTNO,gt_DEPTDESC,gt_DEPTTYPE,gt_QTY,gt_AMOUNT,gt_TXINFLAG,gt_TXOUTFLAG,gt_txroom,gt_SHIFT,gt_USERNO,gt_TRNDETAIL) VALUES ( ?,?,?,?,?,?,?,?,'N',?,?,?,?,?,'Y','N',?,'B','admin1','N')");
                    ps2.setDouble(1, newfol);
                    ps2.setInt(2, fseq);
                    ps2.setInt(3, newtrnseq);
                    ps2.setString(4, newroom);
                    ps2.setString(5, re);
                    ps2.setDate(6, trdate);
                    ps2.setTime(7, trtime);
                    ps2.setString(8, Pt);
                    ps2.setString(9, deptNo);
                    ps2.setString(10, deptDes);
                    ps2.setString(11, deptT);
                    ps2.setInt(12, qty);
                    ps2.setDouble(13, amount);
                    ps2.setString(14, oldroom);
                    ps2.executeUpdate();

                } catch (Exception ex) {

                    out.println("exeSQL Error2 : " + ex.getMessage());
                }
                // close all the connections.



            }
               r = stmt.executeQuery("Select coalesce(sum(gt_Amount), 0) From gtran "
                    + " Where gt_FolNo = '" + oldfol + "' and gt_FolSeq = '" + 1 + "' and "
                    + " gt_DeptType = 'D' and upper(gt_CorrFlag) <> 'Y' and upper(gt_TxOutFlag) <> 'Y' ");
            while (r.next()) {
                Debit = r.getDouble(1);

            }

            /* Sum Credit Amount  */
            r = stmt.executeQuery(" Select coalesce(sum(gt_Amount), 0) From gtran "
                    + " Where gt_FolNo = '" + oldfol + "' and gt_FolSeq = '" + 1 + "' and "
                    + " gt_DeptType = 'C' and upper(gt_CorrFlag) <> 'Y' and upper(gt_TxOutFlag) <> 'Y' ");
            while (r.next()) {
                Credit = r.getDouble(1);

            }
            FolBal = Debit - Credit;

            sql = "Update gfolseq Set gfs_folbal = '" + FolBal + "' Where gfs_folno = '" + oldfol + "' and gfs_folseq = '" + 1+ "' ";
            stmt.executeUpdate(sql);
            
             FolBal =0.00; Debit=0.00; Credit=0.00;
            
            
              r = stmt.executeQuery("Select coalesce(sum(gt_Amount), 0) From gtran "
                    + " Where gt_FolNo = '" + oldfol + "' and gt_FolSeq = '" + 2 + "' and "
                    + " gt_DeptType = 'D' and upper(gt_CorrFlag) <> 'Y' and upper(gt_TxOutFlag) <> 'Y' ");
            while (r.next()) {
                Debit = r.getDouble(1);

            }

            /* Sum Credit Amount  */
            r = stmt.executeQuery(" Select coalesce(sum(gt_Amount), 0) From gtran "
                    + " Where gt_FolNo = '" + oldfol + "' and gt_FolSeq = '" + 2 + "' and "
                    + " gt_DeptType = 'C' and upper(gt_CorrFlag) <> 'Y' and upper(gt_TxOutFlag) <> 'Y' ");
            while (r.next()) {
                Credit = r.getDouble(1);

            }
            FolBal = Debit - Credit;

            sql = "Update gfolseq Set gfs_folbal = '" + FolBal + "' Where gfs_folno = '" + oldfol + "' and gfs_folseq = '" +2+ "' ";
            stmt.executeUpdate(sql);
            
             FolBal =0.00; Debit=0.00; Credit=0.00;
            
            
              r = stmt.executeQuery("Select coalesce(sum(gt_Amount), 0) From gtran "
                    + " Where gt_FolNo = '" + newfol + "' and gt_FolSeq = '" + 1 + "' and "
                    + " gt_DeptType = 'D' and upper(gt_CorrFlag) <> 'Y' and upper(gt_TxOutFlag) <> 'Y' ");
            while (r.next()) {
                Debit = r.getDouble(1);

            }

            /* Sum Credit Amount  */
            r = stmt.executeQuery(" Select coalesce(sum(gt_Amount), 0) From gtran "
                    + " Where gt_FolNo = '" + newfol + "' and gt_FolSeq = '" + 1 + "' and "
                    + " gt_DeptType = 'C' and upper(gt_CorrFlag) <> 'Y' and upper(gt_TxOutFlag) <> 'Y' ");
            while (r.next()) {
                Credit = r.getDouble(1);

            }
            FolBal = Debit - Credit;

            sql = "Update gfolseq Set gfs_folbal = '" + FolBal + "' Where gfs_folno = '" + newfol + "' and gfs_folseq = '" + 1+ "' ";
            stmt.executeUpdate(sql);
            
            
               FolBal =0.00; Debit=0.00; Credit=0.00;
            
            
              r = stmt.executeQuery("Select coalesce(sum(gt_Amount), 0) From gtran "
                    + " Where gt_FolNo = '" + newfol + "' and gt_FolSeq = '" + 2 + "' and "
                    + " gt_DeptType = 'D' and upper(gt_CorrFlag) <> 'Y' and upper(gt_TxOutFlag) <> 'Y' ");
            while (r.next()) {
                Debit = r.getDouble(1);

            }

            /* Sum Credit Amount  */
            r = stmt.executeQuery(" Select coalesce(sum(gt_Amount), 0) From gtran "
                    + " Where gt_FolNo = '" + newfol + "' and gt_FolSeq = '" + 2 + "' and "
                    + " gt_DeptType = 'C' and upper(gt_CorrFlag) <> 'Y' and upper(gt_TxOutFlag) <> 'Y' ");
            while (r.next()) {
                Credit = r.getDouble(1);

            }
            FolBal = Debit - Credit;

            sql = "Update gfolseq Set gfs_folbal = '" + FolBal + "' Where gfs_folno = '" + newfol + "' and gfs_folseq = '" + 2+ "' ";
            stmt.executeUpdate(sql);
            
             out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=GuestFolio.jsp?id=" + oldfol + "'>");
        %>
    </body>
</html>
