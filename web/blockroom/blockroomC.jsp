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

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.comis.frontsystem.database.JDBCTransaction"%> 
<%@ include file ="../config.jsp"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.*"%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page errorPage="../errorPage.jsp"%>
<%@page import="com.comis.frontsystem.util.Converter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<%@ include file="../login/isLogin.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Block Room</title>
        <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem_popup.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/ico/favicon.ico">
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.6.2.min.js"></script>






    </head>
    <body>
        <div class="content">
            <div class="page-header offset1">
                <h1>Block Room</h1>
            </div>
            <div class="row">

                <div class="span16 columns">
                    <%
                        List<String> errorList = (ArrayList<String>) session.getAttribute("errors" + session.getId());

                    %>	
                    <% if (errorList != null && errorList.size() > 0) {%>	
                    <div class="alert-message block-message error offset1">
                        <p>
                            <%

                                if (errorList != null) {
                                    for (String error : errorList) {
                                        out.println(error + "<br/>");
                                    }
                                    errorList = new ArrayList<String>();
                                    session.setAttribute("errors" + session.getId(), errorList);
                                }
                            %>
                        </p>
                    </div>

                    <% }%>
                    <%

                        errorList = (ArrayList) session.getAttribute("errors" + session.getId());
                        errorList = new ArrayList<String>();
                        session.setAttribute("errors" + session.getId(), errorList);
                        Connection dbConnection = null;
                        PreparedStatement preparedStatementSelect = null;

                        String arr = request.getParameter("arr");
                        String dep = request.getParameter("dep");
                        String bt = request.getParameter("bt");
                        bt = bt.trim();
                        String rt = request.getParameter("rt");
                        rt = rt.trim();

                        try {
                            dbConnection = JDBCTransaction.getDBConnection(user1, pw, url, driver, errorList);
                    %>
                    <!-- content here -->
                    <form class="form-stacked offset1" name="form1" method="post" action="blockroomC_1.jsp" onSubmit="JavaScript:return chooseRoom();">
                        <div class="row"  >


                            <div class="span3" width="350" style="width: 350px"  >
                                <div class="clearfix" width="350" style="width: 350px" >
                                    <label  >Room Available</label>
                                    <div class="input"  >                                   
                                        <select class="span3" id="room" name="room" onclick="getRoom1(this.value)" width="250" style="width: 250px"> 
                                            <%
                                                String sql = "select ri_room,ri_location from roominfo where ri_room not in "
                                                        + "( select gf_roomno from gfolio fol inner join gaccount ac on ga_accno = gf_accno "
                                                        + " where ga_accstat ='I'  and '" + arr + "' < ga_departure and gf_roomno is not null) "
                                                        + "    and ri_room not in  (select bl_roomno from block  where  bl_arrdate between '" + arr + "' and '" + dep + "' "
                                                        + " or '" + arr + "' between bl_arrdate and bl_depdate-1 ) and ri_room not in ( "
                                                        + "  select ro_id from roomooo   where  '" + arr + "' between ro_start and ro_end "
                                                        + "    or ro_start between '" + arr + "' and '" + dep + "' ) and (ri_type='" + rt + "') and (ri_bedtype='" + bt + "')  order by ri_room asc ";
                                                Statement stmt = dbConnection.createStatement();
                                                String ll = "  location   ";
                                                String ll1 = "Room no.   ";
                                                ResultSet rs = null;
                                                rs = stmt.executeQuery(sql);
                                                while (rs.next()) {
                                            %>
                                            <option value="<%=rs.getString(1)%>"><%=ll1%> <%=rs.getString(1)%><%=ll%><%=rs.getString(2)%> </option>
                                            <%
                                                }
                                            %>
                                            <option value="none" >&nbsp;</option>
                                        </select>
                                    </div>
                                </div>
                            </div>



                            <script>
                                function getRoom1(str){
                                                 
                                    var lo=$('#room').val();
                                                   
                                    if (lo=="none" ){
                                        alert("Please  change Room type or bed type");
                                        self.close();
                                    }
                                                  
                                                    
                                                  
                                                  
                                }
                            </script>
                            <script>
                                function getRoom(){
                                                  
                                    var arr='<%=(String) request.getParameter("arr")%>';
                                    var dep='<%=(String) request.getParameter("dep")%>';
                                    var bt='<%=(String) request.getParameter("bt")%>';
                                    var rt='<%=(String) request.getParameter("rt")%>';
                                    var lo=$('#location').val();
                                    var st=$('#status').val();
                                    var ex=$('#exposure').val();
                                    $.ajax( '<%=request.getContextPath()%>/blockroom/getroom.jsp?bt='+bt+'&rt='+rt+'&lo='+lo+'&st='+st+'&ex='+ex+'&arr='+arr+'&dep='+dep).done(function(data) { 
                                        $('#room').children().remove();
                                        $('#room').append(data);
                                    })
                                }
                            </script>
                            <div class="span1">
                                <div class="clearfix">
                                    <label>Block</label>
                                    <div class="input">
                                        <script type="text/javascript">
                                            function chooseRoom(){
                                                var lo=$('#room').val();
                                                   
                                                if (lo=="none" ){
                                                    alert("Please  select room before block");
                                                    document.form1.room.focus();
                                                    return false;
                                        
                                                }
                                                document.form1.submit();
                                                      var p=window.opener;
                                                
                                                if(p.$('#roomNo')!==null)
                                                    p.$('#roomNo').val($('#room').val());
                                               // return true; */
                                            }
                                        </script>
                                        <input type="hidden" name="bkacc" value="<%=(String) request.getParameter("bkacc")%>"/>
                                        <input type="hidden" name="dtl" value="<%=(String) request.getParameter("dtl")%>"/>
                                        <input type="hidden" name="arr" value="<%=(String) request.getParameter("arr")%>"/>
                                        <input type="hidden" name="dep" value="<%=(String) request.getParameter("dep")%>"/>
                                        <input type="hidden" name="bt" value="<%=(String) request.getParameter("bt")%>"/>
                                        <input type="hidden" name="rt" value="<%=(String) request.getParameter("rt")%>"/>
                                        <input type="hidden" name="qty" value="<%=(String) request.getParameter("qty")%>"/>
                                        <input type="hidden" name="seq" value="<%=(String) request.getParameter("seq")%>"/>
                                        <% int q = Integer.parseInt(request.getParameter("qty"));
                                            int count = 0;
                                            preparedStatementSelect = dbConnection.prepareStatement("SELECT block.bl_seq,   block.bl_arrdate,   block.bl_depdate,roominfo.ri_room FROM   public.block,   public.users,   public.roominfo,   public.gaccount WHERE   block.bl_accno = gaccount.ga_accno AND  block.bl_userno = users.userid AND  block.bl_roomno = roominfo.ri_room AND bl_accno=? AND bl_dtlseq=? AND bl_seq=?;");

                                            preparedStatementSelect.setInt(1, Converter.parseInt((String) request.getParameter("bkacc")));
                                            preparedStatementSelect.setInt(2, Converter.parseInt((String) request.getParameter("dtl")));
                                            preparedStatementSelect.setInt(3, Converter.parseInt((String) request.getParameter("seq")));

                                            rs = preparedStatementSelect.executeQuery();
                                            while (rs.next()) {
                                                count++;
                                            }
                                            if (count < q) {

                                        %>
                                        <input type="submit" class="btn info"   value="+"/>

                                        <%}%>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </form>
                    <div class="row">
                        <div class="span12 offset2">
                            <div class="alert-message block-message info" id="roomfacility">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="span12 offset2">
                            <table id="blroom">
                                <thead>
                                    <tr>
                                        <th>Room</th>
                                        <th>Arrival</th>
                                        <th>Departure</th>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        preparedStatementSelect = dbConnection.prepareStatement("SELECT block.bl_seq,   block.bl_arrdate,   block.bl_depdate,roominfo.ri_room FROM   public.block,   public.users,   public.roominfo,   public.gaccount WHERE   block.bl_accno = gaccount.ga_accno AND  block.bl_userno = users.userid AND  block.bl_roomno = roominfo.ri_room AND bl_accno=? AND bl_dtlseq=? AND bl_seq=?;");

                                        preparedStatementSelect.setInt(1, Converter.parseInt((String) request.getParameter("bkacc")));
                                        preparedStatementSelect.setInt(2, Converter.parseInt((String) request.getParameter("dtl")));
                                        preparedStatementSelect.setInt(3, Converter.parseInt((String) request.getParameter("seq")));

                                        rs = preparedStatementSelect.executeQuery();
                                        while (rs.next()) {
                                    %>
                                    <tr>
                                        <td><%=rs.getString(4)%></td>
                                        <td><%=rs.getString(2)%></td>
                                        <td><%=rs.getString(3)%></td>
                                        <td><a class="btn info" href="<%=request.getContextPath()%>/blockroom/blockroomC_2.jsp?bkacc=<%=request.getParameter("bkacc")%>&dtl=<%=request.getParameter("dtl")%>&seq=<%=rs.getString(1)%>&bt=<%=request.getParameter("bt")%>&rt=<%=request.getParameter("rt")%>&arr=<%=request.getParameter("arr")%>&qty=<%=request.getParameter("qty")%>&dep=<%=request.getParameter("dep")%>" >-</a></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                                <%

                                    } catch (SQLException e) {
                                        errorList.add(e.getMessage());
                                    } finally {
                                        preparedStatementSelect.close();
                                        if (dbConnection != null) {
                                            dbConnection.close();
                                        }
                                    }
                                %>
                            </table>

                        </div>
                    </div>
                    <div class="row">
                        <div class="actions">
                            <button class="btn primary offset-two-thirds" onclick="self.close()">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
