<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="mainHeader.jsp"%>
<html>
<head>
    <title>상품등록페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bookShop/css/bookShop.css"/>
    <script src="${pageContext.request.contextPath}/bookShop/js/bookShop.js"></script>
</head>
<body>
    <div class="jumbotron">
        <div class="container">
            <h1 class="display-3">도서등록</h1>
        </div>
    </div>
    <div class="container">
        <form name="newProduct" action="${pageContext.request.contextPath}/bookShop/processAddProduct.jsp" class="form-horizontal" method="post" enctype="multipart/form-data">
            <div class="form-group row">
                <label class="col-sm-2">도서코드</label>
                <div class="col-sm-3">
                    <input type="text" id="bookID" name="bookID" class="form-control">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">도서명</label>
                <div class="col-sm-3">
                    <input type="text" id="bookName" name="bookName" class="form-control">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">가격</label>
                <div class="col-sm-3">
                    <input type="text" id="unitPrice" name="unitPrice" class="form-control">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">상세정보</label>
                <div class="col-sm-5">
                    <textarea name="description" cols="50" rows="2" class="form-control"></textarea>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">저자</label>
                <div class="col-sm-3">
                    <input type="text" name="author" class="form-control">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">출판사</label>
                <div class="col-sm-3">
                    <input type="text" name="publisher" class="form-control">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">분류</label>
                <div class="col-sm-3">
                    <input type="text" name="category" class="form-control">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">재고 수</label>
                <div class="col-sm-3">
                    <input type="text" id="unitsInStock" name="unitsInStock" class="form-control">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2">상태</label>
                <div class="col-sm-5">
                    <input type="radio" name="condition" value="New"> 신규 
                    <input type="radio" name="condition" value="Old"> 중고
                    <input type="radio" name="condition" value="E-Book"> E-Book
                </div>
            </div>
            <!-- 이미지 등록 -->
						<div class="form-group row">
							<label class="col-sm-2">이미지</label>
							<div class="col-sm-5">
								<input type="file" name="file" class="form-control">
							</div>
						</div>
            <div class="form-group row">
                <div class="col-sm-offset-2 col-sm-10">
                    <input type="submit" class="btn btn-primary" value="등록하기">
                </div>
            </div>
        </form>
    </div>
</body>
</html>
<%@ include file="mainFooter.jsp"%> 