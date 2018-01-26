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


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="language" content="en" />
  <link rel="stylesheet" type="text/css" href="css/smoothness/jquery-ui-1.7.2.custom.css"></link>
    <script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.7.2.custom.min.js"></script>
   
<link rel="stylesheet" type="text/css" href="css/number_slideshow.css" />
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
 
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/number_slideshow.js"></script>
 
<title>vissarud</title>
 
</head>
<body>
<input id="dateInput1" name="dateInput1" type="text" value="" />

<input id="dateInput2" name="dateInput2" type="text" value="" />
 

 
<script type="text/javascript">
$(function() {
	$("#sldMain").number_slideshow({
	slideshow_autoplay: 'enable',
	slideshow_time_interval: '4000',
	slideshow_window_background_color: '#ddd',
	slideshow_window_padding: '1',
	slideshow_window_width: '900',
	slideshow_window_height: '300',
	slideshow_border_size: '5',
	slideshow_border_color: 'white',
	slideshow_show_button: 'enable',
	slideshow_button_text_color: '#CCC',
	slideshow_button_background_color: '#66CC00',
	slideshow_button_current_background_color: '#006600',
	slideshow_button_border_color: '#006600',
	slideshow_button_border_size: '1',
	slideshow_sleep: 2,
  	slideshow_fade: 1
	});
	$("#sldMain").slideDown("slow");
});
 
</script>
 
<script type="text/javascript">
$(function(){
 
	$('#dateInput1').datepicker({
		dateFormat: 'D,dd/mm/yy',
		numberOfMonths: 2,
		showOn: 'button',
		buttonImage: 'images/calendar.gif',
		buttonImageOnly: true,
		changeMonth: true,
		changeYear: true,
		showButtonPanel: true,
		duration: 'normal',
		minDate: 0,
		onClose: clearEndDate
	});
 
	$('#dateInput2').datepicker({
		dateFormat: 'D,dd/mm/yy',
		numberOfMonths: 2,
		showOn: 'button',
		buttonImage: 'images/calendar.gif',
		buttonImageOnly: true,
		changeMonth: true,
		changeYear: true,
		showButtonPanel: true,
		duration: 'normal',
		minDate: +1,
		defaultDate: +1,
		beforeShow: setMinDateForEndDate
	});
});
 
function setMinDateForEndDate() {
	var date = $('#dateInput1').datepicker('getDate');
	date.setDate(date.getDate() + 1);
	if (date) return { minDate: date }
}
 
function clearEndDate() {
    var test = $('#dateInput1').datepicker('getDate');
    testm = new Date(test.getTime());
    testm.setDate(testm.getDate() + 1);
 
    $("#dateInput2").datepicker("option", "minDate", testm);
}
 
</script>
</body>
</html>