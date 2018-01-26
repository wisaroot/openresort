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

  <%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <%@ include file ="config.jsp"%>
    <link rel="stylesheet" type="text/css" href="css/smoothness/jquery-ui-1.7.2.custom.css"></link>
    <script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.7.2.custom.min.js"></script>
    <script type="text/javascript">
        $(function(){
            // แทรกโค้ต jquery
            $("#dateInput").datepicker({ dateFormat: 'yy-mm-dd' });
            $( "#datepicker" ).datepicker({ dateFormat: 'yy-mm-dd' });
            $("#txtVol1").datepicker({ dateFormat: 'yy-mm-dd' });
          
            $("#txtVol").datepicker({ dateFormat: 'yy-mm-dd' });
            $("#datepicker").datepicker(options);
         
        
        });
    </script>
    <script language="JavaScript">
        function windowOpen() {
            var myWindow=window.open('SelectOOO.jsp','windowRef','width=500,height=500');
            if (!myWindow.opener) myWindow.opener = self;
        }
    </script>

    <script language="javascript">


        function sum(){
    

            if ((document.test.status.value=="OOO")){
    
                document.test.txtVol.disabled = false;
                document.test.txtVol1.disabled = false;
                document.test.txtVol2.disabled = false;
                document.test.txtVol3.disabled = false;
                document.test.openPopup.disabled = false;  
                document.test.dateInput.disabled = true;
                //obj.status.value=obj.t1.value;
            }else { 
                document.test.txtVol.value="";
                document.test.txtVol1.value="";
                document.test.txtVol2.value="";
                document.test.txtVol3.value="";
                document.test.txtVol.disabled = true;
                document.test.txtVol1.disabled = true;
                document.test.txtVol2.disabled = true;
                document.test.txtVol3.disabled = true;
                document.test.openPopup.disabled = true;  
                document.test.dateInput.disabled = false;

            }

        }
    </script> 
    <body>
        <%
            Statement stmt = null;
            ResultSet rs = null;
            Connection con = null;

            String sql = "";
            String id = request.getParameter("id");
            String room = "";
            String status = "";
            String available = "", oostart = "", ooend = "", codeoo = "",descroo="";
            String remark = "";
            String aa = "false";



            String QueryString1 = "";
            //  if (request.getParameter("submit") != null) {
            try {
                Class.forName("org.postgresql.Driver");
                con = DriverManager.getConnection(url, user1, pw);
            } catch (Exception ex) {

                out.println("exeSQL Error : " + ex.getMessage());
            }
            /*      Class.forName("sun.jdbc.odbc.JdbcOdbc");
            <b style="color:black;background-color:#a0ffff">Connection</b> con=DriverManager.getConnection("jdbc:odbc:MyDatabase","system","database");
             */

            if ((id != null) && (request.getParameter("submit") == null)) {

                try {

                    stmt = con.createStatement();
                    QueryString1 = "Select * FROM roomstatus WHERE rs_roomno ='" + id + "'";
                    rs = stmt.executeQuery(QueryString1);
                    while (rs.next()) {


                        room = rs.getString(1);
                        status = rs.getString(2).trim();
                        available = rs.getString(3);
                        remark = rs.getString(4);


                    }
                    if(status.equals("OOO")){
                     QueryString1 = "Select ro_start,ro_end,ro_ooono,oc_descr FROM roomooo left join ooocode on ( oc_id=ro_ooono) WHERE ro_id ='" + id + "'";
                    rs = stmt.executeQuery(QueryString1);
                    while (rs.next()) {


                        oostart = rs.getString(1);
                        ooend = rs.getString(2).trim();
                        codeoo = rs.getString(3);
                        descroo = rs.getString(4);


                    }}

                } catch (Exception ex) {
                    out.println("exeSQL Error : " + ex.getMessage());
                }

                if (remark == null) {
                    remark = "";
                }
                if (status.equals("OCC")) {
                    aa = "true";
                }


        %>
        <form method="post" action="HKChangeRoomStatus.jsp" name="test">
            <table>
                <tr><td>Room</td><td><input type="text" name="room" id="room" value="<%=room%>" disabled="true"  /></td></tr>
                <tr><td>Status</td>  <td width="75%">
                        <select name="status" id="status" onclick="Javascript:sum();"   >

                            <%
                                String h = "false";
                                if (aa.equals(h)) {
                                    String j1 = "", j2 = "";
                                    sql = "select * from status where rs_status not like 'OCC' and rs_status not like '" + status + "' order by rs_id desc  ";
                                    rs = stmt.executeQuery(sql);
                                    while (rs.next()) {
                                        j1 = rs.getString("rs_id");
                                        j2 = rs.getString("rs_status");

                            %>

                            <option value="<%=j1%>" name="status" id="status"   ><%=j2%></option>

                            <%    }
                            } else {
                                                               %> <option value="OCC" name="status" id="status" onclick="  document.test.submit.disabled = true; "  >OCC</option>
                            <%                        }
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td >OOO  Start Date</td><td>   <input type="text" value="<%=oostart%>" name="txtVol" disabled="true" id="txtVol"   /></td></tr>
                <tr> <td >OOO  End Date</td><td>    <input type="text" value="<%=ooend%>" disabled="true" name="txtVol1" id="txtVol1" onchange="Javascript:var myDate=new Date(document.test.txtVol1.value) ;myDate.setDate(myDate.getDate()+1); var ds=myDate.getDate();var dy = myDate.getFullYear() ;var dm = myDate.getMonth()+1; var ys = dy + '-' + dm + '-' + ds;document.test.dateInput.value = ys ;"  /> </td>
                </tr>
                <tr>
                    <td >Code OOO </td><td>      <input type="text" value="<%=codeoo%>" name="txtVol2" id="txtVo2" disabled="true" />
                    </td></tr> <tr> <td > Description</td><td>  <input type="text" value="<%=descroo%>" name="txtVol3" id="txtVol3" disabled="true"/><input name="openPopup" type="button" id="openPopup" onClick="Javascript:windowOpen();" value="Search" disabled="true" /></td>
                </tr>

                <tr>
                    <td>Room Available Date</td>
                    <td><input type="text" name="dateInput" id="dateInput" value="<%=available%>" />
                    </td>
                </tr>

                <tr>
                    <td>Remark</td>
                    <td><textarea name="remark"  cols="30"
                                  rows="5"  ><%=remark%></textarea>
                    </td>
                </tr>


                    <tr><td colspan="2" align="center"><input type="submit" name="submit" value="update" onclick=" document.test.dateInput.disabled = false; if (document.test.status.value == 'OCC'){parent.location='HKRoomStatus.jsp'}"  ></input>
                            <input type="hidden" name="id" value="<%=id%>"> <input name="Cancle" type="button" onclick="parent.location='HKRoomStatus.jsp'" value="Cancle" /></input></td></tr>
            </table>
        </form>
        <%
            }
            if (request.getParameter("submit") != null) {
                room = request.getParameter("id");
                status = request.getParameter("status");
                available = request.getParameter("dateInput");
                oostart = request.getParameter("txtVol");
                ooend = request.getParameter("txtVol1");
                codeoo = request.getParameter("txtVol2");
                String remark1 = request.getParameter("remark");
                remark = new String(remark1.getBytes("ISO8859_1"), "utf-8");


                stmt = con.createStatement();
                if (status.equals("OOO")) {

                    sql = "delete from roomooo where ro_id='" + room + "'";
                    stmt.executeUpdate(sql);
                    sql = "insert into roomooo (ro_id,ro_start,ro_end,ro_ooono) VALUES ( '" + room + "','" + oostart + "' ,'" + ooend + "','" + codeoo + "' )";

                    stmt.executeUpdate(sql);

                }
try{

                String sql1 = "UPDATE roomstatus SET    rs_statusno ='" + status + "', rs_available ='" + available + "', rs_remark ='" + remark + "' WHERE rs_roomno='" + room + "'";

                int row = stmt.executeUpdate(sql1);
                               
                if (row != 0) {
                    out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=HKRoomStatus.jsp'>"); // out.println("<br><a href='SetBedType.jsp'>finish</a>");
                } else {
                    out.println("Can't update");
                }
                stmt.close();
                con.close();
  

                } catch (Exception ex) {
                    out.println("exeSQL Error : " + ex.getMessage());
                }
            }

        %>
    </body>
</html>

