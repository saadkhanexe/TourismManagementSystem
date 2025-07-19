package com.tourist.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.tourist.connector.Connections;
import com.tourist.dto.Destination;

public class DestinationImplementation implements DestinationInterface {

    Connection con = null;

    public void connect() {
        con = Connections.connector();
    }

    @Override
    public boolean insertData(Destination d) {
        connect();
        String qry = "INSERT INTO destinations(destination_name, destination_description, destination_paragraph, destination_price, destination_image, destination_rating) VALUES(?,?,?,?,?,?)";
        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ptst.setString(1, d.getDestination_name());
            ptst.setString(2, d.getDestination_description());
            ptst.setString(3, d.getDestination_paragraph());
            ptst.setDouble(4, d.getDestination_price());
            ptst.setString(5, d.getDestination_image());
            ptst.setString(6, d.getDestination_rating());
            return ptst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateData(Destination d) {
        connect();
        String qry = "UPDATE destinations SET destination_name=?, destination_description=?, destination_paragraph=?, destination_price=?, destination_image=?, destination_rating=? WHERE destination_id=?";
        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ptst.setString(1, d.getDestination_name());
            ptst.setString(2, d.getDestination_description());
            ptst.setString(3, d.getDestination_paragraph());
            ptst.setDouble(4, d.getDestination_price());
            ptst.setString(5, d.getDestination_image());
            ptst.setString(6, d.getDestination_rating());
            ptst.setInt(7, d.getDestination_id());
            return ptst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteData(int id) {
        connect();
        String qry = "DELETE FROM destinations WHERE destination_id=?";
        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ptst.setInt(1, id);
            return ptst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Destination getDestination(int id) {
        connect();
        String qry = "SELECT * FROM destinations WHERE destination_id=?";
        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ptst.setInt(1, id);
            ResultSet rs = ptst.executeQuery();
            if (rs.next()) {
                Destination d = new Destination();
                d.setDestination_id(rs.getInt("destination_id"));
                d.setDestination_name(rs.getString("destination_name"));
                d.setDestination_description(rs.getString("destination_description"));
                d.setDestination_paragraph(rs.getString("destination_paragraph"));
                d.setDestination_price(rs.getDouble("destination_price"));
                d.setDestination_image(rs.getString("destination_image"));
                d.setDestination_rating(rs.getString("destination_rating"));
                return d;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Destination> getAllDestinations() {
        connect();
        List<Destination> list = new ArrayList<>();
        String qry = "SELECT * FROM destinations";
        try (Statement stmt = con.createStatement()) {
            ResultSet rs = stmt.executeQuery(qry);
            while (rs.next()) {
                Destination d = new Destination();
                d.setDestination_id(rs.getInt("destination_id"));
                d.setDestination_name(rs.getString("destination_name"));
                d.setDestination_description(rs.getString("destination_description"));
                d.setDestination_paragraph(rs.getString("destination_paragraph"));
                d.setDestination_price(rs.getDouble("destination_price"));
                d.setDestination_image(rs.getString("destination_image"));
                d.setDestination_rating(rs.getString("destination_rating"));
                list.add(d);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
