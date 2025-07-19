<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.tourist.dto.Tourist"%>
<%@ page session="true"%>
<%@ include file="sessionCheck.jsp"%>

<%
Tourist t = (Tourist) request.getAttribute("tourist");
if (t == null) {
	response.sendRedirect("login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Profile</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Impact, Haettenschweiler, 'Arial Narrow Bold', sans-serif;
	color: whitesmoke;
}

body, html {
	height: 100%;
}

.video-container {
	position: relative;
	width: 100%;
	height: calc(100vh - 100px); /* Full viewport minus nav height */
	overflow: hidden;
}

.bg-video {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
	z-index: 1;
}

.profile-form-container {
	position: relative;
	z-index: 2;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100%;
	padding: 40px;
}

.profile-container {
	background: rgba(90, 52, 23, 0.85); /* Semi-transparent sienna */
	backdrop-filter: blur(10px);
	border: 2px solid goldenrod;
	border-radius: 10px;
	padding: 50px;
	width: 100%;
	max-width: 600px;
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
	animation: fadeIn 0.5s ease-out;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.profile-container h2 {
	text-align: center;
	color: goldenrod;
	margin-bottom: 30px;
	letter-spacing: 3px;
}

label {
	display: block;
	margin-bottom: 8px;
	color: burlywood;
	font-size: 1.1rem;
}

input[type="text"], input[type="email"] {
	width: 100%;
	padding: 12px;
	margin-bottom: 25px;
	border: 1px solid goldenrod;
	border-radius: 5px;
	background: rgba(255, 255, 255, 0.1);
	color: white;
}

input:focus {
	outline: 2px solid goldenrod;
	background: rgba(255, 255, 255, 0.2);
}

.actions {
	display: flex;
	justify-content: space-between;
	gap: 20px;
}

.actions button {
	flex: 1;
	padding: 12px;
	background: goldenrod;
	color: black;
	font-size: 1.1rem;
	font-weight: bold;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background 0.3s;
}

.actions button:hover {
	background: #e6c200;
}
</style>
</head>
<body>
	<%@ include file="navigation.jsp"%>

	<div class="video-container">
		<video class="bg-video" autoplay muted loop>
			<source src="Videos/videoplayback2.webm" type="video/webm">
		</video>

		<!-- Profile Form Overlay -->
		<div class="profile-form-container">
			<div class="profile-container">
				<h2>
					Welcome,
					<%=t.getName()%></h2>
				<form method="post" action="profile">

					<label>Name:</label> <input type="text" name="name"
						value="<%=t.getName()%>" required> <label>Email:</label>
					<input type="email" name="email" value="<%=t.getEmail()%>"
						required> <label>Phone:</label> <input type="text"
						name="phone" value="<%=t.getPhone()%>" required>

					<div class="actions">
						<button type="submit" name="action" value="update">Update
							Profile</button>
						<button type="submit" name="action" value="delete">Delete
							Account</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<%@ include file="footer.jsp"%>
</body>
</html>
