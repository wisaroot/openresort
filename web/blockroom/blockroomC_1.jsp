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

<%@page import="com.comis.frontsystem.blockroom.BlockRoom"%>
<%@page import="com.comis.frontsystem.user.WebUser"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
 <%@page import="com.comis.frontsystem.database.JDBCTransaction"%> 

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="../errorPage.jsp"%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file="../login/isLogin.jsp" %>
<%@ include file ="../config.jsp"%>
<%!
    private void validate(BlockRoom blockRoom, List errorList) {
        if (Converter.isEmpty(blockRoom.getAccountId())) {
            errorList.add("accountId is empty");
        }
        if (Converter.isEmpty(blockRoom.getDtl())) {
            errorList.add("dtl is empty");
        }
        if (Converter.isEmpty(blockRoom.getArrival())) {
            errorList.add("arrival is empty");
        }
        if (Converter.isEmpty(blockRoom.getDeparture())) {
            errorList.add("departure is empty");
        }
        if (Converter.isEmpty(blockRoom.getRoom())) {
            errorList.add("room is empty");
        }
    }

    private boolean addBlockRoom(String user1,String pw,String url,String driver,BlockRoom blockRoom,String seq, WebUser user, List errorList) throws SQLException {
        Connection dbConnection = null;
        PreparedStatement preparedStatementInsert = null;
      //  String selectSQL = "INSERT INTO block(bl_accno, bl_dtlseq, bl_seq, bl_arrdate, bl_depdate, bl_roomno, bl_bckdate, bl_userno) select ?, ?, (select case when (select count(bl_seq) from block where bl_accno=? and bl_dtlseq=?) =0 then 0 else (select bl_seq+1 from block where bl_accno=? and bl_dtlseq=? order by bl_seq desc limit 1) end), ?, ?, ?, ?, ? where (select count(*)=0 or count(*)<(select case when count(*) = 0 then 0 else (select b_qty from booking where b_accno=? and b_seq=?) end as b_qty from booking where b_accno=? and b_seq=? ) from block where bl_accno=? and bl_dtlseq=?);";
        String selectSQL = "INSERT INTO block(bl_accno, bl_dtlseq, bl_seq, bl_arrdate, bl_depdate, bl_roomno, bl_bckdate, bl_userno) select ?, ?, (select case when (select count(bl_seq) from block where bl_accno=? and bl_dtlseq=?) =0 then 0 else ? end), ?, ?, ?, ?, ? ;";
        
        boolean isSave = false;
        try {
            dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
            dbConnection.setAutoCommit(false);
            preparedStatementInsert = dbConnection.prepareStatement(selectSQL);
            preparedStatementInsert.setInt(1, Converter.parseInt(blockRoom.getAccountId()));
            preparedStatementInsert.setInt(2, Converter.parseInt(blockRoom.getDtl()));
            preparedStatementInsert.setInt(3, Converter.parseInt(blockRoom.getAccountId()));
            preparedStatementInsert.setInt(4, Converter.parseInt(blockRoom.getDtl()));
            preparedStatementInsert.setInt(5, Converter.parseInt(seq));
          //  preparedStatementInsert.setInt(6, Converter.parseInt(blockRoom.getDtl()));
            preparedStatementInsert.setDate(6, Converter.parseSQLDate(blockRoom.getArrival()));
            preparedStatementInsert.setDate(7, Converter.parseSQLDate(blockRoom.getDeparture()));
            preparedStatementInsert.setString(8, blockRoom.getRoom());
            preparedStatementInsert.setDate(9, Converter.parseSQLDate(Converter.getCurrentDate()));
            preparedStatementInsert.setString(10, user.getUsername());
     /*       preparedStatementInsert.setInt(12, Converter.parseInt(blockRoom.getAccountId()));
            preparedStatementInsert.setInt(13, Converter.parseInt(blockRoom.getDtl()));
            preparedStatementInsert.setInt(14, Converter.parseInt(blockRoom.getAccountId()));
            preparedStatementInsert.setInt(15, Converter.parseInt(blockRoom.getDtl()));
            preparedStatementInsert.setInt(16, Converter.parseInt(blockRoom.getAccountId()));
            preparedStatementInsert.setInt(17, Converter.parseInt(blockRoom.getDtl()));
          */  int result=preparedStatementInsert.executeUpdate();
            if(result>0){
                isSave=true;
                dbConnection.commit();
            }else{
                errorList.add("No room block.");
            }

        } catch (SQLException e) {
            errorList.add(e.getMessage());
            dbConnection.rollback();
        } finally {
            preparedStatementInsert.close();
            if (dbConnection != null) {
                dbConnection.close();
            }
        }
        return isSave;
    }
%>
<%
    List<String> errorList = (ArrayList) session.getAttribute("errors" + session.getId());
    errorList = new ArrayList<String>();
    session.setAttribute("errors" + session.getId(), errorList);
      
    BlockRoom blockRoom = new BlockRoom(
            (String)request.getParameter("bkacc"),
            (String)request.getParameter("dtl"),
            (String)request.getParameter("arr"),
            (String)request.getParameter("dep"),
            (String)request.getParameter("room"));
    String seq =request.getParameter("seq");
    validate(blockRoom, errorList);
    //Converter.printFields(blockRoom);
    if(errorList.size()>0){
        response.sendRedirect("blockroomC.jsp?bkacc="+blockRoom.getAccountId()+"&dtl="+blockRoom.getDtl()+"&arr="+blockRoom.getArrival()+"&dep="+blockRoom.getDeparture()+"&bt="+request.getParameter("bt")+"&qty="+request.getParameter("qty")+"&rt="+request.getParameter("rt")+"&seq="+request.getParameter("seq"));
    }else{
        WebUser user=(WebUser)session.getAttribute(""+session.getId());
        if(addBlockRoom(user1, pw, url, driver,blockRoom,seq, user, errorList)){
            response.sendRedirect("blockroomC.jsp?bkacc="+blockRoom.getAccountId()+"&dtl="+blockRoom.getDtl()+"&arr="+blockRoom.getArrival()+"&dep="+blockRoom.getDeparture()+"&bt="+request.getParameter("bt")+"&qty="+request.getParameter("qty")+"&rt="+request.getParameter("rt")+"&seq="+request.getParameter("seq"));
        }else{
            response.sendRedirect("blockroomC.jsp?bkacc="+blockRoom.getAccountId()+"&dtl="+blockRoom.getDtl()+"&arr="+blockRoom.getArrival()+"&dep="+blockRoom.getDeparture()+"&bt="+request.getParameter("bt")+"&qty="+request.getParameter("qty")+"&rt="+request.getParameter("rt")+"&seq="+request.getParameter("seq"));
        }
    }
%>