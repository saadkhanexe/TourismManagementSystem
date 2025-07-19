package com.tourist.dao;

import com.tourist.connector.Connections;
import com.tourist.dto.Restaurant;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RestaurantImplementation implements RestaurantInterface {

    Connection con = null;

    public void connect() {
        con = Connections.connector();
    }

    @Override
    public boolean insertData(Restaurant restaurant) {
        connect();
        String qry = "INSERT INTO restaurants (destination_id, name, description, cuisine_type, rating, restaurant_price) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ptst.setInt(1, restaurant.getDestination_id());
            ptst.setString(2, restaurant.getName());
            ptst.setString(3, restaurant.getDescription());
            ptst.setString(4, restaurant.getCuisine_type());
            ptst.setDouble(5, restaurant.getRating());
            ptst.setDouble(6, restaurant.getRestaurant_price()); // ✅ Newly added
            return ptst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteData(Restaurant restaurant) {
        connect();
        String qry = "DELETE FROM restaurants WHERE restaurant_id = ?";
        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ptst.setInt(1, restaurant.getRestaurant_id());
            return ptst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateData(Restaurant restaurant) {
        connect();
        String qry = "UPDATE restaurants SET name = ?, description = ?, cuisine_type = ?, rating = ?, restaurant_price = ? WHERE restaurant_id = ?";
        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ptst.setString(1, restaurant.getName());
            ptst.setString(2, restaurant.getDescription());
            ptst.setString(3, restaurant.getCuisine_type());
            ptst.setDouble(4, restaurant.getRating());
            ptst.setDouble(5, restaurant.getRestaurant_price()); // ✅ Newly added
            ptst.setInt(6, restaurant.getRestaurant_id());
            return ptst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Restaurant getRestaurant(int id) {
        connect();
        String qry = "SELECT * FROM restaurants WHERE restaurant_id = ?";
        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ptst.setInt(1, id);
            ResultSet rs = ptst.executeQuery();
            if (rs.next()) {
                Restaurant r = new Restaurant();
                r.setRestaurant_id(rs.getInt("restaurant_id"));
                r.setDestination_id(rs.getInt("destination_id"));
                r.setName(rs.getString("name"));
                r.setDescription(rs.getString("description"));
                r.setCuisine_type(rs.getString("cuisine_type"));
                r.setRating(rs.getDouble("rating"));
                r.setRestaurant_price(rs.getDouble("restaurant_price")); // ✅ Newly added
                return r;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Restaurant> getRestaurantsByDestinationId(int destinationId) {
        connect();
        List<Restaurant> list = new ArrayList<>();
        String qry = "SELECT * FROM restaurants WHERE destination_id = ?";
        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ptst.setInt(1, destinationId);
            ResultSet rs = ptst.executeQuery();
            while (rs.next()) {
                Restaurant r = new Restaurant();
                r.setRestaurant_id(rs.getInt("restaurant_id"));
                r.setDestination_id(rs.getInt("destination_id"));
                r.setName(rs.getString("name"));
                r.setDescription(rs.getString("description"));
                r.setCuisine_type(rs.getString("cuisine_type"));
                r.setRating(rs.getDouble("rating"));
                r.setRestaurant_price(rs.getDouble("restaurant_price")); // ✅ Newly added
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Restaurant> getAllRestaurants() {
        connect();
        List<Restaurant> list = new ArrayList<>();
        String qry = "SELECT * FROM restaurants";
        try (PreparedStatement ptst = con.prepareStatement(qry)) {
            ResultSet rs = ptst.executeQuery();
            while (rs.next()) {
                Restaurant r = new Restaurant();
                r.setRestaurant_id(rs.getInt("restaurant_id"));
                r.setDestination_id(rs.getInt("destination_id"));
                r.setName(rs.getString("name"));
                r.setDescription(rs.getString("description"));
                r.setCuisine_type(rs.getString("cuisine_type"));
                r.setRating(rs.getDouble("rating"));
                r.setRestaurant_price(rs.getDouble("restaurant_price")); // ✅ Newly added
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
