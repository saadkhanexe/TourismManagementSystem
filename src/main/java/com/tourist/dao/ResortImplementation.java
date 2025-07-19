package com.tourist.dao;

import com.tourist.connector.Connections;
import com.tourist.dto.Resort;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResortImplementation implements ResortInterface {

    Connection con = null;

    public void connect() {
        con = Connections.connector();
    }

    @Override
    public boolean insertData(Resort resort) {
        connect();
        String qry = "INSERT INTO resorts (destination_id, name, description, type, rating, resort_price) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ptst.setInt(1, resort.getDestination_id());
            ptst.setString(2, resort.getName());
            ptst.setString(3, resort.getDescription());
            ptst.setString(4, resort.getType());
            ptst.setDouble(5, resort.getRating());
            ptst.setDouble(6, resort.getResort_price()); // NEW
            return ptst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateData(Resort resort) {
        connect();
        String qry = "UPDATE resorts SET name = ?, description = ?, type = ?, rating = ?, resort_price = ? WHERE resort_id = ?";
        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ptst.setString(1, resort.getName());
            ptst.setString(2, resort.getDescription());
            ptst.setString(3, resort.getType());
            ptst.setDouble(4, resort.getRating());
            ptst.setDouble(5, resort.getResort_price()); // NEW
            ptst.setInt(6, resort.getResort_id());
            return ptst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteData(Resort resort) {
        connect();
        String qry = "DELETE FROM resorts WHERE resort_id = ?";
        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ptst.setInt(1, resort.getResort_id());
            return ptst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Resort getResort(int id) {
        connect();
        String qry = "SELECT * FROM resorts WHERE resort_id = ?";
        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ptst.setInt(1, id);
            ResultSet rs = ptst.executeQuery();
            if (rs.next()) {
                Resort resort = new Resort();
                resort.setResort_id(rs.getInt("resort_id"));
                resort.setDestination_id(rs.getInt("destination_id"));
                resort.setName(rs.getString("name"));
                resort.setDescription(rs.getString("description"));
                resort.setType(rs.getString("type"));
                resort.setRating(rs.getDouble("rating"));
                resort.setResort_price(rs.getDouble("resort_price")); // NEW
                return resort;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Resort> getResortsByDestinationId(int destinationId) {
        connect();
        List<Resort> resorts = new ArrayList<>();
        String qry = "SELECT * FROM resorts WHERE destination_id = ?";
        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ptst.setInt(1, destinationId);
            ResultSet rs = ptst.executeQuery();
            while (rs.next()) {
                Resort resort = new Resort();
                resort.setResort_id(rs.getInt("resort_id"));
                resort.setDestination_id(rs.getInt("destination_id"));
                resort.setName(rs.getString("name"));
                resort.setDescription(rs.getString("description"));
                resort.setType(rs.getString("type"));
                resort.setRating(rs.getDouble("rating"));
                resort.setResort_price(rs.getDouble("resort_price")); // NEW
                resorts.add(resort);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resorts;
    }

    @Override
    public List<Resort> getAllResorts() {
        connect();
        List<Resort> resorts = new ArrayList<>();
        String qry = "SELECT * FROM resorts";
        try (Statement stmt = con.createStatement()) {
            ResultSet rs = stmt.executeQuery(qry);
            while (rs.next()) {
                Resort resort = new Resort();
                resort.setResort_id(rs.getInt("resort_id"));
                resort.setDestination_id(rs.getInt("destination_id"));
                resort.setName(rs.getString("name"));
                resort.setDescription(rs.getString("description"));
                resort.setType(rs.getString("type"));
                resort.setRating(rs.getDouble("rating"));
                resort.setResort_price(rs.getDouble("resort_price")); // NEW
                resorts.add(resort);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resorts;
    }
}
