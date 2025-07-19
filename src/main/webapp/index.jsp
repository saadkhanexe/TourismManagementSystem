<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tourism</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="stylesheet" href="styles.css">
</head>
<body>
	<%@ include file="header.jsp" %>
	<div class="videos">
		<video src="Videos/videoplayback5.mp4" autoplay muted loop></video>
		<div class="video-overlay">
			<h1>SAAD TRAVELS</h1>
			<p>Where Adventure meets Adrenaline</p>
		</div>
	</div>

	<!-- Book Now Section -->
	<div class="book-now-section">
		<div class="book-form">
			<h2>LOGIN TO EXPLORE</h2>
			<form action="loginSubmit" method="post">
				<input style="color: sienna" type="email" placeholder="Email Address" name="email" required>
				 <input style="color: sienna" type="password" placeholder="Password" name="password" required>

				<button type="submit">LOGIN</button>
				<div class="register-link">
					<pre style="color: sienna;">
                    Don't have an account?   <a href="signup.jsp">Register here</a>
					</pre>
				</div>
			</form>
		</div>
		<div class="book-image">
			<img src="Images/autorickshaw_photo.jpg" alt="Travel Destination">
		</div>
	</div>

	<!-- Gallery section -->
	<section class="destinations-section" id="destinations">
		<h2 class="section-title">POPULAR DESTINATIONS</h2>
		<div class="destinations-grid">
			<!-- Row 1 -->
			<div class="destination-card">
				<div class="destination-image">
					<img src="Images/Munnar_photo.jpg" alt="Mountain Resort">
				</div>
				<div class="destination-info">
					<h3>Munnar</h3>
					<p>
						<i class="fas fa-map-marker-alt"></i> 123 Mountain View Rd, Munnar
					</p>
				</div>
			</div>

			<div class="destination-card">
				<div class="destination-image">
					<img src="Images/Ladakh_photo.jpg" alt="Beach Resort">
				</div>
				<div class="destination-info">
					<h3>Ladakh</h3>
					<p>
						<i class="fas fa-map-marker-alt"></i> 123 riverbank Ave, Ladakh
					</p>
				</div>
			</div>

			<div class="destination-card">
				<div class="destination-image">
					<img src="Images/Meghalaya_photo.webp" alt="Desert Camp">
				</div>
				<div class="destination-info">
					<h3>Meghalaya</h3>
					<p>
						<i class="fas fa-map-marker-alt"></i> 798 Rainforest Rd, Meghalaya
					</p>
				</div>
			</div>

			<!-- Row 2 -->
			<div class="destination-card">
				<div class="destination-image">
					<img src="Images/Kanyakumari_photo.jpg" alt="Forest Retreat">
				</div>
				<div class="destination-info">
					<h3>Kanyakumari</h3>
					<p>
						<i class="fas fa-map-marker-alt"></i> 456 Coastal Rd, Kanyakumari
					</p>
				</div>
			</div>

			<div class="destination-card">
				<div class="destination-image">
					<img src="Images/Gandikota_photo.jpg" alt="City Hotel">
				</div>
				<div class="destination-info">
					<h3>Gandikota</h3>
					<p>
						<i class="fas fa-map-marker-alt"></i> 789 Canyon View St, Gandikota
					</p>
				</div>
			</div>

			<div class="destination-card">
				<div class="destination-image">
					<img src="Images/Meghalaya1.jpg" alt="Private Island">
				</div>
				<div class="destination-info">
					<h3>Meghalaya</h3>
					<p>
						<i class="fas fa-map-marker-alt"></i> 123 Waterfall Lane, Meghalaya
					</p>
				</div>
			</div>

			<!-- Row 3 -->
			<div class="destination-card">
				<div class="destination-image">
					<img src="Images/Kerala_backwaters_photo.jpg" alt="Mountain Cabin">
				</div>
				<div class="destination-info">
					<h3>Allepey</h3>
					<p>
						<i class="fas fa-map-marker-alt"></i> 789 Backwater Blvd, Allepey
					</p>
				</div>
			</div>

			<div class="destination-card">
				<div class="destination-image">
					<img src="Images/Gujarat_photo.jpeg" alt="Vineyard">
				</div>
				<div class="destination-info">
					<h3>Rann of Kutch</h3>
					<p>
						<i class="fas fa-map-marker-alt"></i> 456 Desert Oasis Rd, Gujarat
					</p>
				</div>
			</div>

			<div class="destination-card">
				<div class="destination-image">
					<img src="Images/Alleppy_photo.webp" alt="Safari Camp">
				</div>
				<div class="destination-info">
					<h3>Allepey BackWaters</h3>
					<p>
						<i class="fas fa-map-marker-alt"></i> 123 Lagoon Lane, Allepey
					</p>
				</div>
			</div>
		</div>
	</section>

	<!-- Services Section -->
	<section class="services-section" id="services">
		<h2 class="services-title">OUR SERVICES</h2>
		<div class="services-grid">
			<div class="service-card">
				<i class="fas fa-plane-departure"></i>
				<h3>Flight Bookings</h3>
				<p>Seamless flight booking services for all destinations.</p>
			</div>
			<div class="service-card">
				<i class="fas fa-hotel"></i>
				<h3>Hotel Reservations</h3>
				<p>Comfortable and affordable stays tailored to your needs.</p>
			</div>
			<div class="service-card">
				<i class="fas fa-route"></i>
				<h3>Custom Itineraries</h3>
				<p>Unique travel plans crafted just for you.</p>
			</div>
			<div class="service-card">
				<i class="fas fa-bus-alt"></i>
				<h3>Local Transport</h3>
				<p>City tours and safe local travel options at your fingertips.</p>
			</div>
			<div class="service-card">
				<i class="fas fa-passport"></i>
				<h3>Visa Assistance</h3>
				<p>Expert help with visa processing and travel documentation.</p>
			</div>
			<div class="service-card">
				<i class="fas fa-globe-asia"></i>
				<h3>International Packages</h3>
				<p>Explore handpicked international travel experiences tailored
					to your preferences.</p>
			</div>
		</div>
	</section>

	<!-- Reviews Section -->
	<section class="reviews-section" id="reviews">
		<h2>What Our Customers Say</h2>
		<div class="reviews-grid">
			<div class="review-card">
				<img src="Images/Virat_photo.jpeg" alt="Sarah A.">
				<p>"Amazing experience! Everything was perfectly organized. Will
					definitely book again!"</p>
				<h4>Virat Kohli</h4>
			</div>
			<div class="review-card">
				<img src="Images/Ronaldo_photo.webp" alt="Ahmed K.">
				<p>"Professional service and friendly staff. Made our trip
					memorable and stress-free!"</p>
				<h4>Cristiano Ronaldo</h4>
			</div>
			<div class="review-card">
				<img src="Images/Lewis_photo.jpeg" alt="Priya S.">
				<p>"From ticket booking to hotel stay, everything was smooth.
					Highly recommend them!"</p>
				<h4>Lewis Hamilton</h4>
			</div>
		</div>
	</section>

	<%@ include file="footer.jsp" %>
</body>
</html>