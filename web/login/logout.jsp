<%-- 
    Document   : logout
    Created on : Jan 10, 2012, 3:55:38 PM
    Author     : Administrator
--%>




<html>
    
    <head>

 
</head>
<body  >
    <SCRIPT> 
<!-- 
if(top.location.href!=self.location.href) {top.location.replace(self.location.href);
//self.location.href = '/index.jsp'; 
}

session.invalidate();
response.setHeader("Pragma","no-cache");   
response.setHeader("Cache-Control","no-store");   
response.setHeader("Expires","0");   
response.setDateHeader("Expires",-1);

//response.sendRedirect(request.getContextPath()+"/index.jsp");
</SCRIPT>
  <META HTTP-EQUIV='Refresh' CONTENT='1; URL=<%=request.getContextPath() %>/index.jsp'>
</body>
</html>