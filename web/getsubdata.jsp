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
 
<%@ page import="java.sql.*,java.util.ArrayList,net.sf.json.*" %>
<%@ include file ="config.jsp"%>
<%
            String id = request.getParameter("id");
            String rows = request.getParameter("rows");
            String pageno = request.getParameter("page");
            String cpage = pageno;


            JSONObject mysubdata = new JSONObject();
            JSONArray subarray = new JSONArray();
            Connection connect = null;
            Statement statement = null;

            ResultSet rs = null;
          
            Class.forName("org.postgresql.Driver").newInstance();
            connect = DriverManager.getConnection(url, user1, pw);
            statement = connect.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

            rs = statement.executeQuery("Select * FROM country");

            int count = 0;
            rs.last();
            count = rs.getRow();

            int pageval = 0;
            pageval = (count / Integer.parseInt(rows));

            int limitstart = 0;

            limitstart = (Integer.parseInt(rows) * Integer.parseInt(pageno)) - Integer.parseInt(rows);
            int total = count / Integer.parseInt(rows);
            String totalrow = String.valueOf(total + 1);

            rs = statement.executeQuery("Select * FROM country");

            JSONObject responcedata = new JSONObject();
            net.sf.json.JSONArray cellarray = new net.sf.json.JSONArray();
            String aa = String.valueOf(count);
            responcedata.put("total", totalrow);
            responcedata.put("page", cpage);
            responcedata.put("records", aa);

            net.sf.json.JSONArray cell = new net.sf.json.JSONArray();
            net.sf.json.JSONObject cellobj = new net.sf.json.JSONObject();

            int ii = 1;
            while (rs.next()) {
                cellobj.put("id", "" + ii);

                //cell.add(rs.getString(1));
                cell.add(rs.getString(1));
                cell.add(rs.getString(2));


                cellobj.put("cell", cell);
                cell.clear();
                cellarray.add(cellobj);
                ii++;
            }
            responcedata.put("rows", cellarray);
            out.println(responcedata);
%>