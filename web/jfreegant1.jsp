
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
<%@ page  import="org.jfree.chart.ChartPanel" %>
<%@ page  import="org.jfree.chart.JFreeChart" %>

<html>
<!-- DW6 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
<link rel="stylesheet" href="2col_leftNav.css" type="text/css">
<style type="text/css">
<!--
.style3 {
font-size: large;
font-weight: bold;
}
-->
</style>
</head>
<!-- The structure of this file is exactly the same as 2col_rightNav.html;
the only difference between the two is the stylesheet they use -->
<body> 
<div id="masthead"> 
<table width="97%" border="0" cellspacing="2" cellpadding="4">
<tr>
<td align="center" bgcolor="#CCCCCC"><strong>Supplier</strong></td>
</tr>
<tr>
<td align="center" bgcolor="#CCCCCC"><strong>Company</strong>:  <Display company name from database> </td>
</tr>
</table>
<h1 id="siteName"> </h1>
<h1>Project:<BR>
  <Display main project>-<Display sub-project> </h1>
</div>
<div id="content">;.
<div class="feature"> 
    <p><jsp:plugin type="applet"   code="org.me.hello.MyApplet" archive="HelloApplet.jar" width="800" height="800" >
      

            <jsp:params>
<jsp:param name="data" value="10"/>
</jsp:params>
</jsp:plugin> 


      


</p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p class="style3">Task Information </p>
<table width="90%" border="0" cellpadding="8" bgcolor="#FFFFFF">
<tr valign="top">
<td align="right" bgcolor="#CCCCCC">Task</td>
<td colspan="2" bgcolor="#FFFFFF"><input name="company" type="text" id="company" size="50"></td>
</tr>
<tr valign="top">
<td align="right" bgcolor="#CCCCCC">Preprocessor</td>
<td colspan="2" bgcolor="#FFFFFF"><input name="country" type="text" id="country" size="50"></td>
</tr>
<tr valign="top">
<td align="right" bgcolor="#CCCCCC">Task start on</td>
<td colspan="2" bgcolor="#FFFFFF"><input name="s_dd" type="text" id="s_dd" size="2">
DD
<input name="s_mth" type="text" id="s_mth" size="2">
MTH
<input name="s_yyyy" type="text" id="s_yyyy" size="4">
YYYY</td>
</tr>
<tr valign="top">
<td align="right" bgcolor="#CCCCCC">Task end on</td>
<td colspan="2" bgcolor="#FFFFFF"><input name="s_dd" type="text" id="s_dd" size="2">
DD
<input name="s_mth" type="text" id="s_mth" size="2">
MTH
<input name="s_yyyy" type="text" id="s_yyyy" size="4">
YYYY</td>
</tr>
<tr valign="top">
<td align="right" bgcolor="#CCCCCC">Duration</td>
<td colspan="2" bgcolor="#FFFFFF"><input name="duration" type="text" id="duration" size="3">
days</td>
</tr>
</table>
<p>
<input name="New Task" type="submit" id="New Task" value="New Task"> 
<input type="submit" name="Submit" value="Update">
</p>
<p>  </p>
<p> </p>
</div> 
<div class="project_info"></div> 
</div> 
<!--end content --> 
<div id="navBar"> 
<div id="search"> </div> 
<div id="sectionLinks"> 
<ul> 
<li><a href="#">Main Project listing </a></li> 
<li><a href="#">Sub Project listing </a></li> 
</ul> 
</div>
<div class="relatedLinks">
<h3> </h3> 
</div> 
</div> 
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<p> </p>
<table width="94%" border="0" cellspacing="2" cellpadding="4">
<tr>
<td align="center" bgcolor="#CCCCCC"><div align="left"><a href="javascript:history.go(-1)">Back</a> | <a href="#">Email Subcontractor</a></div></td>
</tr>
</table>
<p> </p>
</body>
</html>
