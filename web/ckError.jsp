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
 <%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<br /><table width="50%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000">
<tr>
<td bgcolor="#FF0000"><font color="#FFFFFF"><b> error</b></font></td>
</tr>
<tr>
<td bgcolor="ECE9D8">
<br />
<%
for(int i=0;i<errors.size();i++){
	out.println("<li>"+errors.elementAt(i));
}
%>
<br /><br /><center><input type="submit" name="Submit" value="edit" onclick="javascript:history.back(1)" /></center></td>
</tr>
</table><br />
