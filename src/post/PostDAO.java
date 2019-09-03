package post;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.sql.Date;

public class PostDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	/**
	 * 생성자<br>
	 * UserDAO 객체 생성 시 회원 정보 DB에 접속합니다.
	 */
	public PostDAO() {
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:orcl";
			String id = "JSPBOARD";
			String pw = "jspboard";

			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, id, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Date getDate() {
		SimpleDateFormat format = new SimpleDateFormat("yy-mm-dd");
		Calendar currentTime = Calendar.getInstance();
		Date date = new Date(currentTime.getTimeInMillis());
		return date;
	}
	
	public int write(String title, String userID, String content) {
		String sql = "INSERT INTO POSTS VALUES(POST_ID_SEQ.NEXTVAL, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, userID);
			pstmt.setDate(3, getDate());
			pstmt.setString(4, content);
			pstmt.setInt(5, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //DB 오류
	}
}
