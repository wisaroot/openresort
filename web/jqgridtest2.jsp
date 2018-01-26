
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
        <style type="text/css">
            html, body {
                margin: 0;
                padding: 0;
                font-size: 75%;
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



        <script type="text/javascript">
            jQuery(document).ready(function(){
              jQuery("#list10_d").jqGrid({
                                url:'getsubdata.jsp?id=0',
                                datatype: 'json',
                                colNames:['No','Item', 'Qty'],
                                //'Date','AVL','BKK','CFM','INH','OOO','HSU','TTL',"TTT","DSU"
                                //   }).navGrid('#page',{ page:true, search:true,edit:false,add:false,del:false,searchtext:"Search"});
                                colModel:[
                                        {name:'num',index:'num' },
                                        {name:'item',index:'item'},
                                        {name:'qty',index:'qty',align:"center"},
                                      ],
                                rowNum:5,
                                rowList:[5,10,20],
                                pager: '#pager10_d',
                                sortname: 'item',
                                viewrecords: true,
                                sortorder: "asc",
                                multiselect: true,
                                imgpath: "themes/basic/images",
                                caption:"Invoice Detail"
                        }).navGrid('#pager10_d',{add:false,edit:false,del:false});


     }//function
    );
        </script>
    </head>
    <body >
        <table id="list10_d" class="scroll"></table>
        <div id="pager10_d" class="scroll" style="text-align:center;"></div>
       

    </body>
</html>