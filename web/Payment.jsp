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

  <%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.util.*,javazoom.upload.*" errorPage="" %>

<%@ include file ="config.jsp"%>

<body>

    <script language="JavaScript">
        function windowOpen() {
            var myWindow=window.open('SelectMedia.jsp','windowRef','width=500,height=500');
            if (!myWindow.opener) myWindow.opener = self;
        }
    </script>
    <script language="JavaScript">
        function isNumeric(elem, helperMsg)
        {
            var numericExpression = /^[0-9.]+$/;
            if(elem.value.match(numericExpression)){
                return true;
            }else{
                alert(helperMsg);
                elem.value=elem.value.substr(0,elem.value.length-1);
                elem.focus();
                return false;
            }
        }
    </script>


    <%

        String folno = request.getParameter("id1");
        String roomno = request.getParameter("id2");

        Class.forName("org.postgresql.Driver");
        Connection con = null;
        con = DriverManager.getConnection(url, user1, pw);
        Statement stmt = con.createStatement();
        String sql, mtype = null;
        Double Total1 = 0.00;
        Double Total2 = 0.00, All = 0.00;
        ResultSet rs = null;
         java.sql.Date  sysdate = null;
        Vector errors = new Vector();
        Double Debit = 0.0, Credit = 0.0, FolBal;
        int mfol = Integer.parseInt(folno);

        int trnseq = 0;
        if (MultipartFormDataRequest.isMultipartFormData(request)) {
            MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
            String code1 = mrequest.getParameter("txtVol");
            String co = new String(code1.getBytes("ISO8859_1"), "utf-8");

            String descr1 = mrequest.getParameter("txtVol1");
            String des = new String(descr1.getBytes("ISO8859_1"), "utf-8");

            String am1 = mrequest.getParameter("amount");
            String am = new String(am1.getBytes("ISO8859_1"), "utf-8");


            String re1 = mrequest.getParameter("reference");
            String re = new String(re1.getBytes("ISO8859_1"), "utf-8");
            String rem1 = mrequest.getParameter("remark");
            String rem = new String(rem1.getBytes("ISO8859_1"), "utf-8");
            String ct1 = mrequest.getParameter("ct");
            String ct = new String(ct1.getBytes("ISO8859_1"), "utf-8");
           


            if (co.equals("")) {
                errors.add("check code");
            }
            if (des.equals("")) {
                errors.add("check details");
            }

            if (am.equals("")) {
                errors.add("check amount");
            }

            /*  if ((ct.compareTo("M")==0)||(ct.equals("E"))) {
            errors.add("M");
            }else {errors.add("check Charge to");}*/
            if (re.equals("")) {
                re = null;
            }
            if (rem.equals("")) {
                rem = null;
            }

            if (errors.size() > 0) {
    %><%@include file="ckError.jsp" %><%} else {


        ResultSet r = stmt.executeQuery("  select max(gt_trnseq) FROM gtran where gt_FOLNO='" + mfol + "' and  gt_folseq='" + ct + "' ");
        while (r.next()) {
            trnseq = r.getInt(1);

        }

        rs = stmt.executeQuery(" select sysdate from sysdate   ");
        while (rs.next()) {
            sysdate = rs.getDate(1);
        }
        r = stmt.executeQuery("  select m_type  FROM media where m_id ='" + co + "'  ");
        while (r.next()) {
            mtype = r.getString(1);

        }
        String Pdep = null;
        if (mtype.equals("C")) {
            Pdep = "S";

        } else {
            Pdep = "P";
        }
        int seq1 = Integer.parseInt(ct);

        Double amo1 = Double.parseDouble(am);

        trnseq = trnseq + 1;
        PreparedStatement ps2 = con.prepareStatement("INSERT INTO gtran (gt_FOLNO,gt_FOLSEQ,gt_TRNSEQ,gt_ROOMNO,gt_REFNO,gt_TRNDATE,gt_TRNTIME,gt_POSTTYPE,gt_CORRFLAG,gt_DEPTNO,gt_DEPTDESC,gt_DEPTTYPE,gt_QTY,gt_AMOUNT,gt_TXINFLAG,gt_TXOUTFLAG,gt_SHIFT,gt_USERNO,gt_TRNDETAIL) VALUES ( ?,?,?,?,?, '" + sysdate + "',CURRENT_TIME,?,'N',?,?,?,?,?,'N','N','B','admin1','N')");
        ps2.setDouble(1, mfol);
        ps2.setInt(2, seq1);
        ps2.setInt(3, trnseq);
        ps2.setString(4, roomno);
        ps2.setString(5, re);
        ps2.setString(6, Pdep);
        ps2.setString(7, co);
        ps2.setString(8, des);
        ps2.setString(9, mtype);
        ps2.setInt(10, 1);
        ps2.setDouble(11, amo1);
        ps2.executeUpdate();
        r = stmt.executeQuery("Select coalesce(sum(gt_Amount), 0) From gtran "
                + " Where gt_FolNo = '" + folno + "' and gt_FolSeq = '" + ct + "' and "
                + " gt_DeptType = 'D' and upper(gt_CorrFlag) <> 'Y' and upper(gt_TxOutFlag) <> 'Y' ");
        while (r.next()) {
            Debit = r.getDouble(1);

        }

        /* Sum Credit Amount  */
        r = stmt.executeQuery(" Select coalesce(sum(gt_Amount), 0) From gtran "
                + " Where gt_FolNo = '" + folno + "' and gt_FolSeq = '" + ct + "' and "
                + " gt_DeptType = 'C' and upper(gt_CorrFlag) <> 'Y' and upper(gt_TxOutFlag) <> 'Y' ");
        while (r.next()) {
            Credit = r.getDouble(1);

        }
        FolBal = Debit - Credit;

        sql = "Update gfolseq Set gfs_folbal = '" + FolBal + "' Where gfs_folno = '" + folno + "' and gfs_folseq = '" + ct + "' ";
        stmt.executeUpdate(sql);

    %>



    <%
            // window.location.href = url;
            out.println("<META HTTP-EQUIV='Refresh'CONTENT='1; URL=GuestFolio.jsp?id=" + folno + "'>");

        }
    } else {
        try {
            stmt = con.createStatement();

            String QueryString = "Select gfs_folbal from gfolseq  Where gfs_folno = '" + folno + "' and gfs_folseq = 1 ";
            rs = stmt.executeQuery(QueryString);
            while (rs.next()) {
                Total1 = rs.getDouble(1);
            }
            QueryString = "Select gfs_folbal from gfolseq  Where gfs_folno = '" + folno + "' and gfs_folseq = 2 ";
            rs = stmt.executeQuery(QueryString);
            while (rs.next()) {
                Total2 = rs.getDouble(1);
            }
        } catch (Exception ex) {

            out.println("Unable to connect to database.");
            // table.getSelectedRow();
        }
        All = Total1 + Total2;
    %>

    <P><a href="GuestFolio.jsp?id=<%=folno%>">BACK</a></p>
    <form name="frmMain"  method="post" enctype="multipart/form-data">
        <table width="60%" border="0" align="center" cellpadding="0" style=" border-color: #00F" >
            <tr bgColor=#8080a6 >
                <td colspan="2"><div align="center" style="">
                        <div align="left"><strong>Payment</strong></div>
                    </div></td>
            </tr>
            <tr>
                <td style=" width:300px " >Folio</td>
                <td><input style=" width: 200px" type="text" name="folio" value="<%=folno%>"  />
                </td>
            </tr>
            <tr>
                <td>Room</td>
                <td><input style=" width: 200px" type="text" name="room" value="<%=roomno%>"  />
                </td>
            </tr>
            <tr>
                <td>Folio Master Balance</td>
                <td><input type="text" name="total1" value="<%=Total1%>"  style=" width: 200px" />
                </td>
            </tr>
            <tr>
                <td>Folio Extra Balance</td>
                <td><input type="text" name="total1" value="<%=Total2%>" style=" width: 200px"  />
                </td>
            </tr>
            <tr style=" background-color: khaki " >
                <td>All Total</td>
                <td><input type="text" name="total1" value="<%=All%>"  style=" width: 200px; background-color: khaki  " />
                </td>
            </tr>
            <tr>
                <td colspan="2">Code       <input type="text" value="" name="txtVol" id="txtVol" style=" width: 200px"/>
                    Description  <input type="text" value="" name="txtVol1" id="txtVol1"/><input name="openPopup" type="button" id="openPopup" onClick="Javascript:windowOpen();" value="Search"/></td>
            </tr>

            <tr> <td width="25%">Pay To</td>
                <td width="75%"><p>
                        <label>
                            <input type="radio" name="ct" value="1"  />
                            1-Master</label>
                        <br />
                        <label>
                            <input type="radio" name="ct" value="2"  checked="checked" />
                            2-Extra
                        </label>
                        <br />

                    </p></td>
            </tr>
            <tr>
                <td>Amount</td>
                <td><input type="text" name="amount" style=" width: 200px" onKeyup="JavaScript:return isNumeric(this,'Please enter only number');"  />
                    *</td>
            </tr>
            <tr>
                <td>Reference</td>
                <td><input type="text" name="reference" style=" width: 200px" />
                </td>
            </tr>


            <tr>
                <td>Remark</td>
                <td><input type="text" name="remark" style=" width: 200px" />
                </td>
            </tr>



            <tr>
                <td colspan="2"><div align="center">



                        <input type="Submit" name="Submit" value="OK" onclick="if (! confirm('Pay?')) return  false;"   />
                        <input name="Reset" type="reset" value="reset" />
                    </div></td>
            </tr>
        </table>
    </form>
    <%}%>
</body>



