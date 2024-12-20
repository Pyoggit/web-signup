<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductDAO" %>
<%@ include file="mainHeader.jsp" %>

<html>
<head>
    <title>상품 목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bookShop/css/bookShop.css" />
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
			                    <a href="${pageContext.request.contextPath}/bookShop/product.jsp?id=<%= product.getBookID() %>">상세 보기</a>
			                    <a href="#">주문하기</a>
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