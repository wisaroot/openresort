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
      // refresh
       window.opener.location.reload();
       window.close(); 
      
       
    }
</SCRIPT>
  <script language="JavaScript">
       function isNumeric(elem, helperMsg)
{
        var numericExpression = /^[0-9.]+$/;
        if(elem.value.match(numericExpression)){
                return true;
        }else{
                alert(helperMsg);
                elem.value=elem.value.substr(0,elem.value.length-1);
                elem.focus();
                return false;
        }
}
    </script>
<body>
    <%
        String dep = request.getParameter("id");
        Class.forName("org.postgresql.Driver");
        Connection con = null;
        con = DriverManager.getConnection(url, user1, pw);
        Statement stmt = con.createStatement();
        String sql;
        ResultSet rs = null;
        Vector errors = new Vector();
        if (MultipartFormDataRequest.isMultipartFormData(request)) {
            MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
            String web=mrequest.getParameter("idhk");
            String descr1 = mrequest.getParameter("desc");
            String des = new String(descr1.getBytes("ISO8859_1"), "utf-8");
            String pr1 = mrequest.getParameter("pr");
            String pr = new String(pr1.getBytes("ISO8859_1"), "utf-8");
          


            String descr4 = mrequest.getParameter("service");
            String service;
            if (descr4 != null) {
                service = "true";
            } else {
                service = "false";
            }

            String descr5 = mrequest.getParameter("tax");
            String tax;
            if (descr5 != null) {
                tax = "true";
            } else {
                tax = "false";
            }

            String descr6 = mrequest.getParameter("editamt");
            String editamt;
            if (descr6 != null) {
                editamt = "true";
            } else {
                editamt = "false";
            }
            String descr7 = mrequest.getParameter("active");
            String active;
            if (descr7 != null) {
                active = "true";
            } else {
                active = "false";
            }





            if (pr.equals("")) {
                errors.add("check price");
            }
            if (des.equals("")) {
                errors.add("check details");
            }
            if (service.equals("")) {
                errors.add("check service");
            }
            if (tax.equals("")) {
                errors.add("check tax");
            }
            if (editamt.equals("")) {
                errors.add("check edit amt");
            }
            if (active.equals("")) {
                errors.add("check active");
            }
         

            if (errors.size() > 0) {
    %><%@include file="ckError.jsp" %><% } else {


        sql = "insert into plu (pl_deptno,pl_name,pl_category,pl_price,pl_service,pl_tax,pl_editamt,pl_pluactive) VALUES ( " + dep+ " , '" + des + "', 'H' ," + pr + "," + service + "," + tax + "," + editamt + "," + active +  " )";

        int row = stmt.executeUpdate(sql);

    %>
    <script type="text/javascript" language="JavaScript">
        submitAndClose();
    </script>


    <%
            //response.sendRedirect("clip.jsp");
        }
    } else {
    %>
    <form method="post" enctype="multipart/form-data" name="frm" >
        <table width="60%" border="1" align="center" cellpadding="0" style=" border-color: #00F" >
            <tr>
                <td colspan="2"><div align="center" style="">
                        <div align="left"><strong>PLU</strong></div>
                    </div>    <%
                        //  out.println(" <input type='hidden' name='idhk' id='idhk'  value='EditSetHKPostting.jsp?hk=" + dep + "' />");
             out.println(" <input type='hidden' name='hk' id='hk'  value=" + dep + " />");
            
    %></td>
            </tr>


            <tr>
                <td>Description</td>
                <td><input type="text" name="desc"  />
                    *</td>
            </tr>
            <tr>
                <td>Price</td>
                <td><input type="text" name="pr" onKeyup="JavaScript:return isNumeric(this,'Please enter only number');"  />
                    *</td>
            </tr>

            <tr> <td width="25%"></td>
                <td width="75%"><p>  <input name="service" type="checkbox"  value="checkbox" />Service</td>
            </tr><tr><td width="25%"></td><td width="75%"><p>  <input name="tax" type="checkbox"  value="checkbox" />Tax</td>
            </tr> <tr><td width="25%"></td><td width="75%"><p>  <input name="editAmt" type="checkbox"  value="checkbox" />EditAmt</td>
            </tr>
            <tr><td width="25%"></td><td width="75%"><p>  <input name="active" type="checkbox"  value="checkbox" />Active</td>
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



