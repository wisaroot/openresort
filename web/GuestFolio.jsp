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

  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  <html xmlns="http://www.w3.org/1999/xhtml"> 
    <%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
    <%@ include file ="config.jsp"%>
    <head>          <title>Folio</title>       
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />    
        <script type="text/javascript" src="js/jquery-1.5.1.min.js"></script>   
        <script type="text/javascript" src="js/ui.core.min.js"></script>      
        <script type="text/javascript" src="js/ui.sortable.min.js"></script>   
        <script type="text/javascript" src="js/jquery.metadata.js"></script>   
        <script type="text/javascript" src="js/mbTabset.js"></script>        
        <link rel="stylesheet" type="text/css" href="css/mbTabset.css" title="style"  media="screen"/>   
        <script type="text/javascript">     
            $(function(){                 
                $("#tabset1").buildMbTabset({  
                    stop:function(){if ($("#array").is(":checked")) alert($.mbTabset.mbTabsetArray)},                                  sortable:true                          });       
                
                $("#tabset2").buildMbTabset({                              
                    stop:function(){if ($("#array").is(":checked")) alert($.mbTabset.mbTabsetArray)},                                  sortable:false,                            
                    position:"left"                          });       
                //$("#b").selectMbTab();           
            });  
            var ajaxUrl="content_2.html";   
            var ajaxD="pippo=1&pluto=2";  
            
        </script> 


    </head>  <body>  

        <%
            Statement stmt = null;
            ResultSet rs = null;
            Connection con = null;
            String id = request.getParameter("id");
            String code = "";
            String desc = "";
            String keep = "";
            String QueryString1 = "";
            String folno = "";
            String roomno = "";
            String rateno = "";
            String room = "";
            String service = "";
            String tax = "";
            String extrabed = "";
            String extbedserv = "";
            String extbedtax = "";
            String abf = "";
            String lunch = "";
            String dinner = "";
            String total = "";
            int guestno = 0;
            String accno = "";
            int agentno =0 ;
            String crlimit = "";
            String name = "";
            String agent = "";
            String arrival = "";
            String departure = "";
            boolean comp=false;
            String k1 = "";
            int g = 0;


            //  out.println(id);
            //  if (request.getParameter("submit") != null) {
            try {
                Class.forName("org.postgresql.Driver");
                con = DriverManager.getConnection(url, user1, pw);
            } catch (Exception ex) {

                out.println("exeSQL Error1 : " + ex.getMessage());
            }
            /*      Class.forName("sun.jdbc.odbc.JdbcOdbc");
            <b style="color:black;background-color:#a0ffff">Connection</b> con=DriverManager.getConnection("jdbc:odbc:MyDatabase","system","database");
             */

            if ((id != null) && (request.getParameter("submit") == null)) {
                int maxfol = Integer.parseInt(id);
                try {

                    stmt = con.createStatement();
                    id = id.trim();
                    rs = stmt.executeQuery(" select ga_guestno from gfolio left join gaccount on (gfolio.gf_accno=gaccount.ga_accno)  where  ga_guestno is not null and gf_folno =" + maxfol + " ");

                    while (rs.next()) {
                        g = 1;
                    }
                    if (g == 1) {
                        //out.println(maxfol);
                        QueryString1 = "Select gf_folno,gf_roomno,gf_rateno,gf_room,gf_service,gf_tax,gf_extrabed,gf_extbedserv,gf_extbedtax,gf_abf,gf_lunch,gf_dinner,gf_total,ga_guestno,gf_accno,ga_agentno,ga_arrival,ga_departure,gf_comp FROM gfolio left join gaccount on (gfolio.gf_accno= gaccount.ga_accno) WHERE  gf_folno =" + maxfol + " ";
                        rs = stmt.executeQuery(QueryString1);
                        while (rs.next()) {
                            folno = rs.getString(1);
                            roomno = rs.getString(2);
                            rateno = rs.getString(3);
                            room = rs.getString(4);
                            service = rs.getString(5);
                            tax = rs.getString(6);
                            extrabed = rs.getString(7);
                            extbedserv = rs.getString(8);
                            extbedtax = rs.getString(9);
                            abf = rs.getString(10);
                            lunch = rs.getString(11);
                            dinner = rs.getString(12);
                            total = rs.getString(13);
                            guestno = rs.getInt(14);
                            accno = rs.getString(15);
                            agentno = rs.getInt(16);
                            arrival = rs.getString(17);
                            departure = rs.getString(18);
                            comp = rs.getBoolean("gf_comp");

                        }
                     //   String anObject = "TRUE";
                        if (comp) {
                            k1 = "checked";

                        } else {
                            k1 = "";
                        }
                        QueryString1 = "Select  a_name FROM agent  WHERE a_id ='" + agentno + "'";
                        rs = stmt.executeQuery(QueryString1);
                        while (rs.next()) {
                            agent = rs.getString(1);

                        }

                        QueryString1 = "Select gn_fname||' '||gn_lname,gi_crlimit FROM guestname left join guestinfo on (guestname.gn_guestno = guestinfo.gi_guestno) WHERE gn_guestno ='" + guestno + "'";
                        rs = stmt.executeQuery(QueryString1);
                        while (rs.next()) {
                            name = rs.getString(1);
                            crlimit = rs.getString(2);

                        }
                    }else {
                        try{
                        QueryString1 = "Select gf_folno,gf_roomno,gf_rateno,gf_room,gf_service,gf_tax,gf_extrabed,gf_extbedserv,gf_extbedtax,gf_abf,gf_lunch,gf_dinner,gf_total,ga_grpno,gf_accno,ga_agentno,ga_arrival,ga_departure,gf_comp FROM gfolio left join gaccount on (gfolio.gf_accno= gaccount.ga_accno) WHERE  gf_folno =" + maxfol + " ";
                    rs = stmt.executeQuery(QueryString1);
                    while (rs.next()) {
                        folno = rs.getString(1);
                        roomno = rs.getString(2);
                        rateno = rs.getString(3);
                        room = rs.getString(4);
                        service = rs.getString(5);
                        tax = rs.getString(6);
                        extrabed = rs.getString(7);
                        extbedserv = rs.getString(8);
                        extbedtax = rs.getString(9);
                        abf = rs.getString(10);
                        lunch = rs.getString(11);
                        dinner = rs.getString(12);
                        total = rs.getString(13);
                        guestno = rs.getInt(14);
                        accno = rs.getString(15);
                        agentno = rs.getInt(16);
                        arrival = rs.getString(17);
                        departure = rs.getString(18);
                        comp = rs.getBoolean(19);

                    }
                  //  String anObject = "TRUE";
                    if (comp) {
                        k1 = "checked";

                    } else {
                        k1 = "";
                    }
                    
                    QueryString1 = "Select  a_name FROM agent  WHERE a_id = " + agentno ;
                    rs = stmt.executeQuery(QueryString1);
                    while (rs.next()) {
                        agent = rs.getString(1);

                    }

                    QueryString1 = "Select gri_grpname,gri_crlimit FROM  groupinfo where gri_grpno =" + guestno ;
                    rs = stmt.executeQuery(QueryString1);
                    while (rs.next()) {
                        name = rs.getString(1);
                        crlimit = rs.getString(2);

                    }

                      } catch (Exception ex) {

                    //      out.println("Unable to connect to database.");
                    // table.getSelectedRow();


                    out.println("exeSQL Error1 : " + ex.getMessage());
                }
                    
                    }
                    // close all the connections.

                } catch (Exception ex) {

                    //      out.println("Unable to connect to database.");
                    // table.getSelectedRow();


                    out.println("exeSQL Error2 : " + ex.getMessage());
                }


            }
        %>

        <div class="wrapper" align="left" > 
            <table width="100%" border="0"  align="center" cellpadding="0" style=" border-color: #00F" >
                <tr style=" height:35px " bgcolor="#FFC"  ><td align="center" >

                        <input type="button" onclick="window.location.href='PostToRoom.jsp?id1=<%=folno%>&id2=<%=roomno%> '"  value="Post"/>



                        <input type="button" onclick="window.location.href='Transfer.jsp?id1=<%=folno%>&id2=<%=roomno%> '"  value="Transfer"/>
                        <input type="button" onclick="window.location.href='Payment.jsp?id1=<%=folno%>&id2=<%=roomno%> '"  value="Payment"/>

                    </td> 
                </tr>
                <tr><td><p></p></td></tr>
            </table>


            <div class="tabset" id="tabset1" align="left" >
                <a id="a" class="tab  {content:'cont_1'}"  >InFo</a>
                <a id="b" class="tab  {content:'cont_2', ajaxContent:ajaxUrl,ajaxData:ajaxD}">Master</a>
                <a id="c" class="tab {content:'cont_3'}">Extra</a>
            </div>

            <div id="cont_1" style=" width: 700px" align="left" >                
                <h3>



                    <form method="post" enctype="multipart/form-data">
                        <table><tr>
                                <table width="70%" border="0" align="left" cellpadding="0" style=" border-color: #00F" >

                                    <tr>
                                        <td width="12%">Room</td>
                                        <td width="35%"><input type="text" name="roomno" value="<%=roomno%>"  />
                                        </td>
                                        <td width="18%" > Folio</label></td>
                                        <td width="35%"><input type="text" name="name" value="<%=folno%>"  />
                                        </td>

                                    </tr>
                                    <tr>
                                        <td height="30" >
                                            <div >Name</div>
                                        </td>
                                        <td ><input type="text" name="name" value="<%=name%>"  />
                                        </td>
                                        <td >Account</td>
                                        <td ><input type="text" name="name" value="<%=accno%>" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  >
                                            <div >Agent</div>
                                        </td>
                                        <td ><input type="text" name="name" value="<%=agent%>"  />
                                        </td>

                                        <td  >
                                            <div >Credit Limit</div>
                                        </td>
                                        <td colspan="2"><input type="text" name="name" value="<%=crlimit%>" />
                                        </td>

                                    </tr>
                                    <tr>
                                        <td  >
                                            <div >Arrival</div>
                                        </td>
                                        <td ><input type="text" name="name" value="<%=arrival%>"  />
                                        </td>

                                        <td  >
                                            <div >Departure</div>
                                        </td>
                                        <td colspan="2"><input type="text" name="name" value="<%=departure%>" />
                                        </td>

                                    </tr>
                                    <tr>
                                        <td>
                                            <div >Memo</div>
                                        </td>
                                        <td colspan="3"><textarea name="" cols="" rows="2" readonly="readonly" style="width:320px"></textarea> 
                                        </td>

                                    </tr>


                                </table>
                            </tr>
                            <tr>
                                <table  width="70%" border="0" align="left" cellpadding="0" style=" border-color: #00F">
                                    <tr  bgColor=#8080a6   ><td colspan="6"><div align="center" style="">
                                                <div align="center"><strong>Rate Info</strong></div>
                                            </div></td></tr>
                                    <tr>
                                        <td> <div >Room</div> </td><td ><input type="text" name="name" value="<%=room%>"   />
                                        </td>
                                        <td> <div >Service</div> </td><td ><input type="text" name="name" value="<%=service%>"  />
                                        </td>
                                        <td> <div >Tax</div> </td><td ><input type="text" name="name" value="<%=tax%>"  />
                                        </td></tr>
                                    <tr>


                                        <td> <div >Ext.Bed</div> </td><td ><input type="text" name="name" value="<%=extrabed%>"  />
                                        </td>
                                        <td> <div >Service</div> </td><td ><input type="text" name="name" value="<%=extbedserv%>"  />
                                        </td>
                                        <td> <div >Tax</div> </td><td ><input type="text" name="name" value="<%=extbedtax%>"  />
                                        </td></tr>
                                    <tr>
                                        <td  > <div >ABF</div> </td><td ><input type="text" name="name" value="<%=abf%>"  />
                                        </td>
                                        <td> <div >Lunch</div> </td><td ><input type="text" name="name" value="<%=lunch%>"  />
                                        </td>
                                        <td> <div >Dinner</div> </td><td ><input type="text" name="name" value="<%=dinner%>"  />
                                        </td></tr>
                                    <tr><td><div >Complimentary</div></td><td><input name="Complimentary" type="checkbox"  <%=k1%> /></td><td><div >Total</div></td><td colspan="3" ><input type="text" name="name" value="<%=total%>"  /></td></tr>
                                </table></tr>



                        </table>
                    </form>
                </h3>     
            </div>
            <div id="cont_2">          
                <h3>




                    <%



                        /*      Class.forName("sun.jdbc.odbc.JdbcOdbc");
                        <b style="color:black;background-color:#a0ffff">Connection</b> con=DriverManager.getConnection("jdbc:odbc:MyDatabase","system","database");
                         */
                        try {
                            stmt = con.createStatement();
                            String Total1 = null;
                            String QueryString = "Select gfs_folbal from gfolseq  Where gfs_folno = '" + folno + "' and gfs_folseq = 1 ";
                            rs = stmt.executeQuery(QueryString);
                            while (rs.next()) {
                                Total1 = rs.getString(1);
                            }
                            out.println("Total = " + Total1);
                            QueryString = "Select gt_trndate||' '||gt_trntime,gt_deptno,gt_deptdesc,gt_refno,gt_qty,gt_amount,gt_trnseq,gt_corrflag FROM gtran where gt_folno= '" + folno + "' and gt_folseq = 1 and upper(gt_TxOutFlag) <> 'Y' order by gt_trnseq ";
                            rs = stmt.executeQuery(QueryString);
                            out.println("<table id='tblTest' width='300' border='1'>");
                            //<tr><td>Code </td><td>Description</td></tr>
                            out.println("<tr id='tbl' bgColor=#8080a6 ><td  width='30%'>Date-Time</td><td>Dept No</td><td>Description</td><td>Ref No </td><td>Qty </td><td>Amount </td><td >Void </td><td ></td></tr>");

                            while (rs.next()) {
                                out.println("<TR id=5  ><TD>" + rs.getString(1) + "</TD><TD>" + rs.getString(2) + "</TD><TD>" + rs.getString(3) + "</TD><TD>" + rs.getString(4) + "</TD><TD>" + rs.getString(5) + "</TD><TD>" + rs.getString(6) + "</TD><TD style=' background-color: #fcefa1'>" + rs.getString(8) + "</TD>");

                                out.println("<TD><a href=\"VoidTran.jsp?id1=" + folno + "&id2=" + rs.getString(7) + "&id3=" + rs.getString(8) + "&id4=" + id + "&id5=1\"  onclick=\"return confirm('Void ?');\" >Void</td></TR>");
                            }

                            // close all the connections.

                        } catch (Exception ex) {

                            out.println("Unable to connect to database.");
                            // table.getSelectedRow();
                        }
                        out.println("</table>");
                    %>








                </h3>

                <p>&nbsp;</p>     
            </div>     
            <div id="cont_3">        
                <h3>





                    <%



                        /*      Class.forName("sun.jdbc.odbc.JdbcOdbc");
                        <b style="color:black;background-color:#a0ffff">Connection</b> con=DriverManager.getConnection("jdbc:odbc:MyDatabase","system","database");
                         */

                        try {
                            stmt = con.createStatement();
                            String Total2 = null;
                            String QueryString = "Select gfs_folbal from gfolseq  Where gfs_folno = '" + folno + "' and gfs_folseq = 2 ";
                            rs = stmt.executeQuery(QueryString);
                            while (rs.next()) {
                                Total2 = rs.getString(1);
                            }
                            out.println("Total = " + Total2);
                            QueryString = "Select gt_trndate||' '||gt_trntime,gt_deptno,gt_deptdesc,gt_refno,gt_qty,gt_amount,gt_trnseq,gt_corrflag FROM gtran where gt_folno= '" + folno + "' and gt_folseq = 2 and upper(gt_TxOutFlag) <> 'Y' order by gt_trnseq ";
                            rs = stmt.executeQuery(QueryString);
                            out.println("<table id='tblTest' width='300' border='1'>");

                            //<tr><td>Code </td><td>Description</td></tr>
                            out.println("<tr id='tbl' bgColor=#8080a6 ><td  width='30%'>Date-Time</td><td>Dept No</td><td>Description</td><td>Ref No </td><td>Qty </td><td>Amount </td><td >Void </td><td ></td></tr>");

                            while (rs.next()) {
                                out.println("<TR id=5  ><TD>" + rs.getString(1) + "</TD><TD>" + rs.getString(2) + "</TD><TD>" + rs.getString(3) + "</TD><TD>" + rs.getString(4) + "</TD><TD>" + rs.getString(5) + "</TD><TD>" + rs.getString(6) + "</TD><TD style=' background-color: #fcefa1'>" + rs.getString(8) + "</TD>");
                                //   out.println("<TD><input type=button name='void' value=\"id1=" + folno + "&id2=" + rs.getString(7) +"&id3=" + rs.getString(8) + "&id4=" + id + "&id5=2\" onClick='confirm1()'></td></TR>");

                                out.println("<TD><a href=\"VoidTran.jsp?id1=" + folno + "&id2=" + rs.getString(7) + "&id3=" + rs.getString(8) + "&id4=" + id + "&id5=2\"  onclick=\"if (! confirm('void?')) return  false; \" >Void</td></TR>");

                            }

                            // close all the connections.
                            rs.close();
                            stmt.close();
                            con.close();
                        } catch (Exception ex) {

                            out.println("Unable to connect to database.");
                            // table.getSelectedRow();
                        }
                        out.println("</table>");
                    %>








                </h3>         </div>   

        </div> 



    </body>  </html>  
