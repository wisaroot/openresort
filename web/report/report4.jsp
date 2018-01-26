
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

<html>
    <head></head>
    <%

     // Map parameters = new HashMap();
      Map < String, Object > parameters = new HashMap < String, Object >();

        parameters.put("account", 229);
//parameters.put("nombre", "nombre");       
      
            Class.forName("org.postgresql.Driver");

            Connection connection = null;
            connection = (Connection) DriverManager.getConnection(url, user1, pw);
          //  JRDataSource dataSource = null;
            String templateName = path+"/report/folio.jrxml";
          JasperReport  jasperReport = JasperCompileManager.compileReport(templateName);
       JasperPrint     jasperPrint = JasperFillManager.fillReport(jasperReport, parameters,connection);
 
       JasperViewer.viewReport(jasperPrint);
     
      //  jasperPrint = JasperFillManager.fillReport(jasperReport, parameters,jrxmlds);
 
       
  String destinationFile = path+"/report/folio.pdf";
        //Exporting it to an PDF
        JasperExportManager.exportReportToPdfFile(jasperPrint, destinationFile);
 
       

    /*        StringWriter stringWriter = new StringWriter();
            PrintWriter printWriter = new PrintWriter(stringWriter);
            e.printStackTrace(printWriter);
            response.setContentType("text/plain");
            response.getOutputStream().print(stringWriter.toString());*/
       
   
          /*    public static void generate() {   
                        try {             String reportSource = "resources/authorReport.jasper"; 
                                     JasperReport jasperReport = JasperCompileManager.compileReport(reportSource);
                                                   Map<String, Object> params = new HashMap<String, Object>();   
                                                            params.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(new File(youPath)));     
                                                                     JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, params, new JREmptyDataSource()); 
                                                                                  JasperExportManager.exportReportToHtmlFile(jasperPrint, "hello_report.html");      
                                                                                    } catch (Exception e) {             e.printStackTrace();       
                                                                                     }     }    
*/


    %>
</html>