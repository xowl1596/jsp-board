package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	/**
	 * 생성자<br>
	 * UserDAO 객체 생성 시 회원 정보 DB에 접속합니다.
	 */
	public UserDAO() {
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
	 * login(userID, userPW) : int <br>
	 * 유저 ID/PW와 일치하는 데이터가 DB에 존재하는지 검사해 결과를 정수로 리턴
	 * 
	 * @param userID : 검색하고자 하는 유저 ID
	 * @param userPW : 검색하고자 하는 유저 PW
	 * @return  1 : 일치하는 데이터 발견 (로그인 성공) <br>
	 *         -2 : DB 오류 <br>
	 *         -1 : ID/PW가 일치하지 않음 <br>
	 */
	public int login(String userID, String userPW) {
		String sql = "SELECT USER_PW FROM USERS WHERE USER_ID = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (rs.getString(1).equals(userPW)) {
					return 1;
				} else {
					return -1;
				}
			}

			return -1; // Not found ID
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // DB Error
	}
	
	
	/**
	 * join(user) : int <br>
	 * 유저 정보를 DB에 저장
	 * @param user
	 * @return -1 : DB 오류 <br>
	 *		    1 : 유저 정보 저장 성공(회원가입 성공)
	 */
	public int join(User user) {
		String sql = "INSERT INTO USERS VALUES(?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPW());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
