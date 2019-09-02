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
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPW());
		PrintWriter script = response.getWriter();

		if (result == 1) {
			
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