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
        <title>AutoPostExpense</title>

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"
        type="text/javascript" charset="utf-8"></script>
        <script language="JavaScript">
            function disableButton() {
                
                document.frmMain.submit.disabled = true;
                
            }
           
        
        </script>


    </head>
    <body>


        <%
            Statement stmt = null;
            ResultSet rs = null;
            Connection con = null;
            Date sysdate = null;
            int expense = 0, i = 0;

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
                stmt = con.createStatement();

                rs = stmt.executeQuery("select distinct gf_folno,gf_accno, "
                        + "  case when (A.ga_grpno is not null and coalesce(A.ga_guestno,0) = 0) "
                        + "    then ' Group No.'||  ga_grpno   else gn_fname "
                        + "  end,gf_roomno,gc_deptno,gc_amount,gc_seq   from  gaccount A inner join gfolio F "
                        + "   on F.gf_accno = A.ga_accno left join guestname N  on gn_guestno = A.ga_guestno inner join gcharge C "
                        + "  on gc_accno = A.ga_accno left join ratecode R  on rc_id = F.gf_rateno, sysdate D "
                        + "   where ga_accstat = 'I' and C.gc_postflag = 'N' and gc_chgdate = D.sysdate ");



                //       rs = stmt.executeQuery(" select gf_folno,gf_accno,gn_fname||gn_lname,gri_grpname,gf_roomno,gr_deptno,gr_amount from gaccount right join (select gr_accno,gr_deptno,gr_amount from grequire  where  '" + sysdate + "' BETWEEN   gr_fromdate and gr_enddate ) grequire  on ( ga_accno = gr_accno) left join   gfolio  on (gfolio.gf_accno=gaccount.ga_accno) left join guestname on (guestname.gn_guestno=gaccount.ga_guestno)left join groupinfo on (groupinfo.gri_grpno=gaccount.ga_grpno)  where ga_accstat = 'I'  order by gf_roomno ");
        %>

        <form method='post' name='frmMain' action='AutoPostExpenseUp.jsp'>
            <table id='tblTest' width='300' border='1'>
                <% //<tr><td>Code </td><td>Description</td></tr>
                        out.println("<tr id='tbl' bgColor=#8080a6 ><td>Fol </td><td>Acc </td><td  width='40%'>Name</td><td >Room No</td><td >DeptNo</td><td >amount</td><td  >Posted</td></tr>");
                        String a, ro;
                        while (rs.next()) {

                            out.println(" <input type='hidden' name='fol' value='" + rs.getString(1) + "'>");
                            out.println(" <input type='hidden' name='room' value='" + rs.getString(4) + "'>");
                            out.println(" <input type='hidden' name='deb' value='" + rs.getString(5) + "'>");
                            out.println(" <input type='hidden' name='totalnotpost' value='" + rs.getString(6) + "'>");
                            out.println(" <input type='hidden' name='gc_seq' value='" + rs.getString(7) + "'>");
                            out.println(" <input type='hidden' name='acc' value='" + rs.getString(2) + "'>");

                            a = rs.getString(3);

                            /*         if ((rs.getString(5) == null)) {
                            ro = "group";
                            } else {
                            
                            ro = rs.getString(5);
                            };*/

                            out.println("<TR id=5  ><TD>" + rs.getString(1) + "</TD><TD>" + rs.getString(2) + "</TD><TD>" + rs.getString(3) + "</TD><TD>" + rs.getString(4) + "</TD><TD>" + rs.getString(5) + "</TD><TD>" + rs.getString(6) + "</TD><TD style=' background-color: coral '  ><input name='net' type='checkbox' disabled='false'   value='true'  " + a + " /> </TD>");
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


                            <input type="submit" name="submit" id="submit"   value="Post" onclick="if (! confirm('AutoPost?')) return  false;"   />
                        </label></td>
                </tr> </table></form>
                <%
                    rs = stmt.executeQuery(" select expensedate from autoexpense where expensedate < '" + sysdate + "'  ");
                    while (rs.next()) {
                        expense = 1;
                    }
                    if (expense != 1) {
                %>

        <script type="text/javascript">
            disableButton();
        </script>
        <%    }

        %>
        <p>&nbsp;</p>
    </body>
</html>
