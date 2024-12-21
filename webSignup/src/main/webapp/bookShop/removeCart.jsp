<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO"%>

<%
    // 삭제할 상품 ID 가져오기
    String id = request.getParameter("id");
    if (id == null || id.trim().isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }

    // 세션 무효화 (장바구니 초기화)
    session.invalidate();

    // 장바구니 페이지로 리다이렉트
    response.sendRedirect("cart.jsp");
%>
