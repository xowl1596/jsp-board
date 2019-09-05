<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="post.PostDAO"%>
<%@ page import="post.Post"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device_width, initial-scale=1.0" />
<link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" href="css/main.css" />
<title>JSP Board</title>
</head>

<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		//로그인 상태가 아닐경우 로그인창으로 이동
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 이용해 주세요');");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		
		PostDAO postDAO = new PostDAO();
		Post post = postDAO.getPost(Integer.parseInt(request.getParameter("postID")));
		
		//게시글을 쓴 사람인지 확인
		if(!userID.equals(post.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('자신이 쓴 글만 수정이 가능합니다');");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
	
	<nav class="navbar navbar-expand-sm bg-light">
		<a class="navbar-brand" href="index.jsp">JSP 게시판 페이지</a>
		<ul class="nav">
			<li class="nav-item"><a class="nav-link" href="index.jsp">메인</a></li>
		</ul>
		<ul class="nav">
			<li class="nav-item"><a class="nav-link" href="main.jsp">게시판</a></li>
		</ul>

		
		<div class="dropdown">
			<button type="button" class="btn btn-primary dropdown-toggle"
				data-toggle="dropdown">회원관리</button>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="logoutAction.jsp">로그아웃</a>
			</div>
		</div>
	</nav>

	<div class="container">
			<form method="post" action="updateAction.jsp">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th class="table-head">수정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<input type="text" class="form-control" placeholder="제목" name="title" maxlength="50" value="<%=post.getTitle() %>" />
							</td>
						</tr>
						<tr>
							<td>
								<textarea class="form-control" placeholder="내용" name="content" maxlength="2048" style="height: 350px;"><%=post.getContent() %></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<input type="hidden" name="postID" value="<%=request.getParameter("postID")%>"/>
				<input type="submit" class="btn btn-primary float-right" value="글쓰기" />
			</form>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
</body>

</html>








































