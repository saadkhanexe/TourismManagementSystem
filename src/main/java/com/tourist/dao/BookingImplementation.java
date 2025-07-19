package com.tourist.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.tourist.connector.Connections;
import com.tourist.dto.Booking;

public class BookingImplementation implements BookingInterface {

    Connection con = null;

    public void connect() {
        con = Connections.connector();
    }

    // Calculates total price from resort, restaurant, and itinerary
    private double calculatePrice(int resortId, int restaurantId, int itineraryId) {
        double total = 0;

        try {
            connect();

            String resortQuery = "SELECT resort_price FROM resorts WHERE resort_id = ?";
            try (PreparedStatement pst = con.prepareStatement(resortQuery)) {
                pst.setInt(1, resortId);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    total += rs.getDouble("resort_price");
                }
            }

            String restaurantQuery = "SELECT restaurant_price FROM restaurants WHERE restaurant_id = ?";
            try (PreparedStatement pst = con.prepareStatement(restaurantQuery)) {
                pst.setInt(1, restaurantId);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    total += rs.getDouble("restaurant_price");
                }
            }

            String itineraryQuery = "SELECT itinerary_price FROM itineraries WHERE itinerary_id = ?";
            try (PreparedStatement pst = con.prepareStatement(itineraryQuery)) {
                pst.setInt(1, itineraryId);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    total += rs.getDouble("itinerary_price");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }

    @Override
    public int insertData(Booking b) {
        connect();
        String qry = "INSERT INTO bookings (tourist_id, destination_id, resort_id, restaurant_id, itinerary_id, booking_date, status, price, remarks) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        double price = calculatePrice(b.getResort_id(), b.getRestaurant_id(), b.getItinerary_id());

        try (PreparedStatement ptst = con.prepareStatement(qry, Statement.RETURN_GENERATED_KEYS)) {
            ptst.setInt(1, b.getTourist_id());
            ptst.setInt(2, b.getDestination_id());
            ptst.setInt(3, b.getResort_id());
            ptst.setInt(4, b.getRestaurant_id());
            ptst.setInt(5, b.getItinerary_id());
            ptst.setDate(6, b.getBooking_date());
            ptst.setString(7, b.getStatus());
            ptst.setDouble(8, price);
            ptst.setString(9, b.getRemarks());

            int affectedRows = ptst.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = ptst.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }

    @Override
    public boolean updateData(Booking b) {
        connect();
        String qry = "UPDATE bookings SET tourist_id=?, destination_id=?, resort_id=?, restaurant_id=?, itinerary_id=?, booking_date=?, status=?, price=?, remarks=? WHERE booking_id=?";

        double price = calculatePrice(b.getResort_id(), b.getRestaurant_id(), b.getItinerary_id());

        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ptst.setInt(1, b.getTourist_id());
            ptst.setInt(2, b.getDestination_id());
            ptst.setInt(3, b.getResort_id());
            ptst.setInt(4, b.getRestaurant_id());
            ptst.setInt(5, b.getItinerary_id());
            ptst.setDate(6, b.getBooking_date());
            ptst.setString(7, b.getStatus());
            ptst.setDouble(8, price);
            ptst.setString(9, b.getRemarks());
            ptst.setInt(10, b.getBookingId());

            return ptst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteData(int id) {
        connect();
        String qry = "DELETE FROM bookings WHERE booking_id=?";
        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ptst.setInt(1, id);
            return ptst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Booking> getAllBookings() {
        connect();
        List<Booking> list = new ArrayList<>();
        String qry = "SELECT * FROM bookings";
        try (Statement stmt = con.createStatement()) {
            ResultSet rs = stmt.executeQuery(qry);
            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getInt("booking_id"));
                b.setTourist_id(rs.getInt("tourist_id"));
                b.setDestination_id(rs.getInt("destination_id"));
                b.setResort_id(rs.getInt("resort_id"));
                b.setRestaurant_id(rs.getInt("restaurant_id"));
                b.setItinerary_id(rs.getInt("itinerary_id"));
                b.setBooking_date(rs.getDate("booking_date"));
                b.setStatus(rs.getString("status"));
                b.setPrice(rs.getDouble("price"));
                b.setRemarks(rs.getString("remarks"));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Booking getBooking(int id) {
        connect();
        String qry = "SELECT * FROM bookings WHERE booking_id=?";
        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ptst.setInt(1, id);
            ResultSet rs = ptst.executeQuery();
            if (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getInt("booking_id"));
                b.setTourist_id(rs.getInt("tourist_id"));
                b.setDestination_id(rs.getInt("destination_id"));
                b.setResort_id(rs.getInt("resort_id"));
                b.setRestaurant_id(rs.getInt("restaurant_id"));
                b.setItinerary_id(rs.getInt("itinerary_id"));
                b.setBooking_date(rs.getDate("booking_date"));
                b.setStatus(rs.getString("status"));
                b.setPrice(rs.getDouble("price"));
                b.setRemarks(rs.getString("remarks"));
                return b;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Booking> getBookingsByUserId(int userId) {
        connect();
        List<Booking> bookings = new ArrayList<>();
        String qry = "SELECT * FROM bookings WHERE tourist_id = ?";

        try (PreparedStatement ps = con.prepareStatement(qry)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getInt("booking_id"));
                b.setTourist_id(rs.getInt("tourist_id"));
                b.setDestination_id(rs.getInt("destination_id"));
                b.setResort_id(rs.getInt("resort_id"));
                b.setRestaurant_id(rs.getInt("restaurant_id"));
                b.setItinerary_id(rs.getInt("itinerary_id"));
                b.setBooking_date(rs.getDate("booking_date"));
                b.setStatus(rs.getString("status"));
                b.setPrice(rs.getDouble("price"));
                b.setRemarks(rs.getString("remarks"));
                bookings.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return bookings;
    }
    
    
    @Override
    public boolean updateBookingStatus(int bookingId, String newStatus) {
    	connect();
        String query = "UPDATE bookings SET status = ? WHERE booking_id = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, newStatus);
            ps.setInt(2, bookingId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Returns true if at least one row was updated
        } catch (SQLException e) {
            e.printStackTrace();
            // Log the error for debugging
            System.err.println("SQL Error updating booking status: " + e.getMessage());
            return false;
        }
    }
}
