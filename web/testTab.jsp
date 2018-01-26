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


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>GuestFolio</title>       


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
        <script src="gridJS/src/grid.common.js" type="text/javascript"></script>
        <script src="SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>

        <script type="text/javascript">
            jQuery(document).ready(function(){

  var mygrid = jQuery("#fact").jqGrid({ 
url:'/facts?q=1', 
editurl:'/facts/update', 
datatype: "json", 
colNames:['ID','NAME'], 
colModel:[{name:'id', index:'id',resizable:false,width:135, editable:false },{name:'NAME', index:'NAME',edittype:'text',editable:true}], 
pager: '#fact_pager', 
rowNum:$row_num, 
rowList:$no_elem, 
imgpath: '/images/jqgrid', 
sortname: '', 
viewrecords: true, 
height:$table_height, 
width: $table_width, 
sortorder: '', 
gridview: false, 
scrollrows: true, 
autoheight: false, 
autowidth: false, 
rownumbers: false, 
multiselect: false, 
subGrid: true, 

ondblClickRow: function(id) { 
if (id) { var grid = jQuery('#fact'); 
    if(id != prev) { grid.saveRow(prev);
                     grid.editRow(id, true);
                        prev = id; } 
    else { prev = -1; 
           grid.saveRow(prev); } } }, 

onKeyup: function(id){ grid.saveRow(id); }, 
caption: "Features" }).navGrid('#fact_pager', {edit:true,add:true,del:true,search:true,refresh:true, go:true} )
  mygrid.filterToolbar();mygrid[0].toggleToolbar() }); 



    </script>

    <script type="text/javascript" src="js/jquery-ui-1.7.2.custom.min.js"></script>
    <link href="SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
</head>  <body>  


    <div id="TabbedPanels1" class="TabbedPanels">
        <ul class="TabbedPanelsTabGroup">
            <li class="TabbedPanelsTab" tabindex="0">Individual</li>
            <li class="TabbedPanelsTab" tabindex="0">Group</li>
        </ul>
        <div class="TabbedPanelsContentGroup">
            <div class="TabbedPanelsContent">
                <table id="list10_d" class="scroll"   ></table>
                <div id="pager10_d" class="scroll"  align="center" style="text-align:center;"></div>

            </div>
            <div class="TabbedPanelsContent">Content 2</div>
        </div>
    </div>
    <script type="text/javascript">
        var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
    </script>


</body>  </html>  
