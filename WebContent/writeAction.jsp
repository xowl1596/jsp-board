<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="post.PostDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="post" class="post.Post" scope="page" />
<jsp:setProperty name="post" property="title" />
<jsp:setProperty name="post" property="content" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login...</title>
</head>
<body>
	<%
		String userID = null;
		PostDAO postDAO = new PostDAO();
		PrintWriter script = response.getWriter();
		
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}

		if (userID == null) {
			script.println("<script>");
			script.println("alert('로그인 후 글쓰기가 가능합니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			if (post.getTitle() == null || post.getContent() == null) {
				script.println("<script>");
				script.println("alert('비어있는 항목이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				
				int result = postDAO.write(post.getTitle(), userID, post.getContent());
				if (result == -1 || result == 0) {
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					script.println("<script>");
					script.println("location.href='index.jsp'");
					script.println("</script>");
				}
			}
		}
		
		
	%>
</body>
</html>