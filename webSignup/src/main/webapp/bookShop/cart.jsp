<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO"%>

<html>
<head>
    <title>장바구니</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;500;700&display=swap" rel="stylesheet">    
    <!-- Custom Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bookShop/css/bookCart.css?timestamp=<%= System.currentTimeMillis() %>">
    <script>
        // 전체 선택 / 해제 기능
        function toggleAllCheckboxes(source) {
            const checkboxes = document.querySelectorAll('.chk');
            checkboxes.forEach((checkbox) => {
                checkbox.checked = source.checked;
            });
        }

        // 장바구니가 비어 있으면 폼 숨기기
        window.onload = function() {
            const cartForm = document.getElementById('cartForm');
            const cartItems = document.querySelectorAll('.cart-table tbody tr');
            if (cartItems.length === 0) {
                cartForm.style.display = 'none';
            }
        };
    </script>
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
                        <th><input type="checkbox" id="allChk" onclick="toggleAllCheckboxes(this)" checked></th>
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
                        if (cartList == null || cartList.isEmpty()) {
                    %>
                    <tr>
                        <td colspan="6" class="text-center">장바구니가 비어 있습니다.</td>
                    </tr>
                    <%
                        } else {
                            int sum = 0;
                            for (ProductVO product : cartList) {
                                int total = product.getUnitPrice() * product.getQuantity();
                                sum += total;
                    %>
                    <tr>
                        <td><input type="checkbox" class="chk" name="selectedIds" value="<%= product.getBookID() %>" checked></td>
                        <td><%= product.getBookID() %> - <%= product.getBookName() %></td>
                        <td><%= product.getUnitPrice() %>원</td>
                        <td><%= product.getQuantity() %></td>
                        <td><%= total %>원</td>
                        <td>
                            <a href="removeCart.jsp?id=<%= product.getBookID() %>" class="btn btn-danger btn-sm">삭제</a>
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
