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
 

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Untitled Document</title>
        <style type="text/css">
            body {
                margin: 0px;
                padding: 0px;
                background-image: url(image/bg.jpg);
                background-repeat: repeat;
            }
            div.sc_menu {
                /* Set it so we could calculate the offsetLeft */
                position: relative;
                height: 130px;
                width: 100%;
                overflow: auto;
                /*background: url('image/bg.jpg');*/
                
            }
            ul.sc_menu {
                display: block;
                height: 110px;
                /* max width here, for users without javascript */	
                width: 1500px;	
                padding: 15px 0 0 15px; 
                /* removing default styling */
                margin: 0;
                list-style: none;
            }
            .sc_menu li {
                display: block;
                float: left;	
                padding: 0 4px;
            }
            .sc_menu a {
                display: block;
                text-decoration: none;
            }
            .sc_menu span {
                display: block;
                margin-top: 3px;
                text-align: center;
                font-size: 0.8em;	
                color: #fff;
                background-color: #A1A194;
            }
            .sc_menu div {
                display: block;
                margin-top: 3px;
                text-align: center;
                font-size: 0.8em;	
                color: #000;
                background-color: #A1A194;
            }
            .sc_menu a div{
                padding:5px;
            }
            .sc_menu a:hover span {
                display: block;
                background-color: #A1A194;
            }
            .sc_menu a:hover div {
                display: block;
            }
            .sc_menu div {
                border: 3px #fff solid;	
                -webkit-border-radius: 3px;
                -moz-border-radius: 3px;
            }
            .sc_menu a:hover div {
                filter:alpha(opacity=50);	
                opacity: 0.5;
            }
            .sc_menu img {
                border: 3px #fff solid;	
                -webkit-border-radius: 3px;
                -moz-border-radius: 3px;
            }
            .sc_menu a:hover img {
                filter:alpha(opacity=50);	
                opacity: 0.5;
            }

        </style>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.1.min.js"></script>
        <script type="text/javascript">
            //Insert image
            function loadImage(){
                var imgs=new Array();
                var allImgs=12;
                for(i=1;i<allImgs;i++)
                    imgs.push(i);
                i=0;
                n=1;
                $("ul.sc_menu li img").each(function(){
                    if($(this).attr('src')==""){
                        if(i==allImgs-1)
                            i=0;
                        $("ul.sc_menu li:nth-child("+n+") img").attr('src','image/'+imgs[i]+'.jpg');
                        i++;
                        n++;
                    }
                });
            }
            function showhide(show,hide){
                
                $("#"+show).toggle();
                $("#"+hide).toggle();
            }
            $(document).ready(function(){
                loadImage();
            });
            $(function(){
                //Get our elements for faster access and set overlay width
                var div = $('div.sc_menu'),
                ul = $('ul.sc_menu'),
                ulPadding = 15;
	
                //Get menu width
                var divWidth = div.width();

                //Remove scrollbars	
                div.css({overflow: 'hidden'});
	
                //Find last image container
                var lastLi = ul.find('li:last-child');
	
                //When user move mouse over menu
                div.mousemove(function(e){
                    //As images are loaded ul width increases,
                    //so we recalculate it each time
                    var ulWidth = lastLi[0].offsetLeft + lastLi.outerWidth() + ulPadding;	
                    var left = (e.pageX - div.offset().left) * (ulWidth-divWidth) / divWidth;
                    div.scrollLeft(left);
                });
            });
        </script>
    </head>
    <body>
        <div style="overflow: hidden;" class="sc_menu" id="SystemSetup">
            <ul class="sc_menu">
                <li><a href="#" onclick="showhide('System','SystemSetup')"><img src="" alt="System"><span>+ System</span></a></li>
                <li><a href="#" onclick="showhide('Miscellaneous','SystemSetup')"><img src="" alt="Miscellaneous"><span>+ Miscellaneous</span></a></li>
                <li><a href="#" onclick="showhide('GuestSelection','SystemSetup')"><img src="" alt="Guest Selection"><span>+ Guest Selection</span></a></li>
                <li><a href="#" onclick="showhide('GroupSelection','SystemSetup')"><img src="" alt="Group Selection"><span>+ Group Selection</span></a></li>
                <li><a href="Posting.jsp" target="mainFrame"><img src="" alt="Posting"><span>Posting</span></a></li>
                <li><a href="Checkout.jsp" target="mainFrame"><img src="" alt="Checkout"><span>Checkout</span></a></li>
                <li><a href="#" onclick="showhide('NightAudit','SystemSetup')"><img src="" alt="Night Audit"><span>+ Night Audit</span></a></li>
                <li><a href="#" target="mainFrame"><img src="" alt="Room Available"><span>Room Available</span></a></li>
                <li><a href="#" target="mainFrame"><img src="" alt="Room Plane"><span>Room Plane</span></a></li>
                <li><a href="#" onclick="showhide('User','SystemSetup')"><img src="" alt="User"><span>+ User</span></a></li>
                <li><a href="#" onclick="showhide('Booking','SystemSetup')"><img src="" alt="Booking"><span>+ Booking</span></a></li>
                <li><a href="#" onclick="showhide('GuestInfo','SystemSetup')"><img src="" alt="Guest Info"><span>+ Guest Info</span></a></li>
                <li><a href="#" onclick="showhide('GroupInfo','SystemSetup')"><img src="" alt="Group Info"><span>+ Group Info</span></a></li>
                <li><a href="login/logout.jsp" target="_parent"><img src="" alt="Log out"><span>Log out</span></a></li>
            </ul>
        </div>
        <div style="overflow: hidden;display:none;" class="sc_menu" id="System">
            <ul class="sc_menu">
                <li><a href="#" onclick="showhide('SystemSetup','System')"><img src="" alt="Back"><span>Back</span></a></li>
                <li><a href="#"><img src="" alt="System"><span>System</span></a></li>
                <li><a href="#" target="mainFrame" onclick="showhide('RoomInformation','System')"><img src="" alt="Room Information"><span>+ Room Information</span></a></li>
                <li><a href="#" target="mainFrame"><img src="" alt="Folio Setup"><span>Folio Setup</span></a></li>
                <li><a href="#" onclick="showhide('Agent','System')"><img src="" alt="Agent"><span>+ Agent</span></a></li>
                <li><a href="#" onclick="showhide('Rate','System')"><img src="" alt="Rate"><span>+ Rate</span></a></li>
                <li><a href="#" onclick="showhide('Department','System')"><img src="" alt="Department"><span>+ Department</span></a></li>
                <li><a href="#" onclick="showhide('MarketSegment','System')"><img src="" alt="Market Segment"><span>+ Market Segment</span></a></li>
            </ul>
        </div>
        <div style="overflow: hidden;display:none;" class="sc_menu" id="Miscellaneous">
            <ul class="sc_menu">
                <li><a href="#" onclick="showhide('SystemSetup','Miscellaneous')"><img src="" alt="Back"><span>Back</span></a></li>
            </ul>
        </div>
        <div style="overflow: hidden;display:none;" class="sc_menu" id="NightAudit">
            <ul class="sc_menu">
                <li><a href="#" onclick="showhide('SystemSetup','NightAudit')"><img src="" alt="Back"><span>Back</span></a></li>
                <li><a href="AutoPostRoom.jsp" target="mainFrame"><img src="" alt="Agent"><span>Auto Post Room</span></a></li>
                <li><a href="AutoPostExpense.jsp" target="mainFrame"><img src="" alt="Rate"><span>Auto post other expense</span></a></li>
                <li><a href="EndOfDay.jsp" target="mainFrame"><img src="" alt="Department"><span>End of day</span></a></li>
               
            </ul>
        </div>
        <div style="overflow: hidden;display:none;" class="sc_menu" id="GuestSelection">
            <ul class="sc_menu">
                <li><a href="#" onclick="showhide('SystemSetup','GuestSelection')"><img src="" alt="Back"><span>Back</span></a></li>
            </ul>
        </div>
        <div style="overflow: hidden;display:none;" class="sc_menu" id="GroupSelection">
            <ul class="sc_menu">
                <li><a href="#" onclick="showhide('SystemSetup','GroupSelection')"><img src="" alt="Back"><span>Back</span></a></li>
            </ul>
        </div>
        <div style="overflow: hidden;display:none;" class="sc_menu" id="User">
            <ul class="sc_menu">
                <li><a href="#" onclick="showhide('SystemSetup','User')"><img src="" alt="System"><span>Back</span></a></li>
                <li><a href="users/setuser.jsp" target="mainFrame"><img src="" alt="System"><span>View User</span></a></li>
                <li><a href="users/newuser.jsp" target="mainFrame"><img src="" alt="New User"><span>New User</span></a></li>
            </ul>
        </div>
        <div style="overflow: hidden;display:none;" class="sc_menu" id="Booking">
            <ul class="sc_menu">
                <li><a href="#" onclick="showhide('SystemSetup','Booking')"><img src="" alt="Back"><span>Back</span></a></li>
                <li><a href="guest/guest.jsp" target="mainFrame"><img src="" alt="List Guest"><span>List Guest</span></a></li>
                <li><a href="guest/newguest.jsp" target="mainFrame"><img src="" alt="New Guest"><span>New Guest</span></a></li>
                <li><a href="group/group.jsp" target="mainFrame"><img src="" alt="List Group"><span>List Group</span></a></li>
                <li><a href="group/newgroup.jsp" target="mainFrame"><img src="" alt="New Group"><span>New Group</span></a></li>
            </ul>
        </div>
        <div style="overflow: hidden;display:none;" class="sc_menu" id="GuestInfo">
            <ul class="sc_menu">
                <li><a href="#" onclick="showhide('SystemSetup','GuestInfo')"><img src="" alt="Back"><span>Back</span></a></li>
                <li><a href="guestinfo/individual.jsp" target="mainFrame"><img src="" alt="Search Individual"><span>Search Individual</span></a></li>
                <li><a href="walkin/guest.jsp" target="mainFrame"><img src="" alt="Walk In"><span>Walk In</span></a></li>
                <li><a href="houseused/guest.jsp" target="mainFrame"><img src="" alt="House Used"><span>House Used</span></a></li>
            </ul>
        </div>
        <div style="overflow: hidden;display:none;" class="sc_menu" id="GroupInfo">
            <ul class="sc_menu">
                <li><a href="#" onclick="showhide('SystemSetup','GroupInfo')"><img src="" alt="Back"><span>Back</span></a></li>
                <li><a href="groupinfo/sgroup.jsp" target="mainFrame"><img src="" alt="Search Group"><span>Search Group</span></a></li>
            </ul>
        </div>
    </body>
</html>