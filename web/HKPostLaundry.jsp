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
        <title>HKPostLaundry</title>



    </head>
    <body>
        <script language="JavaScript">
            function windowOpen1() {
                var myWindow=window.open('SelectRoom1.jsp','windowRef','width=500,height=500');
                if (!myWindow.opener) myWindow.opener = self;
            }
        </script>
        <script language="JavaScript">
            function culation(value,prices,u) {
                if(value=="") return false;
                confirm("คลิก OK เพื่อยืนยันความถูกต้อง "+value*prices+" บาท");
                
                window.opener.document.frmMain.priceamount.value = value *prices;
          
            }
        </script>

        <script language = "javaScript">
            function valid_data()
            {

                if (document.frmMain.txtroom.value == '') {
                    alert( 'Please select room before . ');
                    document.frmMain.txtroom.focus();
                    return false ;
                }
                var i=0,uu=0;
                var min = 1;
                var max = 2;
                var chk=0;
                for(var k=0; document.frmMain.item.length>k ; k++){
                    if(document.frmMain.item[k].checked){ i++;}
                }
     
                var jj = document.frmMain.j.value;
              
                for (var ii=0; jj > ii  ; ii++) {
                   
                   
                    if (document.frmMain.qty[ii].value.length != 0){uu++; }
               
                }
                if(parseInt(i) == parseInt(uu)  ) {
                    
                   if (! confirm('Post?')) return  false;
                }
                
                else {
                    alert("Check checkbox or Qty or Amount again . May be something wrong!!")
                    return false;
                }
         //     if (parseInt(chk)==1){
           //           for (var ii=0; jj > ii  ; ii++) {
                   
                   
          //          if (document.frmMain.qty[ii].value.length != 0){
         //                document.frmMain.qt.value = document.frmMain.qty[ii].value;
          //             }
          //     
          //      }alert(document.frmMain.qt.value.length)
          //      }

              
               
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
        <script language="JavaScript">
            function fncSum()
            {
                var data1 = document.frmMain.elements['data1[]'];
                var todata2 = 0;
                var c = data1.length;
        
                for(var a=0;c>a;a++){
                    if(isNaN(parseInt(data1[a].value)) || parseInt(data1[a].value) == ""){}
                    else{
                        todata2 = todata2 + parseInt(data1[a].value);	
                    }
                }   document.frmMain.txtSum.value=todata2;
                
  
            }
        </script>




        <%
            Statement stmt = null;
            ResultSet rs = null;
            Connection con = null;
            String folno = request.getParameter("id1"), u;
            String room = request.getParameter("id2"), qt = null;
            Double total = 0.00, pr = 0.00;
            int qty[] = new int[50];
            try {
                Class.forName("org.postgresql.Driver");
                con = DriverManager.getConnection(url, user1, pw);

            } catch (Exception ex) {
                out.println("exeSQL Error : " + ex.getMessage());
            }
        %>


        <form action="UpdateHKPostLaundry.jsp" method="post" name="frmMain" >
            <p> Room       <input type="text" value="" name="txtroom" id="txtroom"/> Name<input type="text" value="" name="txtroom1" id="txtroom1"/>
                <input name="openPopup1" type="button" id="openPopup" onClick="Javascript:windowOpen1();" value="Search"/></p>
            Bill#    <input type="text" name="bill"  /> Fol# <input type="text" name="folno" id="folno" /> 
            <p> Charge To

                <label>
                    <input type="radio" name="ct" value="1"  />
                    1-Master</label>

                <label>
                    <input type="radio" name="ct" value="2"  checked="checked" />
                    2-Extra
                </label>


            </p>

            <table   border='0'>
                <%
                    /*      Class.forName("sun.jdbc.odbc.JdbcOdbc");
                    <b style="color:black;background-color:#a0ffff">Connection</b> con=DriverManager.getConnection("jdbc:odbc:MyDatabase","system","database");
                     */
                    int j = 0;
                    try {
                        stmt = con.createStatement();
                        String QueryString = "select pl_pluno,pl_name,pl_price from plu where pl_deptno = '619' and  pl_pluactive = 'TRUE' order by pl_pluno  ";
                        rs = stmt.executeQuery(QueryString);
                        out.println("<tr id='tbl' bgColor=#8080a6 ><TD></TD><td>Num</td><td style=' width:200px '>Name</td><td>Price</td><td>Qty </td><td>Amount </td></tr>");

                        while (rs.next()) {

                            pr = rs.getDouble("pl_price");
                            u = rs.getString(1).trim();
                            qt = "qty" + u;
                            // out.println(" <input type='hidden' name='price' id='price' size='5' maxlength='5' value=" + rs.getString("pl_price") + ">");

                            out.println("<TR id=5  ><TD><input name='item' type='checkbox' onclick='enable(); document.frmMain.qty[" + j + "].disabled=false;' value='" + u + "/" + rs.getString(3) + "'></TD><TD >" + rs.getString(1) + "</TD><TD>" + rs.getString(2) + "</TD><TD>" + rs.getString(3) + "</TD><TD><input type='text' name='qty[" + j + "]' id='qty' size='3' maxlength='3' disabled  onkeyup='document.frmMain.t" + u + ".value = (this.value * " + pr + "); fncSum();' /></TD><TD><input name='t" + u + "' id='data1[]'   type='text'   /></TD>");
                            j++;  // out.println("<TD><a href=\"VoidTran.jsp?id1=" + folno + "&id2=" + rs.getString(7) +"&id3=" + rs.getString(8) + "&id4=" + room + "&id5=1\"  onclick=\"return confirm('Void ?')\" >Void</td></TR>");
                        }
                        out.println(" <input type='hidden' name='j' id='price' size='5' maxlength='5' value=" + j + ">");
                      //  out.println(" <input type='hidden' name='qt'  size='5' maxlength='5' value=''>");

                        out.println("<TR><td colspan='2'>Total </td><td colspan='4'><input type='text' name='txtSum' value=''></td><TR>");

                        // close all the connections.
                        rs.close();
                        stmt.close();
                        con.close();
                    } catch (Exception ex) {

                        out.println(ex);
                        // table.getSelectedRow();
                    }
                    //   out.println("</table>");
%>
                <tr>
                    <td colspan="8" align="center" ><label>


                            <input type="submit" name="button" id="button" value="Post" onClick = "javascript:return valid_data();" disabled="true" />
                        </label></td>
                </tr> </table></form>






        <p>&nbsp;</p>
    </body>
</html>

