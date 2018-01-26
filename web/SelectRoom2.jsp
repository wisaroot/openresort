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
<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
<meta content="JavaScript" name="vs_defaultClientScript">
<meta content="http://schemas.microsoft.com/intellisense/ie5"
      name="vs_targetSchema">


<%@ include file ="config.jsp"%>





<body>
    <script language="javascript" type="text/javascript">
        function CheckOne(obj) {
            var grid = obj.parentNode.parentNode.parentNode;
            var inputs = grid.getElementsByTagName("input");
            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].type == "checkbox") {
                    if (obj.checked && inputs[i] != obj && inputs[i].checked) {
                        inputs[i].checked = false;
                    }
                }
            }
          
        } 

    </script>


    <script language="JavaScript">
        function updateOpener() {
        

            window.opener.document.frmMain.txtroom.value = document.all.nz1.value;
            window.opener.document.frmMain.txtroom1.value = document.all.nz2.value;
             window.opener.document.frmMain.account.value = document.all.nz3.value;
            
            window.close();
        }
    </script>


     <%
      
        Connection con = null;
        con = DriverManager.getConnection(url, user1, pw);
        Statement stmt = con.createStatement();

        ResultSet rs = null;
      try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection(url, user1, pw);
        } catch (Exception ex) {

            out.println("exeSQL Error : " + ex.getMessage());
        }
        try {
            stmt = con.createStatement();
            String QueryString = " select  RTRIM(gf_roomno) ,RTRIM(gn_fname),ga_accno from gaccount  left join  guestname on (guestname.gn_guestno= gaccount.ga_guestno ) left join GFOLIO on(gaccount.ga_accno= gfolio.gf_accno) where  gaccount.ga_accstat = 'I' and gf_roomno is not null order by gf_roomno";
            rs = stmt.executeQuery(QueryString);


            /*       } catch (Exception e) {
            
            out.println("exeSQL Error : " + e.getMessage());
            }
            }*/

            //out.println("<form method='post'  enctype='multipart/form-data'>");
            out.println("<form name='frmMain' method='post' >");

            out.println("<table id='tblTest' width='300' border='1'>");
            //<tr><td>Code </td><td>Description</td></tr>
            out.println("<tr id='tbl' bgColor=#8080a6 ><td>Select</td><td>Room </td><td>Name </td></tr>");

            String k1 = "", k2 = "", k3 = "";
            while (rs.next()) {

                String s = rs.getString(1)+'-'+rs.getString(2)+'-'+rs.getString(3);
//out.println("<input type='hidden' name='nz3' value=" + rs.getString(3)+" >");
                out.println("<TR  ><TD><input type='checkbox'  name='nz'  value='" + s + "' onclick='CheckOne(this)'   /> </TD><TD>" + rs.getString(1) + "</TD><TD>" + rs.getString(2) + "</TD>");

                //code = rs.getString(1);
                //  
                //out.println("<TD><a href=PostToDepartment.jsp?id=" + rs.getString(1) + ">OK</td>");
                //  out.println("<TD><input type='button' name='Button' value='OK' onclick='window.opener.location.href=SetDepartment.php; window.close(); '> </td>");
              //  out.println(s);
            }
            //  out.println("<TR  > <td colspan='3'><div align='center'> <input type='Submit' name='Submit' value='OK'  /></td></TR>");
            //  out.println("<TR  ><TD> <input type='checkbox' name='id'  ' " + k + " ' > </TD><TD><input type='checkbox' name='id' value='"+i+"'></TD><TD><input type='checkbox' name='id' value='"+i+"'></TD>");
            out.println("<TR  > <td colspan='3'><div align='center'><input name='Close'  type='submit' id='Close'  value='Submit'/></td></TR>");


            // close all the connections.
            rs.close();
            stmt.close();
            con.close();
        } catch (Exception ex) {

            out.println(ex);
            // table.getSelectedRow();
        }
        out.println("</table>");
        out.println("</form>");




        String select[] = request.getParameterValues("nz");
           if (select != null && select.length != 0) {
            // out.println("You have selected: ");

            for (int i = 0; i < select.length; i++) {
               //  out.println(select[i]);
                String abc = select[i];

                String[] arr = abc.split("\\-"); // แยก String ที่ใช้ | คั่น



                for (int j = 0; j < arr.length; j++) { // พิมพ์ String ย่อยออกหน้าจอ{
                    if (j == 0) {
                        out.println("<input type='hidden' name='nz1' value=" + arr[j] + " >");
                    }
                    if (j == 1) {
                        out.println("<input type='hidden' name='nz2' value=" + arr[j] + " >");
                    }
                    if (j == 2) {
                        out.println("<input type='hidden' name='nz3' value=" + arr[j] + " >");
                    }
                 //   out.println(arr[j]);
                }

            }

    %>
    <script type="text/javascript" language="JavaScript">
        updateOpener();
    </script>


    <%
        }
    %>








</body>



