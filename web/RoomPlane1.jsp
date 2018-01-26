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

  



<%@page import="javax.swing.JFrame"%>
<%@page import="org.jfree.data.time.Month"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page  import="java.util.Calendar" %>
<%@ page  import="java.util.Date" %>
<%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<%@ page  import="org.jfree.chart.ChartFactory" %>
<%@ page  import="org.jfree.chart.ChartPanel" %>
<%@ page  import="org.jfree.chart.JFreeChart" %>
<%@ page  import="org.jfree.data.category.IntervalCategoryDataset" %>
<%@ page  import="org.jfree.data.gantt.Task" %>
<%@ page  import="org.jfree.data.gantt.TaskSeries" %>
<%@ page  import="org.jfree.data.gantt.TaskSeriesCollection" %>
<%@ page  import="org.jfree.data.time.SimpleTimePeriod" %>
<%@ page  import="org.jfree.ui.ApplicationFrame" %>
<%@ page  import="org.jfree.ui.RefineryUtilities" %>

<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.axis.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import="org.jfree.chart.labels.*" %>
<%@ page  import="org.jfree.chart.plot.*" %>
<%@ page  import="org.jfree.chart.renderer.category.*" %>
<%@ page  import="org.jfree.chart.urls.*" %>
<%@ page  import="org.jfree.data.category.*" %>
<%@ page  import="org.jfree.data.general.*" %>
<%@ page import="java.sql.*" %>
<%@ include file="config.jsp"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%




            Connection connect = null;
            Statement statement = null;
            ResultSet rs = null;

            String code = "";
           
            String s;

            s = request.getParameter("s");
            String[] roomno = new String[700];
            String[] rstatus = new String[700];
            Date[] avai = new Date[700];
            TaskSeriesCollection dataset = new TaskSeriesCollection();
            TaskSeries unavailable = new TaskSeries("Unavailable");
            final TaskSeries s1 = new TaskSeries("Out Of Order");
            final TaskSeries s2 = new TaskSeries("Occupied");
            final TaskSeries s3 = new TaskSeries("Vacant Clean");
            final TaskSeries s4 = new TaskSeries("Vacant Dirty");

            //   DefaultCategoryDataset dataset = new DefaultCategoryDataset();
            int count;
            String subject;
            java.sql.Date startdate = null, enddate = null;
            try {
                Class.forName("org.postgresql.Driver").newInstance();
                connect = DriverManager.getConnection(url, user1, pw);
                statement = connect.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            } catch (Exception ex) {
            }


            try {

                rs = statement.executeQuery(" select sysdate,sysdate+90 from sysdate");
                while (rs.next()) {
                    // h = rs.getString(1);
                    startdate = rs.getDate(1);
                    enddate = rs.getDate(2);
                }
            } catch (Exception ex) {
            }
            java.util.Date eDate = new java.util.Date(enddate.getTime());
            java.util.Date sDate = new java.util.Date(startdate.getTime());


        %>


    </head>

    <body><%


        %>


        <%



            code = s;

            int k = 0;

            // select room num
            try {

                rs = statement.executeQuery(" select rs_roomno,rs_statusno,rs_available from roomstatus where rs_roomno ='" + s + "'and  rs_available > '" + startdate + "'");
                while (rs.next()) {
                    // h = rs.getString(1);
                    roomno[k] = rs.getString(1);
                    rstatus[k] = rs.getString(2);
                    avai[k] = rs.getDate("rs_available");
                    k++;
                }
            } catch (Exception ex) {
                out.println(ex);
            }
            int i = 0;
            while (k > i) {
                if (rstatus[i].equals("OOO")) {
                    s1.add(new Task(roomno[i], sDate, avai[i]));
                } else if (rstatus[i].equals("OCC")) {
                    s2.add(new Task(roomno[i], sDate, avai[i]));
                } else if (rstatus[i].equals("VAC")) {
                    s3.add(new Task(roomno[i], sDate, avai[i]));
                } else if (rstatus[i].equals("VDT")) {
                    s4.add(new Task(roomno[i], sDate, avai[i]));
                }

                i++;
            }


            // final TaskSeriesCollection collection = new TaskSeriesCollection();
            dataset.add(s1);
            dataset.add(s2);
            dataset.add(s3);
            dataset.add(s4);


            JFrame frame = new JFrame("MeetNow!");
            JFreeChart bar = ChartFactory.createGanttChart("", "Room", "Date", dataset, false, true, false);

     CategoryPlot plot = (CategoryPlot) bar.getPlot();
          
  //      plot.getDomainAxis().setMaxCategoryLabelWidthRatio(10.0f);
        CategoryItemRenderer renderer = plot.getRenderer();
        renderer.setSeriesPaint(0, Color.BLACK);
         renderer.setSeriesPaint(1, Color.RED);
          renderer.setSeriesPaint(2, Color.YELLOW);
           renderer.setSeriesPaint(3, Color.BLUE);

      
            plot.setRenderer(renderer);


            String fileName = "images/barg.png";
            String file = application.getRealPath("/") + fileName;
            try {
                FileOutputStream fileOut = new FileOutputStream(file);
                ChartUtilities.writeChartAsPNG(fileOut, bar, 900, 300);
                //response.getOutputStream().close();
            } catch (IOException e) {
                out.print(e);
            }



        %>
        <form method="post" action="RoomPlane.jsp">
            <table>
              
                <tr>   <td> <p style=" color:red " >Occupied </p> </td>
                 <td> <p style=" color:black " >Out Of Order </p> </td>
                  <td> <p style=" color:blue " >Vacant Dirty </p> </td>
                   <td> <p style=" color:yellow " >Vacant Clean </p> </td><td colspan="2" align="center">
                       
                            <input type=button value="Back" onCLick="history.back()"/></td></tr>

            </table>
        </form>
        <img src="images/barg.png"  alt="subject Bar Chart" /> </body> </html> 
</body>
</html>

