package com.tourist.controller;

import com.tourist.util.PdfGeneratorUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/downloadReceipt")
public class ReceiptServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingIdStr = request.getParameter("booking_id");

        if (bookingIdStr == null || bookingIdStr.isEmpty()) {
            response.sendRedirect("home.jsp");
            return;
        }

        try {
            int bookingId = Integer.parseInt(bookingIdStr);

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=BookingReceipt_" + bookingId + ".pdf");

            OutputStream out = response.getOutputStream();
            PdfGeneratorUtil.generateReceiptPdf(out, bookingId);

            out.flush();
            out.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error generating receipt.");
        }
    }
}
