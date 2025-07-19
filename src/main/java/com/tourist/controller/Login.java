package com.tourist.controller;

import java.io.IOException;

import com.tourist.dao.TouristImplementation;
import com.tourist.dao.TouristInterface;
import com.tourist.dto.Tourist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/loginSubmit")
public class Login extends HttpServlet{
	Tourist t = new Tourist();
	TouristInterface ti = new TouristImplementation();
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email=req.getParameter("email");
		String password=req.getParameter("password");
		t.setEmail(email);
		t.setPassword(password);
		Tourist t1 = ti.getTouristInfo(email, password);
		if(t1!=null) {
			HttpSession session = req.getSession();
			session.setAttribute("name", t1.getName());
			session.setAttribute("email", t1.getEmail());
			session.setAttribute("password", t1.getPassword());
			session.setAttribute("user_id", t1.getId());
			resp.sendRedirect("home.jsp");
		}
		else {
			resp.sendRedirect("index.jsp");
		}
	}

}
