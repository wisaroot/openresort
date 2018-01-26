   
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
            Statement stmt = null;
            ResultSet rs = null;
            Connection con = null;
            String id = request.getParameter("id");
            String code = "";
            String date1 = "";
            String status = "";
            String QueryString1 = "";
            String sql1;
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
                        code = rs.getString(1);

                        status = rs.getString(2);
                        date1 = rs.getString(3);
                    }

                    // close all the connections.

                } catch (Exception ex) {

                    //      out.println("Unable to connect to database.");
                    // table.getSelectedRow();


                    out.println("exeSQL Error : " + ex.getMessage());
                }



        %>
        <form method="post" action="EditRoomCurrent.jsp">
            <table>
                <tr><td>Code</td><td><input type="text" name ="code" value="<%=code%>"/></td></tr>

                <tr> <td width="25%">Status</td>
                    <td width="75%">
                        <select name="group" onchange="chk_select1(this)" >
                                <%
                                    String j1 = "", j2 = "";
                                    sql1 = "select * from status  ";
                                    rs = stmt.executeQuery(sql1);
                                    while (rs.next()) {
                                        j1 = rs.getString("rs_id");
                                        j2 = rs.getString("rs_status");
                                %>
                                <option value="<%=j1%>" name="group" <%if (status.equals(j1)) {
                                        out.println("selected");
                                    }%>><%=j2%></option>

                            <%    }
                            %>
                        </select>
                    </td>
                </tr>
                        <script type="text/javascript">  
var temp_val; // ตัวแปรสำหรับเก็บค่าเก่า สำหรับกรณียกเลิก  
var selIdx; // ตัวแปรสำหรับเก็บค่ารายการเลือกเก่า สำหรับกรณียกเลิก  
function chk_select1(obj){ // เก็บค่าข้อมูลเมื่อคลิก  
    temp_val=obj.value;  // เก็บค่าข้อมูลเมื่อคลิก  
    selIdx = obj.selectedIndex; //  เก็บค่าข้อมูลเมื่อคลิก    
    if(temp_val=="OOO"){ var myWindow=window.open('SelectOOO.jsp','windowRef','width=500,height=500,top=220,left=250 ');
            if (!myWindow.opener) myWindow.opener = self;};  
} 
    </script>
                  
                        
                    
                       
                        
                <tr>
                    <td>Available</td>
                    <td><input type="text" name="dateInput" id="dateInput" value="<%=date1%>" />
                    </td>
                </tr>

                <tr><td colspan="2" align="center"><input type="submit" name="submit" value="update"></input>
                        <input type="hidden" name="id" value="<%=id%>"></input></td></tr>
            </table>
        </form>
        <%
            }
            if (request.getParameter("submit") != null) {
                code = request.getParameter("code");
                status = request.getParameter("group");
                date1 = request.getParameter("dateInput");



                stmt = con.createStatement();
                String sql = "UPDATE roomstatus SET rs_roomno='" + code + "', rs_statusno='" + status + "', rs_available='" + date1 + "' WHERE rs_roomno='" + id + "'";

                int row = stmt.executeUpdate(sql);
                if (status == "OOO") {
                    sql1 = "UPDATE roomstatus SET rs_roomno='" + code + "', rs_statusno='" + status + "', rs_available='" + date1 + "' WHERE rs_roomno='" + id + "'";
                    stmt.executeUpdate(sql1);
                }

                if (row != 0) {

                    out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=SetRoomCurrent.jsp'>");
                    // out.println("<br><a href='SetBedType.jsp'>finish</a>");
                } else {
                    out.println("Can't update");
                }
                stmt.close();
                con.close();

            }

        %>
    </body>
</html>
