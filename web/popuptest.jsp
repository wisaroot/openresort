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
	<title>ThaiCreate.Com Tutorial</title>
</head>
<body>
<script language="JavaScript">
	function windowOpen() {
		var myWindow=window.open('SelectDepartment.jsp','windowRef','width=500,height=500');
		if (!myWindow.opener) myWindow.opener = self;
	}
</script>
<script language="JavaScript">
	function windowOpen1() {
		var myWindow=window.open('SelectRoom.jsp','windowRef','width=500,height=500');
		if (!myWindow.opener) myWindow.opener = self;
	}
</script>
<form name="frmMain" method="post" action="">
    <input type="text" value="" name="txtVol" id="txtVol"/>
    <input type="text" value="" name="txtVol1" id="txtVol1"/>
   
	<input name="openPopup" type="button" id="openPopup" onClick="Javascript:windowOpen();" value="Search">
         <input type="text" value="" name="txtroom" id="txtroom"/>
    <input type="text" value="" name="txtroom1" id="txtroom1"/>
   
	<input name="openPopup1" type="button" id="openPopup" onClick="Javascript:windowOpen1();" value="Search">
</form>
</body>
</html>
