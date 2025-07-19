package com.tourist.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Invalidate the session
        HttpSession session = req.getSession(false); // false = don’t create if not exists
        if (session != null) {
            session.invalidate(); // Destroy session
        }

        // Prevent caching (disallow back button access)
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        resp.setHeader("Pragma", "no-cache"); // HTTP 1.0
        resp.setDateHeader("Expires", 0); // Proxies

        // Redirect to login page with message
        resp.sendRedirect("login.jsp?msg=You have been logged out successfully");
    }
}
