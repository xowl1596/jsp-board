package post;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
	 * getDate() <br>
	 * Date 현재 시간을 구해 오라클DB에 맞는 포맷으로 변환 후 리턴
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
	 * write(title, userID, content) : int<br>
	 * 
	 * 유저가 쓴 게시물을 DB에 저장
	 * 
	 * @param title    : 게시물 제목
	 * @param userID   : 게시물을 작성한 유저 ID
	 * @param content: 게시물 내용
	 * @return 1 : 게시물에 정상적으로 DB 에 저장 <br>
	 * 	      -1 : DB 오류
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
	
	/**
	 * getPostList(pageNum) : ArrayList<Post> <br>
	 * 해당 페이지에 속해있는 게시물을 리스트로 리턴
	 * @param pageNum : 페이지
	 * @return null : DB 오류
	 * 		   정상 작동 시 게시물의 리스트를 리턴
	 */
	public ArrayList<Post> getPostList(int pageNum) {
		String listSql = "SELECT * \r\n" + 
						 "FROM(SELECT ROWNUM RN, Z.* \r\n" + 
				         "     FROM(SELECT * \r\n" + 
				         "            FROM POSTS \r\n" + 
				         "           WHERE POST_AVAILABLE = 1\r\n" + 
				         "           ORDER BY POST_ID DESC) Z)\r\n" + 
				         "WHERE RN BETWEEN ? AND ?\r\n";
		
		ArrayList<Post> list = new ArrayList<Post>();
		int firstID = ((pageNum-1) * 10) + 1;
		try {
			// 페이지 번호에 해당하는 게시물들 검색 후 리스트에 저장
			pstmt = conn.prepareStatement(listSql);
			
			pstmt.setInt(1, firstID);
			pstmt.setInt(2, firstID + 9);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Post p = new Post();
				p.setPostID(rs.getInt(2));
				p.setTitle(rs.getString(3));
				p.setUserID(rs.getString(4));
				p.setWriteDate(rs.getString(5));
				p.setContent(rs.getString(6));
				p.setPostAvailable(rs.getInt(7));
				
				list.add(p);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // DB 오류
	}
	
	/**
	 * getMaxPage() : int <br>
	 * 게시물 수에 따라 만들어지는 최대 페이지 수 리턴
	 * @return -1 : DB 에러
	 * 			0 이상의 자연수 : 페이지 개수
	 */
	public int getMaxPage() {
		String sql = "SELECT COUNT(*) FROM POSTS";
		try {
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return (rs.getInt(1) / 10) + 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1; //DB 오류
	}
	
	/**
	 * getPost(postID) : Post <br>
	 * ID값에 해당하는 게시글을 DB에서 가져옴
	 * @param postID : 검색하고자 하는 게시글의 ID
	 * @return null : DB 오류
	 * 		   정상 작동시 검색된 게시글을 리턴
	 */
	public Post getPost(int postID) {
		String sql = "SELECT * FROM POSTS WHERE POST_ID = ? AND POST_AVAILABLE = 1";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, postID);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				Post p = new Post();
				
				p.setPostID(rs.getInt(1));
				p.setTitle(rs.getString(2));
				p.setUserID(rs.getString(3));
				p.setWriteDate(rs.getString(4));
				p.setContent(rs.getString(5));
				p.setPostAvailable(rs.getInt(6));
				return p;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null; //DB 오류
	}
	
	/**
	 * update(postID, title, content) : int <br>
	 * 게시물을 새 제목과 내용으로 업데이트
	 * 
	 * @param postID : 수정하고자 하는 게시물의 ID
	 * @param title : 새로 수정하고자 하는 제목
	 * @param content : 새로 수정하고자 하는 내용
	 * @return -1 : DB 오류 발생 <br>
	 * 			0 : SQL 에러 <br>
	 * 		    1 : 정상 실행
	 */
	public int update(int postID, String title, String content) {
		String sql = "UPDATE POSTS SET TITLE = ?, CONTENT = ? WHERE POST_ID = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(3, postID);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return -1; //DB 오류
	}
	
	/**
	 * delete(postID) : int <br>
	 * 게시물을 삭제상태로 둠
	 * 
	 * @param postID : 삭제하고자 하는 게시물ID
	 * @return -1 : DB 오류 <br>
	 * 			0:  SQL 에러 <br>
	 *			1 : 정상 실행
	 */		    
	public int delete(int postID) {
		String sql = "UPDATE POSTS SET POST_AVAILABLE = 0 WHERE POST_ID = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, postID);
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}
}
















