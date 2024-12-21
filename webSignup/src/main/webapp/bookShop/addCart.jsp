<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO"%>
<%@ page import="kr.co.pyo.bookShop.model.ProductDAO"%>

<%
    String id = request.getParameter("id");
    if (id == null || id.trim().isEmpty()) {
        response.sendRedirect("products.jsp");
        return;
    }

    ProductDAO dao = new ProductDAO();
    ProductVO book = dao.getProductById(id);
    if (book == null) {
        response.sendRedirect("exceptionNoBookId.jsp");
        return;
    }

    ArrayList<ProductVO> cartList = (ArrayList<ProductVO>) session.getAttribute("cartlist");
    if (cartList == null) {
        cartList = new ArrayList<>();
        session.setAttribute("cartlist", cartList);
    }

    boolean isExisting = false;
    for (ProductVO cartItem : cartList) {
        if (cartItem.getBookID().equals(book.getBookID())) {
            cartItem.setQuantity(cartItem.getQuantity() + 1);
            isExisting = true;
            break;
        }
    }

    if (!isExisting) {
        book.setQuantity(1);
        cartList.add(book);
    }

    session.setAttribute("cartlist", cartList);
    response.sendRedirect("product.jsp?id=" + id);
%>
