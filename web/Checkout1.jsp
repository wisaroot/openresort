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

        <title>Check Out</title>
        <script language = "javaScript">
            function valid_data()
            {

                if (document.frmMain.ChkOutStat.value == 1) {
                    alert( 'Can not check out cauese FolBal != 0  ');
                    //document.frmMain.txtroom.focus();
                    // return false ;
                    window.opener.location.href="Checkout.jsp";

                    window.close();
                    
                }
                if (document.frmMain.ChkOutStat.value == 2) {
                    alert( 'Can not check out cauese charge folio still unpost ');
                    //  document.frmMain.txtroom.focus();
                    window.opener.location.href="Checkout.jsp";

                    window.close();
                    
                }
              
               
            }//end of function 

        </script>

    </head>
    <body>


        <%
            String fol = request.getParameter("id");

            String name = request.getParameter("id1");
            String ChkOut = request.getParameter("ChkOutStat");
            String accno = null;
            String roomno = null;
            String arrival = null;
            String departure = null;
            String OriNo = null, FPatNo = null, UserNo = null;
            int unpost = 0, ChkOutStat = 0, GuestNo = 0, NewSeq = 0, NewSeq1 = 0, NewReq = 0, AgentNo = 0;
            Statement stmt = null;
            String sql = null, note = null;
            ResultSet rs = null;
            Connection con = null;
            Double fol1 = 0.00, fol2 = 0.00, Total;
            Double folbal1 = 0.0, folbal2 = 0.0, FolBal, TotalBal = 0.00;
            String[] ReqNo = new String[40];
            Date[] FromDate = new Date[40];
            Date[] EndDate = new Date[40];
            String[] ChargeFlag = new String[40];
            String[] DeptNo = new String[40];
            Double[] Amount = new Double[40];
            Date Arrival = null, Departure = null;
            java.sql.Time ArrTime = new java.sql.Time(new java.util.Date().getTime());
            java.sql.Time DepTime = new java.sql.Time(new java.util.Date().getTime());
            // Time ArrTime=null, DepTime=null;
            String RoomNo = null, RoomTypeNo = null, RateNo = null;
            int Rate = 0;
            Double Service = 0.00, Tax = 0.00, Discount = 0.00;


            try {

                Class.forName("org.postgresql.Driver");
                con = DriverManager.getConnection(url, user1, pw);
            } catch (Exception ex) {

                out.println("exeSQL Error : " + ex.getMessage());
            }

            if ((request.getParameter("submit") == null)) {
                try {
                    stmt = con.createStatement();

                    rs = stmt.executeQuery(" select gf_accno,gf_roomno,ga_arrival,ga_departure from gfolio left join gaccount on (gfolio.gf_accno=gaccount.ga_accno)  where ga_accstat = 'I' and gf_folno =  '" + fol + "' ");
                    while (rs.next()) {
                        // เลือกประเภทรูมมาเก็บให้หมด
                        accno = rs.getString(1);
                        roomno = rs.getString(2);
                        arrival = rs.getString(3);
                        departure = rs.getString(4);

                    }



                    rs = stmt.executeQuery(" select gfs_folbal  from gfolseq   where gfs_folno =  '" + fol + "' and gfs_folseq = 1 ");
                    while (rs.next()) {
                        fol1 = rs.getDouble(1);

                    }



                    rs = stmt.executeQuery(" select gfs_folbal  from gfolseq   where gfs_folno =  '" + fol + "' and gfs_folseq = 2 ");
                    while (rs.next()) {
                        fol2 = rs.getDouble(1);

                    }

                    Total = fol1 + fol2;
                    java.sql.Date sysdate = null;
                    rs = stmt.executeQuery(" select sysdate from sysdate   ");
                    while (rs.next()) {
                        sysdate = rs.getDate(1);
                    }
                    rs = stmt.executeQuery(" Select * From gcharge "
                            + " Where gc_accno = '" + accno + "' and gc_chgdate = '" + sysdate + "' and "
                            + " gc_PostFlag = 'N'  ");
                    while (rs.next()) {
                        unpost = 1;

                    }


                    rs = stmt.executeQuery(" Select coalesce(sum(gfs_FolBal), 0) From GFolSeq "
                            + " Where gfs_FolNo = '" + fol + "' and gfs_FolSeq = 1  ");

                    while (rs.next()) {
                        folbal1 = rs.getDouble(1);

                    }
                    rs = stmt.executeQuery(" Select coalesce(sum(gfs_FolBal), 0) From GFolSeq "
                            + " Where gfs_FolNo = '" + fol + "' and gfs_FolSeq = 2  ");

                    while (rs.next()) {
                        folbal2 = rs.getDouble(1);

                    }
                    FolBal = folbal1 + folbal2;


                    // close all the connections.

                    stmt.close();
                    con.close();
                    if (FolBal != 0 || (folbal1 != 0) || (folbal2 != 0)) {
                        ChkOutStat = 1;
                    } else if (unpost > 0) {
                        ChkOutStat = 2;
                    } else {
                        ChkOutStat = 0;
                    }

                    /*       } catch (Exception e) {
                    
                    out.println("exeSQL Error : " + e.getMessage());
                    }
                    }*/

                    out.println(" <form method='post' name='frmMain' action='Checkout1.jsp'>");
                    out.println("<table id='tblTest' width='300' border='1'>");
//<tr><td>Code </td><td>Description</td></tr>
                    out.println("<tr id='tbl' bgColor=#8080a6 ><td>Room </td><td  >Folio</td><td  >Name</td><td  >Arrival</td><td  >Departure</td><td>Balance </td></tr>");




                    out.println("<TR id=5  ><TD>" + roomno + "</TD><TD>" + fol + "</TD>");
                    out.println("<TD>" + name + "</td><TD>" + arrival + "</td><TD>" + departure + "</td>");
                    out.println("<TD>" + Total + "</td></TR>");


                    // close all the connections.

                } catch (Exception ex) {

                    out.println(ex);
                    // table.getSelectedRow();
                }

                out.println("  <tr><td colspan='6' align='center'><input type='submit' name='submit' value='Checkout' onclick='javascript:return valid_data()'  ></input> <input type='hidden' name='acc' value='" + accno + "'></input><input type='hidden' name='fol' value='" + fol + "'></input><input type='hidden' name='ChkOutStat' value='" + ChkOutStat + "'></input></td></tr>");
                out.println("</table> </form>");

        %>



        <%

            }
            if (request.getParameter("submit") != null) {

                // out.println("ok");
                fol = request.getParameter("fol");
                accno = request.getParameter("acc");
                stmt = con.createStatement();

                sql = "update  gaccount set ga_accstat='O',ga_departure= CURRENT_DATE , ga_deptime= current_time where ga_accno = '" + accno + "'";

                stmt.executeUpdate(sql);
                sql = "update  gfolio set gf_closedate = CURRENT_DATE ,gf_closeby= 'admin1'  where gf_folno = '" + fol + "'";

                stmt.executeUpdate(sql);

                sql = "update  gfolseq set gfs_folstatus = 'C', gfs_closedate = CURRENT_DATE,gfs_closetime= current_time ,gfs_closeby= 'admin1'  where gfs_folno = '" + fol + "' and gfs_folstatus <> 'C' ";

                stmt.executeUpdate(sql);
                rs = stmt.executeQuery(" select ga_guestno  from gaccount   where ga_accno =  '" + accno + "'  ");
                while (rs.next()) {
                    GuestNo = rs.getInt(1);

                }
                rs = stmt.executeQuery("  Select (gn_Note) From GNote where gn_AccNo = '" + accno + "'  ");
                while (rs.next()) {
                    note = rs.getString(1);

                }
                if (note == null) {
                } else {
                    rs = stmt.executeQuery("  Select (coalesce(Max(hn_Seq), 0)+1 )  From hisnote  Where hn_GuestNo = '" + GuestNo + "'  ");
                    while (rs.next()) {
                        NewSeq = rs.getInt(1);

                    }
                    sql = "insert into hisnote (hn_GuestNo, hn_Seq, hn_Note) VALUES ( '" + GuestNo + "','" + NewSeq + "','" + note + "' )";

                    stmt.executeUpdate(sql);


                }

                /*Keep grequire Insert Hisreq*/
                rs = stmt.executeQuery(" Select gr_ReqNo, gr_FromDate,gr_EndDate, gr_ChargeFlag, gr_DeptNo, gr_Amount"
                        + " From grequire where gr_AccNo = '" + accno + "'  ");
                int j = 0;
                while (rs.next()) {
                    ReqNo[j] = rs.getString(1);
                    FromDate[j] = rs.getDate("gr_FromDate");
                    EndDate[j] = rs.getDate("gr_EndDate");
                    ChargeFlag[j] = rs.getString(4);
                    DeptNo[j] = rs.getString(5);
                    Amount[j] = rs.getDouble("gr_Amount");
                    j++;
                }
                int m = 0;
                while (j > m) {
                    rs = stmt.executeQuery("  Select (coalesce(Max(hr_Seq), 0)+1 )  From HisReq  Where hr_GuestNo = '" + GuestNo + "'  and hr_ReqNo = '" + ReqNo[m] + "'  ");
                    while (rs.next()) {
                        NewReq = rs.getInt(1);

                    }

                    sql = "insert into hisreq (hr_GuestNo, hr_Seq, hr_ReqNo,hr_FromDate,hr_endDate,hr_ChargeFlag,hr_DeptNo,hr_amount) VALUES ( '" + GuestNo + "','" + NewReq + "','" + ReqNo[m] + "','" + FromDate[m] + "','" + EndDate[m] + "','" + ChargeFlag[m] + "','" + DeptNo[m] + "','" + Amount[m] + "' )";

                    stmt.executeUpdate(sql);


                    m++;
                }
                /* Get Data From GAccount  */
                rs = stmt.executeQuery(" Select ga_AgentNo, ga_OriNo, ga_Arrival, ga_ArrTime, ga_Departure, ga_DepTime,  ga_FPatNo, ga_UserNo"
                        + "  From GAccount Where ga_AccNo  = '" + accno + "'  ");
                while (rs.next()) {
                    AgentNo = rs.getInt(1);
                    OriNo = rs.getString(2);
                    Arrival = rs.getDate("ga_Arrival");
                    ArrTime = rs.getTime("ga_ArrTime");
                    Departure = rs.getDate("ga_Departure");
                    DepTime = rs.getTime("ga_DepTime");
                    FPatNo = rs.getString("ga_FPatNo");
                    UserNo = rs.getString("ga_UserNo");
                }
                if (ArrTime == null) {
                    out.println("<script>alert('hi');</script>");

                }
                /* Get Data From GFolio */
                rs = stmt.executeQuery("Select gf_RoomNo, gf_RoomTypeNo, gf_RateNo, gf_Room, gf_Service, gf_Tax, gf_Discount"
                        + "  From gfolio Where gf_FolNo  = '" + fol + "'  ");
                while (rs.next()) {
                    RoomNo = rs.getString(1);
                    RoomTypeNo = rs.getString(2);
                    RateNo = rs.getString(3);
                    Rate = rs.getInt(4);
                    Service = rs.getDouble(5);
                    Tax = rs.getDouble(6);
                    Discount = rs.getDouble(7);
                }

                /* Get Folio Balance */
                rs = stmt.executeQuery("Select coalesce(SUM(gt_Amount), 0)"
                        + "  From GTran Where gt_FolNo  = '" + fol + "' and  gt_PostType = 'P' and gt_CorrFlag = 'N' and gt_TXOutFlag = 'N' ");
                while (rs.next()) {
                    TotalBal = rs.getDouble(1);

                }
                rs = stmt.executeQuery(" Select coalesce(Max(ht_Seq), 0)+1 From histran where ht_guestNo = '" + GuestNo + "'  ");

                while (rs.next()) {
                    NewSeq1 = rs.getInt(1);

                }


                sql = "insert into Histran (ht_GuestNo, ht_Seq, ht_AgentNo, ht_OriNo, ht_Arrival, ht_ArrTime,"
                        + "  ht_Departure, ht_DepTime,  ht_RoomNo, ht_RoomTypeNo,"
                        + "  ht_FPatNo, ht_RateNo, ht_Rate, ht_Service, ht_Tax, ht_Discount, ht_folbal, ht_UserNo) VALUES ( '" + GuestNo + "','" + NewSeq1 + "','" + AgentNo + "','" + OriNo + "','" + Arrival + "','" + ArrTime + "'"
                        + ",'" + Departure + "','" + DepTime + "','" + RoomNo + "','" + RoomTypeNo + "' "
                        + " ,'" + FPatNo + "','" + RateNo + "','" + Rate + "','" + Service + "','" + Tax + "','" + Discount + "','" + TotalBal + "','" + UserNo + "' )";
                stmt.executeUpdate(sql);


                out.println("<script>window.opener.location.href='Checkout.jsp';</script>");
                out.println("<script>window.close();</script>");

            }

        %>





    </body>
</html>




