package com.tourist.dao;

import com.tourist.dto.Payment;
import java.util.List;

public interface PaymentInterface {

    // Insert a new payment
    int insertPayment(Payment payment);

    // Update an existing payment
    boolean updatePayment(Payment payment);

    // Delete a payment by ID
    boolean deletePayment(int paymentId);

    // Get a single payment by ID
    Payment getPayment(int paymentId);

    // Get all payments
    List<Payment> getAllPayments();

    // Get payments by booking ID (optional but useful)
    List<Payment> getPaymentsByBookingId(int bookingId);
}
