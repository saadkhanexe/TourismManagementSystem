<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up | Saad Travels</title>
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
        
        /* Video Container */
        .video-container {
            position: relative;
            width: 100%;
            height: calc(100vh - 100px);
            overflow: hidden;
            flex: 1;
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
        
        /* Signup Form */
        .signup-form-container {
            position: relative;
            z-index: 2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            padding: 40px;
        }
        
        .signup-form {
            background: rgba(90, 52, 23, 0.85);
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
        
        .signup-form h2 {
            text-align: center;
            font-size: 2rem;
            margin-bottom: 30px;
            letter-spacing: 3px;
            color: goldenrod;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            letter-spacing: 1px;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px;
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
        
        .signup-btn {
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
        
        .signup-btn:hover {
            background-color: #e6c200;
        }
        
        .login-link {
            text-align: center;
            margin-top: 20px;
            color: burlywood;
        }
        
        .login-link a {
            color: goldenrod;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s;
        }
        
        .login-link a:hover {
            color: #e6c200;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <!-- Video Background with Signup Form -->
    <div class="video-container">
        <video class="bg-video" autoplay muted loop>
            <source src="Videos/videoplayback.webm" type="video/webm">
        </video>
        
        <div class="signup-form-container">
            <form action="signupSubmit" method="post" class="signup-form">
                <h2>CREATE ACCOUNT</h2>
                
                <div class="form-group">
                    <label for="name">FULL NAME</label>
                    <input type="text" name="name" id="name" placeholder="Enter your full name" required>
                </div>
                
                <div class="form-group">
                    <label for="email">EMAIL</label>
                    <input type="email" name="email" id="email" placeholder="Enter your email" required>
                </div>
                
                <div class="form-group">
                    <label for="phone">PHONE NUMBER</label>
                    <input type="tel" name="phone" id="phone" placeholder="Enter your phone number" required>
                </div>
                
                <div class="form-group">
                    <label for="password">PASSWORD</label>
                    <input type="password" name="password" id="password" placeholder="Create a password" required>
                </div>
                
                <div class="form-group">
                    <label for="confirm-password">CONFIRM PASSWORD</label>
                    <input type="password" name="confirmPassword" id="confirm-password" placeholder="Re-enter your password" required>
                </div>
                
                <button type="submit" class="signup-btn">SIGN UP</button>
                
                <div class="login-link">
                    Already have an account? <a href="login.html">Login here</a>
                </div>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>
</body>
</html>