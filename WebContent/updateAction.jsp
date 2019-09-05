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
<jsp:setProperty name="post" property="postID" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login...</title>
</head>
<body>
	<%
		PostDAO postDAO = new PostDAO();
		PrintWriter script = response.getWriter();

		if (post.getTitle() == null || post.getContent() == null) {
			script.println("<script>");
			script.println("alert('비어있는 항목이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {

			int result = postDAO.update(post.getPostID(), post.getTitle(), post.getContent());
			if (result == -1 || result == 0) {
				script.println("<script>");
				script.println("alert('글수정에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				script.println("<script>");
				script.println("location.href='view.jsp?postID="+ post.getPostID() +"'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>