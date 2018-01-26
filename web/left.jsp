
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <TITLE></TITLE>
        <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/jquery.jscrollpane.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
        <script type="text/javascript" src="js/jquery.mousewheel.js"></script>
        <script type="text/javascript" src="js/jquery.jscrollpane.min.js"></script>
        <script type="text/javascript">

            $(function(){
                $('#tree-menu > li > a').click(function(){
                    var next = $(this).next();
                    if(next.is(':visible')){
                        next.slideUp(270);
                        $(this).find('span').html('+');
                    }else{
                        next.slideDown(270);
                        $(this).find('span').html('-');
                    }
			
                });
            });
            $(function(){
                $('#menu-lv1 > li > a').click(function(){
                    var next = $(this).next();
                    if(next.is(':visible')){
                        next.slideUp(270);
                        $(this).find('span').html('+');
                    }else{
                        next.slideDown(270);
                        $(this).find('span').html('-');
                    }
			
                });
            });
        </script>
        <script type="text/javascript" id="sourcecode">
            $(function()
            {
                $('.scroll-pane').jScrollPane({showArrows: true});
            });
        </script>
        <script type="text/javascript">
    
            function hideMenu(){
                $('#leftFrameSet', top.document).attr({'cols':'10,*'});
        
            }
            function showMenu(){
                $('#leftFrameSet', top.document).attr({'cols':'210,*'});         
        
            }
        </script>
        <style type="text/css"  >

            #div-head-tree-menu { width:200px; padding:10px 10px 10px 10px; text-align:center; background-color:#ddd; border:1px solid #ccc; border-bottom:5px solid #a8bfd7; }
            #div-tree-menu { padding-left:10px; padding-bottom:0px; width:200px; background-color:#eee; overflow:hidden; border:0px solid #aaa; border-top:1px solid #FFF;   }
            #tree-menu {  width:170px; float:left; margin:0; padding:0; margin-top:-1px;}
            #tree-menu ul { margin:0; padding:8px;  }
            #tree-menu li { list-style:none;  padding:8px; margin:0; border-bottom:1px solid #999; border-top:1px solid #fff; }
            #menu-lv1 { display:none; }
            #menu-lv1 li { border-bottom:none; border-top:none; }
            #menu-lv2 { display:none; }
            #menu-lv2 li { border-bottom:none; border-top:none; }
            #menu-lv3 { display:none; }
            #menu-lv3 li { border-bottom:none; border-top:none; }
            #menu-lv4 { display:none; }
            #menu-lv4 li { border-bottom:none;  border-top:none; }
            #menu-lv11  {  width:170px; float:left; margin:0; padding:0; margin-top:-1px;}
            #menu-lv11 li { border-bottom:none; border-top:none; }

            a:link { text-decoration: none; color: #FFF; }
            a:visited { text-decoration: none; color: #FFF; }
            a:hover { text-decoration: none; color: #F60; }
            a:active { text-decoration: none; color: #FFF; }
            .txt-red { color:#F00 }

            .scroll-pane
            {
                width: 200px;
                height: 600px;
                overflow: auto;
            }

        </style>

    </head>

    <body onmouseover="showMenu()" onmouseout="hideMenu()">
        <div class="scroll-pane">
            <div id="div-tree-menu">

                <ul style="font-weight: bold" id="tree-menu">
                    <li><a href="#"><span>+</span> System Setup</a>

                        <ul id="menu-lv1" style=" font:13px Tahoma, Geneva,  sans-serif; font-weight: bold " >
                            <li>&#8250; <a href="#">System</a>


                            </li>
                            <li><a href="#"><span>-</span> Room Information</a>
                                <ul>
                                    <li>&#8250;<a href="SetRoomInformation.jsp" target="mainFrame">Room Info</a></li>
                                    <li>&#8250;<a href="SetRoomStatus.jsp" target="mainFrame" >Room Status</a></li>
                                    <li>&#8250;<a href="SetRoomType.jsp" target="mainFrame">Room Type</a></li>
                                    <li>&#8250;<a href="SetBedType.jsp" target="mainFrame">Bed Type</a></li>
                                    <li>&#8250;<a href="SetLocation.jsp" target="mainFrame">Location</a></li>
                                    <li>&#8250;<a href="SetExposure.jsp" target="mainFrame">Exposure</a></li>
                                    <li>&#8250;<a href="SetFacility.jsp" target="mainFrame">Facility</a></li>
                                    <li>&#8250;<a href="SetRoomGroup.jsp" target="mainFrame">Room Group</a></li>
                                </ul>

                            </li>
                            <li>&#8250; <a href="#">Folio Setup</a></li>
                            <li><a href="#"><span>-</span>Agent</a>
                                <ul>
                                    <li>&#8250;<a href="SetAgentType.jsp" target="mainFrame">Agent Type</a></li>
                                    <li>&#8250;<a href="SetSales.jsp" target="mainFrame">Sales</a></li>
                                    <li>&#8250;<a href="main.html" target="mainFrame">Contract</a></li>
                                    <li>&#8250;<a href="SetAllotment.jsp" target="mainFrame">Allotment</a></li>
                                </ul>

                            </li>


                            <li><a href="#"><span>-</span> Rate</a>
                                <ul>
                                    <li>&#8250;<a href="SetRateCode.jsp" target="mainFrame">Rate Code</a></li>
                                    <li>&#8250;<a href="main.html" target="mainFrame">Rate Plane</a></li>
                                    <li>&#8250;<a href="SetRateTemplate.jsp" target="mainFrame">Rate Template</a></li>
                                    <li>&#8250;<a href="SetRateCondition.jsp" target="mainFrame">Rate Condition</a></li>
                                </ul>
                            </li>
                            <li><a href="#"><span>-</span> Department</a>
                                <ul>
                                    <li>&#8250;<a href="SetDepartmentGroup.jsp" target="mainFrame">Department Group</a></li>
                                    <li>&#8250;<a href="SetDepartment.jsp" target="mainFrame">Department</a></li>
                                    <li>&#8250;<a href="SetMediaGroup.jsp" target="mainFrame">Media Group</a></li>
                                    <li>&#8250;<a href="SetMedia.jsp" target="mainFrame">Media</a></li>
                                </ul>
                            </li>
                            <li><a href="#"><span>-</span> Market Segment</a>
                                <ul>
                                    <li>&#8250;<a href="SetMarketZone.jsp" target="mainFrame">Market Zone</a></li>
                                    <li>&#8250;<a href="SetNationality.jsp" target="mainFrame">Nationality</a></li>
                                    <li>&#8250;<a href="SetCountry.jsp" target="mainFrame">Country</a></li>
                                    <li>&#8250;<a href="SetOrigin.jsp" target="mainFrame">Origin</a></li>
                                </ul>
                            </li>
                            <li>&#8250; <a href="#">sub-menu-1-2</a></li>
                            <li>&#8250; <a href="#">sub-menu-1-3</a></li>
                            <li>&#8250; <a href="#">sub-menu-1-4</a></li>
                        </ul>
                    </li>



                    <li><a href="#"><span>+</span> Miscellaneous</a>
                        <ul id="menu-lv2" style=" font:13px Tahoma, Geneva,  sans-serif; font-weight: bold ">
                            <li>&#8250; <a href="#">sub-menu-2-1</a></li>
                            <li>&#8250; <a href="#">sub-menu-2-2</a></li>
                            <li>&#8250; <a href="#">sub-menu-2-3</a></li>
                            <li>&#8250; <a href="#">sub-menu-2-4</a></li>
                        </ul>
                    </li>
                    <li><a href="#"><span>+</span> Guest Selection</a>
                        <ul id="menu-lv3" style=" font:13px Tahoma, Geneva,  sans-serif; font-weight: bold ">
                            <li>&#8250; <a href="#">sub-menu-3-1</a></li>
                            <li>&#8250; <a href="#">sub-menu-3-2</a></li>
                            <li>&#8250; <a href="#">sub-menu-3-3</a></li>
                            <li>&#8250; <a href="#">sub-menu-3-4</a></li>
                        </ul>
                    </li>
                    <li><a href="#"><span>+</span> Group Selection</a>
                        <ul id="menu-lv4" style=" font:13px Tahoma, Geneva,  sans-serif; font-weight: bold ">
                            <li>&#8250; <a href="#">sub-menu-4-1</a></li>
                            <li>&#8250; <a href="#">sub-menu-4-2</a></li>
                            <li>&#8250; <a href="#">sub-menu-4-3</a></li>
                            <li>&#8250; <a href="#">sub-menu-4-4</a></li>
                        </ul>
                    </li>
                    <li><a href="Posting.jsp" target="mainFrame">Posting</a>

                    </li>
                    <li><a href="Checkout.jsp" target="mainFrame">Checkout</a>

                    </li>
                    <li><a href="#"><span>+</span> Night Audit</a>
                        <ul id="menu-lv4" style=" font:13px Tahoma, Geneva,  sans-serif; font-weight: bold ">

                            <li>&#8250;<a href="AutoPostRoom.jsp" target="mainFrame">Auto Post Room</a></li>
                            <li>&#8250;<a href="AutoPostExpense.jsp" target="mainFrame">Auto Post Other Expenses</a></li>
                            <li>&#8250;<a href="EndOfDay.jsp" target="mainFrame">End of Day</a></li>
                        </ul>
                    </li>

                    <li><a href="RoomAvailable.jsp" target="mainFrame">Room Available</a>

                    </li>
                    <li><a href="RoomPlane.jsp" target="mainFrame">Room Plane</a>

                    </li>
                    <li><a href="#"><span>+</span> User</a>
                        <ul id="menu-lv2" style=" font:13px Tahoma, Geneva,  sans-serif; font-weight: bold ">
                            <li>&#8250; <a href="users/setuser.jsp" target="mainFrame">View User</a></li>
                            <li>&#8250; <a href="users/newuser.jsp" target="mainFrame">New User</a></li>
                        </ul>
                    </li>
                    <li><a href="#"><span>+</span> Booking</a>
                        <ul id="menu-lv2" style=" font:13px Tahoma, Geneva,  sans-serif; font-weight: bold ">
                            <li>&#8250; <a href="guest/guest.jsp" target="mainFrame">List Guest</a></li>
                            <li>&#8250; <a href="guest/newguest.jsp" target="mainFrame">New Guest</a></li>
                        </ul>
                    </li>
                    <li><a href="#"><span>+</span> Guest Info</a>
                        <ul id="menu-lv2" style=" font:13px Tahoma, Geneva,  sans-serif; font-weight: bold ">
                            <li>&#8250; <a href="guestinfo/individual.jsp" target="mainFrame">Search Individual</a></li>
                            <li>&#8250; <a href="walkin/guest.jsp" target="mainFrame">Walk In</a></li>
                            <li>&#8250; <a href="houseused/guest.jsp" target="mainFrame">House Used</a></li>
                        </ul>
                    </li>
                    <li><a href="login/logout.jsp" target="_parent">Log out</a>

                    </li>

                </ul>

            </div>
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
        </div>

    </body>
</html>
