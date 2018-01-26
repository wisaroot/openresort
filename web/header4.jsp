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
<!DOCTYPE html>
<html>
    <head>
   <title>A very basic Superfish menu example</title>
		<meta http-equiv="content-type" content="text/html;charset=utf-8">
		<link rel="stylesheet" type="text/css" href="css/superfish.css" media="screen">
		<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="js/hoverIntent.js"></script>
		<script type="text/javascript" src="js/superfish.js"></script>
		<script type="text/javascript">

		// initialise plugins
		jQuery(function(){
			jQuery('ul.sf-menu').superfish();
		});

		</script>
    </head>
   <body>
		<ul class="sf-menu">
			<li class="current">
				<a href="#a">Room Information</a>
				<ul>
					<li>
						<a href="SetRoomInformation.jsp" target="mainFrame" >Room Info</a>
					</li>
                                        <li>
						<a href="SetRoomStatus.jsp" target="mainFrame" >Room Status</a>
					</li>
                                        <li>
						<a href="SetRoomType.jsp" target="mainFrame">Room Type</a>
					</li>
                                         <li>
						<a href="SetRoomCurrent.jsp" target="mainFrame">Room Current</a>
					</li>
                                        <li>
						<a href="SetBedType.jsp" target="mainFrame">Bed Type</a>
					</li>
                                        <li>
						<a href="SetLocation.jsp" target="mainFrame">Location</a>
					</li>
                                        <li>
						<a href="SetExposure.jsp" target="mainFrame">Exposure</a>
					</li>
                                        <li>
						<a href="SetFacility.jsp" target="mainFrame">Facility</a>
					</li>
                                        <li>
						<a href="SetRoomGroup.jsp" target="mainFrame">Room Group</a>
					</li>
					<li class="current">
						<a href="SetRoomInformation.jsp">Room Info</a>
						<ul>
							<li class="current"><a href="#">menu item</a></li>
							<li><a href="#aba">menu item</a></li>
							<li><a href="#abb">menu item</a></li>
							<li><a href="#abc">menu item</a></li>
							<li><a href="#abd">menu item</a></li>
						</ul>
					</li>
					<li>
						<a href="#">menu item</a>
						<ul>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
						</ul>
					</li>
					<li>
						<a href="#">menu item</a>
						<ul>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
						</ul>
					</li>
				</ul>
			</li>
			<li>
				<a href="#">Agent</a>
				<ul>
					 <li>
						<a href="SetAgentType.jsp" target="mainFrame">Agent Type</a>
					</li>
                                         <li>
						<a href="SetSales.jsp" target="mainFrame">Sales</a>
					</li>
                                         <li>
						<a href="main.html" target="mainFrame">Contract</a>
					</li>
                                         <li>
						<a href="SetAllotment.jsp" target="mainFrame">Allotment</a>
					</li>
                                     
					
					
					
					
				</ul>
			</li>
                        <li>
				<a href="#">Rate</a>
				<ul>
					 <li>
						<a href="SetRateCode.jsp" target="mainFrame">Rate Code</a>
					</li>
                                         <li>
						<a href="main.html" target="mainFrame">Rate Plane</a>
					</li>
                                         <li>
						<a href="SetRateTemplate.jsp" target="mainFrame">Rate Template</a>
					</li>
                                         <li>
						<a href="SetRateCondition.jsp" target="mainFrame">Rate Condition</a>
					</li>
                                     
		
				</ul>
			</li>
                         <li>
				<a href="#"> Department</a>
				<ul>
					 <li>
						<a href="SetDepartmentGroup.jsp" target="mainFrame">Department Group</a>
					</li>
                                         <li>
						<a href="SetDepartment.jsp" target="mainFrame">Department</a>
					</li>
                                         <li>
						<a href="SetMediaGroup.jsp" target="mainFrame">Media Group</a>
					</li>
                                         <li>
						<a href="SetMedia.jsp" target="mainFrame">Media</a>
					</li>
		
				</ul>
			</li>
                         <li>
				<a href="#"> Market Segment</a>
				<ul>
					 <li>
						<a href="SetMarketZone.jsp" target="mainFrame">Market Zone</a>
					</li>
                                         <li>
						<a href="SetNationality.jsp" target="mainFrame">Nationality</a>
					</li>
                                         <li>
						<a href="SetCountry.jsp" target="mainFrame">Country</a>
					</li>
                                         <li>
						<a href="SetOrigin.jsp" target="mainFrame">Origin</a>
					</li>
                                     
				</ul>
			</li>
                        <li>
				<a href="Posting.jsp" target="mainFrame">Posting</a>
			</li>	
                        <li>
				<a href="Checkout.jsp" target="mainFrame">Checkout</a>
			</li>	
                        <li>
				<a href="RoomAvailable.jsp" target="mainFrame">Room Available</a>
			</li>
                         <li>
				<a href="RoomPlane.jsp" target="mainFrame">Room Plane</a>
			</li>
                         <li>
				<a href="#"> Night Audit</a>
				<ul>
					 <li>
						<a href="AutoPostRoom.jsp" target="mainFrame">Auto Post Room</a>
					</li>
                                         <li>
						<a href="AutoPostExpense.jsp" target="mainFrame">Auto Post Other Expenses</a>
					</li>
                                         <li>
						<a href="EndOfDay.jsp" target="mainFrame">End of Day</a>
					</li>
                                        
                                     
				</ul>
			</li>
                         <li>
				<a href="#"> User</a>
				<ul>
					 <li>
						<a href="users/setuser.jsp" target="mainFrame">View User</a>
					</li>
                                         <li>
						<a href="users/newuser.jsp" target="mainFrame">New User</a>
					</li>
                                        
                                 
				</ul>
			</li>
                        <li>
				<a href="#"> Booking</a>
				<ul>
					 <li>
						<a href="guest/guest.jsp" target="mainFrame">List Guest</a>
					</li>
                                         <li>
						<a href="guest/newguest.jsp" target="mainFrame">New Guest</a>
					</li>
				</ul>
			</li>
                              <li>
				<a href="#"> Guest Info</a>
				<ul>
					 <li>
						<a href="guestinfo/individual.jsp" target="mainFrame">Search Individual</a>
					</li>
                                         <li>
						<a href="walkin/guest.jsp" target="mainFrame">Walk In</a>
					</li>
                                        <li>
                                        <a href="houseused/guest.jsp" target="mainFrame">House Used</a>
                                        </li>
				</ul>
			</li>
                         <li><a href="login/logout.jsp" target="_parent">Log out</a>

                    </li>
                             
                        
			<li>
				<a href="#">menu item</a>
				<ul>
					<li>
						<a href="#">menu item</a>
						<ul>
							<li><a href="#">short</a></li>
							<li><a href="#">short</a></li>
							<li><a href="#">short</a></li>
							<li><a href="#">short</a></li>
							<li><a href="#">short</a></li>
						</ul>
					</li>
					<li>
						<a href="#">menu item</a>
						<ul>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
						</ul>
					</li>
					<li>
						<a href="#">menu item</a>
						<ul>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
						</ul>
					</li>
					<li>
						<a href="#">menu item</a>
						<ul>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
						</ul>
					</li>
					<li>
						<a href="#">menu item</a>
						<ul>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
							<li><a href="#">menu item</a></li>
						</ul>
					</li>
				</ul>
			</li>
			<li>
				<a href="#">Folio Setup</a>
			</li>	
		</ul>
	</body>
</html>

