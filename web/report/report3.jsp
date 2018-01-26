
<%@page import="javax.xml.parsers.SAXParserFactory"%>
<%@ page contentType="text/html"  language="java" import="java.sql.*,java.util.*,javazoom.upload.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import= "net.sf.jasperreports.engine.*"%>

<%@ page import= "javax.xml.parsers.SAXParser"%>
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
      String JAXP_SCHEMA_LANGUAGE =
           "http://java.sun.com/xml/jaxp/properties/schemaLanguage";
        String JAXP_SCHEMA_LOCATION =
           "http://java.sun.com/xml/jaxp/properties/schemaSource";
        String W3C_XML_SCHEMA =
           "http://www.w3.org/2001/XMLSchema";

       System.setProperty( "javax.xml.parsers.SAXParserFactory",
                           "org.apache.xerces.jaxp.SAXParserFactoryImpl" );

       SAXParserFactory spf = SAXParserFactory.newInstance();
       spf.setNamespaceAware(true);
       spf.setValidating(true);
       SAXParser saxParser = spf.newSAXParser();
       
                        JasperDesign jd = JRXmlLoader.load(getClass().getResourceAsStream("/report/test.jrxml"));            
                      JasperReport   jr = JasperCompileManager.compileReport(jd); 
                      JasperPrint jp = JasperFillManager.fillReport(jr, new HashMap(), new JREmptyDataSource());    
            
                
 ServletOutputStream servletOutputStream = response.getOutputStream();
        InputStream reportStream = getServletConfig().getServletContext().getResourceAsStream("/report/test.jasper");
 
        Map parameters = new HashMap();
//parameters.put("cedula", "cedula");
//parameters.put("nombre", "nombre");       
        try {
             Class.forName("org.postgresql.Driver");

            Connection connection = null;
            connection = (Connection) DriverManager.getConnection(url, user1, pw);


            JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream, new HashMap(), new JREmptyDataSource());

            response.setContentType("application/pdf");
            servletOutputStream.flush();
            servletOutputStream.close();
        } catch (JRException e) {
// display stack trace in the browser
            StringWriter stringWriter = new StringWriter();
            PrintWriter printWriter = new PrintWriter(stringWriter);
            e.printStackTrace(printWriter);
            response.setContentType("text/plain");
            response.getOutputStream().print(stringWriter.toString());
        }



    %>
</html>