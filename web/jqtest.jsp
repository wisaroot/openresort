
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
  --%><%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>

<html>
    <head>
        <%@ include file ="config.jsp"%>
        <link href="css/smoothness/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css" media="screen"  />
        <link href="gridJS/src/css/ui.multiselect.css" media="screen" rel="stylesheet" type="text/css" />
  <link href="gridJS/css/ui.jqgrid.css" media="screen" rel="stylesheet" type="text/css" />
       <script src="gridJS/js/jquery-1.5.2.min.js"  type="text/javascript"></script>
        <script src="gridJS/js/i18n/grid.locale-en.js"  type="text/javascript" charset="utf-8"></script>
        <script src="gridJS/src/css/ui.multiselect.js" type="text/javascript" ></script>
        <script src="gridJS/js/jquery.jqGrid.min.js" type="text/javascript"></script>

        <script src="gridJS/plugins/jquery.tablednd.js" type="text/javascript"></script>
        <script src="gridJS/plugins/jquery.contextmenu.js" type="text/javascript"></script>
        <script src="gridJS/src/grid.inlinedit.js" type="text/javascript"></script>
        <script src="gridJS/src/grid.formedit.js" type="text/javascript"></script>
        <script src="gridJS/src/grid.common.js" type="text/javascript"></script>  <script type="text/javascript">
            $.jgrid.no_legacy_api = true;
            $.jgrid.useJSON = true;
        </script>

      </head>
    <body>
       
        
 <table id="colr"></table>
   <%
                    Statement stmt = null;
                    ResultSet rs = null;
                    Connection con = null;
                    String aa="pp";
                    // String co = request.getParameter("code");
                    //  String des = request.getParameter("desc");
                    //  if (request.getParameter("submit") != null) {

                    try {

                        Class.forName("org.postgresql.Driver");
                        con = DriverManager.getConnection(url, user1, pw);
                    } catch (Exception ex) {

                        out.println("exeSQL Error : " + ex.getMessage());
                    }
                    /*      Class.forName("sun.jdbc.odbc.JdbcOdbc");
                    <b style="color:black;background-color:#a0ffff">Connection</b> con=DriverManager.getConnection("jdbc:odbc:MyDatabase","system","database");
                     */
                    try {
                        stmt = con.createStatement();
                        String QueryString = "Select * FROM country";
                        rs = stmt.executeQuery(QueryString);


                        /*       } catch (Exception e) {

                        out.println("exeSQL Error : " + e.getMessage());
                        }
                        }*/
                        out.println("<table id='tblTest' width='300' border='1'>");
//<tr><td>Code </td><td>Description</td></tr>
                        out.println("<tr id='tbl' bgColor=#8080a6 ><td>Code </td><td  width='50%'>Description</td><td colspan='2'> </td></tr>");

                        while (rs.next()) {


                            out.println("<TR id=5  ><TD>" + rs.getString(1) + "</TD><TD>" + rs.getString(2) + "</TD>");
                            out.println("<TD><a href=EditCountry.jsp?id=" + rs.getString(1) + ">edit</td>");
                            out.println("<TD><a href=DeleteCountry.jsp?id=" + rs.getString(1) + ">delete</td></TR>");
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
        <div id="pcolr"></div>
        <div id="filter" style="margin-left:30%;display:none">Search Invoices</div>
    </body>
    <script>
        jQuery("#colr").jqGrid
            (
                {
                    sortable: true,
                    datatype: "local",
                    colNames:['Inv No','Date', 'Client', 'Amount','Tax','Total','Notes'],
                    colModel:[
                                {name:'id',index:'id', width:55},
                                {name:'invdate',index:'invdate', width:90},
                                {name:'name',index:'name asc, invdate', width:100},
                                {name:'amount',index:'amount', width:80, align:"right"},
                                {name:'tax',index:'tax', width:80, align:"right"},
                                {name:'total',index:'total', width:80,align:"right"},
                                {name:'note',index:'note', width:150, sortable:false}
                            ],
                    rowNum:10,
                    rowList:[10,20,30],
                    pager: '#pcolr',
                    sortname: 'invdate',
                    viewrecords: true,
                    sortorder: "desc",
                    caption:"Column Reordering Example" }
            );
        jQuery("#colr").jqGrid('navGrid','#pcolr',{add:false,edit:false,del:false});
       jQuery("#colr").jqGrid('filterToolbar');



        var mydata = [ {id:"1",invdate:"2007-10-01",name:"aa",note:"note",amount:"200.00",tax:"10.00",total:"210.00"}, {id:"2",invdate:"2007-10-02",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"}, {id:"3",invdate:"2007-09-01",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"}, {id:"4",invdate:"2007-10-04",name:"test",note:"note",amount:"200.00",tax:"10.00",total:"210.00"}, {id:"5",invdate:"2007-10-05",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"}, {id:"6",invdate:"2007-09-06",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"}, {id:"7",invdate:"2007-10-04",name:"test",note:"note",amount:"200.00",tax:"10.00",total:"210.00"}, {id:"8",invdate:"2007-10-03",name:"test2",note:"note2",amount:"300.00",tax:"20.00",total:"320.00"}, {id:"9",invdate:"2007-09-01",name:"test3",note:"note3",amount:"400.00",tax:"30.00",total:"430.00"} ];
        for(var i=0;i<=mydata.length;i++)
            jQuery("#colr").jqGrid('addRowData',i+1,mydata[i]);
    </script>
   
</html>
