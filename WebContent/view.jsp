<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="post.PostDAO"%>
<%@ page import="post.Post"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device_width, initial-scale=1.0" />
<link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" href="css/main.css"/>
<title>JSP Board</title>
</head>

<body>
	<%
		//게시글 DB에 접근하기 위한 객체
		PostDAO postDAO = new PostDAO();
		//현재 로그인 상태인지 확인
		String userID = null; 
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
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

		<%
			if (userID == null) { //로그인 상태면 로그인 UI를 숨기고 회원관리 UI를 표시
		%>
				<div class="dropdown">
					<button type="button" class="btn btn-primary dropdown-toggle"data-toggle="dropdown">
						로그인
					</button>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="login.jsp">로그인</a> 
						<a class="dropdown-item" href="join.jsp">회원가입</a>
					</div>
				</div>
		<%
			}else{
		%>
				<div class="dropdown">
					<button type="button" class="btn btn-primary dropdown-toggle"data-toggle="dropdown">
						회원관리
					</button>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="logoutAction.jsp">로그아웃</a>
					</div>
				</div>
		<%		
			}
		%>
	</nav>
	
	<div class="container">
		<div class="row">
			<%
				Post post = postDAO.getPost(Integer.parseInt(request.getParameter("postID")));
			%>
			<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
				<thead>
					<tr>
						<th class="table-head">ID : <%=post.getPostID()%></th>
						<th class="table-head">제목 : <%=post.getTitle() %></th>
						<th class="table-head">작성자 : <%=post.getUserID() %></th>
						<th class="table-head">작성일 : <%=post.getWriteDate() %></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="4">
							<%=post.getContent() %>
						</td>
					</tr>
				</tbody>
			</table>
			<a href="update.jsp?postID=<%=post.getPostID()%>" class="btn btn-success">수정</a>
			<a href="delete.jsp?postID=<%=post.getPostID()%>" class="btn btn-warning">삭제</a>
			<a href="write.jsp" class="btn btn-primary">글쓰기</a>
		</div>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
</body>

</html>








































