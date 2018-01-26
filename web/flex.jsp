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
 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "
http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>test</title>

<link type="text/css" href="css/smoothness/jquery-ui-1.7.2.custom.css" rel="stylesheet" />
<link type="text/css" href="flexigrid-1.1/css/flexigrid.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery-1.5.2.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom.min.js"></script>
<script type="text/javascript" src="flexigrid-1.1/js/flexigrid.js"></script>

<script type="text/javascript">
$(document).ready(function(){
// $('.flexme1').flexigrid({height:'auto', width:'auto'});

$('.jsonFlex').flexigrid({
url:'/TestWeb/JsonServlet',
method: 'GET',
dataType : 'json',
colModel : [
{display: 'Day of Week', name : 'daysofweek', width:100, sortable : true, align: 'center'},
{display: 'Desc', name : 'desc', sortable : true, align: 'left',width:100},
],

sortname: "iso",
sortorder: "asc",
usepager: true,
title: 'FlexiGrid Test',
useRp: true,
rp: 4,
showTableToggleBtn: true
});
});

</script>
</head>
<body>

<center>
<table class="jsonFlex">
</table>
</center>

</body>
</html>
