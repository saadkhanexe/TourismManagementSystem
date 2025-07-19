package com.tourist.dao;

import com.tourist.connector.Connections;
import com.tourist.dto.Itinerary;

import java.sql.*;
import java.util.*;

public class ItineraryImplementation implements ItineraryInterface {

    Connection conn = null;

    public void connect() {
        conn = Connections.connector();
    }

    @Override
    public boolean addItinerary(Itinerary itinerary) {
        connect();
        try {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO itinerary (itinerary_day1, itinerary_day1_description, itinerary_day2, itinerary_day2_description, itinerary_day3, itinerary_day3_description, itinerary_day4, itinerary_day4_description, itinerary_day5, itinerary_day5_description, itinerary_price, destination_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
            );
            ps.setString(1, itinerary.getItinerary_day1());
            ps.setString(2, itinerary.getItinerary_day1_description());
            ps.setString(3, itinerary.getItinerary_day2());
            ps.setString(4, itinerary.getItinerary_day2_description());
            ps.setString(5, itinerary.getItinerary_day3());
            ps.setString(6, itinerary.getItinerary_day3_description());
            ps.setString(7, itinerary.getItinerary_day4());
            ps.setString(8, itinerary.getItinerary_day4_description());
            ps.setString(9, itinerary.getItinerary_day5());
            ps.setString(10, itinerary.getItinerary_day5_description());
            ps.setDouble(11, itinerary.getItinerary_price());
            ps.setInt(12, itinerary.getDestination_id());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateItinerary(Itinerary itinerary) {
        connect();
        try {
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE itinerary SET itinerary_day1=?, itinerary_day1_description=?, itinerary_day2=?, itinerary_day2_description=?, itinerary_day3=?, itinerary_day3_description=?, itinerary_day4=?, itinerary_day4_description=?, itinerary_day5=?, itinerary_day5_description=?, itinerary_price=?, destination_id=? WHERE itinerary_id=?"
            );
            ps.setString(1, itinerary.getItinerary_day1());
            ps.setString(2, itinerary.getItinerary_day1_description());
            ps.setString(3, itinerary.getItinerary_day2());
            ps.setString(4, itinerary.getItinerary_day2_description());
            ps.setString(5, itinerary.getItinerary_day3());
            ps.setString(6, itinerary.getItinerary_day3_description());
            ps.setString(7, itinerary.getItinerary_day4());
            ps.setString(8, itinerary.getItinerary_day4_description());
            ps.setString(9, itinerary.getItinerary_day5());
            ps.setString(10, itinerary.getItinerary_day5_description());
            ps.setDouble(11, itinerary.getItinerary_price());
            ps.setInt(12, itinerary.getDestination_id());
            ps.setInt(13, itinerary.getItinerary_id());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteItinerary(int itineraryId) {
        connect();
        try {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM itinerary WHERE itinerary_id=?");
            ps.setInt(1, itineraryId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Itinerary> getAllItineraries() {
        connect();
        List<Itinerary> list = new ArrayList<>();
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM itinerary");
            while (rs.next()) {
                Itinerary i = new Itinerary();
                i.setItinerary_id(rs.getInt("itinerary_id"));
                i.setItinerary_day1(rs.getString("itinerary_day1"));
                i.setItinerary_day1_description(rs.getString("itinerary_day1_description"));
                i.setItinerary_day2(rs.getString("itinerary_day2"));
                i.setItinerary_day2_description(rs.getString("itinerary_day2_description"));
                i.setItinerary_day3(rs.getString("itinerary_day3"));
                i.setItinerary_day3_description(rs.getString("itinerary_day3_description"));
                i.setItinerary_day4(rs.getString("itinerary_day4"));
                i.setItinerary_day4_description(rs.getString("itinerary_day4_description"));
                i.setItinerary_day5(rs.getString("itinerary_day5"));
                i.setItinerary_day5_description(rs.getString("itinerary_day5_description"));
                i.setItinerary_price(rs.getDouble("itinerary_price"));
                i.setDestination_id(rs.getInt("destination_id"));
                list.add(i);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Itinerary> getItineraryByDestinationId(int destinationId) {
        connect();
        List<Itinerary> list = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM itinerary WHERE destination_id=?");
            ps.setInt(1, destinationId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Itinerary i = new Itinerary();
                i.setItinerary_id(rs.getInt("itinerary_id"));
                i.setItinerary_day1(rs.getString("itinerary_day1"));
                i.setItinerary_day1_description(rs.getString("itinerary_day1_description"));
                i.setItinerary_day2(rs.getString("itinerary_day2"));
                i.setItinerary_day2_description(rs.getString("itinerary_day2_description"));
                i.setItinerary_day3(rs.getString("itinerary_day3"));
                i.setItinerary_day3_description(rs.getString("itinerary_day3_description"));
                i.setItinerary_day4(rs.getString("itinerary_day4"));
                i.setItinerary_day4_description(rs.getString("itinerary_day4_description"));
                i.setItinerary_day5(rs.getString("itinerary_day5"));
                i.setItinerary_day5_description(rs.getString("itinerary_day5_description"));
                i.setItinerary_price(rs.getDouble("itinerary_price"));
                i.setDestination_id(rs.getInt("destination_id"));
                list.add(i);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Itinerary getSingleItineraryByDestinationId(int destinationId) {
        connect();
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM itinerary WHERE destination_id=? LIMIT 1");
            ps.setInt(1, destinationId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Itinerary i = new Itinerary();
                i.setItinerary_id(rs.getInt("itinerary_id"));
                i.setItinerary_day1(rs.getString("itinerary_day1"));
                i.setItinerary_day1_description(rs.getString("itinerary_day1_description"));
                i.setItinerary_day2(rs.getString("itinerary_day2"));
                i.setItinerary_day2_description(rs.getString("itinerary_day2_description"));
                i.setItinerary_day3(rs.getString("itinerary_day3"));
                i.setItinerary_day3_description(rs.getString("itinerary_day3_description"));
                i.setItinerary_day4(rs.getString("itinerary_day4"));
                i.setItinerary_day4_description(rs.getString("itinerary_day4_description"));
                i.setItinerary_day5(rs.getString("itinerary_day5"));
                i.setItinerary_day5_description(rs.getString("itinerary_day5_description"));
                i.setItinerary_price(rs.getDouble("itinerary_price"));
                i.setDestination_id(rs.getInt("destination_id"));
                return i;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Itinerary getItineraryById(int itineraryId) {
        connect();
        Itinerary i = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM itinerary WHERE itinerary_id=?");
            ps.setInt(1, itineraryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                i = new Itinerary();
                i.setItinerary_id(rs.getInt("itinerary_id"));
                i.setItinerary_day1(rs.getString("itinerary_day1"));
                i.setItinerary_day1_description(rs.getString("itinerary_day1_description"));
                i.setItinerary_day2(rs.getString("itinerary_day2"));
                i.setItinerary_day2_description(rs.getString("itinerary_day2_description"));
                i.setItinerary_day3(rs.getString("itinerary_day3"));
                i.setItinerary_day3_description(rs.getString("itinerary_day3_description"));
                i.setItinerary_day4(rs.getString("itinerary_day4"));
                i.setItinerary_day4_description(rs.getString("itinerary_day4_description"));
                i.setItinerary_day5(rs.getString("itinerary_day5"));
                i.setItinerary_day5_description(rs.getString("itinerary_day5_description"));
                i.setItinerary_price(rs.getDouble("itinerary_price"));
                i.setDestination_id(rs.getInt("destination_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }
}
