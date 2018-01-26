
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
<%@page import="org.jfree.chart.axis.ValueAxis"%>
<%@page import="org.jfree.chart.axis.NumberAxis"%>
<%@page import="org.jfree.chart.axis.CategoryAxis"%>
<%@page import="java.awt.Paint"%>
<%@page import="java.awt.GradientPaint"%>
<%@page import="java.awt.Color"%>
<%@page import="org.jfree.chart.renderer.category.BarRenderer"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%@page import="java.io.*" %> 

<%@page import="org.jfree.data.category.*" %>
<%@page import="org.jfree.chart.*" %> 
<%@page import="org.jfree.chart.plot.*" %>  
<%@ page import="java.sql.*,java.util.ArrayList,net.sf.json.*" %>
<%@ page language = "java" import = "java.util.*, java.lang.*,
         java.text.*, java.text.DateFormat.*,java.util.Locale " %>
<%@ include file ="config.jsp"%>
<html> 
    <body> 
        <%
            Connection connect = null;
            Statement statement = null;
            ResultSet rs = null;
            DefaultCategoryDataset dataset = new DefaultCategoryDataset();
            int count;
            String subject;
            try {
                Class.forName("org.postgresql.Driver").newInstance();
                connect = DriverManager.getConnection(url, user1, pw);
                statement = connect.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);


            } catch (Exception ex) {

                out.println("exeSQL Error : " + ex.getMessage());
            }
            rs = statement.executeQuery(" select rt_id,rt_max from roomtype ");
            while (rs.next()) {
                count = rs.getInt("rt_max");
                subject = rs.getString(1); // เลือกประเภทรูมมาเก็บให้หมด
                dataset.addValue(count, "enrollment count statistics", subject);

            }
            BarRenderer renderer = null;
            CategoryPlot plot = null;
            JFreeChart chart = null;
            final CategoryAxis categoryAxis = new CategoryAxis("Match");
            final ValueAxis valueAxis = new NumberAxis("Run");
            renderer = new BarRenderer();



            plot = new CategoryPlot(dataset, categoryAxis, valueAxis, renderer);
            plot.setOrientation(PlotOrientation.HORIZONTAL);
            chart = new JFreeChart(" ", JFreeChart.DEFAULT_TITLE_FONT, plot, true);

            chart.setBackgroundPaint(new Color(249, 231, 236));

            Paint p1 = new GradientPaint(0.0f, 0.0f, new Color(16, 89, 172), 0.0f, 0.0f, new Color(201, 201, 244));

            renderer.setSeriesPaint(1, p1);

            Paint p2 = new GradientPaint(0.0f, 0.0f, new Color(255, 35, 35), 0.0f, 0.0f, new Color(255, 180, 180));

            renderer.setSeriesPaint(2, p2);


            plot.setRenderer(renderer);



            JFreeChart bar = ChartFactory.createBarChart("Enrollment Chart", "subject", "Count", dataset, PlotOrientation.HORIZONTAL, true, false, false);
            // bar.setBackgroundPaint(new Color(249, 231, 236));


            String fileName = "/images/bar2.png";
            String file = application.getRealPath("/") + fileName;
            try {
                FileOutputStream fileOut = new FileOutputStream(file);
                ChartUtilities.writeChartAsPNG(fileOut, bar, 300, 300);
                //response.getOutputStream().close();
            } catch (IOException e) {
                out.print(e);
            }


            //BarRenderer barRenderer = (BarRenderer) plot.; 
            // barRenderer.setSeriesPaint(0, Color.gray);
java.sql.Date startdate = null, enddate = null;
            rs = statement.executeQuery(" select sysdate,sysdate+90 from sysdate");
            while (rs.next()) {
                // h = rs.getString(1);
                startdate = rs.getDate(1);
                enddate = rs.getDate(2);
            }
            
    rs = statement.executeQuery(" select rs.roomno, rs.statusno, st.stattype, rs.availdate"
      + " from roomstatus rs inner join status st on st.statusno = rs.statusno"
      + " where roomno between :fromroom and :toroom into :roomno, :rmstatus, :stattype, :availdate ");
            while (rs.next()) {
              //  roomtypeno[i] = rs.getString(1); // เลือกประเภทรูมมาเก็บให้หมด
              //  i++;
            }
        %> 
        <img src="images/bar2.png"  alt="subject Bar Chart" /> </body> </html> 