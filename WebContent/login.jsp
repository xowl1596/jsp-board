<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device_width, initial-scale=1.0" />
<link rel="stylesheet" href="css/bootstrap.css" />
<title>JSP Board</title>
</head>

<body>
	<nav class="navbar navbar-expand-sm bg-light">
		<a class="navbar-brand" href="index.jsp">JSP 게시판 페이지</a>
		<ul class="nav">
			<li class="nav-item"><a class="nav-link" href="index.jsp">메인</a></li>
		</ul>
		<ul class="nav">
			<li class="nav-item"><a class="nav-link" href="main.jsp">게시판</a></li>
		</ul>
		
		<div class="dropdown">
			<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
				로그인
			</button>
			<div class="dropdown-menu">
				<a class="dropdown-item" href="login.jsp">로그인</a>
				<a class="dropdown-item" href="join.jsp">회원가입</a>
			</div>
		</div>
	</nav>
	
	<div class="container">
		<h2>로그인</h2>
		<form method="post" action="loginAction.jsp">
			<div class="form-group">
				<label for="userID">ID </label>
				<input type="text" class="form-control" id="userID" placeholder="Enter ID" name="userID"/>
			</div>
			<div class="form-group">
				<label for="userPW">PW </label>
				<input type="password" class="form-control" id="userPW" placeholder="Enter PW" name="userPW"/>
			</div>
			<input type="submit" class="btn btn-primary" value="로그인"/>
		</form>
	</div>
	
	
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
</body>

</html>








































