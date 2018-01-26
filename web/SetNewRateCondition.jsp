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
 <%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.util.*,javazoom.upload.*" errorPage="" %>


<%@ include file ="config.jsp"%>
<SCRIPT TYPE="text/javascript">
    function submitAndClose() {
        window.opener.location.href="SetRateCondition.jsp";

        window.close();
    }

</SCRIPT>
<link rel="stylesheet" type="text/css" href="css/smoothness/jquery-ui-1.7.2.custom.css">
<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom.min.js"></script>
<script type="text/javascript">
$(function(){
	// แทรกโค้ต jquery
	$("#dateInput").datepicker({ dateFormat: 'yy-mm-dd' });
         $( "#datepicker" ).datepicker({ dateFormat: 'yy-mm-dd' });
        $("#dend").datepicker();
        $('.datepicker').datepicker(options);

});
</script>
<style type="text/css">
.ui-datepicker{
	width:150px;
	font-family:tahoma;
	font-size:11px;
	text-align:center;
}
</style>
<body>
    <%
                Class.forName("org.postgresql.Driver");
                Connection con = null;
                con = DriverManager.getConnection(url, user1, pw);
                Statement stmt = con.createStatement();
                String sql;
                ResultSet rs = null;
                Vector errors = new Vector();
                if (MultipartFormDataRequest.isMultipartFormData(request)) {
                    MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
                    String head1 = mrequest.getParameter("code");
                    String co = new String(head1.getBytes("ISO8859_1"), "utf-8");

                    String descr1 = mrequest.getParameter("desc");
                    String des = new String(descr1.getBytes("ISO8859_1"), "utf-8");

                    String ncharge1 = mrequest.getParameter("ncharge");
                    String ncharge = new String(ncharge1.getBytes("ISO8859_1"), "utf-8");

                    String nfree1 = mrequest.getParameter("nfree");
                    String nfree = new String(nfree1.getBytes("ISO8859_1"), "utf-8");

                    String dmin1 = mrequest.getParameter("dmin");
                    String dmin = new String(dmin1.getBytes("ISO8859_1"), "utf-8");

                    String dmax1 = mrequest.getParameter("dmax");
                    String dmax = new String(dmax1.getBytes("ISO8859_1"), "utf-8");

                    String dstart1 = mrequest.getParameter("dateInput");
                    String dateInput = new String(dstart1.getBytes("ISO8859_1"), "utf-8");

                    String dend1 = mrequest.getParameter("dend");
                    String dend = new String(dend1.getBytes("ISO8859_1"), "utf-8");


                    if (co.equals("")) {
                        errors.add("check code");
                    }
                    if (des.equals("")) {
                        errors.add("check details");
                    }
                   

                    if (errors.size() > 0) {
    %><%@include file="ckError.jsp" %><% } else {
try{
         sql = "insert into ratecondition (rct_Id,rct_Descr,rct_chargenight,rct_freenight,rct_minday,rct_maxday,rct_startdate,rct_enddate) VALUES ( '" + co + "','" + des + "','" + ncharge + "','" + nfree + "','" + dmin + "','" + dmax + "','" + dateInput + "','" + dend + "' )";

         int row = stmt.executeUpdate(sql);
         }catch(Exception e){   out.println(e);
             }

    %>
    <script type="text/javascript" language="JavaScript">
        submitAndClose();
    </script>


    <%
            //response.sendRedirect("clip.jsp");
        }
    } else {
    %>
    <form method="post" enctype="multipart/form-data">
        <table width="60%" border="1" align="center" cellpadding="0" style=" border-color: #00F" >
            <tr>
                <td colspan="2"><div align="center" style="">
                        <div align="left"><strong>RateCondition</strong></div>
                    </div></td>
            </tr>

            <tr>
                <td>Code</td>
                <td><input type="text" name="code"  />
                    </td>
            </tr>
            <tr>
                <td>Description</td>
                <td><input type="text" name="desc"  />
                    </td>
            </tr>
            <tr><td colspan="4">Night</td> </tr>
            <tr>
                <td>Charge</td>
                <td><input type="number" name="ncharge"  />
                    </td>
                <td>Free</td>
                <td><input type="number" name="nfree"  />
                    </td>
            </tr>
            <tr><td colspan="4">Day</td> </tr>
            <tr>
                <td>Min</td>
                <td><input type="number" name="dmin"  />
                    </td>
                <td>Max</td>
                <td><input type="number" name="dmax"  />
                    </td>
            </tr>
                 <tr><td colspan="4">Date</td> </tr>
            <tr>
                <td>Start</td>
                <td><input type="text" name="dateInput" id="dateInput" />
                    </td>
            </tr>
            <tr>
                <td>End</td>
                <td><input id="datepicker" type="text" name="dend" />
                    </td>
            </tr>

            <tr>
                <td colspan="2"><div align="center">
                        <input type="Submit" name="Submit" value="OK"  />
                        <input name="Reset" type="reset" value="reset" />
                    </div></td>
            </tr>
        </table>
    </form>
    <%}%>
</body>



