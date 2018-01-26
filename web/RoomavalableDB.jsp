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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.ArrayList,net.sf.json.*" %>
<%@ page language = "java" import = "java.util.*, java.lang.*,
         java.text.*, java.text.DateFormat.*,java.util.Locale " %>
<%@ include file ="config.jsp"%>
<%
            String id = request.getParameter("id");
            String rows = request.getParameter("rows");
            String pageno = request.getParameter("page");
            String cpage = pageno;
            String dmin = request.getParameter("dateInput");
            String dmax = request.getParameter("dend");
            java.sql.Date startdate = null, enddate = null;
            // java.util.Date enddate;
//java.sql.Date date = new java.sql.Date(new java.util.Date().getTime());
            JSONObject mysubdata = new JSONObject();
            JSONArray subarray = new JSONArray();
            Connection connect = null;
            Statement statement = null;
            ResultSet rs = null;
            String[] roomtypeno = new String[25];
            String[][][] col1 = new String[25][91][4];
            int[] ravai = new int[91];
            int[] tot = new int[91];
            int[] alloo = new int[91];
            int[] allinh = new int[91];
            int[][][] ravai1 = new int[25][91][5];
          

            /*  Class.forName("org.postgresql.Driver").newInstance();
            connect = DriverManager.getConnection(url, user1, pw);
            statement = connect.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

             */





            try {
                Class.forName("org.postgresql.Driver").newInstance();
                connect = DriverManager.getConnection(url, user1, pw);
                statement = connect.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);


            } catch (Exception ex) {

                out.println("exeSQL Error : " + ex.getMessage());
            }



            String h = null;
            try {

                rs = statement.executeQuery(" select sysdate,sysdate+90 from sysdate");
                while (rs.next()) {
                    // h = rs.getString(1);
                    startdate = rs.getDate(1);
                    enddate = rs.getDate(2);
                }

            } catch (Exception ex) {

                out.println("Unable to connect to database.");
                // table.getSelectedRow();
            }
            java.util.Date eDate = new java.util.Date(enddate.getTime());
            /*   if (dmax != null) {
            eDate = new SimpleDateFormat("dd-MM-yyyy").parse(dmax);

            }*/
            int count = 90;
            int pageval = 0;
            pageval = (count / Integer.parseInt(rows));

            int limitstart = 0;

            limitstart = (Integer.parseInt(rows) * Integer.parseInt(pageno)) - Integer.parseInt(rows);
            int total = count / Integer.parseInt(rows);
            String totalrow = String.valueOf(total + 1);

            JSONObject responcedata = new JSONObject();
            net.sf.json.JSONArray cellarray = new net.sf.json.JSONArray();
            String aa = String.valueOf(count);
            responcedata.put("total", totalrow);
            responcedata.put("page", cpage);
            responcedata.put("records", aa);

            net.sf.json.JSONArray cell = new net.sf.json.JSONArray();
            net.sf.json.JSONObject cellobj = new net.sf.json.JSONObject();


            int i = 0;
            int ii = 0;
            /*    rs = statement.executeQuery(" select * from roomtype ");
            while (rs.next()) {
            //cellobj.put("id", "" + ii);


            }*/
            rs = statement.executeQuery(" select rt_id from roomtype ");
            while (rs.next()) {
                roomtypeno[i] = rs.getString(1); // เลือกประเภทรูมมาเก็บให้หมด
                i++;
            }
            int j = 0, k = 0;


            String roomt;
            while (j < i) {
                roomt = roomtypeno[j];
                ii = 0;
                java.util.Date sDate = new java.util.Date(startdate.getTime());
                // out.println(roomt);
                while (sDate.before(eDate)) {


                    int TOTALROOM = 0, AVAIL = 0;
                  
                    rs = statement.executeQuery(" select count(ri_room) from roominfo where ri_type = '" + roomt + "'  ");
                    while (rs.next()) {
                        TOTALROOM = rs.getInt(1);
                    }


                    Calendar c = Calendar.getInstance();
                    c.setTime(sDate);



                    int RES = 0, blk = 0, INH = 0, OOO = 0;

                    rs = statement.executeQuery("  select coalesce( sum((b_qty - b_inhqty) -(select count(distinct bl_roomno) from block "
                            + "   where bl_accno = bk.b_accno and bl_dtlseq = bk.b_seq)  ) ,0) "
                            + " from booking bk inner join gaccount ac on bk.b_accno = ac.ga_accno  where ga_accstat in('R','C','I') "
                            + " and '" + sDate + "' between bk.b_arrdate and bk.b_depdate-1 and  '" + roomt + "' = b_ROOMTYPENO ");
                    while (rs.next()) {
                        RES = rs.getInt(1);

                    }//'2011-11-01'
                    rs = statement.executeQuery(" select count(distinct blk.bl_roomno) from block blk left join roominfo ri"
                            + " on ri.ri_room = blk.bl_roomno  where '" + sDate + "' between blk.bl_arrdate and blk.bl_depdate-1 "
                            + "  and '" + roomt + "' = ri_type   ");
                    while (rs.next()) {
                        blk = rs.getInt(1);
                    }
                    RES = RES + blk;
                    rs = statement.executeQuery("select count(distinct fol.gf_roomno)"
                            + " from gfolio fol inner join gaccount acc on fol.gf_accno = acc.ga_accno left join roominfo ri "
                            + "   on ri.ri_room     = fol.gf_roomno    where   '" + sDate + "' between ga_arrival and ga_departure-1 "
                            + "   and ri.ri_type =   '" + roomt + "'  and ga_accstat = 'I' ");

                    while (rs.next()) {
                        INH = rs.getInt(1);
                    }

                    rs = statement.executeQuery(" select coalesce(count(ro.ro_id),0) from roomooo ro left join roominfo ri   on ri.ri_room = ro.ro_id "
                            + "   where '" + sDate + "' between ro_start and ro_end and ri.ri_type = '" + roomt + "' ");
                    while (rs.next()) {
                        OOO = rs.getInt(1);
                    }

                    AVAIL = (TOTALROOM - RES - INH - OOO);
                    // out.println(AVAIL);

//2011-11-01
                    String av = Integer.toString(AVAIL);
                    SimpleDateFormat dateformatMMDDYYYY = new SimpleDateFormat("dd-MM-yyyy");
                    String nowMMDDYYYY = new String(dateformatMMDDYYYY.format(sDate));

                    String bk = Integer.toString(RES);
                    //  String cf = Integer.toString(blk);
                    String in = Integer.toString(INH);
                    String oo = Integer.toString(OOO);
                    String tt = Integer.toString(TOTALROOM);
                    ravai1[j][ii][0] = AVAIL;
                    ravai1[j][ii][1] = TOTALROOM;
                    ravai1[j][ii][2] = OOO;
                    col1[j][ii][ 0] = av;
                    col1[j][ii][ 1] = bk;
                    col1[j][ii][ 2] = oo;
                    col1[j][ii][ 3] = in;
                    if (j == 0) {
                        col1[j][ii][3] = nowMMDDYYYY;
                    }

                    /*            cell.add(0,nowMMDDYYYY);

                    cell.add(k + 1, av);
                    cell.add(k + 2, bk);
                    //  cell.add(cf);
                    cell.add(k + 3, in);
                    // cell.add(oo);
                    // cell.add(tt);
                    // cell.add(6, nowMMDDYYYY);




                    cellobj.put("cell", cell);
                    cell.clear();
                    cellarray.add(cellobj);*/
                    ii++;

                    c.add(Calendar.DATE, 1);
                    sDate = c.getTime();


                }
                j++;
                // k = 3 * (j);
            }

            int l = 0, d = 0, m = 0;
            while (d < 91) {
                j = 0;
                while (j < i) {
                    ravai[d] = ravai[d] + ravai1[j][d][0];
                    tot[d] = tot[d] + ravai1[j][d][1];
                    alloo[d] = alloo[d] + ravai1[j][d][2];
                    allinh[d] = allinh[d] + ravai1[j][d][3];
                    j++;
                }
                d++;
            }

            int y = 0;
            String avall, tota, alloo1, allinh1;
            while (y < 91) {
                avall = Integer.toString(ravai[y]);
                tota = Integer.toString(tot[y]);
                alloo1 = Integer.toString(alloo[y]);
                allinh1= Integer.toString(allinh[y]);
                cell.add(0, col1[0][y][3]);
                cell.add(1, tota);
                cell.add(2, avall);
                cell.add(3, allinh1);
                cell.add(4, alloo1);
                cell.add(5, col1[0][y][0]);
                cell.add(6, col1[0][y][1]);
                cell.add(7, col1[0][y][2]);
                cell.add(8, col1[1][y][0]);
                cell.add(9, col1[1][y][1]);
                cell.add(10, col1[1][y][2]);
                // cell.add(0, "kk");

                cellobj.put("cell", cell);
                cell.clear();
                cellarray.add(cellobj);
                y++;
            }
            responcedata.put("rows", cellarray);
            out.println(responcedata);





%>