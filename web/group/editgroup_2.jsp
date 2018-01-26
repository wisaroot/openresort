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
<%@page import="javax.xml.bind.ParseConversionEvent"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
 <%@page import="com.comis.frontsystem.database.JDBCTransaction"%> 
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.comis.frontsystem.group.Group"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="../errorPage.jsp"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file="../login/isLogin.jsp" %>
<%@ include file ="../config.jsp"%>
<%!
    private void validate(Group group,List errorList){
        if(Converter.isEmpty(group.getGrpname())){
            errorList.add("GroupName is empty");
        }
        if(Converter.isEmpty(group.getFollioPattern())){
            errorList.add("Follio pattern is empty");
        }
        if(Converter.isEmpty(group.getArrival())){
            errorList.add("Arrival date is empty");
        }
        if(Converter.isEmpty(group.getDeparture())){
            errorList.add("Departure date is empty");
        }
    }
    private boolean saveBooking(String user1,String pw,String url,String driver,Group group,WebUser user,List errorList)throws SQLException{
        Connection dbConnection = null;
        PreparedStatement preparedStatementUpdate = null;
        String updateGuestInfoSQL = "UPDATE groupinfo SET gri_grpname=?, gri_crlimit=?, gri_natno=?, gri_vipno=?, gri_ctno=?, gri_telno=?, gri_faxno=?, gri_email=?, gri_company=?,  gri_visatypeno=?, gri_entryno=?, gri_pissue=?, gri_pexpire=? WHERE gri_grpno=(select ga_grpno from gaccount where ga_accno=?);";
        String updateGAccountSQL = "UPDATE gaccount SET ga_accstat=?, ga_gsttype=?, ga_rsvtypeno=?, ga_bookby=?, ga_acctype=?, ga_walkin=?, ga_agentno=?, ga_orino=?, ga_arrival=?, ga_arrtime=?, ga_arrfrom=?, ga_arrby=?, ga_departure=?, ga_deptime=?, ga_depto=?, ga_depby=?, ga_fpatno=?, ga_recdate=?, ga_userno=?, ga_coa=? WHERE ga_accno=?;";
        
        boolean isSave = false;
        try {
            
            dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
            
            dbConnection.setAutoCommit(false);
            preparedStatementUpdate = dbConnection.prepareStatement(updateGuestInfoSQL);
            preparedStatementUpdate.setString(1,group.getGrpname());
           
            preparedStatementUpdate.setDouble(2,Converter.parseDouble(group.getCreditLimit()));
            
            preparedStatementUpdate.setString(3,group.getNationality());
            preparedStatementUpdate.setString(4, group.getVip());
            preparedStatementUpdate.setString(5, group.getCountry());
            preparedStatementUpdate.setString(6, group.getPhone());
            preparedStatementUpdate.setString(7, group.getFax());
            preparedStatementUpdate.setString(8, group.getEmail());
            preparedStatementUpdate.setString(9, group.getCompany());
            preparedStatementUpdate.setString(10, group.getVisaType());
            preparedStatementUpdate.setString(11, group.getEntry());
            preparedStatementUpdate.setDate(12, Converter.parseSQLDate(group.getIssue()));
            preparedStatementUpdate.setDate(13, Converter.parseSQLDate(group.getExpire()));
           
            preparedStatementUpdate.setInt(14, Converter.parseInt(group.getAccountId()));
            
            preparedStatementUpdate.executeUpdate();
            
            preparedStatementUpdate = dbConnection.prepareStatement(updateGAccountSQL);
            
            //ga_accstat,
            preparedStatementUpdate.setString(1,"R");
            //ga_gsttype, 
            preparedStatementUpdate.setString(2,"D");
            //ga_rsvtypeno,
            preparedStatementUpdate.setString(3,group.getReserveBy());
            //ga_bookby,
            preparedStatementUpdate.setString(4,group.getBookBy());
            //ga_acctype,
            preparedStatementUpdate.setString(5,"G");
            //ga_walkin,
            preparedStatementUpdate.setString(6,"N");
            
            //ga_agentno,
            preparedStatementUpdate.setInt(7,Converter.parseInt(group.getAgent()));
            //ga_orino,
            preparedStatementUpdate.setString(8,group.getOrigin());
            //ga_arrival,
            preparedStatementUpdate.setDate(9,Converter.parseSQLDate(group.getArrival()));
            //ga_arrtime,
            preparedStatementUpdate.setTime(10,Converter.parseSQLTime(group.getArrTime()));
            //ga_arrfrom, 
            preparedStatementUpdate.setString(11,group.getArrFrom());
            //ga_arrby, 
            preparedStatementUpdate.setString(12,group.getArrBy());
            //ga_departure, 
            preparedStatementUpdate.setDate(13,Converter.parseSQLDate(group.getDeparture()));
            //ga_deptime, 
            preparedStatementUpdate.setTime(14,Converter.parseSQLTime(group.getDepTime()));
            //ga_depto,
            preparedStatementUpdate.setString(15,group.getDepTo());
            //ga_depby,
            preparedStatementUpdate.setString(16,group.getDepBy());
            //ga_fpatno,
            preparedStatementUpdate.setString(17,group.getFollioPattern());
            
            //ga_recdate,
            preparedStatementUpdate.setDate(18,Converter.parseSQLDate(Converter.getCurrentDate()));
            
            //ga_userno,
            preparedStatementUpdate.setString(19,user.getUsername());
            
            //ga_coa
            preparedStatementUpdate.setString(20,Converter.parseToYesNo(group.getCoa()));
            //ga_accno
            preparedStatementUpdate.setInt(21,Converter.parseInt(group.getAccountId()));
            preparedStatementUpdate.executeUpdate();
            
            dbConnection.commit();
            isSave = true;
            

        } catch (SQLException e) {
            errorList.add(e.getMessage());
            dbConnection.rollback();
        } finally {
            preparedStatementUpdate.close();
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
    session.setAttribute("errors"+session.getId(), errorList);
    Group group=new Group(request.getParameter("accountId"), request.getParameter("agent"), request.getParameter("arrBy"), request.getParameter("arrival"), request.getParameter("arrFrom"), request.getParameter("arrTime"), request.getParameter("bookBy"), request.getParameter("coa"), request.getParameter("company"), request.getParameter("country"), request.getParameter("creditLimit"), request.getParameter("depBy"), request.getParameter("departure"), request.getParameter("depTime"), request.getParameter("depTo"), request.getParameter("email"), request.getParameter("entry"), request.getParameter("expire"), request.getParameter("fax"), request.getParameter("follioPattern"), request.getParameter("grpname"), request.getParameter("issue"), request.getParameter("nationality"), request.getParameter("origin"), request.getParameter("phone"), request.getParameter("reserveBy"), request.getParameter("vip"), request.getParameter("visaType"));
    validate(group, errorList);
    WebUser user=(WebUser)session.getAttribute(""+session.getId());
    
    if (errorList.size() > 0) {
        
        response.sendRedirect("editgroup.jsp");
    } else {
        
        if (saveBooking(user1, pw, url, driver,group,user, errorList)) {
            response.sendRedirect("group.jsp");
        } else {
            
            response.sendRedirect("editgroup.jsp");
        }
    }
%>