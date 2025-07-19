<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, com.tourist.dto.Destination, com.tourist.dao.DestinationImplementation "%>
<%@ include file="sessionCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Destinations</title>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;700&family=Roboto:wght@400;500&display=swap" rel="stylesheet">
<style>
/* --- Universal Styling --- */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
    /* Changed default font family for better readability and modern look */
	font-family: 'Roboto', sans-serif; 
	color: #e0e0e0; /* Softer white text for general content */
}

/* --- Body and Layout --- */
body {
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	background-color: #1a1a1a; /* Dark background */
    line-height: 1.6; /* Improved readability for paragraphs */
}

/* Ensure main content takes available space */
.content-section {
    flex-grow: 1; /* Makes this section fill available vertical space */
	padding: 60px 40px;
    max-width: 1200px; /* Max width for content to prevent overly wide lines */
    margin: 40px auto; /* Center the content section */
    animation: fadeIn 0.8s ease-out; /* Smooth fade-in for the whole section */
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

/* --- Section Title --- */
.section-title {
	text-align: center;
	font-size: 3.2rem; /* Larger font size */
	letter-spacing: 3px; /* Slightly less extreme spacing */
	color: goldenrod;
	margin-bottom: 50px; /* More space below title */
	position: relative;
    font-family: 'Montserrat', sans-serif; /* Distinct font for titles */
    font-weight: 700; /* Bolder */
    text-shadow: 0 0 15px rgba(218, 165, 32, 0.6); /* Added subtle glow */
}

.section-title::after {
	content: '';
	position: absolute;
	bottom: -15px; /* Moved line further down */
	left: 50%;
	transform: translateX(-50%);
	width: 150px; /* Wider line */
	height: 4px; /* Thicker line */
	background: goldenrod;
	border-radius: 2px; /* Rounded ends for the line */
    box-shadow: 0 0 10px rgba(218, 165, 32, 0.4); /* Glow for the line */
}

/* --- Responsive Destination Cards Grid --- */
.trips-grid {
	display: grid;
    /* More flexible grid for various screen sizes */
	grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); 
	gap: 40px; /* Increased space between cards */
	margin-top: 50px; /* Space above the grid */
}

/* --- Individual Trip Card --- */
.trip-card {
	background: #2a2a2a; /* Darker, solid background for cards */
	border: 1px solid #444; /* Subtle border */
	border-radius: 15px; /* More rounded corners */
	overflow: hidden;
	transition: transform 0.3s ease, box-shadow 0.3s ease; /* Smooth transition for hover */
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4); /* Deeper shadow */
    display: flex; /* Use flexbox to organize card content */
    flex-direction: column; /* Stack image and info vertically */
}

.trip-card:hover {
	transform: translateY(-12px); /* Lift more on hover */
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.6); /* More pronounced shadow on hover */
}

.trip-card img {
	width: 100%;
	height: 220px; /* Slightly increased image height */
	object-fit: cover;
    display: block; /* Remove extra space below image */
    border-bottom: 1px solid #333; /* Separator for image and content */
}

.trip-info {
	padding: 25px; /* Increased padding */
    flex-grow: 1; /* Allows info section to grow and push button down */
    display: flex;
    flex-direction: column;
}

.trip-info h3 {
	font-size: 1.8rem; /* Larger heading */
	margin-bottom: 12px; /* More space below heading */
	color: goldenrod;
    font-family: 'Montserrat', sans-serif;
    font-weight: 700;
    text-align: center; /* Center trip name */
}

.trip-info p {
	margin-bottom: 18px; /* More space below paragraphs */
	color: #c0c0c0; /* Softer text color */
    font-size: 0.95rem; /* Slightly smaller text for descriptions */
    flex-grow: 1; /* Allows descriptions to take up available space */
}

.trip-meta {
	display: flex;
	justify-content: space-between;
	color: #f0f0f0; /* Brighter white for meta info */
	margin-bottom: 15px; /* More space above button */
    font-size: 1rem;
    font-weight: 500;
    padding-top: 10px;
    border-top: 1px dashed #3a3a3a; /* Subtle dashed separator */
}

.trip-meta span:first-child {
    color: lightgreen; /* Highlight price */
    font-weight: bold;
}

/* --- Book Now Button --- */
.book-now {
	display: block; /* Make it a block-level element to take full width */
	width: fit-content; /* Adjust width to content + padding */
	margin: 0 auto; /* Center the button */
	padding: 12px 30px; /* Larger padding */
	background: goldenrod;
	color: #1a1a1a; /* Dark text on goldenrod */
	border-radius: 8px; /* More rounded button */
	text-decoration: none;
	font-weight: bold;
    font-size: 1.1rem; /* Larger font size for button text */
	transition: background 0.3s ease, transform 0.2s ease; /* Smooth hover effects */
    letter-spacing: 0.5px;
    text-transform: uppercase; /* Uppercase text */
    box-shadow: 0 4px 10px rgba(218, 165, 32, 0.4); /* Shadow for button */
}

.book-now:hover {
	background: #e6c200; /* Slightly darker goldenrod on hover */
    transform: translateY(-3px); /* Lift button on hover */
    box-shadow: 0 6px 15px rgba(218, 165, 32, 0.6);
}

/* --- No Destinations Message --- */
.no-destinations-message {
    background-color: #2a2a2a;
    padding: 50px;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.4);
    border: 1px solid #3a3a3a;
    margin-top: 50px;
    max-width: 600px;
    margin: 50px auto; /* Center it */
}

.no-destinations-message h2 {
    color: goldenrod;
    font-family: 'Montserrat', sans-serif;
    font-size: 2em;
    margin-bottom: 20px;
}

.no-destinations-message p {
    font-size: 1.1em;
    color: #c0c0c0;
    margin-bottom: 30px;
}

.no-destinations-message a {
    display: inline-block;
    background-color: goldenrod;
    color: #1a1a1a;
    padding: 12px 25px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: bold;
    transition: background-color 0.3s ease, transform 0.2s ease;
}

.no-destinations-message a:hover {
    background-color: #e6b800;
    transform: translateY(-2px);
}

/* --- Responsive Adjustments --- */
@media (max-width: 1024px) {
    .content-section {
        padding: 40px 30px;
    }
    .section-title {
        font-size: 2.8rem;
    }
    .trips-grid {
        gap: 30px;
    }
    .trip-card img {
        height: 200px;
    }
}

@media (max-width: 768px) {
    .content-section {
        padding: 30px 20px;
    }
    .section-title {
        font-size: 2.2rem;
        margin-bottom: 40px;
    }
    .section-title::after {
        width: 120px;
        bottom: -12px;
    }
    .trips-grid {
        grid-template-columns: 1fr; /* Single column on small screens */
        gap: 25px;
    }
    .trip-card img {
        height: 180px;
    }
    .trip-info h3 {
        font-size: 1.6rem;
    }
    .trip-info p {
        font-size: 0.9rem;
    }
    .book-now {
        padding: 10px 25px;
        font-size: 1rem;
    }
}

@media (max-width: 480px) {
    .content-section {
        padding: 20px 15px;
    }
    .section-title {
        font-size: 1.8rem;
    }
    .trip-card img {
        height: 160px;
    }
    .trip-info {
        padding: 18px;
    }
}

</style>
</head>
<body>
	<%@ include file="navigation.jsp"%>

	<section class="content-section">
		<h2 class="section-title">Explore Our Destinations</h2>
		<div class="trips-grid">
			<%
			DestinationImplementation dao = new DestinationImplementation();
			List<Destination> destinations = dao.getAllDestinations();
			%>
			<%
			if (destinations != null && !destinations.isEmpty()) {
				for (Destination d : destinations) {
			%>
			<div class="trip-card">
				<img src="<%=d.getDestination_image()%>"
					alt="<%=d.getDestination_name()%>">
				<div class="trip-info">
					<h3><%=d.getDestination_name()%></h3>
					<p><%=d.getDestination_description()%></p>
					<p><%=d.getDestination_paragraph()%></p>
					<div class="trip-meta">
						<span>₹<%=String.format("%.2f", d.getDestination_price())%>/day</span>
						<span>Rating: <%=d.getDestination_rating()%> stars
						</span>
					</div>
					<a href="PackageServlet?destinationId=<%=d.getDestination_id()%>"
						class="book-now">Book Now</a>
				</div>
			</div>
			<%
			}
			} else {
			%>
			<div class="no-destinations-message">
                <h2>No Destinations Available Yet!</h2>
                <p>We're curating new adventures. Please check back soon!</p>
                <p>In the meantime, feel free to contact us for custom travel plans.</p>
                <%-- <a href="contact.jsp">Contact Us</a> --%>
            </div>
			<%
			}
			%>

		</div>
	</section>

	<%@ include file="footer.jsp"%>

</body>
</html>