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
<%@page import="com.comis.frontsystem.user.WebUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to Front System</title>
        <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            div.background
            {
                
                background:url(image/rock.jpg) repeat;
                border:1px dotted grey;
            }
            div.transbox
            {
                margin:30px 50px;
                background-color:#ffffff;
                border:1px dotted grey;
                opacity:0.6;
                filter:alpha(opacity=60); /* For IE8 and earlier */
            }
            div.transbox p
            {
                margin:30px 40px;
                font-weight:bold;
                color:#000000;
            }
        </style>
    </head>
    <body>


        <%
            WebUser user = (WebUser) session.getAttribute("" + session.getId());
        %>



        <div class="content">
            <div class="row">
                <div class="offset1 span12 columns">
                    <div class="background">
                        <div class="transbox">
                        <p>
                        <h2 class="offset2">Hello <%=user.getUsername()%>!, <%=user.getGroup()%></h2>
                        </p>
                        </div>
                    </div>  
                </div>
            </div>
            <div class="row">
                <div class="offset-two-thirds">
                    <img src="image/starfishdouble.gif"/>
                </div>
            </div>                                        
        </div>
        <br/>
    </body>
</html>
