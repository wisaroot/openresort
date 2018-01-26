
<%@ page contentType="text/html"  language="java" import="java.sql.*,java.util.*,javazoom.upload.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import= "net.sf.jasperreports.engine.*"%>
<%@ page import= "net.sf.jasperreports.engine.xml.JRXmlLoader"%>
<%@ page import ="net.sf.jasperreports.engine.JREmptyDataSource"%>
<%@ page import ="net.sf.jasperreports.engine.design.*"%>
<%@ page import ="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@ page import ="net.sf.jasperreports.engine.JasperExportManager"%>
<%@ page import ="net.sf.jasperreports.engine.JasperFillManager"%>
<%@ page import ="net.sf.jasperreports.engine.JasperPrint"%>
<%@ page import ="net.sf.jasperreports.engine.JasperReport"%>
<%@ page import ="net.sf.jasperreports.view.JasperViewer"%>
<%@ page import ="java.io.InputStream"%>
<%@ page import= "net.sf.jasperreports.engine.export.*" %>
<%@ page import= "net.sf.jasperreports.engine.util.*" %>
<%@ page import= "net.sf.jasperreports.engine.fill.*" %>
 
<%@ page import="java.io.*" %>


<%@ page import="java.util.HashMap" %>
<%@ include file ="../config.jsp"%>



<html><head></head>
    <%
    
            Class.forName("org.postgresql.Driver");

            Connection connection = null;
            connection = (Connection) DriverManager.getConnection(url, user1, pw);
        // set header as pdf
        response.setContentType("application/pdf");

        // set input and output stream
        ServletOutputStream servletOutputStream = response.getOutputStream();
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        FileInputStream fis;
        BufferedInputStream bufferedInputStream;

     //   try {
            // get report location
            ServletContext context = getServletContext();
        //    String reportLocation = context.getRealPath("WEB-INF");

            // get report
          //  fis = new FileInputStream(reportLocation + "\\report\\folio.jasper");
            //  File reportFile = new File(context.getRealPath("report/folio.jasper")); 

        File reportFile = new File(context.getRealPath("report/folio.jasper")); 
     
           // bufferedInputStream = new BufferedInputStream(fis);

            // fetch data from database
           Map parameters = new HashMap();
        parameters.put("accno", "229");
    

    byte[] bytes = null; 
     try{ 
        bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, connection); 
      }catch(JRException e){ 

 // do something 


 // disconnect from DB 

 if (bytes != null && bytes.length > 0){ 
response.setContentType("application/pdf"); 
 response.setContentLength(bytes.length); 
 ServletOutputStream ouputStream = response.getOutputStream(); 
 ouputStream.write(bytes, 0, bytes.length); 
 ouputStream.flush(); 
 ouputStream.close(); 

    }}

   

   

    %>
</html>