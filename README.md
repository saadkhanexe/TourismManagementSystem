
# Tourism Management System 🚀

A full-stack web application for managing tourism bookings and packages, developed using Java, Servlets, JSP, and MySQL. The system includes admin and user functionalities, dynamic package options, and booking management.

## 🌐 Live Website

**Visit here**: [http://saad-travels.onrender.com](http://saad-travels.onrender.com)

## 📂 Project Structure

```
TourismManagementSystem/
├── src/                   # Java source code (Servlets, DTOs, DAO)
├── WebContent/            # JSP pages, HTML, CSS, JS
├── target/                # WAR build output (excluded via .gitignore)
├── Dockerfile             # Docker configuration for deployment
├── .gitignore             # Git ignored files/folders
└── README.md              # Project description
```

## 👨‍💻 Features

### 🧳 User Side:
- Browse destinations with images, pricing, and ratings.
- View detailed itineraries, resorts, and restaurants for each package.
- Dynamic selection of trip duration and package components.
- Total price auto-calculation.
- Booking request with user details (name, contact, email).
- Booking confirmation upon admin approval.

### 🛠️ Admin Side:
- Admin login and dashboard access.
- Add, update, delete destinations, itineraries, resorts, and restaurants.
- View and manage booking requests.

## 🛠️ Tech Stack

- **Frontend**: HTML, CSS, JavaScript, JSP
- **Backend**: Java, Servlets, JDBC
- **Database**: MySQL
- **Deployment**: Docker, Render
- **Build Tool**: Maven

## 🐳 Docker Deployment Steps

1. Clone this repository:
   ```bash
   git clone https://github.com/saadkhanexe/TourismManagementSystem.git
   cd TourismManagementSystem
   ```

2. Build Docker image:
   ```bash
   docker build -t tourism-app .
   ```

3. Run Docker container:
   ```bash
   docker run -p 8080:8080 tourism-app
   ```

4. Open in browser:
   ```
   http://localhost:8080/TourismManagementSystem
   ```

## 🗃️ Database Configuration

- Create a MySQL database and import required tables:
  - `admin`, `bookings`, `destinations`, `itinerary`, `resorts`, `restaurants`, `tourist`
- Update DB credentials in `DBConnection.java`.

## 📄 License

This project is licensed under the MIT License - feel free to use, share, and improve it.

---

**Developed by [Saad Ahmed Khan](https://github.com/saadkhanexe)  && [Abdul Azeez] (https://github.com/azzy-techno)** 
