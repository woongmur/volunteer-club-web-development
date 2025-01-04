package vvs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class VvsDAO {
	private Connection conn;
	private ResultSet rs;
	
	public VvsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {
		String SQL = "SELECT vvsID FROM VVS ORDER BY vvsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 게시물인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int write(String vvsTitle, String userID, String vvsContent) {
		String SQL = "INSERT INTO VVS VALUES (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, vvsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, vvsContent);
			pstmt.setInt(6, 1);
			
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
		
	public ArrayList<Vvs> getList(int pageNumber) {
		String SQL = "SELECT * FROM VVS WHERE vvsID < ? AND vvsAvailable = 1 ORDER BY vvsID DESC LIMIT 10";
		ArrayList<Vvs> list = new ArrayList<Vvs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Vvs vvs = new Vvs();
				vvs.setVvsID(rs.getInt(1));
				vvs.setVvsTitle(rs.getString(2));
				vvs.setUserID(rs.getString(3));
				vvs.setVvsDate(rs.getString(4));
				vvs.setVvsContent(rs.getString(5));
				vvs.setVvsAvailable(rs.getInt(1));
				list.add(vvs);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM VVS WHERE vvsID < ? AND vvsAvailable = 1";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Vvs getVvs(int vvsID) {
		String SQL = "SELECT * FROM VVS WHERE vvsID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, vvsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Vvs vvs = new Vvs();
				vvs.setVvsID(rs.getInt(1));
				vvs.setVvsTitle(rs.getString(2));
				vvs.setUserID(rs.getString(3));
				vvs.setVvsDate(rs.getString(4));
				vvs.setVvsContent(rs.getString(5));
				vvs.setVvsAvailable(rs.getInt(1));
				return vvs;
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int vvsID, String vvsTitle, String vvsContent) {
		String SQL = "UPDATE VVS SET vvsTitle = ?, vvsContent = ? WHERE vvsID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, vvsTitle);
			pstmt.setString(2, vvsContent);
			pstmt.setInt(3, vvsID);
			
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(int vvsID) {
		String SQL = "UPDATE VVS SET vvsAvailable = 0 WHERE vvsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, vvsID);
			
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

}
