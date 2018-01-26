/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;

import java.sql.ResultSet;


/**
 *
 * @author SamSung
 */
public class JQGridServlet extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        RequestDispatcher dispatcher = request.getRequestDispatcher("/web/config.jsp");
     //   String url = this.getParameter("url");
      //  String user1 = this.getParameter("user1");
      //  String pw = this.getParameter("pw");
        
                
        //RequestDispatcher rd = request.getRequestDispatcher(“include.jsp” );
if (dispatcher != null){
   dispatcher.include(request, response);
}



        try {

            if (request.getParameter("action").equals("fetchData")) {
                response.setContentType("text/xml;charset=UTF-8");

                String status = request.getParameter("status");

                String rows = request.getParameter("rows");
                String page = request.getParameter("page");

                int totalPages = 0;
                int totalCount = 15;

                if (totalCount > 0) {
                    if (totalCount % Integer.parseInt(rows) == 0) {
                        totalPages = totalCount / Integer.parseInt(rows);
                    } else {
                        totalPages = (totalCount / Integer.parseInt(rows)) + 1;
                    }

                } else {
                    totalPages = 0;
                }
                out.print("<?xml version='1.0' encoding='utf-8'?>\n");
                out.print("<rows>");
                out.print("<page>" + request.getParameter("page") + "</page>");

                out.print("<total>" + totalPages + "</total>");
                out.print("<records>" + 15 + "</records>");
                int srNo = 1;


                Statement stmt = null;
                    ResultSet rs = null;
                    Connection con = null;
                    // String co = request.getParameter("code");
                    //  String des = request.getParameter("desc");
                    //  if (request.getParameter("submit") != null) {

                    try {

                        Class.forName("org.postgresql.Driver");
                   //    con = DriverManager.getConnection(url, user1, pw);
                    } catch (Exception ex) {

                        out.println("exeSQL Error : " + ex.getMessage());
                    }
                    /*      Class.forName("sun.jdbc.odbc.JdbcOdbc");
                    <b style="color:black;background-color:#a0ffff">Connection</b> con=DriverManager.getConnection("jdbc:odbc:MyDatabase","system","database");
                     */
                    try {
                        stmt = con.createStatement();
                        String QueryString = "Select * FROM country";
                        rs = stmt.executeQuery(QueryString);


                        /*       } catch (Exception e) {

                        out.println("exeSQL Error : " + e.getMessage());
                        }
                        }*/
                        out.println("<table id='tblTest' width='300' border='1'>");
//<tr><td>Code </td><td>Description</td></tr>
                        out.println("<tr id='tbl' bgColor=#8080a6 ><td>Code </td><td  width='50%'>Description</td><td colspan='2'> </td></tr>");

                        while (rs.next()) {


                            out.println("<TR id=5  ><TD>" + rs.getString(1) + "</TD><TD>" + rs.getString(2) + "</TD>");
                            out.println("<TD><a href=EditCountry.jsp?id=" + rs.getString(1) + ">edit</td>");
                            out.println("<TD><a href=DeleteCountry.jsp?id=" + rs.getString(1) + ">delete</td></TR>");
                        }

                        // close all the connections.
                        rs.close();
                        stmt.close();
                        con.close();
                    } catch (Exception ex) {

                        out.println("Unable to connect to database.");
                        // table.getSelectedRow();
                    }


                for (int i = 0; i < 15; i++) {
                    out.print("<row id='" + i + "'>");
                    out.print("<cell>" + srNo + "</cell>");
                    out.print("<cell>Taher</cell>");
                    out.print("<cell>8th</cell>");
                    out.print("<cell>25</cell>");
                    out.print("<cell><![CDATA[<a href='ViewStd.jsp'>View</a>]]></cell>");
                    out.print("</row>");
                    srNo++;
                }
                out.print("</rows>");
            }

        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String getParameter(String string) {
        throw new UnsupportedOperationException("Not yet implemented");
    }
}
