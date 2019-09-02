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
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />

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
		
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}

		if (userID != null) {
			script.println("<script>");
			script.println("alert('이미 로그인 되어 있습니다.')");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
		}
		
		if (user.getUserID() == null || user.getUserPW() == null || user.getUserName() == null
				|| user.getUserGender() == null || user.getUserEmail() == null) {
			script.println("<script>");
			script.println("alert('비어있는 항목이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			int result = userDAO.join(user);
			if (result == 1) {
				session.setAttribute("userID", user.getUserID());
				script.println("<script>");
				script.println("location.href = 'index.jsp'");
				script.println("</script>");
			} else if (result == -1) {
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		}
	%>
</body>
</html>