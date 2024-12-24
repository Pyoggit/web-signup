<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO"%>
<%@ page import="java.util.ArrayList"%>

<%
    // 삭제할 상품 ID 가져오기
    String[] selectedIds = request.getParameterValues("selectedIds");
    if (selectedIds == null || selectedIds.length == 0) {
        out.println("<script>alert('삭제할 상품을 선택해주세요.'); history.back();</script>");
        return;
    }

    // 세션에서 장바구니 목록 가져오기
    ArrayList<ProductVO> cartList = (ArrayList<ProductVO>) session.getAttribute("cartlist");
    if (cartList != null) {
        for (String id : selectedIds) {
            cartList.removeIf(product -> product.getBookID().equals(id));
        }
    } else {
        out.println("<script>alert('장바구니가 비어 있습니다.'); history.back();</script>");
        return;
    }

    // 세션에 업데이트된 장바구니 저장
    session.setAttribute("cartlist", cartList);

    // 장바구니 페이지로 리다이렉트
    response.sendRedirect("cart.jsp");
%>
