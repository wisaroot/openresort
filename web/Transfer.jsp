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
        <title>Transfer</title>



    </head>
    <body>
        <script language="JavaScript">
            function windowOpen1() {
                var myWindow=window.open('SelectRoom.jsp','windowRef','width=500,height=500');
                if (!myWindow.opener) myWindow.opener = self;
            }
        </script>
        <script language = "javaScript">
            function valid_data()
            {

                if (document.frmMain.txtroom.value == '') {
                    alert( 'Please select room before transfer. ');
                    document.frmMain.txtroom.focus();
                    return false ;
                }
              
               
            }//end of function 

        </script>
        <script language="JavaScript">
           
           
            
            function enable() {
                 if ( document.frmMain.item.checked ) {
                    document.frmMain.button.disabled = false;
                }else {
                    document.frmMain.button.disabled = false;
                }
            }

        
        </script>



        <%
            Statement stmt = null;
            ResultSet rs = null;
            Connection con = null;
            String folno = request.getParameter("id1");
            String room = request.getParameter("id2");

            try {
                Class.forName("org.postgresql.Driver");
                con = DriverManager.getConnection(url, user1, pw);
            } catch (Exception ex) {

                out.println("exeSQL Error : " + ex.getMessage());
            }
        %>
        
        <P><a href="GuestFolio.jsp?id=<%=folno%>">BACK</a></P>
        <form action="updatetransfer.jsp" method="post" name="frmMain" id="form1">
            <p> Room       <input type="text" value="" name="txtroom" id="txtroom"/>Guest Name<input type="text" value="" name="txtroom1" id="txtroom1"/>
                <input name="openPopup1" type="button" id="openPopup" onClick="Javascript:windowOpen1();" value="Search"/></p>


            <table  width='300' border='1'>
                <%
                    /*      Class.forName("sun.jdbc.odbc.JdbcOdbc");
                    <b style="color:black;background-color:#a0ffff">Connection</b> con=DriverManager.getConnection("jdbc:odbc:MyDatabase","system","database");
                     */
                    try {
                        stmt = con.createStatement();
                        String QueryString = "Select gt_trndate||' '||gt_trntime,gt_deptno,gt_deptdesc,gt_refno,gt_qty,gt_amount,gt_trnseq,gt_folseq FROM gtran where gt_folno= '" + folno + "'  and upper(gt_CorrFlag) <> 'Y' and upper(gt_TxOutFlag) <> 'Y' order by gt_folseq , gt_trnseq ";

                        rs = stmt.executeQuery(QueryString);



                        out.println("<tr id='tbl' bgColor=#8080a6 ><TD></TD><td  width='30%'>Date-Time</td><td>Dept No</td><td>Description</td><td>Ref No </td><td>Qty </td><td>Amount </td><td>Folio Seq </td></tr>");

                        while (rs.next()) {
                            out.println("<TR id=5  ><TD><input name='item' type='checkbox' onclick='enable();' value='" + rs.getString(7) + "/" + rs.getString(8) + "'></TD><TD>" + rs.getString(1) + "</TD><TD>" + rs.getString(2) + "</TD><TD>" + rs.getString(3) + "</TD><TD>" + rs.getString(4) + "</TD><TD>" + rs.getString(5) + "</TD><TD>" + rs.getString(6) + "</TD><TD>" + rs.getString(8) + "</TD>");

                            // out.println("<TD><a href=\"VoidTran.jsp?id1=" + folno + "&id2=" + rs.getString(7) +"&id3=" + rs.getString(8) + "&id4=" + room + "&id5=1\"  onclick=\"return confirm('Void ?')\" >Void</td></TR>");
                        }

                        // close all the connections.
                        rs.close();
                        stmt.close();
                        con.close();
                    } catch (Exception ex) {

                        out.println("Unable to connect to database.");
                        // table.getSelectedRow();
                    }
                    //   out.println("</table>");
%>
                <tr>
                    <td colspan="8" align="center" ><label>
                            <input type = "hidden" name = "oldroom" value = "<%= room%>" />
                            <input type = "hidden" name = "oldfol" value = "<%= folno%>" />

                            <input type="submit" name="button" id="button" value="Transfer" onClick = "javascript:return valid_data()" disabled="true" />
                        </label></td>
                </tr> </table></form>






        <p>&nbsp;</p>
    </body>
</html>

