package com.tourist.controller; // Adjust package as per your servlet location

import com.tourist.dao.BookingImplementation;
import com.tourist.dao.BookingInterface;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/cancelBookingServlet") // This maps the servlet to the URL /cancelBookingServlet
public class CancelBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = 0;
        String message = "";
        String status = "error"; // For success/error message display

        try {
            bookingId = Integer.parseInt(request.getParameter("booking_id"));
            BookingInterface bookingDAO = new BookingImplementation();
            
            // Step 1: Update the booking status to "Cancelled"
            boolean cancelSuccess = bookingDAO.updateBookingStatus(bookingId, "Cancelled"); 

            if (cancelSuccess) {
                // Step 2: If cancellation was successful, now delete the booking record
                boolean deleteSuccess = bookingDAO.deleteData(bookingId); // Using your existing deleteData method

                if (deleteSuccess) {
                    message = "Booking " + bookingId + " has been successfully cancelled and removed.";
                    status = "success";
                    System.out.println(message); // For server logs
                } else {
                    // This scenario means status updated, but deletion failed. Critical to log.
                    message = "Booking " + bookingId + " status changed to Cancelled, but failed to remove record.";
                    status = "error"; // Still an error as full operation didn't complete
                    System.err.println(message); // For server logs
                }
            } else {
                message = "Failed to cancel booking " + bookingId + ". It might not exist or already be cancelled.";
                System.err.println(message); // For server logs
            }

        } catch (NumberFormatException e) {
            message = "Invalid booking ID provided.";
            System.err.println("Invalid booking ID for cancellation/deletion: " + request.getParameter("booking_id") + " - " + e.getMessage());
        } catch (Exception e) {
            message = "An unexpected error occurred during booking cancellation and removal.";
            e.printStackTrace(); // Log full stack trace for debugging
            System.err.println("Error in CancelBookingServlet: " + e.getMessage());
        }

        // Redirect back to myBookings.jsp with a message
        response.sendRedirect("myBookings.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8") + "&status=" + status);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}