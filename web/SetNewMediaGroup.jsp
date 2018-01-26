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


  <%@ include file ="config.jsp"%>
<SCRIPT TYPE="text/javascript">
function submitAndClose() {
window.opener.location.href="SetMediaGroup.jsp";

window.close();
}
</SCRIPT>
  <body>
<%
Class.forName("org.postgresql.Driver");
 Connection con = null;
  con = DriverManager.getConnection(url, user1, pw);
Statement stmt=con.createStatement();
String sql;ResultSet rs =null,sex=null;
Vector errors = new Vector();
if(MultipartFormDataRequest.isMultipartFormData(request)){
        MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
String head1=mrequest.getParameter("code");
String co = new String(head1.getBytes("ISO8859_1"),"utf-8");

String descr1=mrequest.getParameter("desc");
String des = new String(descr1.getBytes("ISO8859_1"),"utf-8");
String mz1=mrequest.getParameter("RadioGroup1");
String mz = new String(mz1.getBytes("ISO8859_1"),"utf-8");




if(co.equals("")){
errors.add("check code");
}if(des.equals("")){
errors.add("check details");
}


 if(errors.size()>0){
%><%@include file="ckError.jsp" %><%
     }else{


       sql="insert into mediagroup (mg_Id,mg_Descr,mg_type) VALUES ( '"+ co+"','"+ des +"','"+ mz +"' )";

       int row = stmt.executeUpdate(sql);

%>
<script type="text/javascript" language="JavaScript">
   submitAndClose();
</script>


<%
 //response.sendRedirect("clip.jsp");
 }
 }else{
%>
<form method="post" enctype="multipart/form-data">
    <table width="60%" border="1" align="center" cellpadding="0" style=" border-color: #00F" >
        <tr>
            <td colspan="2"><div align="center" style="">
                    <div align="left"><strong>Media Group</strong></div>
                </div></td>
        </tr>

        <tr>
            <td>Code</td>
            <td><input type="text" name="code"  />
                *</td>
        </tr>
        <tr>
            <td>Description</td>
            <td><input type="text" name="desc"  />
                *</td>
        </tr>
            <tr> <td width="25%">Group Type</td>
            <td width="75%"><p>
              <label>
                <input type="radio" name="RadioGroup1" value="Cash" id="RadioGroup1_0" />
                Cash</label>
              <br />
              <label>
                <input type="radio" name="RadioGroup1" value="City Ledger" id="RadioGroup1_1" />
                City Ledger
              </label>
              <br />
              <label>
                <input type="radio" name="RadioGroup1" value="Advance Cash" id="RadioGroup1_2" />
                Advance Cash
              </label>
              <br />
              <label>
                <input type="radio" name="RadioGroup1" value="Entertain" id="RadioGroup1_3" />
                Entertain
              </label>
              <br />
              <label>
                <input type="radio" name="RadioGroup1" value="Credit Card" id="RadioGroup1_4" />
                Credit Card
              </label>
              <br />
              <label>
                <input type="radio" name="RadioGroup1" value="Deposit" id="RadioGroup1_5" />
                Deposit
              </label>
              <br />
              <label>
                <input type="radio" name="RadioGroup1" value="Account Recieveable" id="RadioGroup1_6" />
                Account Recieveable
              </label>
              <br />
              <label>
                <input type="radio" name="RadioGroup1" value="Refund" id="RadioGroup1_7" />
               Refund
              </label>
              <br />
            </p></td>
        </tr>

        <tr>
            <td colspan="2"><div align="center">
                    <input type="Submit" name="Submit" value="OK"  />
                    <input name="Reset" type="reset" value="reset" />
                </div></td>
        </tr>
    </table>
</form>
<%}%>
</body>



