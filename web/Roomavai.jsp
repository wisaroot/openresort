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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>





    <body>


        <%
 String[][][] col1 = new String[40][91][4];
                    java.sql.Date startdate = null, enddate = null;
             
                    Connection connect = null;
                    Statement statement = null;
                    String[] roomtypeno = new String[50];
                    ResultSet rs = null;
                    try {
                        Class.forName("org.postgresql.Driver").newInstance();
                        connect = DriverManager.getConnection(url, user1, pw);
                        statement = connect.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);


                    } catch (Exception ex) {

                        out.println("exeSQL Error : " + ex.getMessage());
                    }

                    int count = 0;

                    int ii = 0;

                    String h = null;
                    try {


                        rs = statement.executeQuery("Select * FROM country");
                        rs = statement.executeQuery(" select sysdate,sysdate+31 from sysdate");
                        while (rs.next()) {
                            // h = rs.getString(1);
                            startdate = rs.getDate(1);
                            enddate = rs.getDate(2);
                        }

                    } catch (Exception ex) {

                        out.println("Unable to connect to database.");
                        // table.getSelectedRow();
                    }

                    int i = 0;

                    rs = statement.executeQuery(" select rt_id from roomtype ");

                    while (rs.next()) {
                        roomtypeno[i] = rs.getString(1); // เลือกประเภทรูมมาเก็บให้หมด
                        i++;
                    }
                    int j = 0;

                    String roomt;
                    while (j < i) {
                        ii=0;
                        java.util.Date sDate = new java.util.Date(startdate.getTime());
                        java.util.Date eDate = new java.util.Date(enddate.getTime());
                        roomt = roomtypeno[j];
                        out.println(roomt);
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
                            rs = statement.executeQuery("select count (distinct fol.gf_roomno)"
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
                            out.println(AVAIL);
                            
                    
                              
                             

                              col1[j][ii][ 0] = "av";
                    col1[j][ii][ 1] = "bk";
                    col1[j][ii][ 2] = "in";
                      if (j == 0) {
                        col1[j][ii][3] = "nowMMDDYYYY";
                    }
out.println(col1[j][ii][ 1]+ii);
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
                    }

        %>
    </body>
</html>
