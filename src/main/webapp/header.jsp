<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String uri = request.getRequestURI();
    boolean isIndex = uri.endsWith("/") || uri.endsWith("index.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
nav {
	display: flex;
	justify-content: space-evenly;
	align-items: center;
	background-color: sienna;
	height: 100px;
	width: 100%;
}

ol {
	display: flex;
	align-items: center;
	gap: 30px;
}

.nav-list {
	list-style: none;
	cursor: pointer;
	letter-spacing: 1px;
	font-size: 1.2rem;
}

.nav-list a {
	text-decoration: none;
	color: whitesmoke;
}

.nav-list a:hover {
	text-decoration: underline;
}

#logo img {
	height: 80px;
	width: 90px;
	object-fit: contain;
}

#login {
	position: relative;
	color: white;
	font-size: 1.5rem;
	cursor: pointer;
	padding: 10px;
}

#login:hover .user-dropdown {
	display: block;
}

.user-dropdown {
	display: none;
	position: absolute;
	right: -200%;
	top: 100%;
	background-color: sienna;
	min-width: 200px;
	border-radius: 0 0 8px 8px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
	z-index: 1000;
	border-top: 3px solid goldenrod;
}

.dropdown-header {
	padding: 15px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
	text-align: center;
	color: goldenrod;
	font-size: 1.1rem;
}

.dropdown-options {
	padding: 10px 0;
}

.dropdown-options a {
	display: block;
	padding: 12px 20px;
	color: white;
	text-decoration: none;
	transition: all 0.3s;
}

.dropdown-options a:hover {
	background-color: rgba(218, 165, 32, 0.2);
	padding-left: 25px;
	color: goldenrod;
}

.dropdown-options a i {
	margin-right: 10px;
	width: 20px;
	text-align: center;
}

</style>
</head>
<body>
<header>
	<nav>
		<div id="logo">
			<img src="Images/Saad-removebg-preview.png" alt="Logo">
		</div>
		<div id="nav-elements">
			<ol>
				<li class="nav-list"><a href="index.jsp">Home</a></li>
				<% if (isIndex) { %>
					<li class="nav-list"><a href="#destinations">Destinations</a></li>
					<li class="nav-list"><a href="#services">Services</a></li>
					<li class="nav-list"><a href="#reviews">Reviews</a></li>
				<% } %>
			</ol>
		</div>
		<div id="login">
			<i class="fa-solid fa-user"></i>
			<div class="user-dropdown">
				<div class="dropdown-header">Member Access</div>
				<div class="dropdown-options">
					<a href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a>
					<a href="signup.jsp"><i class="fas fa-user-plus"></i> Sign Up</a>
					<a href="adminLogin.jsp"><i class="fas fa-sign-in-alt"></i> Admin Login</a>
				</div>
			</div>
		</div>
	</nav>
</header>
</body>
</html>