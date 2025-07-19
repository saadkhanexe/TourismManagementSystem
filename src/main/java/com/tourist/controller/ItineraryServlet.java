package com.tourist.controller;

import com.tourist.dao.ItineraryImplementation;
import com.tourist.dao.ItineraryInterface;
import com.tourist.dto.Itinerary;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/itineraryServlet")
public class ItineraryServlet extends HttpServlet {

    private ItineraryInterface itineraryDAO = new ItineraryImplementation();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        boolean result = false;

        try {
            switch (action) {
                case "add":
                    result = addItinerary(request);
                    request.getSession().setAttribute("message", result ? "Itinerary added successfully!" : "Failed to add itinerary.");
                    break;
                case "update":
                    result = updateItinerary(request);
                    request.getSession().setAttribute("message", result ? "Itinerary updated successfully!" : "Failed to update itinerary.");
                    break;
                case "delete":
                    result = deleteItinerary(request);
                    request.getSession().setAttribute("message", result ? "Itinerary deleted successfully!" : "Failed to delete itinerary.");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "An error occurred.");
        }


        response.sendRedirect("adminDashboard.jsp");
    }

    private boolean addItinerary(HttpServletRequest request) {
        try {
            Itinerary itinerary = extractItineraryFromRequest(request, false);
            return itineraryDAO.addItinerary(itinerary);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean updateItinerary(HttpServletRequest request) {
        try {
            Itinerary itinerary = extractItineraryFromRequest(request, true);
            return itineraryDAO.updateItinerary(itinerary);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean deleteItinerary(HttpServletRequest request) {
        try {
            int itinerary_id = Integer.parseInt(request.getParameter("itinerary_id"));
            return itineraryDAO.deleteItinerary(itinerary_id);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Itinerary> itineraries = itineraryDAO.getAllItineraries();
        request.setAttribute("itineraries", itineraries);
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin_itinerary.jsp");
        dispatcher.forward(request, response);
    }

    private Itinerary extractItineraryFromRequest(HttpServletRequest request, boolean isUpdate) {
        Itinerary itinerary = new Itinerary();

        if (isUpdate) {
            itinerary.setItinerary_id(Integer.parseInt(request.getParameter("itinerary_id")));
        }

        itinerary.setItinerary_day1(request.getParameter("itinerary_day1"));
        itinerary.setItinerary_day1_description(request.getParameter("itinerary_day1_description"));
        itinerary.setItinerary_day2(request.getParameter("itinerary_day2"));
        itinerary.setItinerary_day2_description(request.getParameter("itinerary_day2_description"));
        itinerary.setItinerary_day3(request.getParameter("itinerary_day3"));
        itinerary.setItinerary_day3_description(request.getParameter("itinerary_day3_description"));
        itinerary.setItinerary_day4(request.getParameter("itinerary_day4"));
        itinerary.setItinerary_day4_description(request.getParameter("itinerary_day4_description"));
        itinerary.setItinerary_day5(request.getParameter("itinerary_day5"));
        itinerary.setItinerary_day5_description(request.getParameter("itinerary_day5_description"));
        itinerary.setItinerary_price(Double.parseDouble(request.getParameter("itinerary_price")));
        itinerary.setDestination_id(Integer.parseInt(request.getParameter("destination_id")));

        return itinerary;
    }
}
