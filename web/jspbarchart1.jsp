
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
<%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.axis.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import="org.jfree.chart.labels.*" %>
<%@ page  import="org.jfree.chart.plot.*" %>
<%@ page  import="org.jfree.chart.renderer.category.*" %>
<%@ page  import="org.jfree.chart.urls.*" %>
<%@ page  import="org.jfree.data.category.*" %>
<%@ page  import="org.jfree.data.general.*" %>
<%@page import="org.jfree.ui.ApplicationFrame"%>
<%@ include file="config.jsp"%>

<html>
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
        <!meta  http-equiv="refresh" content="1">
      
    <head>
<%
            final double[][] data = new double[][]{
                {210, 300, 320, 265, 299},
                {200, 304, 201, 201, 340}
            };

            final CategoryDataset dataset = DatasetUtilities.createCategoryDataset(
                    "Team ", "", data);
            JFreeChart chart = null;
            BarRenderer renderer = null;
            CategoryPlot plot = null;


            final CategoryAxis categoryAxis = new CategoryAxis("Match");
            final ValueAxis valueAxis = new NumberAxis("Run");
            renderer = new BarRenderer();

            plot = new CategoryPlot(dataset, categoryAxis, valueAxis, renderer);
            plot.setOrientation(PlotOrientation.VERTICAL);
            chart = new JFreeChart("Srore Bord", JFreeChart.DEFAULT_TITLE_FONT, plot, true);
           ChartPanel chartPanel = new ChartPanel(chart);
/*chartPanel.setPreferredSize(new java.awt.Dimension(500, 270));

ApplicationFrame f=new ApplicationFrame("Chart");
f.setContentPane(chartPanel);
f.pack();
f.setVisible(true);*/



            chart.setBackgroundPaint(new Color(249, 231, 236));

            Paint p1 = new GradientPaint(
                    0.0f, 0.0f, new Color(16, 89, 172), 0.0f, 0.0f, new Color(201, 201, 244));
            renderer.setSeriesPaint(1, p1);

            Paint p2 = new GradientPaint(
                    0.0f, 0.0f, new Color(255, 35, 35), 0.0f, 0.0f, new Color(255, 180, 180));
            renderer.setSeriesPaint(2, p2);

            plot.setRenderer(renderer);
        /*    String f1=path+"\\images\\chart.jpg";
ChartUtilities.saveChartAsJPEG(new File(f1), chart, 600, 300);*/


            try {
                final ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
                final File file1 = new File(path+"\\images\\barchart1.png");
                ChartUtilities.saveChartAsPNG(file1, chart, 600, 400, info);
            } catch (Exception e) {
                out.println(e);
            }
%>


    </head>
    
    <body>
        <img src="images/barchart1.png" WIDTH="600" HEIGHT="400" BORDER="0" >
    </body>
</html>
