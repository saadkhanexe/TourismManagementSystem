<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.tourist.dao.DestinationImplementation"%>
<%@ page import="com.tourist.dto.Destination"%>
<%@ page import="com.tourist.dao.BookingImplementation"%>
<%@ page import="com.tourist.dto.Booking"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %> <%-- FIXED: Added ArrayList import --%>
<%@ include file="sessionCheck.jsp" %>

<%
DestinationImplementation dao = new DestinationImplementation();
List<Destination> destinations = dao.getAllDestinations();
// REMOVED: The displayName declaration was here, as it's now handled by navigation.jsp
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard | Saad Travels</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	color: whitesmoke;
}

body {
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	background-color: #1a1a1a;
}


/* === REDESIGNED HERO VIDEO SECTION START === */
.hero-video {
	width: 100%;
	height: 100vh; /* Make it full-screen for a more immersive feel */
	position: relative;
	display: flex;
	align-items: center;
	justify-content: center;
	overflow: hidden;
    border-bottom: 4px solid goldenrod; /* Connects hero to the theme */
}

.hero-video video {
	width: 100%;
	height: 100%;
	object-fit: cover;
	position: absolute;
	top: 0;
	left: 0;
	z-index: -1;
}

.video-overlay {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
	/* A more subtle and modern gradient overlay */
	background: linear-gradient(to top, rgba(0, 0, 0, 0.8) 0%, rgba(0, 0, 0, 0.2) 60%, rgba(0, 0, 0, 0.8) 100%);
	padding: 0 20px;
}

.video-overlay h1 {
	font-family: Impact, Haettenschweiler, 'Arial Narrow Bold', sans-serif;
	font-size: clamp(2.5rem, 8vw, 5rem); /* Responsive font size */
	letter-spacing: 8px;
	color: goldenrod;
	text-transform: uppercase;
	/* Softer, more modern text shadow */
	text-shadow: 0 5px 20px rgba(0, 0, 0, 0.7);
	margin-bottom: 20px;
}

.video-overlay h1 span {
	color: sienna;
	display: block; /* Gives the name its own line on smaller screens */
	font-size: 0.8em;
	margin-top: 10px;
}

.video-overlay p {
	font-size: clamp(1rem, 3vw, 1.4rem); /* Responsive font size */
	max-width: 800px;
	color: #e0e0e0;
	line-height: 1.6;
	text-shadow: 0 2px 10px rgba(0, 0, 0, 0.8);
    letter-spacing: 1px;
}

/* Animated scroll down indicator */
.scroll-down-indicator {
    position: absolute;
    bottom: 40px;
    left: 50%;
    transform: translateX(-50%);
    color: white;
    font-size: 3rem;
    animation: bounce 2s infinite;
}

@keyframes bounce {
    0%, 20%, 50%, 80%, 100% {
        transform: translate(-50%, 0);
    }
    40% {
        transform: translate(-50%, -20px);
    }
    60% {
        transform: translate(-50%, -10px);
    }
}
/* === REDESIGNED HERO VIDEO SECTION END === */


/* Redesigned Content Sections */
.content-section {
	padding: 80px 5%;
}

.section-title {
	text-align: center;
	font-size: 2.8rem;
	letter-spacing: 6px;
	font-weight: 600;
	color: goldenrod;
	margin-bottom: 60px;
	position: relative;
	text-transform: uppercase;
}

.section-title::after {
	content: '';
	position: absolute;
	bottom: -15px;
	left: 50%;
	transform: translateX(-50%);
	width: 80px;
	height: 4px;
	background: sienna;
	border-radius: 2px;
}

/* Redesigned Trip Cards Grid */
.trips-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
	gap: 40px;
}

.trip-card {
	background: #222;
	border: 1px solid #444;
	border-radius: 15px;
	overflow: hidden;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	display: flex;
	flex-direction: column;
}

.trip-card:hover {
	transform: translateY(-10px);
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.5);
}

.trip-card-image-container {
	width: 100%;
	height: 220px;
	overflow: hidden;
}

.trip-card-image-container img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: transform 0.4s ease;
}

.trip-card:hover .trip-card-image-container img {
	transform: scale(1.05);
}

.trip-info {
	padding: 25px;
	flex-grow: 1;
	display: flex;
	flex-direction: column;
}

.trip-info h3 {
	font-size: 1.6rem;
	margin-bottom: 15px;
	color: goldenrod;
	font-weight: 600;
}

.trip-info p {
	margin-bottom: 15px;
	color: #ccc;
	font-size: 0.95rem;
	line-height: 1.6;
	flex-grow: 1;
}

.trip-meta {
	display: flex;
	justify-content: space-between;
	align-items: center;
	color: #ddd;
	font-size: 0.9rem;
	margin-top: auto;
}

.trip-meta span {
	font-weight: 500;
}

.book-now {
	display: inline-block;
	padding: 10px 22px;
	background: goldenrod;
	color: #1a1a1a;
	border-radius: 8px;
	text-decoration: none;
	font-weight: bold;
	transition: background-color 0.3s, transform 0.2s;
	border: 2px solid goldenrod;
	text-align: center;
}

.book-now:hover {
	background: sienna;
	color: white;
	border-color: sienna;
	transform: scale(1.05);
}

/* Other sections... (code remains the same as previous redesign) */

.upcoming-trips-section h2 {
    color: sienna;
}

.no-trips-message {
    text-align: center;
    color: goldenrod;
    font-size: 1.5rem;
    padding: 40px;
    background: rgba(40, 40, 40, 0.5);
    border-radius: 10px;
    border: 1px dashed goldenrod;
}

.offers-section {
	background: #111;
	border-top: 2px solid goldenrod;
	border-bottom: 2px solid goldenrod;
	padding: 80px 5%;
}

.offer-card {
	border-color: sienna;
}

.offer-card .trip-info h3 {
	color: sienna;
}

.offer-card .book-now {
	background-color: sienna;
	border-color: sienna;
	color: white;
}
.offer-card .book-now:hover {
	background-color: goldenrod;
	border-color: goldenrod;
	color: #1a1a1a;
}
.offer-meta {
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: 1.1rem;
	color: #fff;
	margin-bottom: 20px;
}
.offer-meta .discount {
	background-color: goldenrod;
	color: black;
	padding: 5px 10px;
	border-radius: 5px;
	font-weight: bold;
}
.offer-meta .price {
	text-align: right;
}
.offer-meta .original-price {
	text-decoration: line-through;
	color: #999;
	font-size: 1rem;
}

.info-card {
	background: #222;
	border: none;
	border-left: 5px solid goldenrod;
	padding: 30px;
	border-radius: 10px;
	text-align: center;
	transition: background-color 0.3s;
}
.info-card:hover {
	background-color: #2a2a2a;
}
.info-card .icon {
	color: goldenrod;
	margin-bottom: 20px;
}
.info-card h3 {
	color: whitesmoke;
	font-size: 1.5rem;
	margin-bottom: 15px;
}
.info-card p {
	color: #ccc;
	line-height: 1.6;
}

.support-faq-container {
    background: rgba(0, 0, 0, 0.2);
    border-radius: 15px;
    padding: 40px;
    margin-top: 20px;
}

.support-faq-container p {
    color: burlywood;
    line-height: 1.7;
    font-size: 1.1rem;
}

.support-faq-container strong {
    color: goldenrod;
}

.faq-item {
    margin-bottom: 25px;
}
.faq-item h3 {
    color: goldenrod;
    font-size: 1.3rem;
    margin-bottom: 10px;
}
.faq-item p {
    color: #ccc;
    font-size: 1rem;
}

#scrollToTopBtn {
  position: fixed;
  bottom: 30px;
  right: 30px; /* Moved to right for common UI practice */
  left: auto;
  z-index: 999;
  background-color: goldenrod;
  color: white;
  font-size: 20px;
  width: 50px; /* Equal width and height for a perfect circle */
  height: 50px;
  border-radius: 50%;
  text-align: center;
  cursor: pointer;
  box-shadow: 0 4px 12px rgba(0,0,0,0.3);
  transition: opacity 0.3s, background-color 0.3s;
  display: none;
  line-height: 50px; /* Vertically center the icon */
}

#scrollToTopBtn:hover {
  background-color: sienna;
}

@media (max-width: 768px) {
	.section-title {
		font-size: 2.2rem;
		letter-spacing: 4px;
	}
	.trips-grid {
		grid-template-columns: 1fr;
	}
    .support-faq-container .faq-grid {
        grid-template-columns: 1fr;
    }
}
</style>
</head>
<body>
	<%@ include file="navigation.jsp" %>
	<section class="hero-video">
		<video autoplay muted loop>
			<source src="Videos/videoplayback3.webm" type="video/webm">
		</video>
		<div class="video-overlay">
			<h1>
				Welcome To Saad Travels <span><%=displayName%></span>
			</h1>
			<p>Your next adventure begins here. Explore our exclusive member-only deals below.</p>
            <div class="scroll-down-indicator">
                <i class="fas fa-chevron-down"></i>
            </div>
		</div>
	</section>

	
	<section class="content-section" id="main-content">
		<h2 class="section-title">Top Destinations</h2>
		<div class="trips-grid">

			<%
			for (Destination d : destinations) {
			%>
			<div class="trip-card">
                <div class="trip-card-image-container">
				    <img src="<%=d.getDestination_image()%>" alt="<%=d.getDestination_name()%>">
                </div>
				<div class="trip-info">
					<h3><%=d.getDestination_name()%></h3>
					<p><%=d.getDestination_description()%></p>
					<div class="trip-meta">
						<span><strong><%=d.getDestination_price()%>/-</strong> per day</span>
                        <span>
                            <i class="fas fa-star" style="color: goldenrod;"></i> <%=d.getDestination_rating()%>
                        </span>
					</div>
                     <a href="PackageServlet?destinationId=<%=d.getDestination_id()%>" class="book-now" style="margin-top: 20px;">Book Now</a>
				</div>
			</div>
			<%
			}
			%>

		</div>
	</section>

	<%
	Integer userId = (Integer) session.getAttribute("user_id");
    BookingImplementation bookingDAO = new BookingImplementation();
    List<Booking> userBookings = bookingDAO.getBookingsByUserId(userId);

    // Filter for Active and Pending bookings only for "Upcoming Trips"
    List<Booking> upcomingBookings = new ArrayList<>();
    for(Booking b : userBookings) {
        if("Active".equalsIgnoreCase(b.getStatus()) || "Pending".equalsIgnoreCase(b.getStatus())) {
            upcomingBookings.add(b);
        }
    }

    if (upcomingBookings.isEmpty()) {
%>
        <div class="content-section">
             <h2 class="no-trips-message">You have no upcoming trips.</h2>
        </div>
<%
    } else {

    DestinationImplementation destDAO = new DestinationImplementation();
    List<Destination> allDestinations = destDAO.getAllDestinations();
    Map<Integer, Destination> destinationMap = new HashMap<>();
    for (Destination d : allDestinations) {
        destinationMap.put(d.getDestination_id(), d);
    }
%>

<section class="content-section upcoming-trips-section">
    <h2 class="section-title">YOUR UPCOMING TRIPS</h2>
    <div class="trips-grid">
        <%
            for (Booking booking : upcomingBookings) {
                Destination dest = destinationMap.get(booking.getDestination_id());
                if (dest != null) {
        %>
            <div class="trip-card">
                <div class="trip-card-image-container">
                    <img src="<%= dest.getDestination_image() %>" alt="<%= dest.getDestination_name() %>">
                </div>
                <div class="trip-info">
                    <h3><%= dest.getDestination_name() %></h3>
                    <p><strong>Status:</strong> <span style="color: goldenrod;"><%= booking.getStatus() %></span></p>
                    <div class="trip-meta">
                        <span>Booked: <%= booking.getBooking_date() %></span>
                        <span><strong>₹<%= booking.getPrice() %></strong></span>
                    </div>
                     <%-- UPDATED: Link to myBookings.jsp with highlightBookingId parameter --%>
                     <a href="myBookings.jsp?highlightBookingId=<%= booking.getBookingId() %>" class="book-now" style="margin-top: 20px;">Manage Booking</a>
                </div>
            </div>
        <%
                }
            }
        %>
    </div>
</section>
<%
    }
%>

	<section class="content-section offers-section">
		<h2 class="section-title">MEMBER EXCLUSIVES</h2>
		<div class="trips-grid">
			<div class="trip-card offer-card">
				<div class="trip-card-image-container">
					<img src="Images/Kanyakumari_photo.jpg" alt="Paris Special">
				</div>
				<div class="trip-info">
					<h3>Paris Spring Special</h3>
					<p>Experience the city of love with 4 nights in our hand-picked luxury boutique hotels.</p>
					<div class="offer-meta">
						<span class="discount">SAVE 25%</span>
						<div class="price">
							<span>$899</span>
							<div class="original-price">$1,200</div>
						</div>
					</div>
					<a href="#" class="book-now" style="margin-top: 20px;">Claim Deal</a>
				</div>
			</div>

			<div class="trip-card offer-card">
				<div class="trip-card-image-container">
					<img src="Images/login2_photo.jpg" alt="Caribbean Cruise">
				</div>
				<div class="trip-info">
					<h3>Caribbean Cruise</h3>
					<p>A 7-day all-inclusive escape, island hopping through crystal clear waters.</p>
					<div class="offer-meta">
						<span class="discount">EARLY BIRD</span>
						<div class="price">
							<span>$1,399</span>
							<div class="original-price">$1,800</div>
						</div>
					</div>
					<a href="#" class="book-now" style="margin-top: 20px;">Claim Deal</a>
				</div>
			</div>
		</div>
	</section>

	<section class="content-section">
		<h2 class="section-title">Why Choose Us</h2>
		<div class="trips-grid">
			<div class="info-card">
				<i class="fas fa-plane-departure fa-3x icon"></i>
				<h3>Seamless Bookings</h3>
				<p>Quick and hassle-free flight, hotel, and tour bookings with instant confirmation.</p>
			</div>
			<div class="info-card">
				<i class="fas fa-wallet fa-3x icon"></i>
<h3>Affordable Pricing</h3>
				<p>We provide the best deals without compromising on quality or comfort.</p>
			</div>
			<div class="info-card">
				<i class="fas fa-headset fa-3x icon"></i>
				<h3>24/7 Support</h3>
				<p>Dedicated travel experts ready to assist you anytime, anywhere.</p>
			</div>
		</div>
	</section>

	<section class="content-section" style="padding-top: 40px; padding-bottom: 80px;">
        <div class="support-faq-container" style="background: transparent; padding: 0;">
            <div class="faq-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 40px;">
                
                <div class="faq-column">
                    <h2 class="section-title" style="text-align: left; font-size: 2rem; margin-bottom: 40px;">Support</h2>
                    <div class="support-faq-item-container" style="background: #222; padding: 30px; border-radius: 15px;">
                        <p>At Saad Travels, your satisfaction is our priority. Whether it's booking assistance, travel tips, or last-minute changes—we’re just a call or message away.</p>
                        <br>
                        <p>
                            <strong>Email:</strong> support@saadtravels.com<br>
                            <strong>Phone:</strong> +123 456 7890
                        </p>
                    </div>
                </div>

                <div class="faq-column">
                    <h2 class="section-title" style="text-align: left; font-size: 2rem; margin-bottom: 40px;">FAQs</h2>
                    <div class="support-faq-item-container" style="background: #222; padding: 30px; border-radius: 15px;">
                        <div class="faq-item">
                            <h3>How can I cancel or reschedule a trip?</h3>
                            <p>Login to your account, go to "My Trips", and choose the cancel or reschedule option. Policies may apply.</p>
                        </div>
                        <div class="faq-item">
                            <h3>Are your deals refundable?</h3>
                            <p>Most deals are refundable within 24 hours of booking. Check the individual offer’s policy for more info.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

	<%@ include file="footer.jsp" %>
	
	<a href="#" id="scrollToTopBtn" title="Back to Top">
	  <i class="fas fa-arrow-up"></i>
	</a>
	
	<script>
	  const scrollBtn = document.getElementById("scrollToTopBtn");

	  window.onscroll = function() {
		if (document.body.scrollTop > 300 || document.documentElement.scrollTop > 300) {
		  scrollBtn.style.display = "block";
		} else {
		  scrollBtn.style.display = "none";
		}
	  };

	  scrollBtn.addEventListener("click", function(e) {
		e.preventDefault();
		window.scrollTo({ top: 0, behavior: 'smooth' });
	  });
	</script>
	
</body>
</html>