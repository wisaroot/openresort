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
        <title>EndOfDay</title>

        <script language="JavaScript">
            function disableButton() {
                
                document.frmMain.submit.disabled = true;
                
            }
           
        
        </script>


    </head>
    <body>

        <%
            Statement stmt = null;
            int h = 0, EOD = 0;
            ResultSet rs = null;
            Connection con = null;
            Date sysdate = null;
            String roomno = null, ratecode = null;
            int folno = 0, accno = 0, expense = 0;


            try {

                Class.forName("org.postgresql.Driver");
                con = DriverManager.getConnection(url, user1, pw);
            } catch (Exception ex) {

                out.println("exeSQL Error : " + ex.getMessage());
            }


            stmt = con.createStatement();
            rs = stmt.executeQuery(" select sysdate from sysdate   ");
            while (rs.next()) {
                sysdate = rs.getDate(1);
            }

            rs = stmt.executeQuery(" select * from sysdate where sysdate <  CURRENT_DATE  ");
            while (rs.next()) {
                EOD = 10;
            }
            rs = stmt.executeQuery("select distinct gf_folno,gf_accno, "
                    + "  case when (A.ga_grpno is not null and coalesce(A.ga_guestno,0) = 0) "
                    + "    then ' Group No.'||  ga_grpno   else gn_fname "
                    + "  end,gf_roomno,gc_deptno,gc_amount,gc_seq   from  gaccount A inner join gfolio F "
                    + "   on F.gf_accno = A.ga_accno left join guestname N  on gn_guestno = A.ga_guestno inner join gcharge C "
                    + "  on gc_accno = A.ga_accno left join ratecode R  on rc_id = F.gf_rateno, sysdate D "
                    + "   where ga_accstat = 'I' and C.gc_postflag = 'N' and gc_chgdate = D.sysdate ");
            while (rs.next()) {
                expense = 10;
            }

            if (expense==10) {out.println("Can not end of day  cause other charge still not post please go to 'AutoPost Expense before' ");}else{

                // check แขกที่ถึงกำหนดเชคเอ้า แต่ยังไม่เช็คออก
                rs = stmt.executeQuery(" select distinct case a.ga_acctype  when 'G' then 'GRP' when 'C' then 'CS'   else F.gf_roomno end, "
                        + "  gf_folno,ga_accno,R.rc_descr as ratecode   from  gaccount A inner join gfolio F   on F.gf_accno = A.ga_accno  left join ratecode R "
                        + "  on R.rc_id = F.gf_rateno,sysdate   where A.ga_accstat = 'I' and A.ga_departure = sysdate   ");
        %>


        <form method='post' name='frmMain' action='EndOfDayUp.jsp'>
            <table id='tblTest' width='300' border='1'>
             
                <% out.println("<tr bgColor=paleturquoise ><td colspan='4'>Non-Extension </td></tr>");
                    out.println("<tr id='tbl' bgColor=#8080a6 ><td>RoomNo </td><td>Folio </td><td>Account </td><td  >RoomRate</td></tr>");
                    String a, ro;
                    while (rs.next()) {
                        h = 2;
                        //roomno=rs.getString(1);
                        folno = rs.getInt("gf_folno");
                        accno = rs.getInt("ga_accno");
                        ratecode = rs.getString(4);
                        /*      out.println(" <input type='hidden' name='fol' value='" + rs.getString(1) + "'>");
                        out.println(" <input type='hidden' name='room' value='" + rs.getString(5) + "'>");
                        out.println(" <input type='hidden' name='deb' value='" + rs.getString(6) + "'>");
                        out.println(" <input type='hidden' name='totalnotpost' value='" + rs.getString(7) + "'>");
                        
                        if ((rs.getString(3) == null)) {
                        a = rs.getString(4);
                        
                        } else {
                        
                        a = rs.getString(3);
                        };
                        if ((rs.getString(5) == null)) {
                        ro = "group";
                        } else {
                        
                        ro = rs.getString(5);
                        };*/
                        a = rs.getString(1);
                        if (a.length() == 3) {
                            a = "GRP";

                        } else if (a.length() == 2) {
                            a = "CSH";

                        };
                        out.println("<TR id=5  ><TD>" + a + "</TD><TD>" + folno + "</TD><TD>" + accno + "</TD><TD>" + ratecode + "</TD></TD>");
                        // out.println("<TD><a href=EditRateCode.jsp?id=" + rs.getString(1) + ">edit</td>");
                        //  out.println("<TD><a href=DeleteRateCode.jsp?id=" + rs.getString(1) + ">delete</td></TR>");

                    }
                    stmt.close();
                    con.close();
                %>

                <tr>
                    <td colspan="16" align="center" ><label>


                            <input type="submit" name="submit" id="submit"   value="Endday" onclick="if (! confirm('AutoPost?')) return  false;"   />
                        </label></td>
                </tr> </table></form>
                <%
                    if (h == 2) {
                %>
        <script type="text/javascript">
            disableButton();
        </script>
        <%            }
            if (EOD != 10) {
                out.println(sysdate + "  Already end of day");

        %>
        <script type="text/javascript">
            disableButton();
        </script>
        <%
                }
            }

        %>








    </body>
</html>
