<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPW" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login...</title>
</head>
<body>
	<%
		String userID = null;
		UserDAO userDAO = new UserDAO();
		PrintWriter script = response.getWriter();

		//이미 로그인 되어있는 상태인지 확인
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}

		if (userID != null) {
			script.println("<script>");
			script.println("alert('이미 로그인 되어 있습니다.')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}

		//로그인 수행
		int result = userDAO.login(user.getUserID(), user.getUserPW());
		if (result == 1) {
			session.setAttribute("userID", user.getUserID());
			script.println("<script>");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		} else if (result == -1) {
			script.println("<script>");
			script.println("alert('아이디 또는 패스워드가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if (result == -2) {
			script.println("<script>");
			script.println("alert('DB 오류 - 잠시 후 다시 시도해 주세요')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>