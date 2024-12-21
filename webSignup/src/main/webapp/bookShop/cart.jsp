<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO"%>

<html>
<head>
    <title>장바구니</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    
    <!-- Custom Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bookShop/css/bookCart.css?timestamp=<%= System.currentTimeMillis() %>">
</head>
<body>
    <div class="jumbotron">
        <div class="container">
            <h1>장바구니</h1>
        </div>
    </div>
    <div class="container">
        <form id="cartForm" action="deleteCart.jsp" method="post">
            <table class="cart-table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="allChk" checked></th>
                        <th>상품</th>
                        <th>가격</th>
                        <th>수량</th>
                        <th>소계</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ArrayList<ProductVO> cartList = (ArrayList<ProductVO>) session.getAttribute("cartlist");
                        if (cartList == null) {
                            cartList = new ArrayList<>();
                        }
                        int sum = 0;
                        if (cartList.isEmpty()) {
                    %>
                    <tr>
                        <td colspan="6" class="text-center">장바구니가 비어 있습니다.</td>
                    </tr>
                    <%
                        } else {
                            for (ProductVO book : cartList) {
                                int total = book.getUnitPrice() * book.getQuantity();
                                sum += total;
                    %>
                    <tr>
                        <td><input type="checkbox" class="chk" name="selectedIds" value="<%= book.getBookID() %>" checked></td>
                        <td><%= book.getBookID() %> - <%= book.getBookName() %></td>
                        <td><%= book.getUnitPrice() %>원</td>
                        <td><%= book.getQuantity() %></td>
                        <td><%= total %>원</td>
                        <td>
                            <a href="removeCart.jsp?id=<%= book.getBookID() %>" class="btn btn-danger btn-sm">삭제</a>
                        </td>
                    </tr>
                    <%
                            }
                    %>
                    <tr class="total-row">
                        <th colspan="4" class="text-end">총합계</th>
                        <td colspan="2"><%= sum %>원</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <div class="btn-action">
                <a href="products.jsp" class="btn btn-secondary"> &laquo; 쇼핑 계속하기</a>
                <button type="submit" class="btn btn-danger">선택 삭제</button>
                <a href="checkout.jsp" class="btn btn-primary">주문하기</a>
            </div>
        </form>
    </div>
</body>
</html>
