package com.tourist.controller;

import java.io.IOException;
import java.io.PrintWriter;

import com.tourist.dto.Tourist;
import com.tourist.dao.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/signupSubmit")
public class Signup extends HttpServlet {
	Tourist t = new Tourist();
	TouristInterface ti = new TouristImplementation();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		long phone = Long.parseLong(req.getParameter("phone"));
		String pass = req.getParameter("password");
		String confirmpass = req.getParameter("confirmPassword");

		t.setName(name);
		t.setEmail(email);
		t.setPhone(phone);
		t.setPassword(pass);
		t.setConfirmPassword(confirmpass);
		boolean res = ti.insertData(t);
		if (res == true) {
			resp.sendRedirect("login.jsp");
		} else {
			resp.sendRedirect("index.jsp");
		}
	}

}
