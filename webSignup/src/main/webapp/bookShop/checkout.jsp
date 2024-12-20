<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO" %>

<html>
<head>
    <title>주문 확인</title>
</head>
<body>
    <div class="container">
        <h1>주문 확인</h1>
        <%
            ArrayList<ProductVO> cartList = (ArrayList<ProductVO>) session.getAttribute("cartlist");
            int totalAmount = 0;

            if (cartList == null || cartList.isEmpty()) {
        %>
            <p>장바구니가 비어 있습니다.</p>
        <%
            } else {
        %>
            <table>
                <tr>
                    <th>상품명</th>
                    <th>수량</th>
                    <th>가격</th>
                    <th>합계</th>
                </tr>
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
                <tr>
                    <th colspan="3">총 금액</th>
                    <th><%= totalAmount %>원</th>
                </tr>
            </table>
            <a href="orderSuccess.jsp" class="btn btn-success">결제 완료</a>
        <%
            }
        %>
    </div>
</body>
</html>
