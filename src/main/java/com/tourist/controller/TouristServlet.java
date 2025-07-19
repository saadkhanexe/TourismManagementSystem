package com.tourist.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.tourist.dao.TouristImplementation;
import com.tourist.dao.TouristInterface;
import com.tourist.dto.Tourist;

@WebServlet("/touristServlet")
public class TouristServlet extends HttpServlet {

    TouristInterface ti = new TouristImplementation();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("add".equalsIgnoreCase(action)) {
            Tourist t = new Tourist();
            t.setName(request.getParameter("name"));
            t.setEmail(request.getParameter("email"));
            t.setPhone(Long.parseLong(request.getParameter("phone")));
            t.setPassword(request.getParameter("password"));
            t.setConfirmPassword(request.getParameter("confirmPassword"));

            if (t.getPassword().equals(t.getConfirmPassword())) {
                boolean isAdded = ti.insertData(t);
                if (isAdded) {
                    session.setAttribute("message", "Tourist added successfully.");
                    session.setAttribute("messageType", "success");
                } else {
                    session.setAttribute("message", "Failed to add tourist.");
                    session.setAttribute("messageType", "error");
                }
            } else {
                session.setAttribute("message", "Password and Confirm Password do not match.");
                session.setAttribute("messageType", "error");
            }
            response.sendRedirect("adminDashboard.jsp");

        } else if ("update".equalsIgnoreCase(action)) {
            Tourist t = new Tourist();
            t.setId(Integer.parseInt(request.getParameter("id")));
            t.setName(request.getParameter("name"));
            t.setEmail(request.getParameter("email"));
            t.setPhone(Long.parseLong(request.getParameter("phone")));
            t.setPassword(request.getParameter("password"));
            t.setConfirmPassword(request.getParameter("confirmPassword"));

            if (t.getPassword().equals(t.getConfirmPassword())) {
                boolean isUpdated = ti.updateData(t);
                if (isUpdated) {
                    session.setAttribute("message", "Tourist updated successfully.");
                    session.setAttribute("messageType", "success");
                } else {
                    session.setAttribute("message", "Failed to update tourist.");
                    session.setAttribute("messageType", "error");
                }
            } else {
                session.setAttribute("message", "Password and Confirm Password do not match.");
                session.setAttribute("messageType", "error");
            }
            response.sendRedirect("adminDashboard.jsp");

        } else if ("delete".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Tourist t = new Tourist();
            t.setId(id);

            boolean isDeleted = ti.deleteData(t);
            if (isDeleted) {
                session.setAttribute("message", "Tourist deleted successfully.");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "Failed to delete tourist.");
                session.setAttribute("messageType", "error");
            }
            response.sendRedirect("adminDashboard.jsp");

        } else {
            session.setAttribute("message", "Invalid action.");
            session.setAttribute("messageType", "error");
            response.sendRedirect("adminDashboard.jsp");
        }
    }
}
