<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kr.co.pyo.order.model.OrderVO" %>
<%@ page import="kr.co.pyo.order.model.OrderDetailsDAO" %>

<%
    String id = (String) session.getAttribute("userId");
    if (id == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    OrderDetailsDAO dao = new OrderDetailsDAO();
    ArrayList<OrderVO> orderList = dao.getOrderDetails(id);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문내역</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/signup/css/orderDetails.css">
    <script>
        function redirectToMain() {
            if (window.opener) {
                // 부모 창이 있을 경우
                window.opener.location.href = "${pageContext.request.contextPath}/mainHome/mainPage.jsp";
                window.close(); // 현재 창 닫기
            } else {
                // 부모 창이 없는 경우 (기본 이동)
                window.location.href = "${pageContext.request.contextPath}/mainHome/mainPage.jsp";
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>주문내역</h1>
        <% if (orderList.isEmpty()) { %>
            <p class="empty-message">주문내역이 없습니다.</p>
        <% } else { %>
            <table class="order-table">
                <thead>
                    <tr>
                        <th>상품명</th>
                        <th>결제일</th>
                        <th>수량</th>
                        <th>결제금액</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (OrderVO order : orderList) { %>
                    <tr>
                        <td><%= order.getBookName() %></td>
                        <td><%= order.getOrderDate() %></td>
                        <td><%= order.getQuantity() %></td>
                        <td><%= order.getTotalAmount() %>원</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
        <button class="btn" onclick="redirectToMain()">메인 페이지로</button>
    </div>
</body>
</html>
