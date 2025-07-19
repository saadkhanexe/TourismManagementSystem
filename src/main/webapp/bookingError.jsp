<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="sessionCheck.jsp" %> <%-- Ensure session is checked --%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Booking Error</title>
<link rel="stylesheet" href="style.css"> <%-- Link to your existing stylesheet --%>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;700&family=Roboto:wght@400;500&display=swap" rel="stylesheet">
<style>
/* Inherit global styles from style.css or define here if not linked */
body {
    background-color: #1a1a1a; /* Dark background */
    color: #e0e0e0; /* Softer white text */
    font-family: 'Roboto', sans-serif;
    line-height: 1.6;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
}

.error-container {
    background-color: #2a2a2a; /* Darker background for the container */
    padding: 40px;
    border-radius: 15px;
    max-width: 700px;
    margin: 60px auto; /* Centered with more vertical margin */
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5),
                0 0 0 5px rgba(139, 0, 0, 0.1); /* Subtle dark red glow for error */
    text-align: center;
    flex-grow: 1; /* Allows container to grow and fill available space */
    animation: fadeIn 0.8s ease-out;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

h1 {
    color: #FF6347; /* Tomato red for error heading */
    font-family: 'Montserrat', sans-serif;
    font-size: 2.8em;
    margin-bottom: 30px;
    letter-spacing: 2px;
    text-shadow: 0 0 10px rgba(255, 99, 71, 0.5); /* Soft glow */
}

.error-message {
    font-size: 1.2em;
    color: #FFD700; /* Goldenrod for the main message for visibility */
    margin-bottom: 25px;
    font-weight: 500;
}

.error-details {
    font-size: 1em;
    color: #ccc;
    margin-bottom: 30px;
    line-height: 1.8;
}

.error-details strong {
    color: goldenrod;
}

.back-button {
    display: inline-block;
    padding: 12px 25px;
    background-color: goldenrod;
    color: #1a1a1a;
    font-weight: bold;
    text-decoration: none;
    border: none;
    border-radius: 5px;
    transition: background-color 0.3s ease, transform 0.2s ease;
    cursor: pointer;
    font-family: 'Montserrat', sans-serif;
    font-size: 1.1em;
}

.back-button:hover {
    background-color: #e6c200;
    transform: translateY(-2px);
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .error-container {
        padding: 25px;
        margin: 30px auto;
    }
    h1 {
        font-size: 2.2em;
    }
    .error-message {
        font-size: 1.1em;
    }
}
</style>
</head>
<body>

	<%@ include file="navigation.jsp" %>

    <div class="error-container">
        <h1>Booking Failed!</h1>

        <%
            // Retrieve the error message from the session
            String errorMessage = (String) session.getAttribute("bookingErrorMessage");
            if (errorMessage == null || errorMessage.isEmpty()) {
                errorMessage = "An unexpected error occurred during your booking. Please try again or contact support.";
            }
            // Clear the message from session after displaying it
            session.removeAttribute("bookingErrorMessage");
        %>

        <p class="error-message"><%= errorMessage %></p>

        <div class="error-details">
            <p>We apologize for the inconvenience. Your booking could not be completed at this time.</p>
            <p>Please ensure all details are correct and try again.</p>
            <p>If the problem persists, please contact our support team with the details of your attempted booking.</p>
        </div>

        <a href="index.jsp" class="back-button">Go Back to Home</a>
    </div>

	<%@ include file="footer.jsp" %>

</body>
</html>
