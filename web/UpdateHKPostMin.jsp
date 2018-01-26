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

        <title>UpdateHKPostMinibar</title>
    </head>
    <body>
        <%

            String id1 = "";
            String id[] = request.getParameterValues("item");

            String room = request.getParameter("txtroom");
            String folno = request.getParameter("folno");
            String bill = request.getParameter("bill");
            String folseq = request.getParameter("ct");
            String sum = request.getParameter("txtSum");
          
            String[] qtyy= new String[100];
            int m=0;
            // String st1[] = request.getParameterValues("qt");
         /*   for (int i=0;i < st1.length ; i++) {
            out.println(st1.length);
            out.println(st1[i]);
            }*/

            String jj = request.getParameter("j");
          //  out.println(jj);
            for (int i = 0; i < Integer.parseInt(jj); i++) {
                String h = "qty[" + i + "]";
                String st1 = request.getParameter("" + h + "");
                if (st1 != null) {
                    qtyy[m] = st1;
                   
                  //   out.println(qtyy[m].toString());
                      m++;
                    
                }

               

            }







            String sql, qty = null, qty1 = null, pri = null;
            String year = null, MM = null, pqty = null, pamt = null;
            //Date trdate = null;
            Time trtime = null;
            Double Debit = 0.0, Credit = 0.0, FolBal,total=0.00;
            //int qty = 0;
            String plno = null;
            Double amount = 0.00, newamt, oldamt;

            int newtrnseq = 0, oldqty, newqty;
            int fseq = 0;

            Statement stmt = null;

            Connection con = null;
            ResultSet r = null;
            Date sysdate = null;
            int ck = 0;

            try {
                Class.forName("org.postgresql.Driver");
                con = DriverManager.getConnection(url, user1, pw);
                stmt = con.createStatement();
            } catch (Exception ex) {

                out.println("exeSQL connect : " + ex.getMessage());
            }
           
            r = stmt.executeQuery(" SELECT sysdate,to_char(sysdate, 'YYYY'),to_char(sysdate, 'MM') from sysdate   ");
            while (r.next()) {
            sysdate = r.getDate(1);
            year = r.getString(2);
            MM = r.getString(3);
            }
            
             pqty = "pls_qty_" + MM;
            pamt = "pls_amt_" + MM;
            for (int i = 0; i < id.length; i++) {
            id1 = id[i] + " ";
            oldqty = 0;
            oldamt = 0.00;
            newqty = 0;
            newamt = 0.00;
            plno=null;
            pri=null;
            qty=null;
            ck = 0;
            
            
            String[] arr = id1.split("\\/"); // แยก String ที่ใช้ / คั่น
            
            
            
            for (int j = 0; j < arr.length; j++) { // พิมพ์ String ย่อยออกหน้าจอ{
            if (j == 0) {
            plno = arr[j];
            }
           
            if (j == 1) {
            pri = arr[j];
            }
            
            }
             qty=qtyy[i];
            
           
            
            
            try {
            r = stmt.executeQuery(" select pls_pluno," + pqty + "," + pamt + " from plusales where pls_pluno = '" + plno + "' and pls_yref='" + year + "'");
            while (r.next()) {
            ck = 1;
            oldqty = r.getInt(2);
            oldamt = r.getDouble(3);
            }
            }catch (Exception ex) {
            
            out.println("exeSQL Error1 : " + ex.getMessage());
            }
            total=Double.parseDouble(pri)*Integer.parseInt(qty);
            if (ck == 1) {
            newqty = oldqty + Integer.parseInt(qty);
            newamt = oldamt + total;
            sql = "update  plusales set " + pqty + " ='" + newqty + "', " + pamt + " ='" + newamt + "' where pls_pluno = '" + plno + "' and pls_yref='" + year + "'";
            stmt.executeUpdate(sql);
            
            total=0.00;
            } else {
                
                try {
                     total=Double.parseDouble(pri)*Double.parseDouble(qty);
            PreparedStatement ps2 = con.prepareStatement("INSERT INTO plusales (pls_pluno,pls_YREF," + pqty + "," + pamt + ") values (?,?,?,?)");
            ps2.setString(1, plno);
            ps2.setInt(2, Integer.parseInt(year));
            ps2.setInt(3, Integer.parseInt(qty));
            ps2.setDouble(4, total);
            ps2.executeUpdate();
                       }catch (Exception ex) {
            
            out.println("exeSQL Error2 : " + ex.getMessage());
            } total=0.00;
            }
            
            
            }
            amount =Double.parseDouble(sum);
            try {
            
            r = stmt.executeQuery("  select max(gt_trnseq) FROM gtran where gt_FOLNO='" + folno + "' and  gt_folseq='" + folseq + "' ");
            while (r.next()) {
            newtrnseq = r.getInt(1);
            }
            newtrnseq = newtrnseq + 1;
            folseq = folseq.trim();
            fseq = Integer.parseInt(folseq);
            PreparedStatement ps2 = con.prepareStatement("INSERT INTO gtran (gt_FOLNO,gt_FOLSEQ,gt_TRNSEQ,gt_ROOMNO,gt_REFNO,gt_TRNDATE,gt_TRNTIME,gt_POSTTYPE,gt_CORRFLAG,gt_DEPTNO,gt_DEPTDESC,gt_DEPTTYPE,gt_QTY,gt_AMOUNT,gt_TXINFLAG,gt_TXOUTFLAG,gt_SHIFT,gt_USERNO,gt_TRNDETAIL) VALUES ( ?,?,?,?,?,?, CURRENT_TIME ,?,'N',?,?,?,?,?,'N','N','B','admin1','N')");
            ps2.setInt(1, Integer.parseInt(folno));
            ps2.setInt(2, fseq);
            ps2.setInt(3, newtrnseq);
            ps2.setString(4, room);
            ps2.setString(5, bill);
            ps2.setDate(6, sysdate);
            
            ps2.setString(7, "P");
            ps2.setString(8, "631");
            ps2.setString(9, "Minibar");
            ps2.setString(10, "D");
            ps2.setInt(11, 1);
            ps2.setDouble(12, amount);
            
            ps2.executeUpdate();
            
            } catch (Exception ex) {
            
            out.println("exeSQL Error2 : " + ex.getMessage());
            }
            
             try {
            r = stmt.executeQuery("Select coalesce(sum(gt_Amount), 0) From gtran "
            + " Where gt_FolNo = " + folno + " and gt_FolSeq = '" + fseq + "' and "
            + " gt_DeptType = 'D' and upper(gt_CorrFlag) <> 'Y' and upper(gt_TxOutFlag) <> 'Y' ");
            while (r.next()) {
            Debit = r.getDouble(1);
            
            }
            
            
            r = stmt.executeQuery(" Select coalesce(sum(gt_Amount), 0) From gtran "
            + " Where gt_FolNo = " + folno + " and gt_FolSeq = '" + fseq + "' and "
            + " gt_DeptType = 'C' and upper(gt_CorrFlag) <> 'Y' and upper(gt_TxOutFlag) <> 'Y' ");
            while (r.next()) {
            Credit = r.getDouble(1);
            
            }
            FolBal = Debit - Credit;
            
            sql = "Update gfolseq Set gfs_folbal = '" + FolBal + "' Where gfs_folno = '" + folno + "' and gfs_folseq = '" + fseq + "' ";
            stmt.executeUpdate(sql);
            out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=HKPostMin.jsp'>");
            } catch (Exception ex) {
            
            out.println("exeSQL Error2 : " + ex.getMessage());
            }
           
             
        %>
    </body>
</html>
