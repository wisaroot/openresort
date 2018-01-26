<%-- 
    Document   : login
    Created on : Jan 8, 2012, 10:38:22 PM
    Author     : Administrator
--%>

<%
            int minute=60; //60 seconds
            session.setMaxInactiveInterval(180*minute);
            int timeout = session.getMaxInactiveInterval();
            response.setHeader("Refresh", timeout + "; URL =" +request.getContextPath()+"/index.jsp");
            response.setHeader("Pragma","no-cache");   
            response.setHeader("Cache-Control","no-store");   
            response.setHeader("Expires","0");   
            response.setDateHeader("Expires",-1);
            if(session.getAttribute(""+session.getId())==null){
                response.sendRedirect(request.getContextPath()+"/index.jsp");
            }
%>