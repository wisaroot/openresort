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

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>AutoPostRoom</title>

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"
        type="text/javascript" charset="utf-8"></script>



    </head>
    <body>


        <%
            Statement stmt = null;
            ResultSet rs = null;
            Connection con = null;
            Date sysdate = null;
            //String[] folnotpost = new String[400];
            // String co = request.getParameter("code");
            //  String des = request.getParameter("desc");
            //  if (request.getParameter("submit") != null) {
            try {

                Class.forName("org.postgresql.Driver");
                con = DriverManager.getConnection(url, user1, pw);
            } catch (Exception ex) {

                out.println("exeSQL Error : " + ex.getMessage());
            }
           
                try {
                    stmt = con.createStatement();
                    rs = stmt.executeQuery(" select sysdate from sysdate   ");
                    while (rs.next()) {
                        sysdate = rs.getDate(1);
                    }
                    int i = 0;
                    /*     rs = stmt.executeQuery(" select gt_folno, gt_deptdesc from gtran  where gt_deptdesc = 'RoomCharge' and gt_trndate = '"+sysdate+"' ");
                    while (rs.next()) {
                    folpost[i]=rs.getString(1);
                    }*/



                    rs = stmt.executeQuery(" select gf_folno,gf_accno,gn_fname||gn_lname,gf_roomno, gf_room,gf_service,gf_tax,gf_extrabed,gf_extbedserv,gf_extbedtax,gf_abf,gf_lunch,gf_dinner,gf_discount,gf_total,gtran.gt_deptdesc from gfolio left join gaccount on (gfolio.gf_accno=gaccount.ga_accno) left join guestname on (guestname.gn_guestno=gaccount.ga_guestno) left join (select gt_folno,gt_deptdesc from gtran  where gt_deptno = '101' and gt_trndate = '" + sysdate + "') gtran on ( gt_folno = gfolio.gf_folno) where ga_accstat = 'I' and ga_guestno is not null  order by gf_roomno ");
        %>

        <form method='post' name='frmMain' action='AutoPostRoomUp.jsp'>
            <table id='tblTest' width='300' border='1'>
                <%
//<tr><td>Code </td><td>Description</td></tr>
                        out.println("<tr id='tbl' bgColor=#8080a6 ><td>Fol </td><td>Acc </td><td  width='40%'>Name</td><td >Room No</td><td >RoomRate</td><td >RoomService</td><td >RoomTax</td><td>ExbedRate</td><td>Exbed Service</td><td>ExbedTax</td><td>ABF</td><td >Lunch</td><td>Dinner</td><td  >Discount</td><td  >Total</td><td  >Posted</td><td colspan='2'> </td></tr>");
                        String a;
                        while (rs.next()) {
                            if ((rs.getString(16) == null)) {
                                a = "FALSE";
                                //  folnotpost[i] = rs.getString(1);
                                out.println(" <input type='hidden' name='folnotpost' value='" + rs.getString(1) + "'>");
                                out.println(" <input type='hidden' name='roomnotpost' value='" + rs.getString(4) + "'>");
                                out.println(" <input type='hidden' name='totalnotpost' value='" + rs.getString(15) + "'>");
                            } else {

                                a = "checked";
                            };

                            out.println("<TR id=5  ><TD>" + rs.getString(1) + "</TD><TD>" + rs.getString(2) + "</TD><TD>" + rs.getString(3) + "</TD><TD>" + rs.getString(4) + "</TD><TD>" + rs.getString(5) + "</TD><TD>" + rs.getString(6) + "</TD><TD>" + rs.getString(7) + "</TD><TD>" + rs.getString(8) + "</TD><TD>" + rs.getString(9) + "</TD><TD>" + rs.getString(10) + "</TD><TD>" + rs.getString(11) + "</TD><TD>" + rs.getString(12) + "</TD><TD>" + rs.getString(13) + "</TD><TD>" + rs.getString(14) + "</TD><TD>" + rs.getString(15) + "</TD><TD style=' background-color: coral '  ><input name='net' type='checkbox' disabled='false'   value='true'  " + a + " /> </TD>");
                            // out.println("<TD><a href=EditRateCode.jsp?id=" + rs.getString(1) + ">edit</td>");
                            //  out.println("<TD><a href=DeleteRateCode.jsp?id=" + rs.getString(1) + ">delete</td></TR>");
                            i++;
                        }

                        // close all the connections.
                        out.println(" <input type='hidden' name='sysdate' value='" + sysdate + "'>");
                    } catch (Exception ex) {

                        out.println(ex);
                        // table.getSelectedRow();
                    }

                %>

                <tr>
                    <td colspan="16" align="center" ><label>


                            <input type="submit" name="submit"  value="Post" onclick="if (! confirm('AutoPost?')) return  false;"  />
                        </label></td>
                </tr> </table></form>

      


        <p>&nbsp;</p>
    </body>
</html>
