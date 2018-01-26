/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Administrator
 */
package com.comis.frontsystem.database;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
 
public class JDBCTransaction {
 
/*	private static final String DB_DRIVER = "org.postgresql.Driver";
        private static final String DB_PRODUCTION_IP = "localhost";
        private static final String DB_DEVELOP_IP = "127.0.0.1";
        
        private static final String DB_CON_STRING = "jdbc:postgresql://%s:5432/front";
	private static final String DB_USER = "postgres";
	private static final String DB_PASSWORD = "petra2000";
        String path="D:\\FrontWeb\\web";
     *
     */
    //private static final String DB_DRIVER = "org.postgresql.Driver";
        private static final String DB_PRODUCTION_IP = "localhost";
        private static final String DB_DEVELOP_IP = "127.0.0.1";
        
     //   private static final String DB_CON_STRING = "jdbc:postgresql://%s:5432/front";
	//private static final String DB_USER = "root";
	//private static final String DB_PASSWORD = "test";
        
  String path="D:\\FrontWeb\\web";
String user1="root";
String pw="test";
String url="jdbc:postgresql://localhost:5432/front";
String driver="org.postgresql.Driver";
	/*public static void main(String[] argv) throws SQLException {
 
		Connection dbConnection = null;
		PreparedStatement preparedStatementInsert = null;
		PreparedStatement preparedStatementUpdate = null;
 
		String insertTableSQL = "INSERT INTO DBUSER"
				+ "(USER_ID, USERNAME, CREATED_BY, CREATED_DATE) VALUES"
				+ "(?,?,?,?)";
 
		String updateTableSQL = "UPDATE DBUSER SET USERNAME =? "
				+ "WHERE USER_ID = ?";
 
		try {
			dbConnection = getDBConnection();
 
			dbConnection.setAutoCommit(false);
 
			preparedStatementInsert = dbConnection.prepareStatement(insertTableSQL);
			preparedStatementInsert.setInt(1, 999);
			preparedStatementInsert.setString(2, "mkyong101");
			preparedStatementInsert.setString(3, "system");
			preparedStatementInsert.setTimestamp(4, getCurrentTimeStamp());
			preparedStatementInsert.executeUpdate();
 
			preparedStatementUpdate = dbConnection.prepareStatement(updateTableSQL);
			// preparedStatementUpdate.setString(1,
			// "A very very long string caused db error");
			preparedStatementUpdate.setString(1, "new string");
			preparedStatementUpdate.setInt(2, 999);
			preparedStatementUpdate.executeUpdate();
 
			dbConnection.commit();
 
			System.out.println("Done!");
 
		} catch (SQLException e) {
 
			System.out.println(e.getMessage());
			dbConnection.rollback();
 
		} finally {
 
			if (preparedStatementInsert != null) {
				preparedStatementInsert.close();
			}
 
			if (preparedStatementUpdate != null) {
				preparedStatementUpdate.close();
			}
 
			if (dbConnection != null) {
				dbConnection.close();
			}
 
		}
 
	}*/
 
	public static Connection getDBConnection(
String DB_USER,
String DB_PASSWORD,
String DB_CON_STRING,
String DB_DRIVER,List errorList) {
 
		Connection dbConnection = null;
 
		try {
 
			Class.forName(DB_DRIVER);
 
		} catch (ClassNotFoundException e) {
 
			errorList.add(e.getMessage());
 
		}
 
		try {
                        
			dbConnection = DriverManager.getConnection(String.format(DB_CON_STRING,DB_PRODUCTION_IP), DB_USER,
					DB_PASSWORD);
			return dbConnection;
 
		} catch (SQLException e) {
                    try{
                        dbConnection = DriverManager.getConnection(String.format(DB_CON_STRING,DB_DEVELOP_IP), DB_USER,
					DB_PASSWORD);
			return dbConnection;
                    }catch(SQLException e2){
                        errorList.add(e2.getMessage());
                    }
			
 
		}
 
		return dbConnection;
 
	}
 
	
 
}
