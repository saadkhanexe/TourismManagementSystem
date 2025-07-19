package com.tourist.dao;

import com.tourist.connector.Connections;
import com.tourist.dto.Payment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentImplementation implements PaymentInterface {

    Connection con = null;

    private void connect() {
        con = Connections.connector();
    }

    @Override
    public int insertPayment(Payment payment) {
        connect();
        String qry = "INSERT INTO payments (booking_id, payment_method, payment_date, payment_status, amount) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement pst = con.prepareStatement(qry, Statement.RETURN_GENERATED_KEYS)) {
            pst.setInt(1, payment.getBookingId());
            pst.setString(2, payment.getPaymentMethod());
            pst.setDate(3, payment.getPaymentDate());
            pst.setString(4, payment.getPaymentStatus());
            pst.setDouble(5, payment.getAmount());

            int affectedRows = pst.executeUpdate();

            if (affectedRows > 0) {
                ResultSet rs = pst.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);  // Return the generated payment_id
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }

    @Override
    public boolean updatePayment(Payment payment) {
        connect();
        String qry = "UPDATE payments SET booking_id=?, payment_method=?, payment_date=?, payment_status=?, amount=? WHERE payment_id=?";

        try (PreparedStatement pst = con.prepareStatement(qry)) {
            pst.setInt(1, payment.getBookingId());
            pst.setString(2, payment.getPaymentMethod());
            pst.setDate(3, payment.getPaymentDate());
            pst.setString(4, payment.getPaymentStatus());
            pst.setDouble(5, payment.getAmount());
            pst.setInt(6, payment.getPaymentId());

            return pst.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deletePayment(int paymentId) {
        connect();
        String qry = "DELETE FROM payments WHERE payment_id=?";

        try (PreparedStatement pst = con.prepareStatement(qry)) {
            pst.setInt(1, paymentId);
            return pst.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Payment getPayment(int paymentId) {
        connect();
        String qry = "SELECT * FROM payments WHERE payment_id=?";

        try (PreparedStatement pst = con.prepareStatement(qry)) {
            pst.setInt(1, paymentId);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                Payment p = new Payment();
                p.setPaymentId(rs.getInt("payment_id"));
                p.setBookingId(rs.getInt("booking_id"));
                p.setPaymentMethod(rs.getString("payment_method"));
                p.setPaymentDate(rs.getDate("payment_date"));
                p.setPaymentStatus(rs.getString("payment_status"));
                p.setAmount(rs.getDouble("amount"));
                return p;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<Payment> getAllPayments() {
        connect();
        List<Payment> list = new ArrayList<>();
        String qry = "SELECT * FROM payments";

        try (Statement stmt = con.createStatement()) {
            ResultSet rs = stmt.executeQuery(qry);

            while (rs.next()) {
                Payment p = new Payment();
                p.setPaymentId(rs.getInt("payment_id"));
                p.setBookingId(rs.getInt("booking_id"));
                p.setPaymentMethod(rs.getString("payment_method"));
                p.setPaymentDate(rs.getDate("payment_date"));
                p.setPaymentStatus(rs.getString("payment_status"));
                p.setAmount(rs.getDouble("amount"));
                list.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public List<Payment> getPaymentsByBookingId(int bookingId) {
        connect();
        List<Payment> list = new ArrayList<>();
        String qry = "SELECT * FROM payments WHERE booking_id=?";

        try (PreparedStatement pst = con.prepareStatement(qry)) {
            pst.setInt(1, bookingId);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Payment p = new Payment();
                p.setPaymentId(rs.getInt("payment_id"));
                p.setBookingId(rs.getInt("booking_id"));
                p.setPaymentMethod(rs.getString("payment_method"));
                p.setPaymentDate(rs.getDate("payment_date"));
                p.setPaymentStatus(rs.getString("payment_status"));
                p.setAmount(rs.getDouble("amount"));
                list.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
