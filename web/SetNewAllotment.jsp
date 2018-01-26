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
        window.opener.location.href="SetAllotment.jsp";

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
          //          String head1 = mrequest.getParameter("code");
           //         String code = new String(head1.getBytes("ISO8859_1"), "utf-8");

                    String agent1 = mrequest.getParameter("agent");
                    String agent = new String(agent1.getBytes("ISO8859_1"), "utf-8");

                    String room1 = mrequest.getParameter("room");
                    String room = new String(room1.getBytes("ISO8859_1"), "utf-8");

                    String cutoff1 = mrequest.getParameter("cutoff");
                    String cutoff = new String(cutoff1.getBytes("ISO8859_1"), "utf-8");

                 
                    String dstart1 = mrequest.getParameter("dateInput");
                    String dateInput = new String(dstart1.getBytes("ISO8859_1"), "utf-8");

                    String dend1 = mrequest.getParameter("dend");
                    String dend = new String(dend1.getBytes("ISO8859_1"), "utf-8");


                    if (agent.equals("")) {
                        errors.add("check agent");
                    }
                      if (cutoff.equals("")) {
                        cutoff = "0";
                    }
                    if (room.equals("")) {
                        room = "0";
                    }
                  


                    if (errors.size() > 0) {
    %><%@include file="ckError.jsp" %><% } else {
try{
         sql = "insert into allotment (ag_id,am_dstart,am_dend,am_qty,cutoff1) VALUES ( '" + agent + "','" + dateInput + "','" + dend + "','" + room + "','" + cutoff + "' )";

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
                        <div align="left"><strong>Allotment</strong></div>
                    </div></td>
            </tr>

          
                 <tr><td>Agent</td>  <td width="75%">
                    <select name="agent" id="Txt-Field" onchange="id.value=this.value; name.value=this.options[selectedIndex].text;">

                        <%
                                            String j1 = "", j2 = "";
                                            sql = "select * from agent  ";
                                            rs = stmt.executeQuery(sql);
                                            while (rs.next()) {
                                                j1 = rs.getString("a_id");
                                                j2 = rs.getString("a_name");

                        %>

                        <option value="<%=j1%>" name="agent"  ><%=j2%></option>

                        <%    }
                        %>


                    </select>


                </td></tr>

                
            <tr>
                <td>Start Date</td>
                <td><input type="text" name="dateInput" id="dateInput" />
                    </td>
            </tr>
            <tr>
                <td>End Date</td>
                <td><input id="datepicker" type="text" name="dend" />
                    </td>
            </tr>
            <tr>
                <td>Room Qty</td>
                <td><input type="number" name="room"  />
                    </td>
            </tr>
              <tr>
                <td>Cut off days</td>
                <td><input type="number" name="cutoff"  />
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



