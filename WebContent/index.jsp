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
		//현재 로그인 상태인지 확인
		String userID = null; 
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		//현재 보고 있는 페이지 수 확인
		int pageNum = 1;
		if(request.getParameter("pageNum") != null){
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
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
			<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
				<thead>
					<tr>
						<th class="table-head">번호</th>
						<th class="table-head">제목</th>
						<th class="table-head">작성자</th>
						<th class="table-head">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%  //현재 페이지에 맞는 게시물들을 가져와 목록으로 출력
						PostDAO postDAO = new PostDAO();
						ArrayList<Post> list = postDAO.getPostList(pageNum);
						for(int i = 0; i < list.size(); i++){				%>
							<tr>
								<td><%= list.get(i).getPostID() %></td>
								<td><a href="view.jsp?postID=<%= list.get(i).getPostID()%>"><%= list.get(i).getTitle() %></a></td>
								<td><%= list.get(i).getUserID() %></td>
								<td><%= list.get(i).getWriteDate() %></td>
							</tr>
					<%	}%>
				</tbody>
			</table>
			
			<a href="write.jsp" class="btn btn-primary float-right">글쓰기</a>
		</div>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
</body>

</html>








































