<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    String user = (String) session.getAttribute("name");
    if (user == null) {
        response.sendRedirect("login.jsp?msg=Please login again");
    }
%>

