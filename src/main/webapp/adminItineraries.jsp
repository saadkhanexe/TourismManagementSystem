<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.tourist.dao.*, com.tourist.dto.*, java.util.*"%>
<%@ include file="adminSessionCheck.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Manage Itineraries</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
body {
    background-color: #121212;
    color: #f0f0f0;
    font-family: 'Roboto', sans-serif;
    line-height: 1.6;
    margin: 0;
    padding: 0;
}

.admin-section {
    max-width: 1200px;
    margin: 20px auto;
    padding: 20px;
    background-color: #1f1f1f;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.4);
}

h1 {
    color: goldenrod;
    text-align: center;
    margin-bottom: 30px;
    font-family: 'Montserrat', sans-serif;
    font-size: 2.8em;
    letter-spacing: 1.5px;
}

h2 {
    color: sienna;
    text-align: center;
    margin: 40px 0 25px 0;
    font-family: 'Montserrat', sans-serif;
    font-size: 2em;
    border-bottom: 2px solid goldenrod;
    padding-bottom: 10px;
    display: inline-block;
    width: auto;
    max-width: 100%;
    box-sizing: border-box;
}
.admin-section h2 {
    display: block;
    width: 100%;
    text-align: center;
}


/* Forms */
form {
    background: #2a2a2a;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
    margin-bottom: 30px;
}

input[type="text"],
input[type="email"],
input[type="password"],
input[type="number"],
input[type="date"],
textarea {
    width: calc(100% - 20px);
    padding: 12px;
    margin: 10px 0;
    border-radius: 5px;
    border: 1px solid #444;
    background: #333;
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
    width: auto;
    display: block;
    margin: 20px auto 0 auto;
}

input[type="submit"]:hover {
    background-color: #cc5500;
    transform: translateY(-2px);
}

/* Tables (kept for reference, but Itinerary Details won't use it now) */
table {
    width: 100%;
    margin-top: 25px;
    border-collapse: separate;
    border-spacing: 0;
    background: #1a1a1a;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
    table-layout: fixed;
}

th, td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #333;
    font-size: 0.95em;
    white-space: normal;
    word-wrap: break-word;
    vertical-align: top;
}

th {
    background-color: #222;
    color: goldenrod;
    font-family: 'Montserrat', sans-serif;
    font-weight: 600;
    text-transform: uppercase;
}
/* Removed specific th width rules as table is no longer used for main display */

tr:nth-child(even) {
    background-color: #1e1e1e;
}

tr:hover {
    background-color: #282828;
}

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
    gap: 25px;
    margin: 40px auto;
    flex-wrap: wrap;
    max-width: 1200px;
}

.admin-card {
    background: #1f1f1f;
    padding: 25px 35px;
    border-radius: 12px;
    cursor: pointer;
    text-align: center;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.4);
    transition: transform 0.2s ease, background 0.3s ease, color 0.3s ease;
    min-width: 160px;
    flex: 1;
    max-width: 200px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.admin-card:hover {
    background: goldenrod;
    color: #121212;
    transform: translateY(-5px) scale(1.03);
}

.admin-card i {
    font-size: 36px;
    margin-bottom: 12px;
    color: sienna;
    transition: color 0.3s ease;
}

.admin-card:hover i {
    color: #121212;
}

.admin-card p {
    font-weight: 700;
    font-size: 1.1em;
    margin: 0;
    font-family: 'Montserrat', sans-serif;
}

/* Horizontal Rule */
hr {
    width: 70%;
    border: none;
    height: 2px;
    background: sienna;
    margin: 60px auto;
    border-radius: 5px;
}

/* Message Box Styling */
.message-box {
    margin: 20px auto;
    padding: 15px 25px;
    border-radius: 8px;
    font-size: 1.1em;
    font-weight: 500;
    max-width: 800px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    text-align: center;
    border: 1px solid;
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

/* NEW: Styles for the Itinerary Card Display */
.itinerary-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); /* Responsive grid */
    gap: 30px; /* Space between itinerary cards */
    margin-top: 25px;
}

.itinerary-card-display {
    background: #2a2a2a; /* Slightly darker background for individual itinerary cards */
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
    border: 1px solid #3a3a3a; /* Subtle border */
}

.itinerary-summary {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap; /* Allow wrapping on small screens */
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 2px solid goldenrod; /* Strong separator */
    font-size: 1.1em;
    font-weight: 600;
    color: goldenrod;
}

.itinerary-summary span {
    margin-right: 15px; /* Spacing between summary items */
    margin-bottom: 5px; /* For wrapping on smaller screens */
}

.itinerary-day-section {
    background: #333; /* Background for each day section */
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 15px; /* Space between day sections */
    border: 1px solid #444; /* Border for day sections */
}

.itinerary-day-title {
    color: sienna;
    font-weight: 700;
    margin-top: 0;
    margin-bottom: 8px;
    font-size: 1.2em;
}

.itinerary-description {
    color: #ccc;
    line-height: 1.7;
    white-space: pre-wrap; /* Preserve line breaks from textarea input */
    word-wrap: break-word; /* Ensure long words break */
}


/* Responsive adjustments */
@media (max-width: 768px) {
    .admin-nav {
        flex-direction: column;
        align-items: center;
    }

    .admin-card {
        width: 80%;
        max-width: 300px;
    }

    h1 {
        font-size: 2em;
    }

    h2 {
        font-size: 1.6em;
    }

    /* Adjust grid for smaller screens */
    .itinerary-grid {
        grid-template-columns: 1fr; /* Single column on very small screens */
    }

    .itinerary-summary {
        flex-direction: column;
        align-items: flex-start;
    }
}
</style>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
</head>
<body>

<%
    String message = (String) session.getAttribute("message");
    String messageType = (String) session.getAttribute("messageType");
    if (message != null) {
        String messageClass = "message-info";
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

	<div class="admin-section" id="itineraries">
		<h1>Manage Itineraries</h1>

		<div class="container">
			<h2>Itinerary Details</h2>
            <%-- NEW: Grid container for itinerary cards --%>
            <div class="itinerary-grid"> 
					<%
					ItineraryInterface itineraryDAO = new ItineraryImplementation();
					List<Itinerary> itineraries = itineraryDAO.getAllItineraries();
					if (itineraries != null && !itineraries.isEmpty()) {
						for (Itinerary i : itineraries) {
						    Double itineraryPrice = (i.getItinerary_price() != null) ? i.getItinerary_price() : 0.00;
					%>
                    <%-- NEW: Individual Itinerary Card --%>
					<div class="itinerary-card-display">
                        <div class="itinerary-summary">
                            <span><strong>ID:</strong> <%=i.getItinerary_id()%></span>
                            <span><strong>Price:</strong> $<%=String.format("%.2f", itineraryPrice)%></span>
                            <span><strong>Destination ID:</strong> <%=i.getDestination_id()%></span>
                        </div>

                        <% if (i.getItinerary_day1() != null && !i.getItinerary_day1().isEmpty()) { %>
                        <div class="itinerary-day-section">
                            <h3 class="itinerary-day-title">Day 1: <%=i.getItinerary_day1()%></h3>
                            <p class="itinerary-description"><%=i.getItinerary_day1_description()%></p>
                        </div>
                        <% } %>

                        <% if (i.getItinerary_day2() != null && !i.getItinerary_day2().isEmpty()) { %>
                        <div class="itinerary-day-section">
                            <h3 class="itinerary-day-title">Day 2: <%=i.getItinerary_day2()%></h3>
                            <p class="itinerary-description"><%=i.getItinerary_day2_description()%></p>
                        </div>
                        <% } %>

                        <% if (i.getItinerary_day3() != null && !i.getItinerary_day3().isEmpty()) { %>
                        <div class="itinerary-day-section">
                            <h3 class="itinerary-day-title">Day 3: <%=i.getItinerary_day3()%></h3>
                            <p class="itinerary-description"><%=i.getItinerary_day3_description()%></p>
                        </div>
                        <% } %>

                        <% if (i.getItinerary_day4() != null && !i.getItinerary_day4().isEmpty()) { %>
                        <div class="itinerary-day-section">
                            <h3 class="itinerary-day-title">Day 4: <%=i.getItinerary_day4()%></h3>
                            <p class="itinerary-description"><%=i.getItinerary_day4_description()%></p>
                        </div>
                        <% } %>

                        <% if (i.getItinerary_day5() != null && !i.getItinerary_day5().isEmpty()) { %>
                        <div class="itinerary-day-section">
                            <h3 class="itinerary-day-title">Day 5: <%=i.getItinerary_day5()%></h3>
                            <p class="itinerary-description"><%=i.getItinerary_day5_description()%></p>
                        </div>
                        <% } %>

					</div> <%-- END .itinerary-card-display --%>
					<%
						} // End for loop
					} else {
					%>
                    <p style="text-align: center; color: #aaa;">No itineraries found.</p>
                    <%
					}
					%>
            </div> <%-- END .itinerary-grid --%>
		</div>

		<div class="container">
			<h2>Add New Itinerary</h2>
			<form action="itineraryServlet" method="post">
				<input type="hidden" name="action" value="add">

				<input type="text" name="itinerary_day1" placeholder="Day 1 Title" required>
				<textarea name="itinerary_day1_description" placeholder="Day 1 Description" required></textarea>

				<input type="text" name="itinerary_day2" placeholder="Day 2 Title">
				<textarea name="itinerary_day2_description" placeholder="Day 2 Description"></textarea>

				<input type="text" name="itinerary_day3" placeholder="Day 3 Title">
				<textarea name="itinerary_day3_description" placeholder="Day 3 Description"></textarea>

				<input type="text" name="itinerary_day4" placeholder="Day 4 Title">
				<textarea name="itinerary_day4_description" placeholder="Day 4 Description"></textarea>

				<input type="text" name="itinerary_day5" placeholder="Day 5 Title">
				<textarea name="itinerary_day5_description" placeholder="Day 5 Description"></textarea>

				<input type="number" step="0.01" name="itinerary_price" placeholder="Itinerary Price" required> 
				<input type="number" name="destination_id" placeholder="Destination ID" required>

				<input type="submit" value="Add Itinerary">
			</form>
		</div>

		<div class="container">
			<h2>Update Itinerary</h2>
			<form action="itineraryServlet" method="post">
				<input type="hidden" name="action" value="update"> 
				<input type="number" name="itinerary_id" placeholder="Itinerary ID to Update" required>

				<input type="text" name="itinerary_day1" placeholder="New Day 1 Title" required>
				<textarea name="itinerary_day1_description" placeholder="New Day 1 Description" required></textarea>

				<input type="text" name="itinerary_day2" placeholder="New Day 2 Title">
				<textarea name="itinerary_day2_description" placeholder="New Day 2 Description"></textarea>

				<input type="text" name="itinerary_day3" placeholder="New Day 3 Title">
				<textarea name="itinerary_day3_description" placeholder="New Day 3 Description"></textarea>

				<input type="text" name="itinerary_day4" placeholder="New Day 4 Title">
				<textarea name="itinerary_day4_description" placeholder="New Day 4 Description"></textarea>

				<input type="text" name="itinerary_day5" placeholder="New Day 5 Title">
				<textarea name="itinerary_day5_description" placeholder="New Day 5 Description"></textarea>

				<input type="number" step="0.01" name="itinerary_price" placeholder="New Itinerary Price" required> 
				<input type="number" name="destination_id" placeholder="New Destination ID" required> 
				<input type="submit" value="Update Itinerary">
			</form>
		</div>

		<div class="container">
			<h2>Delete Itinerary</h2>
			<form action="itineraryServlet" method="post">
				<input type="hidden" name="action" value="delete"> 
				<input type="number" name="itinerary_id" placeholder="Itinerary ID to Delete" required> 
				<input type="submit" value="Delete Itinerary">
			</form>
		</div>
	</div>

	<hr>

	<%@ include file="footer.jsp"%>

</body>
</html>