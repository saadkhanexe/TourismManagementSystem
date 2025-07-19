<%

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

    if (session.getAttribute("admin_name") == null) {
        response.sendRedirect("adminLogin.jsp?msg=Please login first");
        return;
    }


%>
