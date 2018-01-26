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
            String[] seq = new String[30];
            int i = 0;
            String sql = "";
            String id = request.getParameter("id");
            String guestno = "";
            String[] arrival = new String[30];
            String[] departure = new String[30];
            String[] roomno = new String[30];
            String[] folbal = new String[30];
            String[] RateCodeName = new String[30];
            String nation = "", birthdate = "", email = "", homeaddr1 = "", homeaddr2 = "";
            String ORGName = "", VIPLevel = "", CITYNAME = "";
            String aa = "false", guestname = "", lastname = "", phone = "";



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

                    QueryString1 = " select distinct HT.ht_guestno, HT.ht_seq, NT.n_descr as NationName, "
                            + "  GI.gi_birthdate, GI.gi_email, GI.gi_homeaddr1, GI.gi_homeaddr2,  HT.ht_arrival, "
                            + "  HT.ht_departure, HT.ht_roomno, HT.ht_folbal, ORG.o_descr as ORGName,  RC.rc_descr as RateCodeName, "
                            + "  VP.v_descr as VIPLevel, CN.ct_descr as CITYNAME ,gn_fname,gn_lname,GI.gi_telno from histran HT left join guestinfo GI on (HT.ht_guestno = GI.gi_guestno)"
                            + " left join origin ORG on (HT.ht_orino = ORG.o_id)  left join ratecode RC on (HT.ht_rateno = RC.rc_id)"
                            + " left join nationality NT on (GI.gi_natno = NT.n_id) left join country CN on (GI.gi_ctno = CN.ct_id)"
                            + " left join vip VP on (GI.gi_vipno = VP.v_id) left join guestname on (gn_guestno=ht_guestno) WHERE ht_guestno ='" + id + "' ";
                    rs = stmt.executeQuery(QueryString1);
                    while (rs.next()) {


                        guestno = rs.getString(1);
                        seq[i] = rs.getString(2).trim();
                        nation = rs.getString(3);
                        birthdate = rs.getString(4);
                        email = rs.getString(5);
                        homeaddr1 = rs.getString(6);
                        homeaddr2 = rs.getString(7);
                        arrival[i] = rs.getString(8);
                        departure[i] = rs.getString(9);
                        roomno[i] = rs.getString(10);
                        folbal[i] = rs.getString(11);
                        ORGName = rs.getString(12);
                        RateCodeName[i] = rs.getString(13);
                        VIPLevel = rs.getString(14);
                        CITYNAME = rs.getString(15);
                        guestname = rs.getString(16);
                        lastname = rs.getString(17);
                        phone = rs.getString(18);
                        i++;

                    }




                } catch (Exception ex) {
                    out.println("exeSQL Error : " + ex.getMessage());
                }

                /*     if (remark == null) {
                remark = "";
                }
                if (status.equals("OCC")) {
                aa = "true";
                }*/


        %>
        <form method="post" action="GuestHistoryDetail.jsp" name="test">
            <table>

                <tr>
                    <td >Guest# </td><td><input type="text" value="<%=guestno%>" name="guestno" id="guestno" disabled="true" />
                    </td>

                    <td >birthdate </td><td><input type="text" value="<%=birthdate%>" name="birthdate" id="birthdate" disabled="true" />
                    </td></tr>
                <tr>
                    <td >First </td><td><input type="text" value="<%=guestname%>" name="guestname" id="guestname"  disabled="true" />
                    </td>
                    <td >Last </td><td><input type="text" value="<%=lastname%>" name="lastname" id="lastname"  disabled="true" />
                    </td></tr>
                <tr>
                    <td >Nationality </td><td><input type="text" value="<%=nation%>" name="nation" id="nation"  disabled="true" />
                    </td>
                    <td >Origin </td><td><input type="text" value="<%=ORGName%>" name="ORGName" id="ORGName"  disabled="true" />
                    </td></tr>
                <tr>
                    <td >CITYNAME </td><td><input type="text" value="<%=CITYNAME%>" name="CITYNAME" id="CITYNAME"  disabled="true" />
                    </td>
                    <td >VIPLevel </td><td><input type="text" value="<%=VIPLevel%>" name="VIPLevel" id="VIPLevel"  disabled="true"  />
                    </td></tr>
                <tr>
                    <td >homeaddr1 </td><td><input type="text" value="<%=homeaddr1%>" name="homeaddr1" id="homeaddr1"  />
                    </td>
                    <td >homeaddr2 </td><td><input type="text" value="<%=homeaddr2%>" name="homeaddr2" id="homeaddr2"  />
                    </td></tr>
                <tr>
                    <td >Phone </td><td><input type="text" value="<%=phone%>" name="phone" id="phone"  />
                    </td>
                    <td >email </td><td><input type="text" value="<%=email%>" name="email" id="email"  />
                    </td></tr>



                <tr><td colspan="4" align="center"><input type="submit" name="submit" value="update"   ></input>
                        <input type="hidden" name="id" value="<%=id%>"> <input name="Cancle" type="button" onclick="parent.location='GuestHistory.jsp'" value="Cancle" /></input></td></tr>



            </table>

            <table id='tblTest' width='300' border='1'>
                <%    int j = 0;
                   while (i > j) {%>
                <tr id="tbl" bgcolor="#8080a6"  ><td colspan="8">History</td></tr>
                <tr id="tbl" bgcolor="#8080a6"  ><td >Seq</td><td >RoomNo</td><td >Arrival</td><td >Departure</td><td >RateCode</td><td >FolBal</td></tr>
                <tr>
                    <td><input type="text" value="<%=seq[j]%>" name="seq" id="seq" disabled="true" />
                    </td>
                    <td><input type="text" value="<%=roomno[j]%>" name="roomno" id="roomno" disabled="true" />
                    </td>

                    <td><input type="text" value="<%=arrival[j]%>" name="arrival[j]" id="arrival" disabled="true" />
                    </td>
                    <td><input type="text" value="<%=departure[j]%>" name="departure[j]" id="departure[j]" disabled="true" />
                    </td>
                    <td><input type="text" value="<%=RateCodeName[j]%>" name="RateCodeName[j]" id="RateCodeName[j]" disabled="true" />
                    </td>

                    <td><input type="text" value="<%=folbal[j]%>" name="folbal[j]" id="folbal" disabled="true" />
                    </td>

                </tr>


                <%  j++;
                 }%>
            </table>
        </form>
        <%
            }
            if (request.getParameter("submit") != null) {


                //  seq = rs.getString(2).trim();

                //  arrival = rs.getString(8);
                //  departure = rs.getString(9);

                //  RateCodeName = rs.getString(13);
                //   VIPLevel = rs.getString(14);
                //  CITYNAME = rs.getString(15);

                guestno = request.getParameter("id");
                // nation = request.getParameter("nation");
                // birthdate = request.getParameter("birthdate");
                email = request.getParameter("email");
                homeaddr1 = request.getParameter("homeaddr1");
                homeaddr2 = request.getParameter("homeaddr2");
                phone = request.getParameter("phone");
                /*   folbal = request.getParameter("folbal");
                ORGName = request.getParameter("ORGName");
                RateCodeName = request.getParameter("RateCodeName");
                VIPLevel = request.getParameter("VIPLevel");
                CITYNAME = request.getParameter("CITYNAME");
                guestname = request.getParameter("guestname");
                lastname = request.getParameter("lastname");
                 */


                stmt = con.createStatement();

                try {

                    String sql1 = "UPDATE guestinfo SET    gi_telno ='" + phone + "',gi_email ='" + email + "', gi_homeaddr1 ='" + homeaddr1 + "', gi_homeaddr2 ='" + homeaddr2 + "' WHERE gi_guestno ='" + id + "'";

                    int row = stmt.executeUpdate(sql1);

                    if (row != 0) {
                        out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=GuestHistory.jsp'>"); // out.println("<br><a href='SetBedType.jsp'>finish</a>");
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

