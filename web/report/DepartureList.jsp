
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

<%@ page import="java.text.*" %> 
<%@ page import="java.util.HashMap" %>
<%@ include file ="../config.jsp" %>



<html>
    <head></head>
    <body>
    <%
 String dateInput = request.getParameter("dateInput");
        ServletOutputStream servletOutputStream = response.getOutputStream();
        InputStream reportStream = getServletConfig().getServletContext().getResourceAsStream("/report/EXPECTED_DEPARTURE.jasper");
        InputStream jasperSubReport = getServletConfig().getServletContext().getResourceAsStream("/report/EXPECTED_DEPARTURE_subreport0.jasper");



        JasperReport subreport1_jasper = (JasperReport) JRLoader.loadObject(jasperSubReport);

       
        Map parameters = new HashMap();
        parameters.put("Dateinput2", dateInput);
        //parameters.put("ac", new Integer(229));
        parameters.put("DepartlListsubreport", subreport1_jasper);

        //parameters.put("ac", new Integer(229));

        // parameters.put("GuestLeaderReport_subreport0", filepath);
        //   parameters.put("account", new Integer(229));
//parameters.put("nombre", "nombre");       

        Class.forName("org.postgresql.Driver");

        Connection connection = null;
        connection = (Connection) DriverManager.getConnection(url, user1, pw);
        //JRDataSource dataSource = null;

        //  JasperPrint jasperPrint = JasperFillManager.fillReport(  reportStream, parameters, connection);
        JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, parameters, connection);
//new HashMap(), new JREmptyDataSource()
        response.setContentType("application/pdf");
        //servletOutputStream.flush();
       // servletOutputStream.close();


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
    </body>
</html>