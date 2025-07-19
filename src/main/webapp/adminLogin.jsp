<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login | Saad Travels</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Impact, Haettenschweiler, 'Arial Narrow Bold', sans-serif;
        }
        
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            color: whitesmoke;
        }
        
        /* Background Video Section */
        .login-hero {
            position: relative;
            flex: 1;
            overflow: hidden;
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
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1;
        }
        
        /* Transparent Login Form */
        .login-form-container {
            position: relative;
            z-index: 2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            padding: 40px;
        }
        
        .login-form {
            background: rgba(90, 52, 23, 0.85); /* Semi-transparent sienna */
            backdrop-filter: blur(10px);
            border: 2px solid goldenrod;
            border-radius: 10px;
            padding: 40px;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
            animation: fadeIn 0.5s ease-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .login-form h2 {
            text-align: center;
            font-size: 2rem;
            margin-bottom: 30px;
            letter-spacing: 3px;
            color: goldenrod;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            letter-spacing: 1px;
        }
        
        .form-group input {
            width: 100%;
            padding: 15px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid goldenrod;
            border-radius: 5px;
            color: white;
            font-size: 1rem;
        }
        
        .form-group input:focus {
            outline: 2px solid goldenrod;
            background: rgba(255, 255, 255, 0.15);
        }
        
        .login-btn {
            width: 100%;
            padding: 15px;
            background-color: goldenrod;
            color: black;
            border: none;
            border-radius: 5px;
            font-size: 1.1rem;
            cursor: pointer;
            transition: background 0.3s;
            margin-top: 10px;
        }
        
        .login-btn:hover {
            background-color: #e6c200;
        }
        
        .register-link {
            text-align: center;
            margin-top: 25px;
            color: burlywood;
        }
        
        .register-link a {
            color: goldenrod;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s;
        }
        
        .register-link a:hover {
            color: #e6c200;
            text-decoration: underline;
        }
        #toast {
    position: fixed;
    top: 30px;
    right: 30px;
    background-color: #333;
    color: #fff;
    padding: 14px 24px;
    border-radius: 6px;
    font-size: 16px;
    z-index: 9999;
    box-shadow: 0 2px 12px rgba(0,0,0,0.3);
    animation: fadein 0.5s, fadeout 0.5s 3.5s;
}
@keyframes fadein {
    from {opacity: 0;}
    to {opacity: 1;}
}
@keyframes fadeout {
    from {opacity: 1;}
    to {opacity: 0;}
}
    </style>
</head>
<body>

<% if (msg != null) { %>
<script>
    window.onload = function () {
        const toast = document.getElementById("toast");
        toast.style.display = "block";
        setTimeout(() => {
            toast.style.display = "none";
        }, 4000);
    };
</script>
<% } %>
<!-- Toast Box -->
<div id="toast" style="display: none;">
    <span id="toast-message"><%= msg != null ? msg : "" %></span>
</div>


    <!-- Navigation -->
    <%@ include file="header.jsp" %>
    
    <div class="video-container">
        <video class="bg-video" autoplay muted loop>
            <source src="Videos/videoplayback2.webm" type="video/webm">
        </video>
        
        <!-- Admin Login Form Overlay -->
        <div class="login-form-container">
            <form action="adminLogin" method="post" class="login-form">
                <h2>ADMIN LOGIN</h2>
                
                <div class="form-group">
                    <label for="email">ADMIN EMAIL</label>
                    <input type="email" name="email" id="email" placeholder="Enter admin email" required>
                </div>
                
                <div class="form-group">
                    <label for="password">PASSWORD</label>
                    <input type="password" name="password" id="password" placeholder="Enter password" required>
                </div>
                
                <button type="submit" class="login-btn">LOGIN</button>
                
                <div class="register-link">
                    Are you a user? <a href="login.jsp">Go to User Login</a>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Footer (Same as Main Page) -->
    <%@ include file="footer.jsp" %>
    
</body>
</html>
