<%@ page import="java.util.*, com.tourist.dto.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="sessionCheck.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Travel Package Details</title>
<link rel="stylesheet" href="style.css">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;700&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<style>
/* Global Styles */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Roboto', sans-serif; /* Changed to Roboto */
	color: whitesmoke;
}

body {
	background-color: #1a1a1a;
	line-height: 1.6;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

/* Main Content Section */
.content-section {
	padding: 40px;
}

/* Section Block Styling */
.section-block {
	margin-bottom: 40px;
	background: rgba(90, 52, 23, 0.3);
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 3px 6px rgba(0, 0, 0, 0.3);
}

/* Section Headings */
.section-block h2 {
	font-size: 2rem;
	letter-spacing: 3px;
	color: goldenrod;
	margin-bottom: 20px;
	position: relative;
	padding-bottom: 10px;
	font-family: 'Montserrat', sans-serif; /* Added font for headings */
    text-align: center; /* Centered heading */
}

.section-block h2::after {
	content: '';
	position: absolute;
	bottom: 0;
	left: 50%;
	transform: translateX(-50%);
	width: 50px;
	height: 2px;
	background: goldenrod;
}

/* Destination Card */
.destination-card {
	background: rgba(90, 52, 23, 0.5);
	padding: 20px;
	border: 1px solid goldenrod;
	border-radius: 10px;
	margin-bottom: 20px;
}

.destination-card h3 {
	font-size: 1.8rem;
	color: goldenrod;
	margin-bottom: 10px;
	font-family: 'Montserrat', sans-serif; /* Added font for h3 */
}

.destination-card p {
	margin-bottom: 8px;
	font-family: 'Roboto', sans-serif; /* Added font for paragraphs */
}


/* --- ITINERARY SECTION STYLES --- */
.itinerary-container {
    display: flex;
    flex-direction: column;
    gap: 30px; /* Space between different itinerary groups */
}

.itinerary-group {
    background: #282828; /* Darker background for the entire itinerary card */
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
    border: 1px solid goldenrod; /* Accent border */
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.itinerary-group:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.6);
}

.itinerary-group h3 {
    font-family: 'Montserrat', sans-serif;
    color: goldenrod;
    font-size: 1.6rem;
    margin-bottom: 15px;
    text-align: center;
    border-bottom: 1px solid rgba(218, 165, 32, 0.4);
    padding-bottom: 10px;
}

.itinerary-group ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

.itinerary-group ul li {
    display: flex;
    align-items: flex-start; /* Align icon and text at the top */
    padding: 12px 0;
    border-bottom: 1px dashed rgba(255, 255, 255, 0.1); /* Subtle separator */
    font-family: 'Roboto', sans-serif;
    color: #ccc; /* Lighter text color for readability */
}

.itinerary-group ul li:last-child {
    border-bottom: none;
    margin-bottom: 0;
}

.itinerary-group ul li strong {
    color: goldenrod;
    min-width: 80px; /* Give space for 'Day 1', 'Day 2' */
    margin-right: 15px;
    flex-shrink: 0; /* Prevent it from shrinking */
}

.itinerary-group ul li .description {
    flex-grow: 1; /* Allow description to take available space */
}

/* Price specific style within itinerary group */
.itinerary-group .itinerary-price {
    text-align: right;
    font-size: 1.1rem;
    color: #f0f0f0; /* Keeping itinerary price as white/f0f0f0 */
    font-weight: 700;
    margin-top: 20px;
    padding-top: 15px;
    border-top: 1px solid rgba(218, 165, 32, 0.4);
}

.itinerary-group .itinerary-price strong {
    color: goldenrod;
}

/* --- RESTAURANT & RESORT SECTIONS STYLES --- */
.card-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 25px;
}

.item-card {
    background: #282828; /* Darker background */
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
    border: 1px solid rgba(218, 165, 32, 0.5); /* Subtle border */
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    display: flex;
    flex-direction: column;
    justify-content: space-between; /* Push content apart */
}

.item-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.6);
}

.item-card h3 {
    font-family: 'Montserrat', sans-serif;
    color: goldenrod;
    font-size: 1.5rem;
    margin-bottom: 10px;
}

.item-card p {
    font-family: 'Roboto', sans-serif;
    color: #ccc;
    font-size: 0.95rem;
    margin-bottom: 8px;
}

.item-card p strong {
    color: #f0f0f0; /* Make labels stand out */
    margin-right: 5px;
}

/* Base style for prices in item cards (e.g., restaurants, resorts) */
/* Changed to apply light green to all item card prices */
.item-card .rating,
.item-card .price {
    margin-top: 10px;
    padding-top: 10px;
    border-top: 1px dashed rgba(255, 255, 255, 0.1);
    text-align: right;
    font-size: 1rem;
    color: #90EE90; /* Light Green for all restaurant/resort prices */
    font-weight: 500;
}


/* Book Package Button (existing styles, adding font for consistency) */
.book-now-button {
	display: inline-block;
	padding: 12px 25px;
	background-color: goldenrod;
	color: black;
	font-weight: bold;
	text-decoration: none;
	border: none;
	border-radius: 5px;
	transition: background-color 0.3s ease;
	cursor: pointer;
	font-family: 'Montserrat', sans-serif; /* Added font for button text */
}

.book-now-button:hover {
	background-color: #e6c200;
}

/* Responsive Adjustments */
@media ( max-width : 768px) {
	header h1 {
		font-size: 2rem;
	}
	.section-block h2 {
		font-size: 1.6rem;
	}
    .itinerary-group ul li {
        flex-direction: column; /* Stack day and description on smaller screens */
        align-items: flex-start;
    }
    .itinerary-group ul li strong {
        margin-bottom: 5px;
    }
}

@media (max-width: 480px) {
    .content-section {
        padding: 20px;
    }
    .section-block {
        padding: 15px;
    }
    .section-block h2 {
        font-size: 1.8rem;
    }
    .itinerary-group, .item-card {
        padding: 15px;
    }
    .itinerary-group h3, .item-card h3 {
        font-size: 1.4rem;
    }
}
</style>
<body>

<%@ include file="navigation.jsp" %>

    <%--
        All Java variable declarations are in this single scriptlet block
        so they are correctly scoped and accessible throughout the JSP.
    --%>
    <%
    // Declare and initialize ALL lists and objects at the top,
    // so they are available throughout the JSP.
    Destination destination = (Destination) request.getAttribute("destination");

    List<Itinerary> itineraries = (List<Itinerary>) request.getAttribute("itineraries");
    if (itineraries == null) {
        itineraries = new ArrayList<>();
    }

    List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
    if (restaurants == null) {
        restaurants = new ArrayList<>();
    }

    List<Resort> resorts = (List<Resort>) request.getAttribute("resorts");
    if (resorts == null) {
        resorts = new ArrayList<>();
    }

    // Removed otherItineraries, otherRestaurants, otherResorts since "Explore More Options" is removed
    %>

	<main class="content-section">

        <section class="section-block">
			<h2>Destination Details</h2>
			<%
			if (destination != null) {
			%>
			<div class="destination-card">
				<h3><%=destination.getDestination_name()%></h3>
				<p>
					<strong>State:</strong>
					<%=destination.getDestination_paragraph()%></p>
				<p>
					<strong>Description:</strong>
					<%=destination.getDestination_description()%></p>
				<p>
					<strong>Base Price:</strong> ₹<%=destination.getDestination_price()%>
					per day
				</p>
			</div>
			<%
			} else {
			%>
			<p>No destination found.</p>
			<%
			}
			%>
		</section>

        <%-- REMOVED THE ENTIRE "EXPLORE MORE OPTIONS" SECTION --%>

		<section class="section-block">
			<h2>Itinerary Included in This Package</h2>
			<div class="itinerary-container"> <%-- Container for all itinerary cards --%>
			<%
            if (!itineraries.isEmpty()) {
				for (Itinerary it : itineraries) {
			%>
			<div class="itinerary-group">
                <h3><%= destination != null ? destination.getDestination_name() : "Package" %> Itinerary</h3> <%-- Dynamic title for the itinerary card --%>
				<ul>
					<%
					if (it.getItinerary_day1() != null && !it.getItinerary_day1().isEmpty()) {
					%>
					<li><strong><%=it.getItinerary_day1()%>:</strong> <span class="description"><%=it.getItinerary_day1_description()%></span></li>
					<%
					}
					%>
					<%
					if (it.getItinerary_day2() != null && !it.getItinerary_day2().isEmpty()) {
					%>
					<li><strong><%=it.getItinerary_day2()%>:</strong> <span class="description"><%=it.getItinerary_day2_description()%></span></li>
					<%
					}
					%>
					<%
					if (it.getItinerary_day3() != null && !it.getItinerary_day3().isEmpty()) {
					%>
					<li><strong><%=it.getItinerary_day3()%>:</strong> <span class="description"><%=it.getItinerary_day3_description()%></span></li>
					<%
					}
					%>
					<%
					if (it.getItinerary_day4() != null && !it.getItinerary_day4().isEmpty()) {
					%>
					<li><strong><%=it.getItinerary_day4()%>:</strong> <span class="description"><%=it.getItinerary_day4_description()%></span></li>
					<%
					}
					%>
					<%
					if (it.getItinerary_day5() != null && !it.getItinerary_day5().isEmpty()) {
					%>
					<li><strong><%=it.getItinerary_day5()%>:</strong> <span class="description"><%=it.getItinerary_day5_description()%></span></li>
					<%
					}
					%>
				</ul>
                <div class="itinerary-price">
                    <strong>Total Itinerary Price:</strong> ₹<%=it.getItinerary_price()%>
                </div>
			</div> <%-- Close the itinerary-group div --%>
			<%
				}
			} else {
			%>
			<p>No itinerary available for this package.</p>
			<%
			}
			%>
            </div> <%-- Close itinerary-container --%>
		</section>

		<section class="section-block">
			<h2>Restaurants Included in This Package</h2>
			<div class="card-grid"> <%-- Use card-grid for restaurants --%>
			<%
			if (!restaurants.isEmpty()) {
				for (Restaurant r : restaurants) {
				%>
				<div class="item-card"> <%-- Each restaurant is an item-card --%>
					<h3><%=r.getName()%></h3>
					<p><strong>Cuisine:</strong> <%=r.getCuisine_type()%></p>
					<p><strong>Description:</strong> <%=r.getDescription()%></p>
					<p class="rating">Rating: <%=r.getRating()%></p>
                    <%-- Display price if available and not zero --%>
                    <% if (r.getRestaurant_price() != 0) { %>
                    <p class="price">Price: ₹<%=r.getRestaurant_price()%></p>
                    <% } else { %>
                    <p class="price">Price: N/A</p>
                    <% } %>
				</div>
				<%
				}
			} else {
			%>
			<p>No restaurants listed for this package.</p>
			<%
			}
			%>
            </div> <%-- Close card-grid --%>
		</section>

		<section class="section-block">
			<h2>Resorts Included in This Package</h2>
			<div class="card-grid"> <%-- Use card-grid for resorts --%>
			<%
			if (!resorts.isEmpty()) {
				for (Resort resort : resorts) {
				%>
				<div class="item-card"> <%-- Each resort is an item-card --%>
					<h3><%=resort.getName()%></h3>
					<p><strong>Type:</strong> <%=resort.getType()%></p>
                    <p><strong>Description:</strong> <%=resort.getDescription()%></p>
					<p class="rating">Rating: <%=resort.getRating()%></p>
                    <%-- Display price if available and not zero --%>
                    <% if (resort.getResort_price() != 0) { %>
                    <p class="price">Price: ₹<%=resort.getResort_price()%></p>
                    <% } else { %>
                    <p class="price">Price: N/A</p>
                    <% } %>
				</div>
				<%
				}
			} else {
			%>
			<p>No resorts listed for this package.</p>
			<%
			}
			%>
            </div> <%-- Close card-grid --%>
		</section>

		<section class="section-block">
			<form action="bookingServlet" method="post">
				<input type="hidden" name="action" value="add">

				<%-- Defensive checks for potential NullPointerExceptions --%>
				<% if (destination != null) { %>
				<input type="hidden" name="destination_id" value="<%= destination.getDestination_id() %>">
				<% } %>

				<%
                // Safely get the ID, default to 0 if list is null or empty
                int defaultResortId = 0;
                if (!resorts.isEmpty()) {
                    defaultResortId = resorts.get(0).getResort_id();
                }
                %>
				<input type="hidden" name="resort_id" value="<%= defaultResortId %>">

				<%
                int defaultRestaurantId = 0;
                if (!restaurants.isEmpty()) {
                    defaultRestaurantId = restaurants.get(0).getRestaurant_id();
                }
                %>
				<input type="hidden" name="restaurant_id" value="<%= defaultRestaurantId %>">

				<%
                // For Itinerary ID, assuming it.getItinerary_id() returns a primitive int.
                int defaultItineraryId = 0;
                if (!itineraries.isEmpty()) {
                    defaultItineraryId = itineraries.get(0).getItinerary_id();
                }
                %>
				<input type="hidden" name="itinerary_id" value="<%= defaultItineraryId %>">

				<input type="hidden" name="booking_date" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
				<input type="hidden" name="status" value="Pending">

				<button type="submit" class="book-now-button">Book This Package</button>
			</form>
		</section>

	</main>
	<%@ include file="footer.jsp" %>

</body>
</html>