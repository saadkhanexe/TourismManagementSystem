<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.tourist.dao.PaymentImplementation"%>
<%@ page import="com.tourist.dto.Payment"%>
<%@ include file="sessionCheck.jsp"%>

<%
String bookingId = request.getParameter("booking_id");
String paymentMethod = request.getParameter("payment");
%>

<%
String paymentIdStr = request.getParameter("payment_id");
String paymentStatus = "N/A";
double amount = 0;

if (paymentIdStr != null) {
	try {
		int paymentId = Integer.parseInt(paymentIdStr);
		PaymentImplementation paymentDAO = new PaymentImplementation();
		Payment payment = paymentDAO.getPayment(paymentId);

		if (payment != null) {
	bookingId = String.valueOf(payment.getBookingId());
	paymentMethod = payment.getPaymentMethod();
	paymentStatus = payment.getPaymentStatus();
	amount = payment.getAmount();
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Booking Confirmed</title>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;700&family=Roboto:wght@400;500&display=swap" rel="stylesheet">
<style>
/* Reset and Global Styles */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	background-color: #121212; /* Dark background */
	color: #e0e0e0; /* Softer white text */
	font-family: 'Roboto', sans-serif; /* Modern, readable font for body */
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh; /* Ensure it takes full viewport height */
	line-height: 1.6;
}

.confirmation-box {
	background-color: #1f1f1f; /* Slightly lighter than body background */
	border: 1px solid #3a3a3a; /* Subtle border */
	padding: 50px; /* Increased padding */
	border-radius: 15px; /* Softer rounded corners */
	text-align: center;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.6), /* Stronger, deeper shadow */
	            0 0 0 5px rgba(218, 165, 32, 0.1); /* Subtle goldenrod glow */
	max-width: 550px; /* Max width for readability */
	width: 90%; /* Responsive width */
	animation: fadeIn 0.8s ease-out; /* Fade-in animation */
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

.confirmation-box h1 {
	color: goldenrod; /* Bright accent for main title */
	font-family: 'Montserrat', sans-serif; /* Distinct font for headings */
	font-size: 2.8em; /* Larger heading */
	margin-bottom: 25px; /* More space below heading */
	letter-spacing: 1.5px;
	text-shadow: 0 0 10px rgba(218, 165, 32, 0.4); /* Soft glow for title */
	display: flex;
    align-items: center;
    justify-content: center;
    gap: 15px; /* Space between text and icon */
}

.confirmation-box h1::after {
    content: '✅'; /* The checkmark icon */
    font-size: 0.8em; /* Slightly smaller icon relative to text */
    color: #4CAF50; /* Green color for success icon */
    margin-left: -10px; /* Adjust to bring icon closer to text */
    animation: bounce 0.6s ease-out 0.5s; /* Bounce animation for the checkmark */
    animation-fill-mode: backwards; /* Keeps the starting state of the animation */
}

@keyframes bounce {
    0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
    40% { transform: translateY(-10px); }
    60% { transform: translateY(-5px); }
}


.confirmation-box p {
	font-size: 1.1em; /* Slightly larger text for details */
	margin: 12px 0; /* More vertical spacing */
	color: #c0c0c0; /* Softer color for detail text */
}

.confirmation-box p strong {
	color: goldenrod; /* Highlight labels */
	font-weight: 600; /* Bolder label text */
	margin-right: 8px; /* Space between label and value */
}

/* Status Spans */
.status-success {
	color: #4CAF50; /* Distinct green */
	font-weight: bold;
	letter-spacing: 0.5px;
}

.status-pending {
	color: #FFC107; /* Distinct amber/orange */
	font-weight: bold;
	letter-spacing: 0.5px;
}

/* Button Grouping */
.button-group {
    margin-top: 35px; /* Space above buttons */
    display: flex;
    flex-wrap: wrap; /* Allow buttons to wrap on smaller screens */
    justify-content: center;
    gap: 15px; /* Space between buttons */
}

.back-btn {
	padding: 12px 25px; /* More padding for a larger touch area */
	font-size: 1.05em; /* Slightly larger font */
	background-color: goldenrod;
	color: #121212; /* Dark text on button */
	border: none;
	border-radius: 8px; /* Softer button corners */
	cursor: pointer;
	font-weight: 700; /* Bolder text */
	text-decoration: none; /* Remove underline for anchor-like buttons */
	transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
	box-shadow: 0 3px 8px rgba(0, 0, 0, 0.3); /* Button shadow */
    display: inline-block; /* Essential for flexbox and padding */
}

.back-btn:hover {
	background-color: #e6b800; /* Darker goldenrod on hover */
	transform: translateY(-3px); /* Lift effect */
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.4); /* Enhanced shadow on hover */
}

/* Specific styling for the download button if needed, but keeping unified for now */
.button-group form {
    margin: 0; /* Remove default form margins inside flex */
}

/* Responsive adjustments */
@media (max-width: 600px) {
    .confirmation-box {
        padding: 30px;
        border-radius: 10px;
    }
    .confirmation-box h1 {
        font-size: 2.2em;
        gap: 10px;
    }
    .confirmation-box h1::after {
        font-size: 0.7em;
    }
    .confirmation-box p {
        font-size: 1em;
    }
    .button-group {
        flex-direction: column; /* Stack buttons vertically on small screens */
        align-items: center;
    }
    .back-btn {
        width: 100%; /* Full width buttons when stacked */
        max-width: 250px; /* Max width for stacked buttons */
    }
}
</style>
</head>
<body>


	<div class="confirmation-box">
		<h1>Booking Confirmed</h1>
		<p>
			<strong>Booking ID:</strong>
			<%=bookingId%></p>
		<p>
			<strong>Payment Method:</strong>
			<%=paymentMethod != null ? paymentMethod.toUpperCase() : "N/A"%></p> <%-- Added null check for safety --%>
		<p>
			<strong>Payment Status:</strong> <span
				class="<%="Success".equalsIgnoreCase(paymentStatus) ? "status-success" : "status-pending"%>">
				<%=paymentStatus%>
			</span>
		</p>
		<p>
			<strong>Amount Paid:</strong> ₹<%=String.format("%.2f", amount)%></p> <%-- Format amount to 2 decimal places --%>
		<p>Thank you for booking with us!</p>

        <%-- Grouping buttons in a div for better layout --%>
        <div class="button-group">
            <form action="downloadReceipt" method="get">
                <input type="hidden" name="booking_id" value="<%=bookingId%>">
                <button class="back-btn" type="submit">Download Receipt (PDF)</button>
            </form>

            <form action="home.jsp" method="get">
                <button class="back-btn" type="submit">Back to Home</button>
            </form>
        </div>
	</div>

</body>
</html>