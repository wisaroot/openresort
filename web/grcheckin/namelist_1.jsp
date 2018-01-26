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
  
<%@page import="java.util.ArrayList"%>
<%@page import="com.comis.frontsystem.user.WebUser"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ include file ="../config.jsp"%>
<%@page errorPage="../errorPage.jsp"%>
<%!
    private boolean checkIn(String user1,String pw,String url,String driver,String chk[], WebUser user, List errorList) throws SQLException {
        boolean isSave = true;

        for (int i = 0; i < chk.length; i++) {
            String value = chk[i];
            String values[] = value.split(":");
            String acc = values[0];
            String bkacc = values[1];
            String dtl = values[2];
            String seq = values[3];
            if (!acc.equals("null")) {
                Connection dbConnection = null;
                PreparedStatement preparedStatementInsert = null;
                //   String insertGFolioSQL = "INSERT INTO gfolio(gf_accno, gf_bkaccno, gf_bookseq, gf_fpatno, gf_roomno, gf_roomtypeno, gf_adult, gf_child, gf_comp, gf_compby, gf_rateno, gf_room,gf_service,gf_tax,gf_extrabed,gf_extbedserv,gf_extbedtax,gf_abf,gf_lunch,gf_dinner,gf_discount,gf_total,gf_discby,gf_userno,gf_chargetobook,gf_ratetype) select ?,?,?,(select ga_fpatno from gaccount where ga_accno=?),nl_roomno,nl_roomtypeno,nl_adult,nl_child,nl_comp,'',nl_rateno,nl_room,nl_service,nl_tax,nl_extrabed,nl_extbedserv,nl_extbedtax,nl_abf,nl_lunch,nl_dinner,nl_discount,nl_total,'',?,(select case when b_chargeto='B' then 'Y' else 'N' end as b_chargeto from booking where b_accno=? and b_seq=?),(select rc_ratetype from ratecode where rc_id=nl_rateno) from namelist where nl_accno=? and nl_dtlseq=? and nl_seq=? and nl_ownaccno=? and 0= (select count(gf_accno) from gfolio where gf_accno=? and gf_bkaccno=? and gf_bookseq=?);";
                String insertGFolioSQL = "INSERT INTO gfolio(gf_accno, gf_bkaccno, gf_bookseq, gf_fpatno, gf_roomno, gf_roomtypeno, gf_adult, gf_child, gf_comp, gf_compby, gf_rateno, gf_room,gf_service,gf_tax,gf_extrabed,gf_extbedserv,gf_extbedtax,gf_abf,gf_lunch,gf_dinner,gf_discount,gf_total,gf_discby,gf_userno,gf_chargetobook,gf_ratetype) select ?,?,?,(select ga_fpatno from gaccount where ga_accno=?),nl_roomno,nl_roomtypeno,nl_adult,nl_child,nl_comp,'',nl_rateno,nl_room,nl_service,nl_tax,nl_extrabed,nl_extbedserv,nl_extbedtax,nl_abf,nl_lunch,nl_dinner,nl_discount,nl_total,'',?,(select case when b_chargeto='B' then 'Y' else 'N' end as b_chargeto from booking where b_accno=? and b_seq=?),(select rc_ratetype from ratecode where rc_id=nl_rateno) from namelist where nl_accno=? and nl_dtlseq=? and nl_seq=? and nl_ownaccno=? ;";

                String updateBookingSQL = "update booking set b_inhqty=b_inhqty+1 where b_qty > b_inhqty and b_accno=? and b_seq=?;";
                String updateGAccountSQL = "update gaccount set ga_accstat='I' where ga_accno=? and exists (select 1 from booking where b_accno=? and b_seq=? having sum(b_qty)=sum(b_inhqty) );";
                String updateNGAccountSQL = "update gaccount set ga_accstat='I' where ga_accno=? and exists (select 1 from booking where b_accno=? and b_seq=? );";
                String updateNameListSQL = "update namelist set nl_status='I' where nl_accno=? and nl_dtlseq=? and nl_seq=? and nl_ownaccno=?";
                String insertGFolioSeq1SQL = "INSERT INTO gfolseq(gfs_folno, gfs_folseq, gfs_folname, gfs_folbal,gfs_chgtofolio,gfs_folstatus) values (?,1,'Master',0.00,?,'A');";
                String insertGFolioSeq2SQL = "INSERT INTO gfolseq(gfs_folno, gfs_folseq, gfs_folname, gfs_folbal,gfs_chgtofolio,gfs_folstatus) values (?,2,'Extra',0.00,?,'A');";
                String updateRoom = "  update roomstatus set rs_statusno = 'OCC', rs_available = (select ga_departure from gaccount where ga_accno=? )  where rs_roomno = (select nl_roomno from namelist where nl_accno=? and nl_dtlseq=? and nl_seq=? and nl_ownaccno=?);";
                String deleteSQL = "delete from block where bl_accno=? and bl_dtlseq=? and bl_seq=?";
                int j = 1;
                try {
                   dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
                    dbConnection.setAutoCommit(false);
                    preparedStatementInsert = dbConnection.prepareStatement(insertGFolioSQL, Statement.RETURN_GENERATED_KEYS);
                    preparedStatementInsert.setInt(j++, Converter.parseInt(acc));
                    preparedStatementInsert.setInt(j++, Converter.parseInt(bkacc));
                    preparedStatementInsert.setInt(j++, Converter.parseInt(dtl));
                    preparedStatementInsert.setInt(j++, Converter.parseInt(acc));
                    preparedStatementInsert.setString(j++, user.getUsername());
                    preparedStatementInsert.setInt(j++, Converter.parseInt(bkacc));
                    preparedStatementInsert.setInt(j++, Converter.parseInt(dtl));//b_seq
                    preparedStatementInsert.setInt(j++, Converter.parseInt(bkacc));
                    preparedStatementInsert.setInt(j++, Converter.parseInt(dtl));//nl_dtlseq
                    preparedStatementInsert.setInt(j++, Converter.parseInt(seq));//nl_seq
                    preparedStatementInsert.setInt(j++, Converter.parseInt(acc));
                    //  preparedStatementInsert.setInt(j++, Converter.parseInt(acc));
                    //  preparedStatementInsert.setInt(j++, Converter.parseInt(bkacc));
                    //  preparedStatementInsert.setInt(j++, Converter.parseInt(dtl)); //gf_bookseq
                    preparedStatementInsert.executeUpdate();
                    ResultSet generatedKeys = null;
                    generatedKeys = preparedStatementInsert.getGeneratedKeys();
                    int gfolId;
                    if (generatedKeys.next()) {
                        gfolId = generatedKeys.getInt(1);
                    } else {
                        throw new SQLException("Can't create guestinfo");
                    }

                    preparedStatementInsert = dbConnection.prepareStatement(updateBookingSQL);
                    preparedStatementInsert.setInt(1, Converter.parseInt(bkacc));
                    preparedStatementInsert.setInt(2, Converter.parseInt(dtl));
                    preparedStatementInsert.executeUpdate();

                    preparedStatementInsert = dbConnection.prepareStatement(updateGAccountSQL);
                    preparedStatementInsert.setInt(1, Converter.parseInt(bkacc));
                    preparedStatementInsert.setInt(2, Converter.parseInt(bkacc));
                    preparedStatementInsert.setInt(3, Converter.parseInt(dtl));
                    preparedStatementInsert.executeUpdate();

                    preparedStatementInsert = dbConnection.prepareStatement(updateNGAccountSQL);
                    preparedStatementInsert.setInt(1, Converter.parseInt(acc));
                    preparedStatementInsert.setInt(2, Converter.parseInt(bkacc));
                    preparedStatementInsert.setInt(3, Converter.parseInt(dtl));
                    preparedStatementInsert.executeUpdate();

                    preparedStatementInsert = dbConnection.prepareStatement(updateNameListSQL);
                    preparedStatementInsert.setInt(1, Converter.parseInt(bkacc));
                    preparedStatementInsert.setInt(2, Converter.parseInt(dtl));
                    preparedStatementInsert.setInt(3, Converter.parseInt(seq));
                    preparedStatementInsert.setInt(4, Converter.parseInt(acc));
                    preparedStatementInsert.executeUpdate();

                    preparedStatementInsert = dbConnection.prepareStatement(insertGFolioSeq1SQL);
                    preparedStatementInsert.setInt(1, gfolId);
                    preparedStatementInsert.setInt(2, gfolId);
                    preparedStatementInsert.executeUpdate();

                    preparedStatementInsert = dbConnection.prepareStatement(insertGFolioSeq2SQL);
                    preparedStatementInsert.setInt(1, gfolId);
                    preparedStatementInsert.setInt(2, gfolId);
                    preparedStatementInsert.executeUpdate();

                    preparedStatementInsert = dbConnection.prepareStatement(updateRoom);
                    preparedStatementInsert.setInt(1, Converter.parseInt(acc));
                    preparedStatementInsert.setInt(2, Converter.parseInt(bkacc));
                    preparedStatementInsert.setInt(3, Converter.parseInt(dtl));//nl_dtlseq
                    preparedStatementInsert.setInt(4, Converter.parseInt(seq));//nl_seq
                    preparedStatementInsert.setInt(5, Converter.parseInt(acc));
                    preparedStatementInsert.executeUpdate();

                    preparedStatementInsert = dbConnection.prepareStatement(deleteSQL);

                    preparedStatementInsert.setInt(1, Converter.parseInt(bkacc));
                    preparedStatementInsert.setInt(2, Converter.parseInt(dtl));//nl_dtlseq
                    preparedStatementInsert.setInt(3, Converter.parseInt(seq));//nl_seq

                    preparedStatementInsert.executeUpdate();

                    dbConnection.commit();
                    isSave = true;


                } catch (SQLException e) {
                    //  System.out.println(e);
                    errorList.add(e.getMessage());
                    dbConnection.rollback();
                } finally {
                    preparedStatementInsert.close();
                    if (dbConnection != null) {
                        dbConnection.close();
                    }
                }
                //  return isSave;
            } else {
                isSave = false;

            }
        }
        return isSave;

    }
%>
<%
    List<String> errorList = (ArrayList) session.getAttribute("errors" + session.getId());
    errorList = new ArrayList<String>();
    session.setAttribute("errors" + session.getId(), errorList);
    WebUser user = (WebUser) session.getAttribute("" + session.getId());
    String chk[] = request.getParameterValues("chk");
    String bkacc = request.getParameter("bkacc");
    String dtl = request.getParameter("dtl");
    if (request.getParameterValues("chk") == null) {
        errorList.add("select before checkin");
    }

    if (checkIn(user1, pw, url, driver,chk, user, errorList)) {
        if (errorList.size() > 0) {
            response.sendRedirect("namelist.jsp?bkacc=" + bkacc + "&dtl=" + dtl);
        } else {
            response.sendRedirect("../guestinfo/individual.jsp");
        }
    } else {
        errorList.add("Can't checkin");
        response.sendRedirect("namelist.jsp?bkacc=" + bkacc + "&dtl=" + dtl);

        //throw new Exception();
    }

%>