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
 

<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="de.laures.cewolf.*"%>
<%@page import="de.laures.cewolf.tooltips.*"%>
<%@page import="de.laures.cewolf.links.*"%>
<%@page import="org.jfree.data.*"%>
<%@page import="org.jfree.data.time.*"%>
<%@page import="org.jfree.data.gantt.*"%>
<%@page import="org.jfree.chart.*"%>
<%@page import="org.jfree.chart.plot.*"%>
<%@page import="org.jfree.data.category.*"%>
<%@page import="org.jfree.data.general.*"%>
<%@page import="org.jfree.data.xy.*"%>
<%@page import="java.awt.*" %>
<%@page import="de.laures.cewolf.taglib.CewolfChartFactory" %>
<%@page import="org.jfree.chart.event.ChartProgressListener" %>
<%@page import="org.jfree.chart.event.ChartProgressEvent" %> 
<%@page pageEncoding="UTF-8"%>
<%@taglib uri='/WEB-INF/cewolf.tld' prefix='cewolf' %>
<%@  include file ="config.jsp"%>
      Class.forName(driver);
      Connection con = DriverManager.getConnection(url, user, pw);
      Statement stmt = con.createStatement();
      String sql;
      sql ="select * from employee where employee_id=1001";
      ResultSet rs=null;
      rs=stmt.executeQuery(sql); 
   
   class DatasetMonth implements DatasetProducer{

    int[] PURCHASE_ORDER= new int[12];

    public DatasetMonth(int[] data){
        for(int i=0;i<12;i++) {
            PURCHASE_ORDER[i]=data[i];
        }
    }
    public Object produceDataset(Map params) {
      final String[] categories = {"มกราคม", "กุมภาพันธ", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน", "กรกฎาคม", "สิงหาคม", "กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม"};
      final String[] seriesNames = {"มกราคม", "กุมภาพันธ", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน", "กรกฎาคม", "สิงหาคม", "กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม"};
      final Integer[][] startValues = new Integer[seriesNames.length][categories.length];
      final Integer[][] endValues = new Integer[seriesNames.length][categories.length];

      for (int series = 0; series < seriesNames.length; series++) {
        for (int i = 0; i < categories.length; i++) {
          startValues[i][i] = 0;
          endValues[i][i] = PURCHASE_ORDER[i];
        }
      }
      DefaultIntervalCategoryDataset ds =
        new DefaultIntervalCategoryDataset(seriesNames, categories, startValues, endValues);
      return ds;
    }
    public String getProducerId() {
      return "CategoryDataProducer";
    }
    public boolean hasExpired(Map params, Date since) {
      return false;
    }
  }

    DatasetProducer categoryData = new DatasetProducer() {
    public Object produceDataset(Map params) {
      final String[] categories = { "apples", "pies", "bananas", "oranges" };
      final String[] seriesNames = { "8.00", "Helga", "Franz", "16.00" };
      final Integer[][] startValues = new Integer[seriesNames.length][categories.length];
      final Integer[][] endValues = new Integer[seriesNames.length][categories.length];
      for (int series = 0; series < seriesNames.length; series++) {
        for (int i = 0; i < categories.length; i++) {
          int y = (int) (Math.random() * 10 + 1);
          startValues[series][i] = new Integer(y);
          endValues[series][i] = new Integer(y + (int) (Math.random() * 10));
        }
      }
      DefaultIntervalCategoryDataset ds =
        new DefaultIntervalCategoryDataset(seriesNames, categories, startValues, endValues);
      return ds;
    }
    public String getProducerId() {
      return "CategoryDataProducer";
    }
    public boolean hasExpired(Map params, Date since) {
      return false;
    }
  };
  pageContext.setAttribute("categoryData", categoryData);
     
 %>
    <table width="100%">
      <tr>
        <td width="201" background="file:///C|/Users/SamSung/AppData/Local/Microsoft/Windows/Temporary Internet Files/Content.IE5/XNHEMA05/56235623.jpg">
          <div align="center">
            <span class="style66">ส่วนจัดการตรวจสอบสต๊อกสินค้า</span>
          </div>
        </td>
        <td width="365">
          <embed src="http://www.clocklink.com/clocks/5003-green.swf?TimeZone=ICT&amp;Place=&amp;DateFormat=yyyy+/+mm+/+dd+DDD&amp;TimeFormat=hh:mm:ss+TT&amp;"  width="240" height="20" align="right" wmode="transparent" type="application/x-shockwave-flash"></embed>
        </td>
      </tr>
    </table>
    <table>
      <tr>
        <td colspan="2"></td>
        </tr>
      <tr>
        <td colspan="2" valign="baseline" class="style43">
          <div align="center">
            <strong>ข้อมูลของวันนี้</strong>
          </div>
        </td>
      </tr>
      <tr>
        <td valign="baseline" class="style43">
          <div align="center">
            <strong>ซื้อเข้า</strong>
          </div>
        </td>   
      </tr>
             <tr>
        <td>
          <cewolf:chart id="verticalBar3D"
          title="รายงานการซื้อเข้า"
          type="verticalBar3D"
          xaxislabel="ชั่วโมงที่"
          yaxislabel="จำนวนน้ำหนัก">
             <cewolf:data>
                   <cewolf:producer id="categoryData" />
             </cewolf:data>
          </cewolf:chart>
           <cewolf:img chartid="verticalBar3D"
           renderer="/cewolf"
           width="600"
           height="300"/>
         </td>
      </tr>
      <tr>
        <td valign="baseline" class="style43">
          <div align="center">
            <strong>ขายออก</strong>
            </div>
          </td>
      </tr>
       <tr>
        <td>
          <cewolf:chart id="verticalBar3D"
          title="รายงานการขายออก"
          type="verticalBar3D"
          xaxislabel="ชั่วโมงที่"
          yaxislabel="จำนวนน้ำหนัก">
             <cewolf:data>
                   <cewolf:producer id="categoryData" />
             </cewolf:data>
          </cewolf:chart>
           <cewolf:img chartid="verticalBar3D"
           renderer="/cewolf"
           width="600"
           height="300"/>
         </td>
      </tr>
            <tr>
        <td colspan="2" valign="baseline" class="style43">
          <div align="center">
            <strong>ข้อมูลของเดือนนี้</strong>
          </div>
        </td>
      </tr>
      <tr>
        <td valign="baseline" class="style43">
          <div align="center">
            <strong>ซื้อเข้า</strong>
          </div>
        </td>
      </tr>
       <tr>
        <td>
          <cewolf:chart id="verticalBar3D"
          title="รายงานการซื้อเข้า"
          type="verticalBar3D"
          xaxislabel="วันที่"
          yaxislabel="จำนวนน้ำหนัก">
             <cewolf:data>
                   <cewolf:producer id="categoryData" />
             </cewolf:data>
          </cewolf:chart>
           <cewolf:img chartid="verticalBar3D"
           renderer="/cewolf"
           width   ="600"
           height  ="300"/>
         </td>
      </tr>
      <tr>
        <td valign="baseline" class="style43">
          <div align="center">
            <strong>ขายออก</strong>
          </div>
         </td>
      </tr>
              <tr>
        <td>
          <cewolf:chart id="verticalBar3D"
          title="รายงานการขายออก"
          type="verticalBar3D"
          xaxislabel="วันที่"
          yaxislabel="จำนวนน้ำหนัก">
             <cewolf:data>
                   <cewolf:producer id="categoryData" />
             </cewolf:data>
          </cewolf:chart>
           <cewolf:img chartid="verticalBar3D"
           renderer="/cewolf"
           width="600"
           height="300"/>
         </td>
      </tr>
    </table>