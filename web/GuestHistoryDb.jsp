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
    rs = statement.executeQuery(" select count(ht_guestno) from HISTRAN   ");
    while (rs.next()) {
        TOTALINH = rs.getInt(1);
    }


    String h = null;
   

    /*   if (dmax != null) {
    eDate = new SimpleDateFormat("dd-MM-yyyy").parse(dmax);
    
    }*/
    int count = TOTALINH;
    TOTALINH = TOTALINH + 1;
   
    



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

    rs = statement.executeQuery("select ht_guestno,ga_accno,gn_fname||gn_lname,gi_natno,gi_vipno,gi_telno   "
            + "from  histran left join guestname on (gn_guestno=ht_guestno) left join guestinfo on   "
            + "(gi_guestno=ht_guestno) left join gaccount on (ht_guestno=ga_guestno)group by "
            + "ht_guestno,gn_fname,gn_lname,ga_accno,gi_natno,gi_vipno,gi_telno ");
          
        

    // String avall, tota, alloo1, allinh1;
    while (rs.next()) {

        cell.add(0, rs.getString("ht_guestno"));
        cell.add(1, rs.getString("ga_accno"));
        cell.add(2, rs.getString(3));
        cell.add(3, rs.getString("gi_natno"));
        cell.add(4, rs.getString("gi_vipno"));
        cell.add(5, rs.getString("gi_telno"));
      

        // cell.add(0, "kk");

        cellobj.put("cell", cell);
        cell.clear();
        cellarray.add(cellobj);
       
    }
    responcedata.put("rows", cellarray);
    out.println(responcedata);





%>