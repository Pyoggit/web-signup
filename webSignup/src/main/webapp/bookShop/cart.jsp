<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO" %>

<html>
<head>
    <title>장바구니</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bookShop/css/bookCart.css">
</head>
<body>
    <div class="jumbotron">
        <h1>장바구니</h1>
    </div>
    <div class="container">
        <form id="cartForm" action="deleteCart.jsp" method="post">
            <table class="table">
                <thead>
                    <tr>
                        <th>선택</th>
                        <th>상품명</th>
                        <th>가격</th>
                        <th>수량</th>
                        <th>합계</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ArrayList<ProductVO> cartList = (ArrayList<ProductVO>) session.getAttribute("cartlist");
                        if (cartList == null || cartList.isEmpty()) {
                    %>
                    <tr>
                        <td colspan="6" class="text-center">장바구니가 비어 있습니다.</td>
                    </tr>
                    <%
                        } else {
                            int totalAmount = 0;
                            for (ProductVO product : cartList) {
                                int total = product.getUnitPrice() * product.getQuantity();
                                totalAmount += total;
                    %>
                    <tr>
                        <td><input type="checkbox" name="selectedIds" value="<%= product.getBookID() %>"></td>
                        <td><%= product.getBookName() %></td>
                        <td><%= product.getUnitPrice() %>원</td>
                        <td><%= product.getQuantity() %></td>
                        <td><%= total %>원</td>
                        <td><a href="removeCart.jsp?id=<%= product.getBookID() %>" class="btn btn-danger btn-sm">삭제</a></td>
                    </tr>
                    <%
                            }
                    %>
                    <tr>
                        <td colspan="4" class="text-end">총합계</td>
                        <td colspan="2"><%= totalAmount %>원</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <div class="btn-action">
                <a href="products.jsp" class="btn btn-secondary">&laquo; 쇼핑 계속하기</a>
                <button type="submit" class="btn btn-danger">선택 삭제</button>
                <a href="checkout.jsp" class="btn btn-primary">주문하기</a>
            </div>
        </form>
    </div>
</body>
</html>
