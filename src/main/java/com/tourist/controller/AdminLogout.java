package com.tourist.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/adminLogout")
public class AdminLogout extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false); // Don’t create if it doesn’t exist
        if (session != null) {
            session.invalidate(); // Destroy admin session
        }

        // Prevent caching (disable back button access after logout)
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        resp.setHeader("Pragma", "no-cache"); // HTTP 1.0
        resp.setDateHeader("Expires", 0); // Proxies

        // Redirect to admin login page with message
        resp.sendRedirect("adminLogin.jsp?msg=You have been logged out successfully");
    }
}
