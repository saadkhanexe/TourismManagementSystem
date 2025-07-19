<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.tourist.dao.*, com.tourist.dto.*, java.util.*"%>
<%@ include file="adminSessionCheck.jsp" %>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Dashboard - Tourists</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
/* General Body and Container Styles - KEPT THE SAME AS PREVIOUS RESPONSE */
body {
    background-color: #121212;
    color: #f0f0f0;
    font-family: 'Roboto', sans-serif; /* Modern, clean font */
    line-height: 1.6;
    margin: 0;
    padding: 0;
}

.admin-section {
    max-width: 1200px; /* Increased max-width for more space */
    margin: 20px auto;
    padding: 20px;
    background-color: #1f1f1f; /* Slightly lighter background for sections */
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.4);
}

/* Headings */
h1 {
    color: goldenrod;
    text-align: center;
    margin-bottom: 30px;
    font-family: 'Montserrat', sans-serif; /* Distinct font for main titles */
    font-size: 2.8em; /* Larger main title */
    letter-spacing: 1.5px;
}

h2 {
    color: sienna;
    text-align: center;
    margin: 40px 0 25px 0;
    font-family: 'Montserrat', sans-serif;
    font-size: 2em; /* Larger section titles */
    border-bottom: 2px solid goldenrod;
    padding-bottom: 10px;
    display: inline-block; /* To make border-bottom fit content */
    width: auto;
    max-width: 100%;
    box-sizing: border-box;
}
.admin-section h2 {
    display: block; /* Override inline-block for section headings */
    width: 100%;
    text-align: center;
}


/* Forms */
form {
    background: #2a2a2a; /* Darker background for forms */
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
    margin-bottom: 30px; /* Space between forms */
}

input[type="text"],
input[type="email"],
input[type="password"],
input[type="number"],
input[type="date"],
textarea {
    width: calc(100% - 20px); /* Account for padding */
    padding: 12px;
    margin: 10px 0;
    border-radius: 5px;
    border: 1px solid #444; /* Subtle border */
    background: #333; /* Darker input fields */
    color: white;
    font-size: 1em;
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
}

input[type="text"]:focus,
input[type="email"]:focus,
input[type="password"]:focus,
input[type="number"]:focus,
input[type="date"]:focus,
textarea:focus {
    border-color: goldenrod;
    box-shadow: 0 0 8px rgba(218, 165, 32, 0.5);
    outline: none;
}

input[type="submit"] {
    background-color: sienna;
    color: white;
    padding: 12px 25px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
    font-size: 1.1em;
    transition: background-color 0.3s ease, transform 0.2s ease;
    width: auto; /* Allow button to size to content */
    display: block; /* Make it a block element */
    margin: 20px auto 0 auto; /* Center the button */
}

input[type="submit"]:hover {
    background-color: #cc5500; /* Darker sienna on hover */
    transform: translateY(-2px);
}

/* Tables */
table {
    width: 100%;
    margin-top: 25px;
    border-collapse: separate; /* Use separate for rounded corners */
    border-spacing: 0;
    background: #1a1a1a;
    border-radius: 8px; /* Rounded corners for the table */
    overflow: hidden; /* Ensures corners are rounded */
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
}

th, td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #333;
    font-size: 0.95em;
}

th {
    background-color: #222;
    color: goldenrod;
    font-family: 'Montserrat', sans-serif;
    font-weight: 600;
    text-transform: uppercase;
}

tr:nth-child(even) {
    background-color: #1e1e1e; /* Slight striping for readability */
}

tr:hover {
    background-color: #282828; /* Highlight row on hover */
}

/* Image in table */
table img {
    max-width: 80px;
    height: auto;
    border-radius: 5px;
    border: 1px solid #444;
}

/* Admin Navigation Cards */
.admin-nav {
    display: flex;
    justify-content: center;
    gap: 25px; /* Increased gap */
    margin: 40px auto;
    flex-wrap: wrap;
    max-width: 1200px;
}

.admin-card {
    background: #1f1f1f;
    padding: 25px 35px; /* Increased padding */
    border-radius: 12px; /* Slightly more rounded */
    cursor: pointer;
    text-align: center;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.4); /* Stronger shadow */
    transition: transform 0.2s ease, background 0.3s ease, color 0.3s ease;
    min-width: 160px; /* Ensure a minimum width */
    flex: 1; /* Allow cards to grow */
    max-width: 200px; /* Max width for consistency */
    display: flex; /* For vertical alignment */
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.admin-card:hover {
    background: goldenrod;
    color: #121212; /* Darker text on hover */
    transform: translateY(-5px) scale(1.03); /* Lift and slightly scale */
}

.admin-card i {
    font-size: 36px; /* Larger icon */
    margin-bottom: 12px;
    color: sienna; /* Icon color */
    transition: color 0.3s ease;
}

.admin-card:hover i {
    color: #121212; /* Icon color on hover */
}

.admin-card p {
    font-weight: 700; /* Bolder text */
    font-size: 1.1em; /* Slightly larger text */
    margin: 0;
    font-family: 'Montserrat', sans-serif;
}

/* Horizontal Rule */
hr {
    width: 70%; /* Slightly narrower */
    border: none;
    height: 2px; /* Thicker */
    background: sienna;
    margin: 60px auto; /* More vertical space */
    border-radius: 5px;
}

/* Message Box Styling */
.message-box {
    margin: 20px auto; /* Centered with more margin */
    padding: 15px 25px; /* More padding */
    border-radius: 8px; /* Slightly more rounded */
    font-size: 1.1em; /* Larger font */
    font-weight: 500;
    max-width: 800px; /* Constrain width */
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    text-align: center;
    border: 1px solid; /* General border for all types */
}

.message-success {
    background-color: #d4edda;
    color: #155724;
    border-color: #c3e6cb;
}

.message-error {
    background-color: #f8d7da;
    color: #721c24;
    border-color: #f5c6cb;
}

.message-warning {
    background-color: #fff3cd;
    color: #856404;
    border-color: #ffeeba;
}

.message-info {
    background-color: #d1ecf1;
    color: #0c5460;
    border-color: #bee5eb;
}
/* Ensure the overall layout feels clean */
.container {
    padding: 20px;
    background-color: #1f1f1f;
    border-radius: 10px;
    margin-bottom: 30px;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .admin-nav {
        flex-direction: column;
        align-items: center;
    }

    .admin-card {
        width: 80%;
        max-width: 300px; /* Limit card width on smaller screens */
    }

    h1 {
        font-size: 2em;
    }

    h2 {
        font-size: 1.6em;
    }
}
</style>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
</head>
<body>

<%
    String message = (String) session.getAttribute("message");
    String messageType = (String) session.getAttribute("messageType"); // Optional: success/error/warning/info
    if (message != null) {
        String messageClass = "message-info"; // Default
        if ("success".equals(messageType)) {
            messageClass = "message-success";
        } else if ("error".equals(messageType)) {
            messageClass = "message-error";
        } else if ("warning".equals(messageType)) {
            messageClass = "message-warning";
        }
%>
    <div class="message-box <%= messageClass %>">
        <%= message %>
    </div>
<%
        session.removeAttribute("message");
        session.removeAttribute("messageType");
    }
%>


	<%@ include file="navigation.jsp"%>
	<div class="admin-nav">
		<a href="adminDashboard.jsp" class="admin-card">
			<i class="fas fa-user"></i>
			<p>Tourist</p>
		</a>
	
		<a href="adminDestinations.jsp" class="admin-card">
			<i class="fas fa-map-marker-alt"></i>
			<p>Destinations</p>
		</a>
		<a href="adminItineraries.jsp" class="admin-card">
			<i class="fas fa-route"></i>
			<p>Itineraries</p>
		</a>
		<a href="adminResorts.jsp" class="admin-card">
			<i class="fas fa-hotel"></i>
			<p>Resorts</p>
		</a>
		<a href="adminRestaurants.jsp" class="admin-card">
			<i class="fas fa-utensils"></i>
			<p>Restaurants</p>
		</a>
		<a href="adminBookings.jsp" class="admin-card">
			<i class="fas fa-receipt"></i>
			<p>Bookings</p>
		</a>

	</div>

	<div class="admin-section" id="tourists">
		<h1>Welcome to Admin Dashboard</h1>
		<h2>Manage Tourists</h2>

		<div class="container">
			<h2>Tourist Details</h2>
			<table>
				<thead>
					<tr>
						<th>Tourist ID</th>
						<th>Name</th>
						<th>Email</th>
						<th>Phone</th>
						<th>Password</th>
						<th>Confirm Password</th>
					</tr>
				</thead>
				<tbody>
				<%
				TouristInterface ti = new TouristImplementation();
				List<Tourist> tourists = ti.getAllTourists();
				for (Tourist tourist : tourists) {
				%>
					<tr>
						<td><%=tourist.getId()%></td>
						<td><%=tourist.getName()%></td>
						<td><%=tourist.getEmail()%></td>
						<td><%=tourist.getPhone()%></td>
						<td><%=tourist.getPassword()%></td>
						<td><%=tourist.getConfirmPassword()%></td>
					</tr>
				<%
				}
				%>
				</tbody>
			</table>
		</div>
		
		<div class="container">
			<h2>Add New Tourist</h2>
			<form action="touristServlet" method="post">
				<input type="hidden" name="action" value="add"> 
				<input type="text" name="name" placeholder="Tourist Name" required>
				<input type="email" name="email" placeholder="Tourist Email" required> 
				<input type="text" name="phone" placeholder="Tourist Phone" required> 
				<input type="password" name="password" placeholder="Tourist Password" required> 
				<input type="password" name="confirmPassword" placeholder="Confirm Password" required> 
				<input type="submit" value="Add Tourist">
			</form>
		</div>
			<div class="container">
            <h2>Update Tourist</h2>
            <form action="touristServlet" method="post">
                <input type="hidden" name="action" value="update"> 
                <input type="number" name="id" placeholder="Tourist ID" required>
                <input type="text" name="name" placeholder="New Tourist Name" required> 
                <input type="email" name="email" placeholder="New Tourist Email" required> 
                <input type="text" name="phone" placeholder="New Tourist Phone" required> 
                <input type="password" name="password" placeholder="New Tourist Password" required> 
                <input type="password" name="confirmPassword" placeholder="Confirm New Password" required> 
                <input type="submit" value="Update Tourist">
            </form>
	</div>
	    <div class="container">
            <h2>Delete Tourist</h2>
            <form action="touristServlet" method="post">
                <input type="hidden" name="action" value="delete"> 
                <input type="number" name="id" placeholder="Tourist ID" required> 
                <input type="submit" value="Delete Tourist">
            </form>
        </div>
    </div>
		
	<hr>

	<%@ include file="footer.jsp"%>

</body>
</html>