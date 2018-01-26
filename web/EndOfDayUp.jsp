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

    <body>


        <%
           // String id = request.getParameter("id");
            Statement stmt = null;
            ResultSet r = null;
            Connection con = null;
            String sql;

           // String[] folno = new String[100];
            String[] accno = new String[100];
            String[] Room = new String[100];
            String[] total = new String[100];
            
            String[] Serv = new String[100];
            String[] Tax = new String[100];
            String[] ExtServ = new String[100];

            String[] ExtBed = new String[100];
            String[] ExtTax = new String[100];
            String[] Disc = new String[100];
            String[] Abf = new String[100];
            String[] Lunch = new String[100];
            String[] Dinner = new String[100];
            int i = 0, j = 0;

            try {

                Class.forName("org.postgresql.Driver");
                con = DriverManager.getConnection(url, user1, pw);
            } catch (Exception ex) {

                out.println("exeSQL Error1 : " + ex.getMessage());
            }
            try {
                // update rate chage ของวันต่อไป
                stmt = con.createStatement();
                r = stmt.executeQuery("  select grc_accno, grc_room, grc_service, grc_tax, grc_extrabed, "
                        + " grc_extbedserv, grc_extbedtax, grc_discount, grc_abf, grc_lunch, grc_dinner,"
                        + "   grc_orino from gratechange    where grc_chgdate = (select sysdate+1 from sysdate)");

                while (r.next()) {

                    accno[i] = r.getString(1);
                    Room[i] = r.getString(2);
                     total[i] = Room[i];
                    Serv[i] = r.getString(3);
                    Tax[i] = r.getString(4);
                    ExtBed[i] = r.getString(5);
                    ExtServ[i] = r.getString(6);
                    ExtTax[i] = r.getString(7);
                    Disc[i] = r.getString(8);
                    Abf[i] = r.getString(9);
                    Lunch[i] = r.getString(10);
                    Dinner[i] = r.getString(11);
                    i++;
                }
                while (j < i) {
                    sql = " Update GFolio set gf_room = '" + Room[j] + "',gf_Service = '" + Serv[j] + "', gf_Tax = '" + Tax[j] + "', gf_ExtraBed = '" + ExtBed[j] + "',  gf_ExtBedServ = '" + ExtServ[j] + "', gf_ExtBedTax = '" + ExtTax[j] + "', gf_Discount ='" + Disc[j] + "' , gf_Abf ='" + Abf[j] + "' , gf_Lunch ='" + Lunch[j] + "' , gf_Dinner = '" + Dinner[j] + "',gf_total = '" + total[j] + "',gf_approveby = 'admin1' ,gf_approval = 'Y' Where gf_AccNo ='" + accno[j] + "' ";
                    stmt.executeUpdate(sql);
                    j++;
                }
                sql = "Update sysdate  set sysdate = sysdate + 1 ";
                stmt.executeUpdate(sql);



                out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=EndOfDay.jsp'>");

                // out.println("<br><a href='SetBedType.jsp'>finish</a>");
 stmt.close();
                        con.close();
              
            } catch (Exception ex) {

                out.println("exeSQL Error2 : " + ex.getMessage());
            }

        %>
    </body>
</html>
