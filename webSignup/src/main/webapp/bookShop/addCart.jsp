<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO"%>
<%@ page import="kr.co.pyo.bookShop.model.ProductDAO"%>

<%
    // URL에서 전달된 상품 ID 가져오기
    String id = request.getParameter("id");
    if (id == null || id.trim().isEmpty()) {
        out.println("<script>alert('상품 ID가 없습니다.'); location.href='products.jsp';</script>");
        return;
    }

    // 상품 조회
    ProductDAO dao = new ProductDAO();
    ProductVO book = dao.getProductById(id);
    if (book == null) {
        out.println("<script>alert('해당 상품을 찾을 수 없습니다.'); location.href='products.jsp';</script>");
        return;
    }

    // 장바구니 세션 가져오기
    ArrayList<ProductVO> cartList = (ArrayList<ProductVO>) session.getAttribute("cartlist");
    if (cartList == null) {
        cartList = new ArrayList<>();
        session.setAttribute("cartlist", cartList);
    }

    // 상품 추가 또는 수량 증가
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

    // 디버깅 메시지 출력
    System.out.println("Updated cart list:");
    for (ProductVO product : cartList) {
        System.out.println("- " + product.getBookID() + ": " + product.getQuantity() + "개");
    }

    // 장바구니 페이지로 리다이렉트
    response.sendRedirect("cart.jsp");
%>
