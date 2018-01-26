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
  
<%@page import="com.comis.frontsystem.user.WebUser"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.comis.frontsystem.checkin.GFolio"%>
<%@page import="javax.swing.text.html.HTMLDocument.HTMLReader.PreAction"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page import="com.comis.frontsystem.checkin.GFolio"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@ include file ="../config.jsp"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%!
    private void validate(GFolio gFolio,List errorList){
        if(Converter.isEmpty(gFolio.getAccountId()))
            errorList.add("accountId is empty");
        if(Converter.isEmpty(gFolio.getBookAccountId()))
            errorList.add("bookAccountId is empty");
        if(Converter.isEmpty(gFolio.getDtl()))
            errorList.add("dtl is empty");
        if(Converter.isEmpty(gFolio.getRoomNo()))
            errorList.add("roomno is emtpy");
    }
    private boolean addGFolio(String user1,String pw,String url,String driver,GFolio gFolio,WebUser user,List errorList)throws SQLException{
        Connection dbConnection = null;
        PreparedStatement preparedStatementInsert = null;
        String insertGFolioSQL = "INSERT INTO gfolio(gf_accno, gf_bkaccno, gf_bookseq, gf_fpatno, gf_roomno, gf_roomtypeno, gf_adult, gf_child, gf_comp, gf_compby, gf_rateno, gf_room,gf_service,gf_tax,gf_extrabed,gf_extbedserv,gf_extbedtax,gf_abf,gf_lunch,gf_dinner,gf_discount,gf_total,gf_discby,gf_userno,gf_chargetobook,gf_ratetype) select ?,?,?,(select ga_fpatno from gaccount where ga_accno=?),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,(select case when b_chargeto='B' then 'Y' else 'N' end as b_chargeto from booking where b_accno=? and b_seq=?),(select rc_ratetype from ratecode where rc_id=?) where not exists (select 1 from gfolio where gf_accno=? and gf_bkaccno=? and gf_bookseq=?);";
        String updateBookingSQL = "update booking set b_inhqty=b_inhqty+1 where b_qty > b_inhqty and b_accno=? and b_seq=?;";
     //   String updateGAccountSQL = "update gaccount set ga_accstat='I' where ga_accno=? and exists (select 1 from booking where b_accno=? and b_seq=? having sum(b_qty)=sum(b_inhqty) );";
        String updateNGAccountSQL = "update gaccount set ga_accstat='I' where ga_accno=? ;";
                    String insertGFolioSeq1SQL = "INSERT INTO gfolseq(gfs_folno, gfs_folseq, gfs_folname, gfs_folbal,gfs_chgtofolio,gfs_folstatus) values (?,1,'Master',0.00,?,'A');";
           String insertGFolioSeq2SQL = "INSERT INTO gfolseq(gfs_folno, gfs_folseq, gfs_folname, gfs_folbal,gfs_chgtofolio,gfs_folstatus) values (?,2,'Extra',0.00,?,'A');";
                String updateRoom = "  update roomstatus set rs_statusno = 'OCC', rs_available = (select ga_departure from gaccount where ga_accno=? )  where rs_roomno = ?;";
                String deleteSQL = "delete from block where bl_accno=? and bl_dtlseq=? and bl_seq=?";
              //    String insertGrequire = "INSERT INTO grequire( gr_accno, gr_reqno, gr_fromdate, gr_eventtime,gr_enddate,gr_chargeflag,gr_deptno,gr_amount,gr_chargetype, gr_remark) select brq_accno, brq_reqno, brq_fromdate, brq_eventtime,brq_enddate,brq_chargeflag,brq_deptno,brq_amount,brq_chargetype, brq_remark from brequire where brq_accno = ?;";
 
             
        boolean isSave = false;
        try {
           dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
            dbConnection.setAutoCommit(false);
            preparedStatementInsert = dbConnection.prepareStatement(insertGFolioSQL,Statement.RETURN_GENERATED_KEYS);
            preparedStatementInsert.setInt(1,Converter.parseInt(gFolio.getAccountId()));
            preparedStatementInsert.setInt(2,Converter.parseInt(gFolio.getBookAccountId()));
            preparedStatementInsert.setInt(3,Converter.parseInt(gFolio.getDtl()));
            preparedStatementInsert.setInt(4,Converter.parseInt(gFolio.getAccountId()));
            preparedStatementInsert.setString(5,gFolio.getRoomNo().trim());
            preparedStatementInsert.setString(6,gFolio.getRoomType());
            preparedStatementInsert.setInt(7,Converter.parseInt(gFolio.getAdult()));
            preparedStatementInsert.setInt(8,Converter.parseInt(gFolio.getChild()));
            preparedStatementInsert.setBoolean(9, Converter.parseBoolean(gFolio.getCompliment()));
            //preparedStatementInsert.setString(9,(gFolio.getCompliment()==null?"false":gFolio.getCompliment()));
            preparedStatementInsert.setString(10,gFolio.getCompBy());
            preparedStatementInsert.setString(11,gFolio.getRateCode());
            preparedStatementInsert.setDouble(12, Converter.parseDouble(gFolio.getRoom()));
            preparedStatementInsert.setDouble(13, Converter.parseDouble(gFolio.getService()));
            preparedStatementInsert.setDouble(14, Converter.parseDouble(gFolio.getTax()));
            preparedStatementInsert.setDouble(15, Converter.parseDouble(gFolio.getExtraBed()));
            preparedStatementInsert.setDouble(16, Converter.parseDouble(gFolio.getExtraBedService()));
            preparedStatementInsert.setDouble(17, Converter.parseDouble(gFolio.getExtraBedTax()));
            preparedStatementInsert.setDouble(18, Converter.parseDouble(gFolio.getAbf()));
            preparedStatementInsert.setDouble(19, Converter.parseDouble(gFolio.getLunch()));
            preparedStatementInsert.setDouble(20, Converter.parseDouble(gFolio.getDinner()));
            preparedStatementInsert.setDouble(21, Converter.parseDouble(gFolio.getDiscount()));
            preparedStatementInsert.setDouble(22, Converter.parseDouble(gFolio.getTotal()));
            preparedStatementInsert.setString(23, gFolio.getDiscountBy());
            preparedStatementInsert.setString(24, user.getUsername());
            preparedStatementInsert.setInt(25,Converter.parseInt(gFolio.getBookAccountId()));
            preparedStatementInsert.setInt(26,Converter.parseInt(gFolio.getDtl()));
            preparedStatementInsert.setString(27,gFolio.getRateCode());
            preparedStatementInsert.setInt(28,Converter.parseInt(gFolio.getAccountId()));
            preparedStatementInsert.setInt(29,Converter.parseInt(gFolio.getBookAccountId()));
            preparedStatementInsert.setInt(30,Converter.parseInt(gFolio.getDtl()));
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
            preparedStatementInsert.setInt(1,Converter.parseInt(gFolio.getBookAccountId()));
            preparedStatementInsert.setInt(2,Converter.parseInt(gFolio.getDtl()));
            preparedStatementInsert.executeUpdate();
            
        /*    preparedStatementInsert = dbConnection.prepareStatement(updateGAccountSQL);
            preparedStatementInsert.setInt(1,Converter.parseInt(gFolio.getBookAccountId()));
            preparedStatementInsert.setInt(2,Converter.parseInt(gFolio.getBookAccountId()));
            preparedStatementInsert.setInt(3,Converter.parseInt(gFolio.getDtl()));
            preparedStatementInsert.executeUpdate();
        */    
            preparedStatementInsert = dbConnection.prepareStatement(updateNGAccountSQL);
            preparedStatementInsert.setInt(1,Converter.parseInt(gFolio.getAccountId()));
          
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
                    preparedStatementInsert.setInt(1, Converter.parseInt(gFolio.getAccountId()));
                   preparedStatementInsert.setString(2,gFolio.getRoomNo());
                 
                    preparedStatementInsert.executeUpdate();

                    preparedStatementInsert = dbConnection.prepareStatement(deleteSQL);

                    preparedStatementInsert.setInt(1, Converter.parseInt(gFolio.getBookAccountId()));
                    preparedStatementInsert.setInt(2, Converter.parseInt(gFolio.getDtl()));//nl_dtlseq
                    preparedStatementInsert.setInt(3, Converter.parseInt(gFolio.getDtl()));//nl_seq
 preparedStatementInsert.executeUpdate();
       /*     preparedStatementInsert = dbConnection.prepareStatement(insertGrequire);
                      preparedStatementInsert.setInt(1,Converter.parseInt(gFolio.getBookAccountId()));
                     preparedStatementInsert.executeUpdate();
            */
            dbConnection.commit();
            isSave = true;
            

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
    private void updateRoomStatus(String user1,String pw,String url,String driver,String roomNo,String departure,List errorList)throws SQLException{
    
        Connection dbConnection = null;
        PreparedStatement preparedStatementInsert = null;
        String updateRoomStatusSQL = "UPDATE roomstatus SET rs_statusno=?, rs_available=? WHERE rs_roomno=?";
        
        
        try {
            dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
            dbConnection.setAutoCommit(false);
            
            
            preparedStatementInsert = dbConnection.prepareStatement(updateRoomStatusSQL);
            preparedStatementInsert.setString(1,"OCC");
            preparedStatementInsert.setDate(2,Converter.parseSQLDate(departure));
            preparedStatementInsert.setString(3,roomNo);
            preparedStatementInsert.executeUpdate();
            dbConnection.commit();
            
            

        } catch (SQLException e) {
            errorList.add(e.getMessage());
            dbConnection.rollback();
        } finally {
            preparedStatementInsert.close();
            if (dbConnection != null) {
                dbConnection.close();
            }
        }
    }
     public void copyBRequire(String user1,String pw,String url,String driver,String accountId,String oldAccountId,List errorList)throws SQLException{
        Connection dbConnection = null;
        PreparedStatement preparedStatementSelect = null;
        String selectSQL = "INSERT INTO grequire(gr_accno, gr_reqno, gr_fromdate, gr_eventtime, gr_enddate, gr_chargeflag, gr_deptno, gr_amount, gr_chargetype, gr_remark) SELECT ?, brq_reqno, brq_fromdate, brq_eventtime, brq_enddate, brq_chargeflag, brq_deptno, brq_amount, brq_chargetype, brq_remark FROM brequire WHERE brq_accno=? and not exists (select 1 from grequire where gr_accno=?);";
        
        try {
           dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);

            preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
            preparedStatementSelect.setInt(1,Converter.parseInt(accountId));
            preparedStatementSelect.setInt(2,Converter.parseInt(oldAccountId));
            preparedStatementSelect.setInt(3,Converter.parseInt(accountId));
            preparedStatementSelect.executeUpdate();
           
       
        String[] reqno = new String[10];   
    String[] deptno = new String[10];
    String[] amount = new String[10];
    String[] chargetype = new String[10];
     String[] enddate1 = new String[10];
    String[] fromdate1 = new String[10];
    int i=0;
         preparedStatementSelect = dbConnection.prepareStatement(" select gr_reqno,gr_deptno, gr_amount, gr_chargetype,gr_enddate,gr_fromdate from grequire where gr_accno = " + accountId + " ;");
       ResultSet  rs = preparedStatementSelect.executeQuery();
       
        while (rs.next()) {
            reqno[i]=rs.getString("gr_reqno");
            deptno[i]=rs.getString("gr_deptno");
            amount[i]=rs.getString("gr_amount");
            chargetype[i]=rs.getString("gr_chargetype");
            enddate1[i]=rs.getString("gr_enddate");
                    fromdate1[i]=rs.getString("gr_fromdate");
            
            i++;
        }
       Date fromdate,enddate;
       
      
  
       String insertGchargeSQL;
       int j=0;
        while (i > j) {
            fromdate=Converter.parseDate(fromdate1[j].toString());
               enddate=Converter.parseDate(enddate1[j].toString());
         while ( fromdate.before(enddate) ||fromdate.equals(enddate) ) {
         
               insertGchargeSQL = "INSERT INTO gcharge(gc_accno, gc_reqno, gc_chgdate, gc_postflag, gc_deptno, gc_amount) values ( '"+ accountId+"','"+ reqno[j].toString() +"','"+ fromdate +"','N','"+ deptno[j].toString() +"','"+ amount[j].toString() +"' );";
    preparedStatementSelect = dbConnection.prepareStatement(insertGchargeSQL);
    preparedStatementSelect.executeUpdate();
            fromdate = new Date(fromdate.getTime()+(24*60*60*1000));
                    }
         j++;
        }
         
         } catch (SQLException e) {
            errorList.add(e.getMessage());
        } finally {
            preparedStatementSelect.close();
            if (dbConnection != null) {
                dbConnection.close();
            }
        }
    }
    public void copyBRateChange(String user1,String pw,String url,String driver,String accountId,String oldAccountId,String dtl,List errorList)throws SQLException{
        Connection dbConnection = null;
        PreparedStatement preparedStatementSelect = null;
        String selectSQL = "INSERT INTO gratechange(grc_accno, grc_chgdate, grc_room, grc_service, grc_tax, grc_extrabed, grc_extbedserv, grc_extbedtax, grc_discount, grc_abf, grc_lunch, grc_dinner, grc_userno, grc_rateno, grc_orino)SELECT ?, brc_chgdate, brc_room, brc_service, brc_tax, brc_extrabed, brc_extbedserv, brc_extbedtax, brc_discount, brc_abf, brc_lunch, brc_dinner, brc_userno,brc_rateno,brc_orino from bratechange where brc_accno=? and brc_seq=? and not exists (select 1 from gratechange where grc_accno=?);";
        
        try {
           dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);

            preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
            preparedStatementSelect.setInt(1,Converter.parseInt(accountId));
            preparedStatementSelect.setInt(2,Converter.parseInt(oldAccountId));
            preparedStatementSelect.setInt(3,Converter.parseInt(dtl));
            preparedStatementSelect.setInt(4,Converter.parseInt(accountId));
            
            preparedStatementSelect.executeUpdate();
        } catch (SQLException e) {
            errorList.add(e.getMessage());
        } finally {
            preparedStatementSelect.close();
            if (dbConnection != null) {
                dbConnection.close();
            }
        }
    }
    public void copyBNote(String user1,String pw,String url,String driver,String accountId,String oldAccountId,List errorList)throws SQLException{
        Connection dbConnection = null;
        PreparedStatement preparedStatementSelect = null;
        String selectSQL = "INSERT INTO gnote(gn_accno, gn_note) SELECT ?, bn_note FROM bnote WHERE bn_accno=? and not exists (select 1 from gnote where gn_accno=?);";
        
        try {
           dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);

            preparedStatementSelect = dbConnection.prepareStatement(selectSQL);
            preparedStatementSelect.setInt(1,Converter.parseInt(accountId));
            preparedStatementSelect.setInt(2,Converter.parseInt(oldAccountId));
            preparedStatementSelect.setInt(3,Converter.parseInt(accountId));
            preparedStatementSelect.executeUpdate();
        } catch (SQLException e) {
            errorList.add(e.getMessage());
        } finally {
            preparedStatementSelect.close();
            if (dbConnection != null) {
                dbConnection.close();
            }
        }
    }
    
%>
<%
    List<String> errorList = (ArrayList) session.getAttribute("errors" + session.getId());
    errorList = new ArrayList<String>();
    session.setAttribute("errors"+session.getId(), errorList);
    WebUser user=(WebUser)session.getAttribute(""+session.getId());
    GFolio gFolio=new GFolio(
            (String)request.getParameter("acc"),
            (String)request.getParameter("bkacc"),
            (String)request.getParameter("dtl"),
            (String)request.getParameter("roomNo"),
            (String)request.getParameter("roomType"),
            (String)request.getParameter("compliment"),
            (String)request.getParameter("compBy"),           
            (String)request.getParameter("adult"),
            (String)request.getParameter("child"),
            (String)request.getParameter("rateCode"),
            (String)request.getParameter("room"),
            (String)request.getParameter("service"),
            (String)request.getParameter("tax"),
            (String)request.getParameter("extraBed"),
            (String)request.getParameter("extraBedService"),
            (String)request.getParameter("extraBedTax"),
            (String)request.getParameter("abf"),
            (String)request.getParameter("lunch"),
            (String)request.getParameter("dinner"),
            (String)request.getParameter("discount"),
            (String)request.getParameter("discountBy"),
            (String)request.getParameter("total")
    );
    validate(gFolio, errorList);
    
    
 if(errorList.size()>0){
        response.sendRedirect("newcheckin.jsp?acc="+gFolio.getAccountId()+"&dtl="+gFolio.getDtl()+"&bkacc="+gFolio.getBookAccountId()+"&roomno="+gFolio.getRoomNo());
    }else{
        if(addGFolio(user1, pw, url, driver,gFolio,user, errorList)){
            updateRoomStatus(user1, pw, url, driver,gFolio.getRoomNo(), request.getParameter("departure"), errorList);
copyBRequire(user1, pw, url, driver,gFolio.getBookAccountId(),gFolio.getAccountId(), errorList) ; 
copyBRateChange (user1, pw, url, driver,gFolio.getBookAccountId(),gFolio.getAccountId(),gFolio.getDtl(), errorList) ;     
copyBNote (user1, pw, url, driver,gFolio.getBookAccountId(),gFolio.getAccountId(), errorList) ; 
            response.sendRedirect("../grequirementnoteCk/newrequirementnote.jsp?acc="+gFolio.getAccountId()+"&dtl=0&bkacc="+gFolio.getBookAccountId());
        }else{
            response.sendRedirect("newcheckin.jsp?acc="+gFolio.getAccountId()+"&dtl="+gFolio.getDtl()+"&bkacc="+gFolio.getBookAccountId()+"&roomno="+gFolio.getRoomNo());
        }
    }
%>