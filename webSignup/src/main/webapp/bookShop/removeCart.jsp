<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO" %>

<%
    // 세션에서 장바구니 목록 가져오기
    ArrayList<ProductVO> cartList = (ArrayList<ProductVO>) session.getAttribute("cartlist");
    if (cartList == null) {
        cartList = new ArrayList<>();
        session.setAttribute("cartlist", cartList);
    }

    // 삭제할 상품 ID 가져오기
    String id = request.getParameter("id");
    if (id != null && !id.trim().isEmpty()) {
        for (int i = 0; i < cartList.size(); i++) {
            ProductVO product = cartList.get(i);
            if (product.getBookID().equals(id)) {
                product.setQuantity(0); // 상품 수량 초기화
                cartList.remove(i); // 장바구니에서 삭제
                break;
            }
        }
    }

    // 세션에 업데이트된 장바구니 목록 저장
    session.setAttribute("cartlist", cartList);

    // 장바구니 페이지로 리다이렉트
    response.sendRedirect("cart.jsp");
%>
