package vvscomment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class vvsCommentDAO {
	private Connection conn;	//db에 접근하는 객체
	private ResultSet rs;
	
	public vvsCommentDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public String getvvsDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	public int getvvsNext() {
		String SQL = "SELECT vvscommentID FROM vvscomment ORDER BY vvscommentID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 1; //첫번째 댓글인 경우
	}
	public int vvswrite(int vvsboardID, int vvsID, String userID, String vvscommentText) {
		String SQL = "INSERT INTO vvscomment VALUES(?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, vvsboardID);
			pstmt.setInt(2, getvvsNext());
			pstmt.setInt(3, vvsID);
			pstmt.setString(4, userID);
			pstmt.setString(5, getvvsDate());
			pstmt.setString(6, vvscommentText);
			pstmt.setInt(7, 1);
			pstmt.executeUpdate();
			return getvvsNext();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	public String getUpdatevvsComment(int vvscommentID) {
		String SQL = "SELECT vvscommentText FROM vvscomment WHERE vvscommentID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, vvscommentID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //오류
	}
	public ArrayList<vvsComment> getList(int vvsboardID, int vvsID){
		String SQL = "SELECT * FROM vvscomment WHERE vvsboardID = ? AND vvsID= ? AND vvscommentAvailable = 1 ORDER BY vvsID DESC"; 
		ArrayList<vvsComment> list = new ArrayList<vvsComment>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, vvsboardID);
			pstmt.setInt(2, vvsID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vvsComment cmt = new vvsComment();
				cmt.setVvsboardID(rs.getInt(1));
				cmt.setVvscommentID(rs.getInt(2));
				cmt.setVvsID(rs.getInt(3));
				cmt.setUserID(rs.getString(4));
				cmt.setVvscommentDate(rs.getString(5));
				cmt.setVvscommentText(rs.getString(6));
				cmt.setVvscommentAvilable(rs.getInt(7));
				list.add(cmt);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; //데이터베이스 오류
	}
	
	public int update(int vvscommentID, String vvscommentText) {
		String SQL = "UPDATE vvscomment SET vvscommentText = ? WHERE vvscommentID LIKE ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, vvscommentText);
			pstmt.setInt(2, vvscommentID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	public vvsComment getvvsComment(int vvscommentID) {
		String SQL = "SELECT * FROM vvscomment WHERE vvscommentID = ? ORDER BY vvscommentID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  vvscommentID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vvsComment cmt = new vvsComment();
				cmt.setVvsboardID(rs.getInt(1));
				cmt.setVvscommentID(rs.getInt(2));
				cmt.setVvsID(rs.getInt(3));
				cmt.setUserID(rs.getString(4));
				cmt.setVvscommentDate(rs.getString(5));
				cmt.setVvscommentText(rs.getString(6));
				cmt.setVvscommentAvilable(rs.getInt(7));
				return cmt;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public int vvsdelete(int vvscommentID) {
		String SQL = "DELETE FROM vvscomment WHERE vvscommentID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, vvscommentID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
