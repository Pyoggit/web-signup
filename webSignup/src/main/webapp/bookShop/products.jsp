<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductDAO" %>
<%@ include file="mainHeader.jsp" %>

<html>
<head>
    <title>상품 목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bookShop/css/bookShop.css" />
    <script type="text/javascript">
		    function addToCart(bookID) {
		        if (confirm('상품을 장바구니에 추가하시겠습니까?')) {
		            document.addForm.action = './addCart.jsp?id=' + bookID;
		            document.addForm.submit();
		        } else {
		            // 취소 시 상품목록 페이지로 이동
		            window.location.href ='products.jsp';
		        }
		    }
    </script>
    
</head>
<body>
    <div class="jumbotron">
        <div class="container">
            <h1 class="display-3">상품 목록</h1>
        </div>
    </div>
    <div class="container">
        <div class="product-list">
            <%
                // DAO를 사용하여 모든 상품 정보 가져오기
                ProductDAO productDAO = new ProductDAO();
                ArrayList<ProductVO> products = productDAO.getAllProducts();

                if (products.isEmpty()) {
            %>
                <div class="alert alert-warning">등록된 상품이 없습니다.</div>
            <%
                } else {
                    for (ProductVO product : products) {
            %>
                <div class="product-item">
                    <!-- 상품 이미지 -->
                    <div class="product-image">
                        <img src="<%= request.getContextPath() %>/upload/<%= product.getFilename() %>" alt="<%= product.getBookName() %>">
                    </div>
                    <!-- 상품 정보 -->
                    <div class="product-info">
                        <div>
                            <div class="product-title"><%= product.getBookName() %></div>
                            <div class="product-meta">
                                저자: <%= product.getAuthor() %> | 출판사: <%= product.getPublisher() %> | 분류: <%= product.getCategory() %>
                            </div>
                        </div>
                        <div class="product-price"><%= product.getUnitPrice() %>원</div>
                        <!-- 상품 액션 -->
                        <div class="product-actions">
                            <form name="addForm" method="post">
                                <a href="${pageContext.request.contextPath}/bookShop/product.jsp?id=<%= product.getBookID() %>" class="btn btn-primary">상세 보기</a>
                                <a href="${pageContext.request.contextPath}/bookShop/cart.jsp?id=<%= product.getBookID() %>" class="btn btn-warning" onclick="addToCart()">장바구니 추가</a>
                                <a href="./order.jsp?id=<%= product.getBookID() %>" class="btn btn-warning">주문하기</a>
                            </form>
                        </div>
                    </div>
                </div>
            <%
                    }
                }
            %>
        </div>
    </div>
</body>
</html>
<%@ include file="mainFooter.jsp" %>
