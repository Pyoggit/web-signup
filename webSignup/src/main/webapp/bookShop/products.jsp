<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO" %>
<%@ page import="kr.co.pyo.bookShop.model.ProductDAO" %>
<%@ include file="/includes/mainHeader.jsp" %>
<%
    String writer = (String) session.getAttribute("userName");
    String email = (String) session.getAttribute("userEmail");

    if (writer == null || email == null) {
%>
        <script>
            alert("로그인 하셔야 합니다.");
            const popupWidth = 550;
            const popupHeight = 800;

            const screenWidth = window.screen.width;
            const screenHeight = window.screen.height;

            const popupX = Math.round((screenWidth - popupWidth) / 2);
            const popupY = Math.round((screenHeight - popupHeight) / 2);

            window.open(
                '<%= request.getContextPath() %>/signup/login.jsp',
                'LoginPopup',
                `width=${popupWidth},height=${popupHeight},left=${popupX},top=${popupY},scrollbars=no,resizable=no`
            );
            history.back();
        </script>
<%
        return;
    }

    // 검색어 처리
    String searchKeyword = request.getParameter("search");
    ArrayList<ProductVO> products;
    ProductDAO productDAO = new ProductDAO();

    // 페이징 처리
    int currentPage = 1; // 현재 페이지
    int pageSize = 5; // 페이지당 상품 수
    String pageParam = request.getParameter("page");

    if (pageParam != null) {
        currentPage = Integer.parseInt(pageParam);
    }

    int totalProducts = 0; // 전체 상품 개수
    int totalPages = 0; // 전체 페이지 수

    if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
        // 검색 결과 가져오기
        products = productDAO.searchProductsByName(searchKeyword);
        totalProducts = products.size(); // 검색된 상품 개수
        totalPages = (int) Math.ceil(totalProducts / (double) pageSize);
    } else {
        // 전체 상품 가져오기
        totalProducts = productDAO.getTotalProductCount();
        totalPages = (int) Math.ceil(totalProducts / (double) pageSize);
        int startIndex = (currentPage - 1) * pageSize;
        products = productDAO.getProductsByPage(startIndex, pageSize);
    }
%>
<html>
<head>
    <title>상품 목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bookShop/css/bookShop.css" />
    <script type="text/javascript">
        function addToCart(bookID) {
            if (confirm('상품을 장바구니에 추가하시겠습니까?')) {
                window.location.href = './addCart.jsp?id=' + bookID;
            } else {
                window.location.href = './products.jsp';
            }
        }

        function orderNow(bookID) {
            if (confirm('상품을 주문하시겠습니까?')) {
                window.location.href = './checkout.jsp?id=' + bookID;
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
                if (products.isEmpty()) {
            %>
                <div class="alert alert-warning">검색된 상품이 없습니다.</div>
            <%
                } else {
                    for (ProductVO product : products) {
            %>
                <div class="product-item">
                    <div class="product-image">
                        <img src="<%= request.getContextPath() %>/upload/<%= product.getFilename() %>" alt="<%= product.getBookName() %>">
                    </div>
                    <div class="product-info">
                        <div class="product-title"><%= product.getBookName() %></div>
                        <div class="product-meta">
                            저자: <%= product.getAuthor() %> | 출판사: <%= product.getPublisher() %> | 분류: <%= product.getCategory() %>
                        </div>
                        <div class="product-price"><%= product.getUnitPrice() %>원</div>
                        <div class="product-actions">
                            <a href="${pageContext.request.contextPath}/bookShop/product.jsp?id=<%= product.getBookID() %>" class="btn btn-primary">상세 보기</a>
                            <a href="javascript:void(0);" class="btn btn-warning" onclick="addToCart('<%= product.getBookID() %>')">장바구니 추가</a>
                            <a href="javascript:void(0);" class="btn btn-success" onclick="orderNow('<%= product.getBookID() %>')">주문하기</a>
                        </div>
                    </div>
                </div>
            <%
                    }
                }
            %>
        </div>
        <!-- 페이징 -->
        <div class="paging-container">
            <div class="paging">
                <ul>
                    <% if (currentPage > 1) { %>
                        <li><a href="?page=<%= currentPage - 1 %>" class="prev">이전</a></li>
                    <% } else { %>
                        <li><a class="disabled">이전</a></li>
                    <% } %>
                    <% for (int i = 1; i <= totalPages; i++) { %>
                        <li>
                            <a href="?page=<%= i %>" class="<%= (i == currentPage) ? "current-page" : "" %>"><%= i %></a>
                        </li>
                    <% } %>
                    <% if (currentPage < totalPages) { %>
                        <li><a href="?page=<%= currentPage + 1 %>" class="next">다음</a></li>
                    <% } else { %>
                        <li><a class="disabled">다음</a></li>
                    <% } %>
                </ul>
            </div>
            <!-- 검색창  -->
            <div class="search-bar">
                <form action="products.jsp" method="get">
                    <input type="text" name="search" placeholder="책 이름으로 검색" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                    <button type="submit">검색</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
<%@ include file="/includes/mainFooter.jsp" %>
