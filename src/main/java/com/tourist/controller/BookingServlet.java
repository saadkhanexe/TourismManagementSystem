package com.tourist.controller;

import com.tourist.dao.BookingInterface;
import com.tourist.dao.BookingImplementation;
import com.tourist.dto.Booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.sql.Date;

@WebServlet("/bookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingInterface bookingDAO = new BookingImplementation();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("home.jsp");
            return;
        }

        switch (action) {
            case "add":
                addBooking(request, response);
                break;
            case "update":
                updateBooking(request, response);
                break;
            case "delete":
                deleteBooking(request, response);
                break;
            default:
                response.sendRedirect("home.jsp");
        }
    }

    private void addBooking(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user_id") == null) {
                response.sendRedirect("index.jsp");
                return;
            }

            int userId = (Integer) session.getAttribute("user_id");
            int destinationId = Integer.parseInt(request.getParameter("destination_id"));
            int resortId = Integer.parseInt(request.getParameter("resort_id"));
            int restaurantId = Integer.parseInt(request.getParameter("restaurant_id"));
            int itineraryId = Integer.parseInt(request.getParameter("itinerary_id"));
            String bookingDateStr = request.getParameter("booking_date");
            String status = request.getParameter("status");

            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date utilDate = formatter.parse(bookingDateStr);
            Date sqlDate = new Date(utilDate.getTime());

            Booking booking = new Booking();
            booking.setTourist_id(userId);
            booking.setDestination_id(destinationId);
            booking.setResort_id(resortId);
            booking.setRestaurant_id(restaurantId);
            booking.setItinerary_id(itineraryId);
            booking.setBooking_date(sqlDate);
            booking.setStatus(status);

            int bookingId = bookingDAO.insertData(booking);

            if (bookingId > 0) {
                response.sendRedirect("bookingConfirmation.jsp?booking_id=" + bookingId);
            } else {
                response.sendRedirect("bookingError.jsp");
            }

        } catch (ParseException | NumberFormatException e) {
            getServletContext().log("Error adding booking: ", e);
            response.sendRedirect("bookingError.jsp");
        }
    }

    private void updateBooking(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("booking_id"));
            int userId = Integer.parseInt(request.getParameter("user_id"));
            int destinationId = Integer.parseInt(request.getParameter("destination_id"));
            int resortId = Integer.parseInt(request.getParameter("resort_id"));
            int restaurantId = Integer.parseInt(request.getParameter("restaurant_id"));
            int itineraryId = Integer.parseInt(request.getParameter("itinerary_id"));
            String bookingDateStr = request.getParameter("booking_date");
            String status = request.getParameter("status");

            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date utilDate = formatter.parse(bookingDateStr);
            Date sqlDate = new Date(utilDate.getTime());

            Booking booking = new Booking();
            booking.setBookingId(bookingId);
            booking.setTourist_id(userId);
            booking.setDestination_id(destinationId);
            booking.setResort_id(resortId);
            booking.setRestaurant_id(restaurantId);
            booking.setItinerary_id(itineraryId);
            booking.setBooking_date(sqlDate);
            booking.setStatus(status);

            bookingDAO.updateData(booking);
            response.sendRedirect("adminDashboard.jsp");

        } catch (ParseException | NumberFormatException e) {
            getServletContext().log("Error updating booking: ", e);
            response.sendRedirect("adminDashboard.jsp");
        }
    }

    private void deleteBooking(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("booking_id"));
            bookingDAO.deleteData(bookingId);
            response.sendRedirect("adminDashboard.jsp");
        } catch (Exception e) {
            getServletContext().log("Error deleting booking: ", e);
            response.sendRedirect("adminDashboard.jsp");
        }
    }
}
