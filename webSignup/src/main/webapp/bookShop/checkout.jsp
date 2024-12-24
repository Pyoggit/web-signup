<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO" %>

<html>
<head>
    <title>주문 확인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bookShop/css/bookShop.css" />
</head>
<body>
    <div class="container">
        <h1>주문 확인</h1>
        <%
            // 세션에서 장바구니 가져오기
            ArrayList<ProductVO> cartList = (ArrayList<ProductVO>) session.getAttribute("cartlist");
            int totalAmount = 0;

            if (cartList == null || cartList.isEmpty()) {
        %>
            <script>
                alert('장바구니가 비어 있습니다. 쇼핑을 계속해주세요.');
                location.href = 'products.jsp';
            </script>
        <%
            } else {
        %>
            <table border="1">
                <thead>
                    <tr>
                        <th>상품명</th>
                        <th>수량</th>
                        <th>가격</th>
                        <th>합계</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (ProductVO product : cartList) {
                            int total = product.getUnitPrice() * product.getQuantity();
                            totalAmount += total;
                    %>
                    <tr>
                        <td><%= product.getBookName() %></td>
                        <td><%= product.getQuantity() %></td>
                        <td><%= product.getUnitPrice() %>원</td>
                        <td><%= total %>원</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
                <tfoot>
                    <tr>
                        <th colspan="3">총 금액</th>
                        <th><%= totalAmount %>원</th>
                    </tr>
                </tfoot>
            </table>
            <div class="btn-action">
                <a href="orderSuccess.jsp" class="btn btn-success">결제 완료</a>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>
