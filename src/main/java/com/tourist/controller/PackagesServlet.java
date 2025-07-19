package com.tourist.controller;

import com.tourist.dao.*;	
import com.tourist.dto.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/PackageServlet")
public class PackagesServlet extends HttpServlet {

    private DestinationInterface destinationDAO = new DestinationImplementation();
    private ItineraryInterface itineraryDAO = new ItineraryImplementation();
    private RestaurantInterface restaurantDAO = new RestaurantImplementation();
    private ResortInterface resortDAO = new ResortImplementation();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int destinationId = Integer.parseInt(request.getParameter("destinationId"));

            // 1. Get Destination Details
            Destination destination = destinationDAO.getDestination(destinationId);

            // 2. Get Itineraries
            List<Itinerary> itineraries = itineraryDAO.getItineraryByDestinationId(destinationId);

            // 3. Get Restaurants
            List<Restaurant> restaurants = restaurantDAO.getRestaurantsByDestinationId(destinationId);

            // 4. Get Resorts
            List<Resort> resorts = resortDAO.getResortsByDestinationId(destinationId);

            // Set as request attributes
            request.setAttribute("destination", destination);
            request.setAttribute("itineraries", itineraries);
            request.setAttribute("restaurants", restaurants);
            request.setAttribute("resorts", resorts);

            // Forward to the dynamic package view
            RequestDispatcher dispatcher = request.getRequestDispatcher("package.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("exception", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
