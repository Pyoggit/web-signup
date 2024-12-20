<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductDAO" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO" %>
<%@ include file="mainHeader.jsp" %>

<%
    // URL에서 전달된 id 값 가져오기
    String id = request.getParameter("id");
    if (id == null || id.trim().isEmpty()) {
        out.println("<div class='alert alert-warning'>유효한 ID가 전달되지 않았습니다.</div>");
        return;
    }

    // DAO를 사용해 상품 정보 조회
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bookShop/css/bookShop.css" />
</head>
<body>
    <div class="jumbotron">
        <div class="container">
            <h1 class="display-3">상품 정보</h1>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h3><%= product.getBookName() %></h3>
                <p><%= product.getDescription() %></p>
                <p><b>상품코드:</b> <span class="badge badge-danger"><%= product.getBookID() %></span></p>
                <p><b>저자:</b> <%= product.getAuthor() %></p>
                <p><b>출판사:</b> <%= product.getPublisher() %></p>
                <p><b>분류:</b> <%= product.getCategory() %></p>
                <p><b>재고 수:</b> <%= product.getUnitsInStock() %></p>
                <h4><%= product.getUnitPrice() %>원</h4>
                <p>
                    <a href="#" class="btn btn-info">상품 주문 &raquo;</a>
                    <a href="products.jsp" class="btn btn-secondary">상품 목록 &raquo;</a>
                </p>
            </div>
        </div>
    </div>
</body>
</html>
<%
    }
%>
<%@ include file="mainFooter.jsp" %>
