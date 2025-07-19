package com.tourist.controller;

import com.tourist.dao.TouristImplementation;
import com.tourist.dao.TouristInterface;
import com.tourist.dto.Tourist;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/profile")
public class TouristProfileServlet extends HttpServlet {
    TouristInterface dao = new TouristImplementation();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Integer id = (Integer) session.getAttribute("user_id");

        if (id == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        Tourist t = dao.getTourist(id);
        req.setAttribute("tourist", t);
        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession(false);
        Integer id = (Integer) session.getAttribute("user_id");

        if (id == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        if ("update".equalsIgnoreCase(action)) {
            Tourist t = new Tourist();
            t.setId(id);
            t.setName(req.getParameter("name"));
            t.setEmail(req.getParameter("email"));
            t.setPhone(Long.parseLong(req.getParameter("phone")));

            boolean updated = dao.updateData(t);
            if (updated) {
                session.setAttribute("name", t.getName()); // optional: update session name
                resp.sendRedirect("profile");
            } else {
                resp.sendRedirect("error.jsp");
            }
        } else if ("delete".equalsIgnoreCase(action)) {
            boolean deleted = dao.deleteTouristById(id);
            if (deleted) {
                session.invalidate();
                resp.sendRedirect("index.jsp?msg=account_deleted");
            } else {
                resp.sendRedirect("profile.jsp?msg=delete_failed");
            }
        }
    }
}
