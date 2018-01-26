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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

    <head>
 
       
    

<%@ include file ="../config.jsp"%>
 <link rel="stylesheet" type="text/css" href="../css/smoothness/jquery-ui-1.7.2.custom.css"/>
    <script type="text/javascript" src="../js/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="../js/jquery-ui-1.7.2.custom.min.js"></script>
    <script type="text/javascript">
        $(function(){
            // แทรกโค้ต jquery
            $("#dateInput").datepicker({ dateFormat: 'yy-mm-dd' });
            $( "#datepicker" ).datepicker({ dateFormat: 'yy-mm-dd' });
           
            $("#datepicker").datepicker(options);
         
        
        });
    </script>
<script language = "javaScript">
            function valid_data()
            {
                if (document.test.txtrootm.value == '') {
                    alert( 'Please select date before . ');
                    document.test.txtrootm.focus();
                    return false ;
                }else{
                     var aa=document.test.txtrootm.value;
           //  window.open="GuestLeader.jsp?dateInput="+dateInput;
            var myWindow=window.open('Cityledgerfolio.jsp?fol='+aa,'windowRef','width=500,height=500,scrollbars=1' );
            if (!myWindow.opener) myWindow.opener = self;
       
                }
                    }//end of function 

        </script>
</head>
<body>
    <script language="JavaScript">
          function windowOpen() {
            var myWindow=window.open('../SelectGuest.jsp','windowRef','width=500,height=500');
            if (!myWindow.opener) myWindow.opener = self;
        }
    </script>

  




  
        <%
            Statement stmt = null;
            ResultSet rs = null;
            Connection con = null;

            String sql = "";
          //  String id = request.getParameter("id");
            String room = "";
            String status = "";
            String available = "";
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

            if ((request.getParameter("submit") == null)) {

               


               


        %>
        <form method="post" action="Cityledgerfolio.jsp" name="test">
            <table>
               
                
               <tr bgcolor="#8080a6" ><td colspan="2"  ><div align="center" style=""> Cityledgerfolio </div></td> </tr>
               
               <tr>
        <td colspan="2"> Fol       <input type="text" value="" name="txtroom" id="txtrootm"/>Guest Name<input type="text" value="" name="txtroom1" id="txtroom1"/>
                <input name="openPopup1" type="button" id="openPopup" onClick="Javascript:windowOpen();" value="Search"/></td>
            </tr>
                

               

                <tr><td colspan="2" align="center"> 
                             <input name="Cancle" type="button" onClick="Javascript:return valid_data();" value="Show" /></td></tr>
            </table>
        </form>
        <%
            }
        %>
    </body>



