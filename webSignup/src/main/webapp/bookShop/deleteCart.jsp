<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO" %>

<%
    String[] selectedIds = request.getParameterValues("selectedIds");
    ArrayList<ProductVO> cartList = (ArrayList<ProductVO>) session.getAttribute("cartlist");

    if (cartList != null && selectedIds != null) {
        for (String id : selectedIds) {
            cartList.removeIf(product -> product.getBookID().equals(id));
        }
    }

    session.setAttribute("cartlist", cartList);
    response.sendRedirect("cart.jsp");
%>
