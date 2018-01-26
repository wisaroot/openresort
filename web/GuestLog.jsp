<!--
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
  -->
  
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <%@ include file ="config.jsp"%>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>GuestLog</title>



    </head>
    <body>
        <script language="JavaScript">
            function windowOpen1() {
                var myWindow=window.open('SelectRoom2.jsp','windowRef','width=500,height=500');
                if (!myWindow.opener) myWindow.opener = self;
                 document.frmMain.button.disabled = false;
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


        <form action="UpdateGuestlog.jsp" method="post" name="frmMain" >
            <p> Room       <input type="text" value="" name="txtroom" id="txtroom"/> Name<input type="text" value="" name="txtroom1" id="txtroom1"/>
              acc       <input type="text" value="" name="account" id="account"/>  <input name="openPopup1" type="button" id="openPopup" onClick="Javascript:windowOpen1();" value="Search"/></p>
            Title#    <input type="text" name="title"  /> 
            <p>Detail# 
            <textarea  name="detail" id="detail"  style="width: 400px; height: 80px;"></textarea>
            </p>
            <p style=" width:500px" align="center" >
            <input type="submit"  name="button" id="button" value="Post" onClick = "javascript:return valid_data();" disabled="true" />
            </p>
           </form>






        <p>&nbsp;</p>
    </body>
</html>

