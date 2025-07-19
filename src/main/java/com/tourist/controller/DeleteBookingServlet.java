package com.tourist.controller; // IMPORTANT: Adjust this package to match your project structure

import com.tourist.dao.BookingImplementation;
import com.tourist.dao.BookingInterface;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteBookingServlet") // This annotation maps this servlet to the URL "/deleteBookingServlet"
public class DeleteBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = 0;
        String message = "";
        String status = "error";

        try {
            bookingId = Integer.parseInt(request.getParameter("booking_id"));
            BookingInterface bookingDAO = new BookingImplementation();
            
            // IMPORTANT: For security and data integrity, you might want to uncomment these lines
            // to ensure only 'Cancelled' bookings can be deleted from here.
            // Booking bookingToDelete = bookingDAO.getBooking(bookingId); 
            // if (bookingToDelete != null && "Cancelled".equalsIgnoreCase(bookingToDelete.getStatus())) {

            boolean success = bookingDAO.deleteData(bookingId); // Use your existing deleteData method

            if (success) {
                message = "Booking " + bookingId + " has been successfully removed from records.";
                status = "success";
                System.out.println("DEBUG (DeleteBookingServlet): " + message);
            } else {
                message = "Failed to remove booking " + bookingId + ". It might not exist or could not be deleted.";
                System.err.println("ERROR (DeleteBookingServlet): " + message);
            }
            // } else {
            //    message = "Booking " + bookingId + " cannot be removed this way as it's not in a 'Cancelled' state.";
            //    System.err.println("ERROR (DeleteBookingServlet): " + message);
            // }

        } catch (NumberFormatException e) {
            message = "Invalid booking ID provided for removal.";
            System.err.println("ERROR (DeleteBookingServlet): Invalid ID: " + request.getParameter("booking_id") + " - " + e.getMessage());
        } catch (Exception e) {
            message = "An unexpected error occurred during booking removal.";
            e.printStackTrace();
            System.err.println("ERROR (DeleteBookingServlet): Exception: " + e.getMessage());
        }

        response.sendRedirect("myBookings.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8") + "&status=" + status);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}