<%@page import="com.tourist.dao.*" %>
<%@ page import="com.tourist.dto.*"%>
<%@ page import="java.util.Date"%> <%-- Import java.util.Date if Booking DTO uses it --%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="sessionCheck.jsp" %>

<%
String bookingIdStr = request.getParameter("booking_id");
Booking booking = null;
Destination destination = null;
Resort resort = null;       // Singular resort
Restaurant restaurant = null; // Singular restaurant
Itinerary itinerary = null;
Tourist tourist = null;

// Initialize price variables to 0.0
double finalCalculatedTotalPrice = 0.0;
double destinationPrice = 0.0; // To hold destination's price for display in booking details

if (bookingIdStr != null) {
	try {
		int bookingId = Integer.parseInt(bookingIdStr);

		BookingInterface bookingDAO = new BookingImplementation();
		booking = bookingDAO.getBooking(bookingId); // Your DAO returns a Booking object with single resort_id/restaurant_id

		if (booking != null) {
			DestinationInterface destinationDAO = new DestinationImplementation();
			ResortInterface resortDAO = new ResortImplementation();
			RestaurantInterface restaurantDAO = new RestaurantImplementation();
			ItineraryInterface itineraryDAO = new ItineraryImplementation();
            TouristInterface touristDAO = new TouristImplementation();

			// Fetch all related DTOs using the single IDs from the Booking object
			destination = destinationDAO.getDestination(booking.getDestination_id());
			resort = resortDAO.getResort(booking.getResort_id());           // Fetching single resort
			restaurant = restaurantDAO.getRestaurant(booking.getRestaurant_id()); // Fetching single restaurant
			itinerary = itineraryDAO.getItineraryById(booking.getItinerary_id());
            tourist = touristDAO.getTourist(booking.getTourist_id());

            // --- DEBUG START ---
            System.out.println("\n--- Booking Confirmation Debug ---");
            System.out.println("Fetching details for Booking ID: " + bookingId);
            System.out.println("Booking object retrieved: " + (booking != null ? "Not null" : "NULL"));
            if (booking != null) {
                System.out.println("Booking Tourist ID: " + booking.getTourist_id());
                System.out.println("Booking Destination ID: " + booking.getDestination_id());
                System.out.println("Booking Resort ID: " + booking.getResort_id());
                System.out.println("Booking Restaurant ID: " + booking.getRestaurant_id());
                System.out.println("Booking Itinerary ID: " + booking.getItinerary_id());
                System.out.println("Booking Price (from booking object): " + booking.getPrice());
            }

            System.out.println("\n--- Fetched DTOs Debug ---");
            if (tourist != null) {
                System.out.println("Tourist fetched (ID: " + tourist.getId() + "): " + tourist.getName() + ", Email: " + tourist.getEmail());
            } else {
                System.out.println("Tourist object is NULL or not found for ID: " + booking.getTourist_id());
            }
            if (destination != null) {
                System.out.println("Destination fetched (ID: " + destination.getDestination_id() + "): " + destination.getDestination_name() + ", Price: " + destination.getDestination_price());
                destinationPrice = destination.getDestination_price(); // Store for display
            } else {
                System.out.println("Destination object is NULL or not found for ID: " + booking.getDestination_id());
            }
            if (resort != null) {
                System.out.println("Resort fetched (ID: " + resort.getResort_id() + "): " + resort.getName() + ", Price: " + resort.getResort_price());
            } else {
                System.out.println("Resort object is NULL or not found for ID: " + booking.getResort_id());
            }
            if (restaurant != null) {
                System.out.println("Restaurant fetched (ID: " + restaurant.getRestaurant_id() + "): " + restaurant.getName() + ", Price: " + restaurant.getRestaurant_price());
            } else {
                System.out.println("Restaurant object is NULL or not found for ID: " + booking.getRestaurant_id());
            }
            if (itinerary != null) {
                System.out.println("Itinerary fetched (ID: " + itinerary.getItinerary_id() + "), Price: " + itinerary.getItinerary_price());
            } else {
                System.out.println("Itinerary object is NULL or not found for ID: " + booking.getItinerary_id());
            }
            // --- DEBUG END ---

            // --- Price Calculation (using single items) ---
            if (destination != null) {
                finalCalculatedTotalPrice += destination.getDestination_price();
            }
            if (itinerary != null) {
                finalCalculatedTotalPrice += itinerary.getItinerary_price();
            }
            if (resort != null) { // Add price of the single resort
                finalCalculatedTotalPrice += resort.getResort_price();
            }
            if (restaurant != null) { // Add price of the single restaurant
                finalCalculatedTotalPrice += restaurant.getRestaurant_price();
            }
            // --- End Price Calculation ---

            // --- DEBUG START ---
            System.out.println("\n--- Calculated Total Debug ---");
            System.out.println("Destination Price added: " + (destination != null ? destination.getDestination_price() : 0.0));
            System.out.println("Itinerary Price added: " + (itinerary != null ? itinerary.getItinerary_price() : 0.0));
            System.out.println("Resort Price added: " + (resort != null ? resort.getResort_price() : 0.0));
            System.out.println("Restaurant Price added: " + (restaurant != null ? restaurant.getRestaurant_price() : 0.0));
            System.out.println("Final Calculated Total Price: " + finalCalculatedTotalPrice);
            System.out.println("----------------------------------\n");
            // --- DEBUG END ---

		}
	} catch (Exception e) {
		e.printStackTrace();
		// Reset prices if an error occurs during data fetching/calculation
		finalCalculatedTotalPrice = 0.0;
        destinationPrice = 0.0;
	}
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Booking Confirmation</title>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;700&family=Roboto:wght@400;500&display=swap" rel="stylesheet">
<style>
/* Global Resets and Body Styling */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	background-color: #1a1a1a; /* Dark background */
	color: #e0e0e0; /* Softer white text */
	font-family: 'Roboto', sans-serif; /* Modern, readable font */
	line-height: 1.6;

	/* Flexbox for full page layout with header and footer */
	display: flex;
	flex-direction: column;
	min-height: 100vh; /* Ensure body takes at least full viewport height */
}

/* Main content container */
.confirmation-container {
	background-color: #1f1f1f; /* Slightly lighter dark background */
	padding: 40px;
	border-radius: 15px;
	max-width: 900px; /* Increased max-width for more content */
	margin: 40px auto; /* Centered with vertical margin */
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5),
	            0 0 0 5px rgba(218, 165, 32, 0.1); /* Subtle goldenrod glow */
	animation: fadeIn 0.8s ease-out; /* Fade-in effect */
	flex-grow: 1; /* Allows container to grow and fill available space */
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Main Heading */
h1 {
	color: goldenrod;
	text-align: center;
	font-family: 'Montserrat', sans-serif;
	font-size: 2.8em;
	margin-bottom: 40px;
	letter-spacing: 2px;
	text-shadow: 0 0 15px rgba(218, 165, 32, 0.5); /* Stronger glow */
}

/* Detail Blocks (e.g., Booking Details, Destination, Resort) */
.detail-block {
	background-color: #2a2a2a; /* Darker card background */
	padding: 30px;
	border-radius: 12px;
	margin-bottom: 30px; /* Space between blocks */
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.4);
	border: 1px solid #3a3a3a; /* Subtle border */
}

.detail-block h2 {
	color: sienna;
	font-family: 'Montserrat', sans-serif;
	font-size: 1.8em;
	border-bottom: 2px solid goldenrod; /* More prominent separator */
	padding-bottom: 10px;
	margin-bottom: 20px;
	text-align: center;
}

.detail-block p {
	font-size: 1.05em;
	margin: 8px 0;
}

.detail-block p strong {
	color: goldenrod; /* Highlight labels */
	font-weight: 600;
	margin-right: 10px; /* Space between label and value */
}

/* Item Card (for singular Resort/Restaurant) - keeping for consistency but not iterating */
.item-card {
    background-color: #333; /* Darker background for individual item cards */
    padding: 20px;
    border-radius: 8px;
    border: 1px solid #444;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
    margin-bottom: 15px;
}
.item-card:last-child {
    margin-bottom: 0;
}
.item-card h3 {
    color: goldenrod;
    font-size: 1.3em;
    margin-bottom: 10px;
}
.item-card p {
    font-size: 0.95em;
    color: #c0c0c0;
}
.item-card p strong {
    color: goldenrod;
}


/* Specific styling for Itinerary days */
.itinerary-days-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); /* Responsive grid for days */
    gap: 20px; /* Space between day cards */
    margin-top: 20px;
}

.itinerary-day-card {
    background-color: #333; /* Darker background for individual day cards */
    padding: 20px;
    border-radius: 8px;
    border: 1px solid #444;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
}

.itinerary-day-card strong {
    color: goldenrod;
    display: block; /* Make day title a block for better spacing */
    margin-bottom: 5px;
    font-size: 1.1em;
}
.itinerary-day-card p {
    font-size: 0.95em;
    color: #c0c0c0;
    line-height: 1.5;
}

/* Payment Block */
.payment-block {
	background-color: #2a2a2a; /* Similar to detail blocks */
	padding: 30px;
	border-radius: 12px;
	margin-top: 40px; /* More space above payment block */
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.4);
	border: 1px solid #3a3a3a;
}

.payment-block h2 {
	color: lightgreen; /* Distinct color for payment heading */
	font-family: 'Montserrat', sans-serif;
	font-size: 1.8em;
	border-bottom: 2px solid goldenrod;
	padding-bottom: 10px;
	margin-bottom: 20px;
	text-align: center;
}

.payment-options {
    display: flex;
    flex-wrap: wrap; /* Allow options to wrap */
    justify-content: center; /* Center the radio buttons */
    gap: 25px; /* Space between radio buttons */
    margin-bottom: 30px;
}

.payment-options label {
	background-color: #3f3f3f; /* Background for each payment option */
	padding: 15px 25px;
	border-radius: 8px;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.2s ease;
	display: flex;
	align-items: center;
	font-size: 1.1em;
	border: 1px solid #555;
}

.payment-options label:hover {
	background-color: #4a4a4a;
	transform: translateY(-3px);
}

.payment-options input[type="radio"] {
	margin-right: 10px;
	accent-color: goldenrod; /* Color of the radio button itself */
	transform: scale(1.3); /* Make radio button slightly larger */
}


/* Confirm Button */
.confirm-btn {
	background-color: goldenrod;
	color: #1a1a1a; /* Dark text on button */
	padding: 15px 30px; /* Larger padding */
	font-weight: 700; /* Bolder text */
	font-size: 1.2em; /* Larger font size */
	border: none;
	border-radius: 8px; /* Softer corners */
	cursor: pointer;
	margin-top: 25px;
	transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.4);
    display: block; /* Make it a block element to center easily */
    margin-left: auto;
    margin-right: auto;
}

.confirm-btn:hover {
	background-color: #e6b800; /* Darker goldenrod on hover */
	transform: translateY(-3px); /* Lift effect */
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5); /* Enhanced shadow on hover */
}

/* No data message */
.no-data-message {
    color: #cc6600; /* Orange-red for warning */
    text-align: center;
    font-style: italic;
    margin-top: 15px;
    font-size: 1.1em;
}

/* Total Price Display before payment button */
.final-total-price {
    background-color: #3f3f3f;
    padding: 20px 30px;
    border-radius: 10px;
    margin: 30px auto; /* Centered */
    max-width: 500px;
    text-align: center;
    font-size: 1.5em;
    color: lightgreen;
    font-family: 'Montserrat', sans-serif;
    box-shadow: 0 2px 10px rgba(0,0,0,0.3);
    border: 1px solid #555;
    font-weight: bold;
}
.final-total-price strong {
    color: goldenrod;
    margin-right: 10px;
}


/* Responsive Adjustments */
@media (max-width: 768px) {
    .confirmation-container {
        padding: 25px;
        margin: 20px auto;
    }
    h1 {
        font-size: 2.2em;
        margin-bottom: 30px;
    }
    .detail-block {
        padding: 20px;
        margin-bottom: 20px;
    }
    .detail-block h2 {
        font-size: 1.5em;
        margin-bottom: 15px;
    }
    .itinerary-days-grid {
        grid-template-columns: 1fr; /* Single column on smaller screens */
    }
    .payment-options {
        flex-direction: column; /* Stack payment options vertically */
        align-items: flex-start; /* Align labels to the left */
        gap: 15px;
    }
    .payment-options label {
        width: 100%; /* Full width for stacked labels */
    }
    .final-total-price {
        font-size: 1.2em;
        padding: 15px 20px;
    }
}
</style>
</head>
<body>

	<%@ include file="navigation.jsp"%>

	<div class="confirmation-container">
		<h1>Booking Confirmation</h1>

		<%
		if (booking != null) {
		%>
        <div class="detail-block">
            <h2>User Details</h2>
            <% if (tourist != null) { %>
            <p>
                <strong>Name:</strong>
                <%=tourist.getName()%></p>
            <p>
                <strong>Email:</strong>
                <%=tourist.getEmail()%></p>
            <p>
                <strong>Phone:</strong>
                <%=tourist.getPhone()%></p>
            <p>
                <strong>Booking Date:</strong>
                <%=booking.getBooking_date()%></p>
            <% } else { %>
            <p class="no-data-message">User details not available.</p>
            <% } %>
        </div>

		<div class="detail-block">
			<h2>Booking Details</h2>
			<p>
				<strong>Booking ID:</strong>
				<%=booking.getBookingId()%></p>
			<p>
				<strong>Tourist ID:</strong>
				<%=booking.getTourist_id()%></p>
			<p>
				<strong>Status:</strong>
				<%=booking.getStatus()%></p>
			<p>
				<strong>Base Package Price:</strong> ₹<%=String.format("%.2f", destinationPrice)%></p>
		</div>

		<div class="detail-block">
			<h2>Destination</h2>
			<% if (destination != null) { %>
			<p>
				<strong>Name:</strong>
				<%=destination.getDestination_name()%></p>
			<p>
				<strong>Description:</strong>
				<%=destination.getDestination_description()%></p>
            <p>
                <strong>Price:</strong> ₹<%=String.format("%.2f", destination.getDestination_price())%></p>
			<% } else { %>
			<p class="no-data-message">No destination details available.</p>
			<% } %>
		</div>

		<div class="detail-block">
			<h2>Resort</h2>
			<% if (resort != null) { %>
			<%-- The item-card class is used here for a single item for consistent styling --%>
			<div class="item-card">
				<h3><%=resort.getName()%></h3>
				<p>
					<strong>Type:</strong>
					<%=resort.getType()%>
				</p>
				<p>
					<strong>Rating:</strong>
					<%=String.format("%.1f", resort.getRating())%>
				</p>
	            <p>
					<strong>Price:</strong> ₹<%=String.format("%.2f", resort.getResort_price())%>
				</p>
			</div>
			<% } else { %>
			<p class="no-data-message">No resort details available for this package.</p>
			<% } %>
		</div>

		<div class="detail-block">
			<h2>Restaurant</h2>
			<% if (restaurant != null) { %>
			<%-- The item-card class is used here for a single item for consistent styling --%>
			<div class="item-card">
				<h3><%=restaurant.getName()%></h3>
				<p>
					<strong>Cuisine:</strong>
					<%=restaurant.getCuisine_type()%>
				</p>
				<p>
					<strong>Rating:</strong>
					<%=String.format("%.1f", restaurant.getRating())%>
				</p>
	            <p>
					<strong>Price:</strong> ₹<%=String.format("%.2f", restaurant.getRestaurant_price())%>
				</p>
			</div>
			<% } else { %>
			<p class="no-data-message">No restaurant details available for this package.</p>
			<% } %>
		</div>

		<div class="detail-block">
			<h2>Itinerary</h2>
			<% if (itinerary != null) { %>
			<p>
				<strong>Price:</strong> ₹<%=String.format("%.2f", itinerary.getItinerary_price())%></p>

            <div class="itinerary-days-grid">
			<%
			if (itinerary.getItinerary_day1() != null && !itinerary.getItinerary_day1().isEmpty()) {
			%>
			<div class="itinerary-day-card">
				<strong>Day 1: <%=itinerary.getItinerary_day1()%></strong>
				<p><%=itinerary.getItinerary_day1_description()%></p>
			</div>
			<%
			}
			%>
			<%
			if (itinerary.getItinerary_day2() != null && !itinerary.getItinerary_day2().isEmpty()) {
			%>
			<div class="itinerary-day-card">
				<strong>Day 2: <%=itinerary.getItinerary_day2()%></strong>
				<p><%=itinerary.getItinerary_day2_description()%></p>
			</div>
			<%
			}
			%>
			<%
			if (itinerary.getItinerary_day3() != null && !itinerary.getItinerary_day3().isEmpty()) {
			%>
			<div class="itinerary-day-card">
				<strong>Day 3: <%=itinerary.getItinerary_day3()%></strong>
				<p><%=itinerary.getItinerary_day3_description()%></p>
			</div>
			<%
			}
			%>
			<%
			if (itinerary.getItinerary_day4() != null && !itinerary.getItinerary_day4().isEmpty()) {
			%>
			<div class="itinerary-day-card">
				<strong>Day 4: <%=itinerary.getItinerary_day4()%></strong>
				<p><%=itinerary.getItinerary_day4_description()%></p>
			</div>
			<%
			}
			%>
			<%
			if (itinerary.getItinerary_day5() != null && !itinerary.getItinerary_day5().isEmpty()) {
			%>
			<div class="itinerary-day-card">
				<strong>Day 5: <%=itinerary.getItinerary_day5()%></strong>
				<p><%=itinerary.getItinerary_day5_description()%></p>
			</div>
			<%
			}
			%>
            </div>
			<% } else { %>
			<p class="no-data-message">No itinerary details available for this package.</p>
			<% } %>
		</div>

        <div class="final-total-price">
            <strong>Total Payable Amount:</strong> ₹<%=String.format("%.2f", finalCalculatedTotalPrice)%>
        </div>

		<form action="paymentServlet" method="post" class="payment-block">
            <h2>Select Payment Method</h2>
            <div class="payment-options">
                <label><input type="radio" name="payment" value="credit" checked> Credit Card</label>
                <label><input type="radio" name="payment" value="debit"> Debit Card</label>
                <label><input type="radio" name="payment" value="upi"> UPI</label>
                <label><input type="radio" name="payment" value="cod"> Cash on Delivery</label>
            </div>

            <input type="hidden" name="booking_id" value="<%=booking.getBookingId()%>">
            <input type="hidden" name="amount" value="<%=finalCalculatedTotalPrice%>">

            <button class="confirm-btn" type="submit">Confirm Payment</button>
        </form>
        <%
        } else {
        %>
        <p style="color: red; text-align: center;" class="no-data-message">Booking not found or invalid booking ID. Please check your booking details.</p>
        <%
        }
        %>
	</div>

	<%@ include file="footer.jsp"%>
</body>
</html>