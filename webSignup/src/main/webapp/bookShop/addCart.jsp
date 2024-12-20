<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductDAO" %>

<%
    String id = request.getParameter("id");
    if (id == null || id.trim().isEmpty()) {
        response.sendRedirect("products.jsp");
        return;
    }

    ProductDAO dao = new ProductDAO();
    ProductVO product = dao.getProductById(id);

    if (product == null) {
        response.sendRedirect("products.jsp");
        return;
    }

    ArrayList<ProductVO> cartList = (ArrayList<ProductVO>) session.getAttribute("cartlist");
    if (cartList == null) {
        cartList = new ArrayList<>();
        session.setAttribute("cartlist", cartList);
    }

    boolean isExisting = false;
    for (ProductVO item : cartList) {
        if (item.getBookID().equals(product.getBookID())) {
            item.setQuantity(item.getQuantity() + 1);
            isExisting = true;
            break;
        }
    }

    if (!isExisting) {
        product.setQuantity(1);
        cartList.add(product);
    }

    session.setAttribute("cartlist", cartList);
    response.sendRedirect("cart.jsp");
%>
