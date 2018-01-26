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

    <head>
        <%@ include file ="config.jsp"%>
        <title>DeleteAgent</title>
    </head>
    <body>
        <%

                Statement stmt = null;
                ResultSet rs = null;
                Connection con = null;
                
              String  fol = "11328";
              String  accno = "12722";
                   String OriNo = null, FPatNo = null, UserNo = null;
            int unpost = 0, ChkOutStat = 0, GuestNo = 0, NewSeq = 0,NewSeq1 = 0, NewReq = 0, AgentNo = 0;
            
            String sql = null, note = null;
         
            Double fol1 = 0.00, fol2 = 0.00, Total;
            Double folbal1 = 0.0, folbal2 = 0.0, FolBal,TotalBal=0.00;
            String[] ReqNo = new String[40];
            Date[] FromDate = new Date[40];
            Date[] EndDate = new Date[40];
            String[] ChargeFlag = new String[40];
            String[] DeptNo = new String[40];
            Double[] Amount = new Double[40];
            Date Arrival=null, Departure=null;
            java.sql.Time  ArrTime = new java.sql.Time(new java.util.Date().getTime());
            java.sql.Time  DepTime = new java.sql.Time(new java.util.Date().getTime());
           // Time ArrTime=null, DepTime=null;
            String RoomNo = null, RoomTypeNo = null, RateNo = null;
            int Rate=0;
            Double Service=0.00, Tax=0.00, Discount=0.00;

                try {

                    Class.forName("org.postgresql.Driver");
                    con = DriverManager.getConnection(url, user1, pw);
                } catch (Exception ex) {

                    out.println("exeSQL Error1 : " + ex.getMessage());
                }
                String s=null;
                  
                try {

                    stmt = con.createStatement();
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


      /*              rs = stmt.executeQuery("select  distinct rf.ri_room,rs.rs_statusno, "
                            + "case st.rs_status when 'OCC' then rs.rs_available "
                            + "when 'OOO' then (select roo.ro_end from roomooo roo "
                            + "where roo.ro_id = rf.ri_room) else  null end as Avail_date,"
                            + "rf.ri_type,rf.ri_bedtype,blk.bl_arrdate,blk.bl_depdate,rs.rs_remark from roominfo rf "
                            + "left join roomstatus rs on (rf.ri_room = rs.rs_roomno) "
                            + "left join status st on st.rs_status = rs.rs_statusno "
                            + "left join block blk on (rf.ri_room = blk.bl_roomno ) "
                            + "and bl_arrdate = (select min(bl_arrdate) from block where ri_room = rf.ri_room) order by rf.ri_room");

                  
                        while (rs.next()) {

                            String a = rs.getString("ri_room");
                            out.println(a);
                            String b = rs.getString("rs_statusno");
                            out.println(b);
                            String c = rs.getString("Avail_date");
                            out.println(c);
                            String d = rs.getString("ri_type");
                            out.println(d);


                            out.println(rs.getString("ri_bedtype"));
                            out.println(rs.getString("bl_arrdate"));
                            out.println(rs.getString("bl_depdate"));
                            out.println("===========");

                        
                        } 
                */
                        stmt.close();
                        con.close();
                    }  catch (Exception ex) {

                    out.println("exeSQL Error2 : " + ex.getMessage());
                }
            

        %>
    </body>
</html>

