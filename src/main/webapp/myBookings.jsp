<%@ page import="java.util.*, com.tourist.dto.*" %>
<%@ page import="com.tourist.dao.BookingImplementation, com.tourist.dao.DestinationImplementation" %>
<%@ page import="com.tourist.dao.ResortImplementation, com.tourist.dao.RestaurantImplementation, com.tourist.dao.ItineraryImplementation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="sessionCheck.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Your Bookings</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;700&family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <style>
        /* GLOBAL RESET AND BASE LAYOUT STYLES - CRITICAL FOR HEADER/FOOTER POSITIONING */
        html, body {
            height: 100%; /* Make sure html and body take full viewport height */
            margin: 0;   /* Remove default browser margins */
            padding: 0;  /* Remove default browser paddings */
            box-sizing: border-box; /* Include padding and border in the element's total width and height */
        }

        body {
            background-color: #1a1a1a;
            color: #e0e0e0; /* Softer white text */
            font-family: 'Roboto', sans-serif; /* Modern, readable font */
            line-height: 1.6;
            
            /* Flexbox for full page layout: stacks children vertically */
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensure body takes at least full viewport height */
        }

        /* MAIN CONTENT CONTAINER */
        .bookings-container {
            flex-grow: 1; /* THIS IS KEY: Makes this container expand to fill available space */
            padding: 40px;
            max-width: 1000px; /* Increased max-width */
            margin: 40px auto;
            background-color: #1f1f1f;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5),
                        0 0 0 5px rgba(218, 165, 32, 0.1); /* Subtle goldenrod glow */
            animation: fadeIn 0.8s ease-out; /* Fade-in effect */
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h1 {
            color: goldenrod;
            text-align: center;
            font-family: 'Montserrat', sans-serif;
            font-size: 2.8em;
            margin-bottom: 40px;
            letter-spacing: 2px;
            text-shadow: 0 0 15px rgba(218, 165, 32, 0.5); /* Stronger glow */
        }

        /* Booking Cards Grid */
        .bookings-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); /* Responsive grid */
            gap: 30px; /* Space between cards */
            padding-top: 20px; /* Space below heading */
        }

        .booking-card {
            background-color: #2a2a2a; /* Darker card background */
            border-radius: 12px;
            overflow: hidden; /* Ensures image corners are rounded */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
            border: 1px solid #3a3a3a; /* Subtle border */
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex; /* Flexbox for internal card layout */
            flex-direction: column;
        }

        .booking-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.6);
        }

        .booking-card-image {
            width: 100%;
            height: 200px; /* Fixed height for images */
            object-fit: cover; /* Cover the area, crop if necessary */
            display: block;
        }

        .booking-card-content {
            padding: 20px; /* Slightly reduced padding */
            flex-grow: 1; /* Allows content area to expand */
            display: flex;
            flex-direction: column;
            justify-content: space-between; /* Distribute content and push buttons down */
        }

        .booking-card h3 {
            color: goldenrod;
            font-family: 'Montserrat', sans-serif;
            font-size: 1.5em; /* Slightly smaller heading */
            margin-bottom: 10px; /* Reduced margin */
            text-align: center;
        }

        .booking-info {
            flex-grow: 1; /* Make info section grow to push price/buttons down */
            margin-bottom: 15px; /* Space before price/buttons */
        }

        .booking-info p {
            font-size: 0.95em; /* Slightly smaller text */
            margin: 6px 0; /* Reduced margin */
            display: flex;
            justify-content: space-between; /* Space out label and value */
            align-items: baseline;
        }

        .booking-info p strong {
            color: goldenrod; /* Highlight labels */
            font-weight: 600;
            flex-shrink: 0; /* Prevent label from shrinking */
            padding-right: 10px;
        }

        .price-total {
            font-size: 1.3em; /* Slightly smaller total price */
            font-weight: bold;
            color: lightgreen;
            margin-top: 15px;
            text-align: right;
            border-top: 1px dashed #444;
            padding-top: 10px;
        }

        .price-total span {
            font-size: 0.7em; /* Smaller currency symbol */
        }

        /* Status Styling */
        .status-active { color: #66ccff; } /* Light blue */
        .status-completed { color: #99ff99; } /* Light green */
        .status-pending { color: #ffcc66; } /* Orange/Amber - implies awaiting action */
        .status-cancelled { color: #ff6666; } /* Light red - Re-added for old cancelled bookings */

        /* No bookings message */
        .no-bookings-message {
            background-color: #2a2a2a;
            padding: 50px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.4);
            border: 1px solid #3a3a3a;
            margin-top: 50px;
        }

        .no-bookings-message h2 {
            color: goldenrod;
            font-family: 'Montserrat', sans-serif;
            font-size: 2.2em;
            margin-bottom: 20px;
        }

        .no-bookings-message p {
            font-size: 1.2em;
            color: #c0c0c0;
            margin-bottom: 30px;
        }

        .no-bookings-message a {
            display: inline-block;
            background-color: goldenrod;
            color: #1a1a1a;
            padding: 12px 25px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .no-bookings-message a:hover {
            background-color: #e6b800;
            transform: translateY(-2px);
        }

        /* Buttons Container within card */
        .booking-actions {
            display: flex;
            justify-content: flex-end; /* Align buttons to the right */
            gap: 10px; /* Space between buttons */
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px dashed #444; /* Separate actions section */
        }

        .action-btn {
            background-color: sienna; /* Default for actions */
            color: whitesmoke;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            font-weight: 500;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .action-btn:hover {
            background-color: #a0522d;
            transform: translateY(-2px);
        }

        .action-btn:disabled {
            background-color: #555;
            cursor: not-allowed;
            opacity: 0.7;
        }
        
        .action-btn.remove-btn { /* Style for the new remove button */
            background-color: #8B0000; /* Dark red for remove */
        }

        .action-btn.remove-btn:hover {
            background-color: #b30000; /* Brighter red on hover */
        }

        /* Message Box for Servlet Redirect */
        .message-box {
            padding: 15px;
            margin: 20px auto;
            max-width: 700px;
            border-radius: 8px;
            font-weight: bold;
            text-align: center;
            display: none; /* Hidden by default */
        }
        .message-box.success {
            background-color: #336633; /* Dark green */
            color: #e0ffe0;
        }
        .message-box.error {
            background-color: #800000; /* Dark red */
            color: #ffe0e0;
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .bookings-container {
                padding: 20px;
                margin: 20px auto;
            }
            h1 {
                font-size: 2.2em;
                margin-bottom: 30px;
            }
            .bookings-grid {
                grid-template-columns: 1fr; /* Single column on small screens */
            }
            .booking-card-image {
                height: 180px;
            }
            .booking-card h3 {
                font-size: 1.4em;
            }
            .price-total {
                font-size: 1.2em;
            }
            .no-bookings-message {
                padding: 30px;
            }
            .no-bookings-message h2 {
                font-size: 1.8em;
            }
            .no-bookings-message p {
                font-size: 1em;
            }
            .booking-actions {
                flex-direction: column; /* Stack buttons vertically on small screens */
                align-items: stretch; /* Make them full width */
            }
        }
    </style>

    <script>
        // This function handles the initial cancellation (which now also deletes)
        function confirmCancelAndDelete(bookingId) {
            if (confirm("Are you sure you want to cancel this booking? This will also permanently remove it from your records.")) {
                window.location.href = 'cancelBookingServlet?booking_id=' + bookingId;
            }
        }

        // This new function handles removing *already cancelled* records
        function confirmRemoveRecord(bookingId) {
            if (confirm("Are you sure you want to permanently remove this cancelled booking record? This cannot be undone.")) {
                window.location.href = 'deleteBookingServlet?booking_id=' + bookingId;
            }
        }

        // Function to display messages from servlet redirect
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const message = urlParams.get('message');
            const status = urlParams.get('status');
            const messageBox = document.getElementById('messageBox');

            if (message && messageBox) {
                messageBox.textContent = decodeURIComponent(message);
                messageBox.className = 'message-box ' + (status !== null ? status : ""); 
                messageBox.style.display = 'block'; // Make it visible
                
                // Remove message from URL to prevent re-display on refresh and cleaner URL
                history.replaceState({}, document.title, window.location.pathname);
            }
        };
    </script>
    </head>
<body>

<%@ include file="navigation.jsp" %>

<div class="bookings-container">
    <h1>Your Travel Bookings</h1>

    <%
        // Retrieve userId from session (as already done in your original code)
        Integer userId = (Integer) session.getAttribute("user_id");
        String userName = (String) session.getAttribute("name"); // Assuming 'name' is also in session

        if (userId == null) {
    %>
            <div class="no-bookings-message">
                <h2>Access Denied</h2>
                <p>Please log in to view your amazing travel bookings.</p>
                <a href="login.jsp">Log In Now</a>
            </div>
    <%
            return; // Stop processing the JSP here
        }

        // Display welcome message for logged-in user
        if (userName != null) {
    %>
            <h2 style="text-align: center; color: #c0c0c0; font-family: 'Montserrat', sans-serif; margin-bottom: 20px;">
                Hello, <%= userName %>! Here's an overview of your trips.
            </h2>
    <%
        }

        // Display messages from cancellation/deletion servlet
        String servletMessage = request.getParameter("message");
        String messageStatus = request.getParameter("status");
        if (servletMessage != null && !servletMessage.isEmpty()) {
    %>
        <div id="messageBox" class="message-box <%= messageStatus != null ? messageStatus : "" %>" style="display: block;">
            <%= java.net.URLDecoder.decode(servletMessage, "UTF-8") %>
        </div>
    <%
        } else {
    %>
        <div id="messageBox" class="message-box"></div>
    <%
        }


        BookingImplementation bookingDAO = new BookingImplementation();
        List<Booking> userBookings = bookingDAO.getBookingsByUserId(userId);

        if (userBookings == null || userBookings.isEmpty()) {
    %>
            <div class="no-bookings-message">
                <h2>No Bookings Found!</h2>
                <p>It looks like you haven't booked any trips yet. Your adventure awaits!</p>
                <p>Start planning your next getaway with our exciting destinations.</p>
                <a href="destination.jsp">Explore Destinations</a>
            </div>
    <%
            return; // Stop processing the JSP here
        }

        // Initialize DAOs for fetching related details (optimized to fetch once)
        DestinationImplementation destDAO = new DestinationImplementation();
        ResortImplementation resortDAO = new ResortImplementation();
        RestaurantImplementation restaurantDAO = new RestaurantImplementation();
        ItineraryImplementation itineraryDAO = new ItineraryImplementation();
    %>

    <div class="bookings-grid">
        <%
            for (Booking booking : userBookings) {
                // If a booking is marked "Cancelled", we now display it and offer a "Remove Record" button.
                // New cancellations (via CancelBookingServlet) will immediately delete the record.

                Destination dest = destDAO.getDestination(booking.getDestination_id());
                Resort resort = resortDAO.getResort(booking.getResort_id());
                Restaurant restaurant = restaurantDAO.getRestaurant(booking.getRestaurant_id());
                Itinerary itinerary = itineraryDAO.getItineraryById(booking.getItinerary_id());

                double calculatedTotalPrice = 0.0;
                
                // Calculate total price from components
                if (dest != null) {
                    calculatedTotalPrice += dest.getDestination_price();
                }
                if (resort != null) {
                    calculatedTotalPrice += resort.getResort_price();
                }
                if (restaurant != null) {
                    calculatedTotalPrice += restaurant.getRestaurant_price();
                }
                if (itinerary != null) {
                    calculatedTotalPrice += itinerary.getItinerary_price();
                }

                // Determine status class for styling
                String statusClass = "";
                if ("Active".equalsIgnoreCase(booking.getStatus())) {
                    statusClass = "status-active";
                } else if ("Completed".equalsIgnoreCase(booking.getStatus())) {
                    statusClass = "status-completed";
                } else if ("Pending".equalsIgnoreCase(booking.getStatus())) {
                    statusClass = "status-pending"; // Still 'Pending' if DB says so
                } else if ("Cancelled".equalsIgnoreCase(booking.getStatus())) {
                    statusClass = "status-cancelled"; // Now displaying Cancelled bookings
                } else {
                    statusClass = ""; // Default or no special style for other statuses
                }
        %>
            <div class="booking-card">
                <% if (dest != null && dest.getDestination_image() != null && !dest.getDestination_image().isEmpty()) { %>
                    <img src="<%= dest.getDestination_image() %>" alt="<%= dest.getDestination_name() %> Image" class="booking-card-image" />
                <% } else { %>
                    <img src="images/placeholder_destination.jpg" alt="Destination Image Placeholder" class="booking-card-image" />
                <% } %>
                <div class="booking-card-content">
                    <h3><%= dest != null ? dest.getDestination_name() : "Unknown Destination" %></h3>
                    
                    <div class="booking-info">
                        <p><strong>Booking ID:</strong> <span><%= booking.getBookingId() %></span></p>
                        <p><strong>Booking Date:</strong> <span><%= booking.getBooking_date() %></span></p>
                        <p><strong>Status:</strong> <span class="<%= statusClass %>"><%= booking.getStatus() %></span></p>
                        <p><strong>Remarks:</strong> <span><%= booking.getRemarks() != null && !booking.getRemarks().trim().isEmpty() ? booking.getRemarks() : "N/A" %></span></p>
                    </div>
                    
                    <div class="price-total">
                        <strong>Total Paid:</strong> ₹<span><%= String.format("%.2f", calculatedTotalPrice) %></span>
                    </div>

                    <div class="booking-actions">
                        <%-- Logic for action buttons based on status --%>
                        <% if ("Active".equalsIgnoreCase(booking.getStatus()) || "Pending".equalsIgnoreCase(booking.getStatus())) { %>
                            <button class="action-btn" onclick="confirmCancelAndDelete(<%= booking.getBookingId() %>)">Cancel Booking</button>
                        <% } else if ("Cancelled".equalsIgnoreCase(booking.getStatus())) { %>
                            <button class="action-btn remove-btn" onclick="confirmRemoveRecord(<%= booking.getBookingId() %>)">Remove Record</button>
                        <% } else { %>
                            <button class="action-btn" disabled>No Actions</button>
                        <% } %>
                    </div>
                </div>
            </div>
        <%
            } // End of for loop
        %>
    </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>