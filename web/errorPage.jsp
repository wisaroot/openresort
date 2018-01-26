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
 

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" import="java.io.*"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error</title>
        <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%=request.getContextPath()%>/css/frontsystem.css" rel="stylesheet" type="text/css" />
    </head>
    <body>

        <div id="masthead">
            <div class="inner">
                <div class="container">
                    <h1>Error</h1>
                </div>
            </div>
        </div>
        <div class="container">

            <div class="content well">
                <div class="row">
                    <div class="span16 columns">

                        <%
                            List<String> errorList = (ArrayList<String>) session.getAttribute("errors" + session.getId());
                            if (errorList != null && errorList.size() > 0 || exception.toString() != null) {%>	
                        <div class="alert-message block-message error span14 columns">
                            <p>
                                <%

                                    if (errorList != null) {
                                        for (String error : errorList) {
                                            out.println(error + "<br/>");
                                        }
                                        
                                    }
                                %>
                                <%= exception.toString()%><br>
                                <%
                                    out.println("<!--");
                                    StringWriter sw = new StringWriter();
                                    PrintWriter pw = new PrintWriter(sw);
                                    exception.printStackTrace(pw);
                                    out.print(sw);
                                    sw.close();
                                    pw.close();
                                    out.println("-->");
                                    errorList = new ArrayList<String>();
                                    session.setAttribute("errors" + session.getId(), errorList);
                                %>
                            </p>
                        </div>

                        <% }%>



                    </div>
                </div>
            </div>
        </div>                            
    </body>
</html>

