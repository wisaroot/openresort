
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
       <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JQGrid Special</title>
        <link href="css/smoothness/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css" media="screen"  />
        <link href="gridJS/src/css/ui.multiselect.css" media="screen" rel="stylesheet" type="text/css" />
        <link href="gridJS/css/ui.jqgrid.css" media="screen" rel="stylesheet" type="text/css" />
        <style type="text/css" media="screen">
            .ui-jqgrid .ui-jqgrid-htable th div {
                height:auto;
                text-align:center;
                overflow:hidden;
                padding-right:4px;
                padding-top:2px;
                position:relative;
                vertical-align:text-top;
                white-space:normal !important;
            }
            .ui-jqgrid tr.jqgrow td {
                white-space: normal !important;
                height:auto;
                vertical-align:text-top;
                padding-top:2px;
            }


        </style>


        <script src="gridJS/js/jquery-1.5.2.min.js"  type="text/javascript"></script>
        <script src="gridJS/js/i18n/grid.locale-en.js"  type="text/javascript" charset="utf-8"></script>
        <script src="gridJS/src/css/ui.multiselect.js" type="text/javascript" ></script>
        <script src="gridJS/js/jquery.jqGrid.min.js" type="text/javascript"></script>

        <script src="gridJS/plugins/jquery.tablednd.js" type="text/javascript"></script>
        <script src="gridJS/plugins/jquery.contextmenu.js" type="text/javascript"></script>
        <script src="gridJS/src/grid.inlinedit.js" type="text/javascript"></script>
        <script src="gridJS/src/grid.formedit.js" type="text/javascript"></script>
        <script src="gridJS/src/grid.common.js" type="text/javascript"></script>




        <script  >
            function fillGridOnEvent(){
                $("#jQGrid").html("<table id=\"list\"></table><div id=\"page\"></div>");

                jQuery("#list").jqGrid({
                    url:'<%=request.getContextPath()%>/JQGridServlet?q=1&action=fetchData',
                    datatype: "xml",
                    height: 250,

                    colNames:['Sr. No.','Student Name','Student Std.','Student RollNo.',"Action"],
                    colModel:[
                        {name:'srNo',index:'srNo', width:90,sortable:true},
                        {name:'stdName',index:'stdName', width:130,sortable:false},
                        {name:'stdStd',index:'stdStd', width:100,sortable:false},
                        {name:'stdRollNo',index:'stdRollNo', width:180,sortable:false},
                        {name:'view',index:'view', width:100,sortable:false}
                    ],
                    multiselect: false,
                    mtype: "GET",
                    paging: true,
                    rowNum:10,
                   // imgpath: gridimgpath,
                    rowList:[10,20,30],
                    pager: $("#page"),
                    loadonce:true,
                    viewrecords: true,
                    gridview: true,
                    height: '100%',
                    width:700,
                    caption: "Student Details"
                }).navGrid('#page',{ page:true, search:true,edit:false,add:false,del:false,searchtext:"Search"});
                //  }).navGrid('#page',{edit:false,add:false,del:false},{},{},{},{multipleSearch:true, multipleGroup:true, showQuery: true});


            }
            jQuery().ready(function (){
                //fillGrid();
            });
        </script>
    </head>
    <body onload="fillGridOnEvent();">
        <div id="jQGrid" align="center">

        </div>

    </body>
</html>