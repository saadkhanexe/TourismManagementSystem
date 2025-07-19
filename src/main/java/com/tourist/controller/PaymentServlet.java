package com.tourist.controller;

import com.tourist.dao.*;
import com.tourist.dto.*;
import com.tourist.util.EmailUtil;
import com.tourist.util.PdfGeneratorUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.sql.Date;

@WebServlet("/paymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PaymentInterface paymentDAO = new PaymentImplementation();
    private BookingInterface bookingDAO = new BookingImplementation();
    private TouristInterface touristDAO = new TouristImplementation();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int bookingId = Integer.parseInt(request.getParameter("booking_id"));
            String paymentMethod = request.getParameter("payment");
            double amount = Double.parseDouble(request.getParameter("amount"));

            java.util.Date currentDate = new java.util.Date();
            Date sqlDate = new Date(currentDate.getTime());

            Payment payment = new Payment();
            payment.setBookingId(bookingId);
            payment.setPaymentMethod(paymentMethod);
            payment.setPaymentStatus("Pending"); // initially pending
            payment.setPaymentDate(sqlDate);
            payment.setAmount(amount);

            int paymentId = paymentDAO.insertPayment(payment);

            if (paymentId > 0) {
                // Simulate processing delay
                Thread.sleep(3000);

                // Update payment to success
                payment.setPaymentId(paymentId);
                payment.setPaymentStatus("Success");
                paymentDAO.updatePayment(payment);

                // Fetch booking and tourist email
                Booking booking = bookingDAO.getBooking(bookingId);
                Tourist tourist = touristDAO.getTourist(booking.getTourist_id());
                String toEmail = tourist.getEmail();

                // Generate PDF receipt
                File receiptPdf = File.createTempFile("receipt_" + bookingId, ".pdf");
                try (FileOutputStream fos = new FileOutputStream(receiptPdf)) {
                    PdfGeneratorUtil.generateReceiptPdf(fos, bookingId);
                }

                // Send email
                String subject = "Your Booking Receipt - Booking ID #" + bookingId;
                String message = "Dear " + tourist.getName() + ",\n\n" +
                        "Thank you for booking with us.\n" +
                        "Your payment of ₹" + amount + " via " + paymentMethod + " was successful.\n\n" +
                        "Booking ID: " + bookingId + "\nPayment Status: Success\n\n" +
                        "Please find your booking receipt attached.\n\nRegards,\nTourist Booking Team";

                EmailUtil.sendEmailWithAttachment(toEmail, subject, message, receiptPdf);

                receiptPdf.deleteOnExit(); // Clean up temp file

                // Redirect to confirmation JSP
                response.sendRedirect("booking.jsp?payment_id=" + paymentId);
            } else {
                response.sendRedirect("paymentError.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("paymentError.jsp");
        }
    }
}
