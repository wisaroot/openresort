

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
            }} catch (Exception ex) {

            }
java.util.Date eDate = new java.util.Date(enddate.getTime());
java.util.Date sDate = new java.util.Date(startdate.getTime());
            TaskSeriesCollection dataset = new TaskSeriesCollection();
            TaskSeries unavailable = new TaskSeries("Unavailable");
            final TaskSeries s1 = new TaskSeries("Scheduled");
            s1.add(new Task("Write Proposal", sDate, eDate));
            s1.add(  new Task("Obtain Approval", sDate, eDate));
            s1.add(new Task("Requirements Analysis", sDate, eDate));
            final TaskSeries s2 = new TaskSeries("Actual");
            s2.add(new Task("Write Proposal", sDate, eDate));
            s2.add(new Task("Obtain Approval", sDate, eDate));
            s2.add(new Task("Requirements Analysis", sDate, eDate));
           // final TaskSeriesCollection collection = new TaskSeriesCollection();
            dataset.add(s1);
            dataset.add(s2);

    /*        Task room1 = new Task("Meeting Room 1",
                    new GregorianCalendar(2009, Month.DECEMBER, 1, 7, 00).getTime(),
                    new GregorianCalendar(2009, Month.DECEMBER, 1, 18, 00).getTime());
            unavailable.add(room1);

            room1.addSubtask(new Task("Meeting 1",
                    new GregorianCalendar(2009, Month.DECEMBER, 1, 9, 00).getTime(),
                    new GregorianCalendar(2009, Month.DECEMBER, 1, 16, 00).getTime()));

            Task room2 = new Task("Meeting Room 2",
                    new GregorianCalendar(2009, Month.DECEMBER, 1, 7, 00).getTime(),
                    new GregorianCalendar(2009, Month.DECEMBER, 1, 18, 00).getTime());
            unavailable.add(room2);

            room2.addSubtask(new Task("Meeting 2",
                    new GregorianCalendar(2009, Month.DECEMBER, 1, 10, 00).getTime(),
                    new GregorianCalendar(2009, Month.DECEMBER, 1, 11, 00).getTime()));

            room2.addSubtask(new Task("Meeting 3",
                    new GregorianCalendar(2009, Month.DECEMBER, 1, 14, 00).getTime(),
                    new GregorianCalendar(2009, Month.DECEMBER, 1, 15, 00).getTime()));
            room2.addSubtask(new Task("Meeting 4",
                    new GregorianCalendar(2009, Month.DECEMBER, 1, 16, 00).getTime(),
                    new GregorianCalendar(2009, Month.DECEMBER, 1, 18, 00).getTime()));
*/
            //dataset.add(unavailable);





            //   plot.setOrientation(PlotOrientation.HORIZONTAL);
            // chart = new JFreeChart(" ", JFreeChart.DEFAULT_TITLE_FONT, plot, true);

            JFrame frame = new JFrame("MeetNow!");
            JFreeChart bar = ChartFactory.createGanttChart("", "Room", "Date", dataset, false, true, false);




            String fileName = "images/barg.png";
            String file = application.getRealPath("/") + fileName;
            try {
                FileOutputStream fileOut = new FileOutputStream(file);
                ChartUtilities.writeChartAsPNG(fileOut, bar, 300, 300);
                //response.getOutputStream().close();
            } catch (IOException e) {
                out.print(e);
            }
        %>


    </head>

    <body>
        <img src="images/barg.png"  alt="subject Bar Chart" /> </body> </html> 
</body>
</html>

