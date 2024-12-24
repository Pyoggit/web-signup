<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductDAO" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO" %>
<%@ include file="/includes/mainHeader.jsp" %>

<%
    String id = request.getParameter("id");
    if (id == null || id.trim().isEmpty()) {
        out.println("<div class='alert alert-warning'>유효한 ID가 전달되지 않았습니다.</div>");
        return;
    }

    ProductDAO productDAO = new ProductDAO();
    ProductVO product = productDAO.getProductById(id);

    if (product == null) {
%>
    <div class="alert alert-danger">상품 정보를 찾을 수 없습니다.</div>
<%
    } else {
%>
<html>
<head>
    <title>상품 상세 페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bookShop/css/bookDetail.css" />
    <script type="text/javascript">
		    function addToCart(bookID) {
		        if (confirm('상품을 장바구니에 추가하시겠습니까?')) {
		            window.location.href = './addCart.jsp?id=' + bookID;
		        } else {
		            // 취소 시 상품목록 페이지로 이동
		            window.location.href = './products.jsp';
		        }
		    }
    </script>
    
</head>
<body>
    <div class="jumbotron">
        <div class="container">
            <h1 class="display-3">상품 상세 정보</h1>
        </div>
    </div>
    <div class="container">
        <div class="product-detail">
            <!-- 상품 이미지 -->
            <div class="product-image">
                <img src="<%= request.getContextPath() %>/upload/<%= product.getFilename() %>" alt="<%= product.getBookName() %>">
            </div>
            <!-- 상품 정보 -->
            <div class="product-info">
                <div>
                    <div class="product-title"><%= product.getBookName() %></div>
                    <div class="product-meta">
                        <p><b>상품코드:</b> <%= product.getBookID() %></p>
                        <p><b>저자:</b> <%= product.getAuthor() %></p>
                        <p><b>출판사:</b> <%= product.getPublisher() %></p>
                        <p><b>분류:</b> <%= product.getCategory() %></p>
                        <p><b>재고 수:</b> <%= product.getUnitsInStock() %></p>
                    </div>
                </div>
                <div class="product-price"><%= product.getUnitPrice() %>원</div>
                <!-- 액션 버튼 -->
                <div class="product-actions">
                		<a href="javascript:void(0);" class="btn btn-warning" onclick="addToCart('<%= product.getBookID() %>')">장바구니 추가</a>
								    <a href="${pageContext.request.contextPath}/bookShop/products.jsp" class="btn btn-secondary">상품 목록</a>
								</div>
                
            </div>
        </div>
    </div>
</body>
</html>
<%
    }
%>
<%@ include file="/includes/mainFooter.jsp" %>
