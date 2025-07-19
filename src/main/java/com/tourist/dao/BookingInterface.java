package com.tourist.dao;

import java.util.List;
import com.tourist.dto.Booking;

public interface BookingInterface {

    // Add a new booking
    int insertData(Booking booking);

    // Update an existing booking
    boolean updateData(Booking booking);

    // Delete a booking by ID
    boolean deleteData(int bookingId);

    // Get a specific booking by ID
    Booking getBooking(int bookingId);

    // Get a list of all bookings
    List<Booking> getAllBookings();
    
    List<Booking> getBookingsByUserId(int userId);
    
    boolean updateBookingStatus(int bookingId, String newStatus);
    
    

}
