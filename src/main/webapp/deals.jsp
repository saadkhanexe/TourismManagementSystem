<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="sessionCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Amazing Deals!</title>
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
            color: #e0e0e0;
            font-family: 'Roboto', sans-serif;
            line-height: 1.6;
            
            /* Flexbox for full page layout: stacks children vertically */
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensure body takes at least full viewport height */
        }

        /* HEADER AND FOOTER ARE DIRECT CHILDREN OF BODY.
           THE MAIN CONTENT CONTAINER MUST GROW TO PUSH FOOTER DOWN. */
        .deals-container {
            flex-grow: 1; /* THIS IS KEY: Makes this container expand to fill available space */
            padding: 40px;
            max-width: 900px;
            margin: 40px auto;
            background-color: #1f1f1f;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5),
                        0 0 0 5px rgba(218, 165, 32, 0.1);
            animation: fadeIn 0.8s ease-out;
            
            /* Center content within the container itself */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h1 {
            color: goldenrod;
            font-family: 'Montserrat', sans-serif;
            font-size: 2.8em;
            margin-bottom: 30px;
            letter-spacing: 2px;
            text-shadow: 0 0 15px rgba(218, 165, 32, 0.5);
        }

        .no-deals-message {
            background-color: #2a2a2a;
            padding: 50px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.4);
            border: 1px solid #3a3a3a;
            max-width: 600px;
            width: 100%;
            margin-top: 20px;
        }

        .no-deals-message h2 {
            color: sienna;
            font-family: 'Montserrat', sans-serif;
            font-size: 2.2em;
            margin-bottom: 20px;
        }

        .no-deals-message p {
            font-size: 1.2em;
            color: #c0c0c0;
            margin-bottom: 30px;
        }

        .no-deals-message a {
            display: inline-block;
            background-color: goldenrod;
            color: #1a1a1a;
            padding: 12px 25px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .no-deals-message a:hover {
            background-color: #e6b800;
            transform: translateY(-2px);
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .deals-container {
                padding: 20px;
                margin: 20px auto;
            }
            h1 {
                font-size: 2.2em;
                margin-bottom: 20px;
            }
            .no-deals-message {
                padding: 30px;
            }
            .no-deals-message h2 {
                font-size: 1.8em;
            }
            .no-deals-message p {
                font-size: 1em;
            }
        }
    </style>
</head>
<body>

    <%@ include file="navigation.jsp"%>

    <div class="deals-container">
        <h1>Exclusive Deals & Offers!</h1>

        <div class="no-deals-message">
            <h2>No Hot Deals Right Now!</h2>
            <p>We're brewing up some exciting new offers, but it looks like our deal pot is currently empty.</p>
            <p>Please check back later for amazing discounts on your next adventure!</p>
            <a href="destination.jsp">Explore Destinations Instead</a>
        </div>
    </div>

    <%@ include file="footer.jsp"%>
</body>
</html>