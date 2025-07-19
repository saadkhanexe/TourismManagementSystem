
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
/* Footer Styles */
.site-footer {
	background-color: sienna;
	color: white;
	padding: 60px 0 0;
	position: relative;
}

.footer-content {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 40px;
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 40px;
}

.footer-column {
	margin-bottom: 30px;
}

.footer-column h3 {
	font-size: 1.5rem;
	margin-bottom: 20px;
	letter-spacing: 1px;
	position: relative;
	padding-bottom: 10px;
}

.footer-column h3::after {
	content: '';
	position: absolute;
	left: 0;
	bottom: 0;
	width: 50px;
	height: 2px;
	background: goldenrod;
}

.footer-column p {
	margin-bottom: 20px;
	line-height: 1.6;
	color: burlywood;
}

.footer-column ul {
	list-style: none;
}

.footer-column ul li {
	margin-bottom: 12px;
}

.footer-column ul li a {
	color: burlywood;
	text-decoration: none;
	transition: color 0.3s;
}

.footer-column ul li a:hover {
	color: goldenrod;
	padding-left: 5px;
}

.social-links {
	display: flex;
	gap: 15px;
	margin-top: 20px;
}

.social-links a {
	display: flex;
	align-items: center;
	justify-content: center;
	width: 40px;
	height: 40px;
	background: rgba(255, 255, 255, 0.1);
	border-radius: 50%;
	color: white;
	transition: all 0.3s;
}

.social-links a:hover {
	background: goldenrod;
	transform: translateY(-3px);
}

.newsletter-form {
	display: flex;
	margin-top: 20px;
}

.newsletter-form input {
	flex: 1;
	padding: 12px;
	border: none;
	background: rgba(255, 255, 255, 0.1);
	color: white;
}

.newsletter-form input::placeholder {
	color: rgba(255, 255, 255, 0.7);
}

.newsletter-form button {
	width: 50px;
	background: goldenrod;
	color: black;
	border: none;
	cursor: pointer;
	transition: background 0.3s;
}

.newsletter-form button:hover {
	background: #e6c200;
}

.footer-bottom {
	text-align: center;
	padding: 20px;
	background-color: rgba(0, 0, 0, 0.2);
	margin-top: 40px;
	color: burlywood;
}

@media ( max-width : 768px) {
	.footer-content {
		grid-template-columns: 1fr;
		gap: 30px;
	}
	.footer-column {
		text-align: center;
	}
	.footer-column h3::after {
		left: 50%;
		transform: translateX(-50%);
	}
	.social-links {
		justify-content: center;
	}
}
</style>
</head>
<body>
<!-- ======= FOOTER ======= -->
	<footer class="site-footer">
		<div class="footer-content">
			<!-- Footer Columns -->
			<div class="footer-column">
				<h3>SAAD TRAVELS</h3>
				<p>Where Adventure Meets Adrenaline</p>
				<div class="social-links">
					<a href="#"><i class="fab fa-facebook-f"></i></a> <a href="#"><i
						class="fab fa-twitter"></i></a> <a href="#"><i
						class="fab fa-instagram"></i></a> <a href="#"><i
						class="fab fa-youtube"></i></a>
				</div>
			</div>

			<div class="footer-column">
				<h3>Quick Links</h3>
				<ul>
					<li><a href="#">Home</a></li>
					<li><a href="#">Destinations</a></li>
					<li><a href="#">Special Offers</a></li>
					<li><a href="#">Gallery</a></li>
				</ul>
			</div>

			<div class="footer-column">
				<h3>Support</h3>
				<ul>
					<li><a href="#">Contact Us</a></li>
					<li><a href="#">FAQs</a></li>
					<li><a href="#">Privacy Policy</a></li>
					<li><a href="#">Terms & Conditions</a></li>
				</ul>
			</div>

			<div class="footer-column">
				<h3>Newsletter</h3>
				<p>Subscribe for travel tips and offers</p>
				<form class="newsletter-form">
					<input type="email" placeholder="Your Email">
					<button type="submit">
						<i class="fas fa-paper-plane"></i>
					</button>
				</form>
			</div>
		</div>

		<div class="footer-bottom">
			<p>&copy; 2025 Saad Travels. All Rights Reserved.</p>
		</div>
	</footer>
</body>
</html>