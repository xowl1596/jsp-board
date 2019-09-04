package post;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.sql.Date;

public class PostDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	/**
	 * 생성자<br>
	 * UserDAO 객체 생성 시 회원 정보 DB에 접속.
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

	/**
	 * getDate() : Date 현재 시간을 구해 오라클DB에 맞는 포맷으로 변환 후 리턴
	 * 
	 * @return 오라클 DB에 맞는 포맷의 현재 날짜
	 */
	public Date getDate() {
		SimpleDateFormat format = new SimpleDateFormat("yy-mm-dd");
		Calendar currentTime = Calendar.getInstance();
		Date date = new Date(currentTime.getTimeInMillis());
		return date;
	}

	/**
	 * write(title, userID, content) : int 유저가 쓴 게시물을 DB에 저장
	 * 
	 * @param title    : 게시물 제목
	 * @param userID   : 게시물을 작성한 유저 ID
	 * @param content: 게시물 내용
	 * @return 1 : 게시물에 정상적으로 DB 에 저장 -1 : DB 오류
	 */
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
		return -1; // DB 오류
	}

	public ArrayList<Post> getPostList(int pageNum) {
		String listSql = "SELECT * FROM POSTS WHERE POST_ID < ? AND POST_AVAILABLE = 1 AND ROWNUM <= 10 ORDER BY POST_ID DESC";
		String lastIdSql = "SELECT MAX(POST_ID) FROM POSTS";
		
		int lastId = 0;
		ArrayList<Post> list = new ArrayList<Post>();

		try {
			// 게시물의 최대 ID값 구하기
			pstmt = conn.prepareStatement(lastIdSql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				lastId = rs.getInt(1);
			}
			System.out.println(lastId);
			
			// 페이지 번호에 해당하는 게시물들 검색 후 리스트에 저장
			pstmt = conn.prepareStatement(listSql);
			pstmt.setInt(1, (lastId + 1) - ((pageNum - 1) * 10));
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Post p = new Post();
				p.setPostID(rs.getInt(1));
				p.setTitle(rs.getString(2));
				p.setUserID(rs.getString(3));
				p.setWriteDate(rs.getString(4));
				p.setContent(rs.getString(5));
				p.setPostAvailable(rs.getInt(6));
				
				list.add(p);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // DB 오류
	}
}
















