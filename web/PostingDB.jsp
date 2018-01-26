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
    java.sql.Date sysdate = null;
    // java.util.Date enddate;
//java.sql.Date date = new java.sql.Date(new java.util.Date().getTime());
    JSONObject mysubdata = new JSONObject();
    JSONArray subarray = new JSONArray();
    Connection connect = null;
    Statement statement = null;
   
    ResultSet rs = null;

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

    int TOTALINH = 0;
    rs = statement.executeQuery(" select count(ga_accstat) from gaccount where ga_accstat='I'  ");
    while (rs.next()) {
        TOTALINH = rs.getInt(1);
    }


    String h = null;
    try {

        rs = statement.executeQuery(" select sysdate from sysdate");
        while (rs.next()) {
            // h = rs.getString(1);
            sysdate = rs.getDate(1);

        }

    } catch (Exception ex) {

        out.println("Unable to connect to database.");
        // table.getSelectedRow();
    }
  
    /*   if (dmax != null) {
    eDate = new SimpleDateFormat("dd-MM-yyyy").parse(dmax);
    
    }*/
    int count = TOTALINH;
    TOTALINH = TOTALINH + 1;
    String[] folno = new String[TOTALINH];
    String[] accno = new String[TOTALINH];
    String[] roomno = new String[TOTALINH];
    String[] arrival = new String[TOTALINH];
    String[] departure = new String[TOTALINH];
    String[] guestno = new String[TOTALINH];
    String[] name = new String[TOTALINH];
    String[] fol1 = new String[TOTALINH];
    String[] fol2 = new String[TOTALINH];



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
    rs = statement.executeQuery(" select gf_folno,gf_accno,gf_roomno,ga_arrival,ga_departure,ga_guestno from gfolio left join gaccount on (gfolio.gf_accno=gaccount.ga_accno)  where ga_accstat = 'I' and ga_guestno is not null order by gf_roomno ");
    while (rs.next()) {
        folno[i] = rs.getString(1); // เลือกประเภทรูมมาเก็บให้หมด
        accno[i] = rs.getString(2);
        roomno[i] = rs.getString(3);
        arrival[i] = rs.getString(4);
        departure[i] = rs.getString(5);
        guestno[i] = rs.getString(6);
        i++;
    }
    int j = 0, k = 0;
    while (j < i) {
        rs = statement.executeQuery(" select gn_fname||' '||gn_lname  from gaccount left join guestname on (guestname.gn_guestno=gaccount.ga_guestno)  where ga_guestno =  '" + guestno[j] + "'");
        while (rs.next()) {
            name[j] = rs.getString(1);

        }
        j++;
    }


    j = 0;
    while (j < i) {
        rs = statement.executeQuery(" select gfs_folbal  from gfolseq   where gfs_folno =  '" + folno[j] + "' and gfs_folseq = 1 ");
        while (rs.next()) {
            fol1[j] = rs.getString(1);

        }
        j++;
    }
    j = 0;
    while (j < i) {
        rs = statement.executeQuery(" select gfs_folbal  from gfolseq   where gfs_folno =  '" + folno[j] + "' and gfs_folseq = 2 ");
        while (rs.next()) {
            fol2[j] = rs.getString(1);

        }
        j++;
    }


    int y = 0;
    // String avall, tota, alloo1, allinh1;
    while (y < TOTALINH) {

        cell.add(0, roomno[y]);
        cell.add(1, folno[y]);
        cell.add(2, name[y]);
        cell.add(3, arrival[y]);
        cell.add(4, departure[y]);
        cell.add(5, fol1[y]);
        cell.add(6, fol2[y]);

        // cell.add(0, "kk");

        cellobj.put("cell", cell);
        cell.clear();
        cellarray.add(cellobj);
        y++;
    }
    responcedata.put("rows", cellarray);
    out.println(responcedata);





%>