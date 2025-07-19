package com.tourist.controller;

import java.io.IOException;

import com.tourist.dao.AdminImplementation;
import com.tourist.dao.AdminInterface;
import com.tourist.dto.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/adminLogin")
public class AdminLogin extends HttpServlet {
    Admin a = new Admin();
    AdminInterface ai = new AdminImplementation();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        a.setEmail(email);
        a.setPassword(password);

        Admin a1 = ai.getAdmin(email, password);

        if (a1 != null) {
            HttpSession session = req.getSession();
            session.setAttribute("admin_name", a1.getName());
            session.setAttribute("admin_email", a1.getEmail());
            resp.sendRedirect("adminDashboard.jsp");
        } else {
            resp.sendRedirect("adminLogin.jsp?msg=invalid");
        }
    }
}
