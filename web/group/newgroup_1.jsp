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
<%@ include file ="../config.jsp"%>
<%@ include file="../login/isLogin.jsp" %>
<%!
    private void validate(Group group,List errorList){
        String    vip = group.getVip(),
                reserveBy = group.getReserveBy(),
                follioPattern = group.getFollioPattern(),
               
                
              
                origin = group.getOrigin(),
                bookBy = group.getBookBy(),
                agent = group.getAgent(),
                nationality = group.getNationality(),
               
                company = group.getCompany(),
               
                creditLimit = group.getCreditLimit(),
              
                phone = group.getPhone(),
                fax = group.getFax(),
                country = group.getCountry(),
                email = group.getEmail(),
               
                arrival = group.getArrival(),
                arrTime = group.getArrTime(),
                arrFrom = group.getArrFrom(),
                arrBy = group.getArrBy(),
                departure = group.getDeparture(),
                depTime = group.getDepTime(),
                depTo = group.getDepTo(),
                depBy = group.getDepBy();
        
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
        PreparedStatement preparedStatementInsert = null;
        String insertGuestInfoSQL = "INSERT INTO groupinfo(gri_grpname, gri_crlimit, gri_natno, gri_vipno, gri_ctno, gri_telno, gri_faxno, gri_email, gri_company,  gri_visatypeno, gri_entryno, gri_pissue, gri_pexpire) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
      String insertGAccountSQL = "INSERT INTO gaccount(ga_accstat, ga_gsttype, ga_rsvtypeno, ga_bookby, ga_acctype, ga_walkin, ga_grpno,ga_agentno, ga_orino, ga_arrival, ga_arrtime, ga_arrfrom, ga_arrby, ga_departure, ga_deptime, ga_depto, ga_depby, ga_fpatno, ga_recdate, ga_userno, ga_coa)VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
        ResultSet generatedKeys = null;
        boolean isSave = false;
        try {
           dbConnection = JDBCTransaction.getDBConnection( user1, pw, url, driver, errorList);
            dbConnection.setAutoCommit(false);
            preparedStatementInsert = dbConnection.prepareStatement(insertGuestInfoSQL,Statement.RETURN_GENERATED_KEYS);
            preparedStatementInsert.setString(1,group.getGrpname());
            preparedStatementInsert.setDouble(2,Converter.parseDouble(group.getCreditLimit()));
            preparedStatementInsert.setString(3,group.getNationality());
            preparedStatementInsert.setString(4, group.getVip());
            preparedStatementInsert.setString(5, group.getCountry());
            preparedStatementInsert.setString(6, group.getPhone());
            preparedStatementInsert.setString(7, group.getFax());
            preparedStatementInsert.setString(8, group.getEmail());
            preparedStatementInsert.setString(9, group.getCompany());
            preparedStatementInsert.setString(10, group.getVisaType());
            preparedStatementInsert.setString(11, group.getEntry());
            preparedStatementInsert.setDate(12, Converter.parseSQLDate(group.getIssue()));
            preparedStatementInsert.setDate(13, Converter.parseSQLDate(group.getExpire()));
            preparedStatementInsert.executeUpdate();
            generatedKeys = preparedStatementInsert.getGeneratedKeys();
            int grInfoId;
            if (generatedKeys.next()) {
                grInfoId=generatedKeys.getInt(1);
            } else {
                throw new SQLException("Can't create groupinfo");
            }

            
            
          preparedStatementInsert = dbConnection.prepareStatement(insertGAccountSQL,Statement.RETURN_GENERATED_KEYS);
            //ga_accstat,
            preparedStatementInsert.setString(1,"R");
            //ga_gsttype, 
            preparedStatementInsert.setString(2,"D");
            //ga_rsvtypeno,
            preparedStatementInsert.setString(3,group.getReserveBy());
            //ga_bookby,
            preparedStatementInsert.setString(4,group.getBookBy());
            //ga_acctype,
            preparedStatementInsert.setString(5,"G");
            //ga_walkin,
            preparedStatementInsert.setString(6,"N");
            //ga_guestno,
            preparedStatementInsert.setInt(7,grInfoId);
            //ga_agentno,
            preparedStatementInsert.setInt(8,Converter.parseInt(group.getAgent()));
            //ga_orino,
            preparedStatementInsert.setString(9,group.getOrigin());
            //ga_arrival,
            preparedStatementInsert.setDate(10,Converter.parseSQLDate(group.getArrival()));
            //ga_arrtime,
            preparedStatementInsert.setTime(11,Converter.parseSQLTime(group.getArrTime()));
            //ga_arrfrom, 
            preparedStatementInsert.setString(12,group.getArrFrom());
            //ga_arrby, 
            preparedStatementInsert.setString(13,group.getArrBy());
            //ga_departure, 
            preparedStatementInsert.setDate(14,Converter.parseSQLDate(group.getDeparture()));
            //ga_deptime, 
            preparedStatementInsert.setTime(15,Converter.parseSQLTime(group.getDepTime()));
            //ga_depto,
            preparedStatementInsert.setString(16,group.getDepTo());
            //ga_depby,
            preparedStatementInsert.setString(17,group.getDepBy());
            //ga_fpatno,
            preparedStatementInsert.setString(18,group.getFollioPattern());
            //ga_recdate,
            preparedStatementInsert.setDate(19,Converter.parseSQLDate(Converter.getCurrentDate()));
            //ga_userno,
            preparedStatementInsert.setString(20,user.getUsername());
            //ga_coa
            preparedStatementInsert.setString(21,Converter.parseToYesNo(group.getCoa()));
            preparedStatementInsert.executeUpdate();
            generatedKeys = preparedStatementInsert.getGeneratedKeys();
            int gAccountId;
            if (generatedKeys.next()) {
                gAccountId=generatedKeys.getInt(1);
                group.setAccountId(""+gAccountId);
            } else {
                throw new SQLException("Can't create gaccount");
            }
 
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
%>
<%
    List<String> errorList = (ArrayList) session.getAttribute("errors" + session.getId());
    errorList = new ArrayList<String>();
    session.setAttribute("errors"+session.getId(), errorList);
    Group group=new Group(request.getParameter("accountId"), 
            request.getParameter("agent"),
            request.getParameter("arrBy"),
            request.getParameter("arrival"), 
            request.getParameter("arrFrom"),
            request.getParameter("arrTime"),
            request.getParameter("bookBy"),
            request.getParameter("coa"),
            request.getParameter("company"),
            request.getParameter("country"), 
            request.getParameter("creditLimit"),
            request.getParameter("depBy"),
            request.getParameter("departure"),
            request.getParameter("depTime"),
            request.getParameter("depTo"),
            request.getParameter("email"),
            request.getParameter("entry"),
            request.getParameter("expire"),
            request.getParameter("fax"), 
            request.getParameter("follioPattern"),
            request.getParameter("grpname"),
            request.getParameter("issue"), 
            request.getParameter("nationality"), 
            request.getParameter("origin"),
            request.getParameter("phone"),
            request.getParameter("reserveBy"),
            request.getParameter("vip"), 
            request.getParameter("visaType"));
    
    WebUser user=(WebUser)session.getAttribute(""+session.getId());
 validate(group, errorList);
    if (errorList.size() > 0) {
        
        response.sendRedirect("newgroup.jsp");
    } else {
        if (saveBooking(user1, pw, url, driver,group,user, errorList)) {
            response.sendRedirect("../booking/bookingdetails.jsp?acc="+group.getAccountId());
        } else {
            
            response.sendRedirect("newgroup.jsp");
        }
    }
%>