<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO" %>
<%@ page import="kr.co.pyo.order.model.OrderDetailsDAO" %>

<%
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    ArrayList<ProductVO> cartList = (ArrayList<ProductVO>) session.getAttribute("cartlist");

    if (cartList != null && !cartList.isEmpty()) {
        // 주문내역 데이터베이스에 저장
        OrderDetailsDAO orderDAO = new OrderDetailsDAO();
        orderDAO.insertOrder(userId, cartList);

        // 주문내역 세션에 저장 (선택 사항)
        ArrayList<ProductVO> orderList = (ArrayList<ProductVO>) session.getAttribute("orderList");
        if (orderList == null) {
            orderList = new ArrayList<>();
        }
        orderList.addAll(cartList);

        // 세션 갱신
        session.setAttribute("orderList", orderList);
        session.setAttribute("paymentDate", new java.util.Date().toString()); // 결제일 설정
        cartList.clear(); // 장바구니 초기화
        session.setAttribute("cartlist", cartList);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>결제 진행중</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bookShop/css/bookSuccess.css">
    <script>
        function redirectAfterPayment() {
            setTimeout(() => {
                alert("결제가 완료되었습니다!");
                if (window.opener) {
                    window.opener.location.href = ("${pageContext.request.contextPath}/mainHome/mainPage.jsp");
                    window.close();
                } else {
                    window.location.href = "${pageContext.request.contextPath}/mainHome/mainPage.jsp";
                }
            }, 3000); // 3초 후에 실행
        }
    </script>
</head>
<body onload="redirectAfterPayment()">
    <div class="payment-container">
        <h1>결제 진행중...</h1>
        <div class="spinner"></div>
        <p class="message">결제가 완료될 때까지 잠시만 기다려주세요.</p>
        <div class="progress-bar">
            <div class="progress"></div>
        </div>
    </div>
</body>
</html>
