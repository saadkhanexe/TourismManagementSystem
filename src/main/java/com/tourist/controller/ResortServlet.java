package com.tourist.controller;

import com.tourist.dao.ResortImplementation;
import com.tourist.dao.ResortInterface;
import com.tourist.dto.Resort;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/resortServlet")
public class ResortServlet extends HttpServlet {

    private ResortInterface resortDAO = new ResortImplementation();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession(); // ✅ Flash messages

        boolean result = false;

        try {
            switch (action) {
                case "add":
                    result = addResort(request);
                    break;
                case "update":
                    result = updateResort(request);
                    break;
                case "delete":
                    result = deleteResort(request);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Server error occurred.");
        }

        if (result) {
            session.setAttribute("message", "Operation successful.");
        } else {
            session.setAttribute("message", "Operation failed.");
        }

        response.sendRedirect("adminDashboard.jsp");
    }

    private boolean addResort(HttpServletRequest request) {
        try {
            int destinationId = Integer.parseInt(request.getParameter("destination_id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String type = request.getParameter("type");
            double rating = Double.parseDouble(request.getParameter("rating"));
            double resortPrice = Double.parseDouble(request.getParameter("resort_price"));

            Resort resort = new Resort();
            resort.setDestination_id(destinationId);
            resort.setName(name);
            resort.setDescription(description);
            resort.setType(type);
            resort.setRating(rating);
            resort.setResort_price(resortPrice);

            return resortDAO.insertData(resort); // ✅ Make sure your DAO method returns boolean
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean updateResort(HttpServletRequest request) {
        try {
            int resortId = Integer.parseInt(request.getParameter("resort_id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String type = request.getParameter("type");
            double rating = Double.parseDouble(request.getParameter("rating"));
            double resortPrice = Double.parseDouble(request.getParameter("resort_price"));

            Resort resort = new Resort();
            resort.setResort_id(resortId);
            resort.setName(name);
            resort.setDescription(description);
            resort.setType(type);
            resort.setRating(rating);
            resort.setResort_price(resortPrice);

            return resortDAO.updateData(resort); // ✅ DAO should return boolean
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean deleteResort(HttpServletRequest request) {
        try {
            int resortId = Integer.parseInt(request.getParameter("resort_id"));
            Resort resort = new Resort();
            resort.setResort_id(resortId);
            return resortDAO.deleteData(resort); // ✅ DAO should return boolean
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Resort> resorts = resortDAO.getAllResorts();
        request.setAttribute("resorts", resorts);
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin_resorts.jsp");
        dispatcher.forward(request, response);
    }
}
