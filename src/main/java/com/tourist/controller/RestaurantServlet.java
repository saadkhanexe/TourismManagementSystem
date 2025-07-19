package com.tourist.controller;

import com.tourist.dao.RestaurantImplementation;
import com.tourist.dao.RestaurantInterface;
import com.tourist.dto.Restaurant;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/restaurantServlet")
public class RestaurantServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RestaurantInterface restaurantDAO = new RestaurantImplementation();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession(); // ✅ for flash messages

        try {
            if ("add".equalsIgnoreCase(action)) {
                addRestaurant(request, response, session);
            } else if ("update".equalsIgnoreCase(action)) {
                updateRestaurant(request, response, session);
            } else if ("delete".equalsIgnoreCase(action)) {
                deleteRestaurant(request, response, session);
            } else {
                session.setAttribute("message", "Invalid action.");
                response.sendRedirect("adminDashboard.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Server Error: " + e.getMessage());
            response.sendRedirect("adminDashboard.jsp");
        }
    }

    private void addRestaurant(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        Restaurant restaurant = new Restaurant();
        restaurant.setName(request.getParameter("name").trim());
        restaurant.setDescription(request.getParameter("description").trim());
        restaurant.setCuisine_type(request.getParameter("cuisine_type").trim());
        restaurant.setRating(Double.parseDouble(request.getParameter("rating")));
        restaurant.setDestination_id(Integer.parseInt(request.getParameter("destination_id")));
        restaurant.setRestaurant_price(Double.parseDouble(request.getParameter("restaurant_price")));

        boolean inserted = restaurantDAO.insertData(restaurant);
        session.setAttribute("message", inserted ? "Restaurant added successfully!" : "Failed to add restaurant.");
        response.sendRedirect("adminDashboard.jsp");
    }

    private void updateRestaurant(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        Restaurant restaurant = new Restaurant();
        restaurant.setRestaurant_id(Integer.parseInt(request.getParameter("restaurant_id")));
        restaurant.setName(request.getParameter("name").trim());
        restaurant.setDescription(request.getParameter("description").trim());
        restaurant.setCuisine_type(request.getParameter("cuisine_type").trim());
        restaurant.setRating(Double.parseDouble(request.getParameter("rating")));
        restaurant.setDestination_id(Integer.parseInt(request.getParameter("destination_id")));
        restaurant.setRestaurant_price(Double.parseDouble(request.getParameter("restaurant_price")));

        boolean updated = restaurantDAO.updateData(restaurant);
        session.setAttribute("message", updated ? "Restaurant updated successfully!" : "Failed to update restaurant.");
        response.sendRedirect("adminDashboard.jsp");
    }

    private void deleteRestaurant(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        int restaurantId = Integer.parseInt(request.getParameter("restaurant_id"));

        Restaurant restaurant = new Restaurant();
        restaurant.setRestaurant_id(restaurantId);

        boolean deleted = restaurantDAO.deleteData(restaurant);
        session.setAttribute("message", deleted ? "Restaurant deleted successfully!" : "Failed to delete restaurant.");
        response.sendRedirect("adminDashboard.jsp");
    }
}
