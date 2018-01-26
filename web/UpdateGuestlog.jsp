
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

        <title>UpdateHKPostMinibar</title>
    </head>
    <body>
        <%
            String room = request.getParameter("txtroom");
            String acc = request.getParameter("account");
            String datail = request.getParameter("detail");
            String title = request.getParameter("title");
           
        String sql, qty = null, qty1 = null, pri = null;
            String year = null, MM = null, pqty = null, pamt = null;
            //Date trdate = null;
            Time trtime = null;
            Double Debit = 0.0, Credit = 0.0, FolBal,total=0.00;
            //int qty = 0;
            String plno = null;
            Double amount = 0.00, newamt, oldamt;

            int newtrnseq = 0, oldqty, newqty;
            int fseq = 0;

            Statement stmt = null;

            Connection con = null;
            ResultSet r = null;
            Date sysdate = null;
            int ck = 0;

            try {
                Class.forName("org.postgresql.Driver");
                con = DriverManager.getConnection(url, user1, pw);
                stmt = con.createStatement();
            } catch (Exception ex) {

                out.println("exeSQL connect : " + ex.getMessage());
            }
          
                try {
                     total=Double.parseDouble(pri)*Double.parseDouble(qty);
            PreparedStatement ps2 = con.prepareStatement("INSERT INTO plusales (pls_pluno,pls_YREF," + pqty + "," + pamt + ") values (?,?,?,?)");
            ps2.setString(1, plno);
            ps2.setInt(2, Integer.parseInt(year));
            ps2.setInt(3, Integer.parseInt(qty));
            ps2.setDouble(4, total);
            ps2.executeUpdate();
                       }catch (Exception ex) {
            
            out.println("exeSQL Error2 : " + ex.getMessage());
            }
            
     
           
             
        %>
    </body>
</html>
