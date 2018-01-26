<%@page import="java.util.List,java.util.ArrayList,java.util.Date" session="true"%>
<%@ page buffer="1024kb"%>
<%@ page autoFlush="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/default.dwt.jsp" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Front System - Login</title>
<link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/frontsystem.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/ico/favicon.ico">
</head>
<body>
<div id="masthead">
      <div class="inner">
        <div class="container">
          <h1>Front System</h1>
          
          
        </div><!-- /container -->
      </div>
</div>
    <br/>
    <br/>
    <div class="container">
		<div class="content">
	<div class="row">
		
		<div class="offset4 span8 login-bg">
			
			<div class="page-header">
                                
				<h3>Welcome to Front System</h3>
				<p>The time on the server is <%=new Date()%>.</p>
			</div>
			
			<br />
		<% 
                    List<String> errorList=(ArrayList<String>)session.getAttribute("errors"+session.getId()); 
                    
                %>	
		<% if(errorList!=null&&errorList.size()>0){ %>	
                        <div class="alert-message block-message error">
                                <p>
                                        <%
                                            
                                            if(errorList!=null)
                                                for(String error:errorList){
                                                    out.println(error+"<br/>");
                                                }
                                                errorList = new ArrayList<String>();
                                                session.setAttribute("errors" + session.getId(), errorList);
                                        %>
                                </p>
                        </div>
        
		<% } %>	
			<form action="<%=request.getContextPath()%>/login/login_1.jsp" method="post">
                                <fieldset>
                                        <legend>Login</legend>
                                </fieldset>
                                <div class="clearfix <% if(errorList!=null&&errorList.size()>0)out.print("error"); %>">
                                        <label for="j_username">Username</label>
                                        <div class="input">
                                                <input class="medium" id="username" type="text" size="10"
                                                        name="username" /> <span class="label important">REQUIRED</span>
                                                <br />
                                        </div>
                                </div>
                                <br />
                                <div class="clearfix <% if(errorList!=null&&errorList.size()>0)out.print("error"); %>">
                                        <label for="password">Password</label>
                                        <div class="input">
                                                <input class="medium" id="password" type="password" size="10"
                                                        name="password" /> <span class="label important">REQUIRED</span>
                                        </div>
                                </div>
                                <br />

                                <div class="actions">
                                        <input class="btn primary" type="submit" value="Login"/>
                                        <button class="btn" type="reset">Cancel</button>
                                </div>
                        </form>	
			
		</div>
	</div>
</div>
    </div>
	<br/>
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
        <br/>
</body>
</html>
