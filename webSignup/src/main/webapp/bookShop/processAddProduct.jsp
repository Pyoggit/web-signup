<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="kr.co.pyo.bookShop.model.ProductVO"%>
<%@ page import="kr.co.pyo.bookShop.model.ProductDAO"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.io.File"%>

<%
    // 업로드 설정
    String realFolder = application.getRealPath("/upload"); // 업로드 경로
    int maxSize = 5 * 1024 * 1024; // 최대 파일 크기 5MB
    String encType = "utf-8"; // 인코딩 방식

    // 업로드 폴더 확인 및 생성
    File uploadDir = new File(realFolder);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs(); // 업로드 디렉토리가 없으면 생성
    }

    // 파일 업로드 처리
    MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

    // 폼 데이터 가져오기
    String bookID = multi.getParameter("bookID");
    String bookName = multi.getParameter("bookName");
    String unitPrice = multi.getParameter("unitPrice");
    String description = multi.getParameter("description");
    String author = multi.getParameter("author");
    String publisher = multi.getParameter("publisher");
    String category = multi.getParameter("category");
    String unitsInStock = multi.getParameter("unitsInStock");
    String condition = multi.getParameter("condition");

    // 파일 이름 가져오기
    Enumeration<?> files = multi.getFileNames();
    String filename = null;
    if (files.hasMoreElements()) {
        String fileElement = (String) files.nextElement();
        filename = multi.getFilesystemName(fileElement); // 업로드된 파일 이름 가져오기
        System.out.println("업로드된 파일 이름: " + filename); // 디버깅용
    } else {
        System.out.println("업로드된 파일이 없습니다.");
    }

    // 데이터 검증 및 변환
    Integer price = (unitPrice == null || unitPrice.isEmpty()) ? 0 : Integer.valueOf(unitPrice);
    long stock = (unitsInStock == null || unitsInStock.isEmpty()) ? 0 : Long.valueOf(unitsInStock);

    // DAO 호출
    ProductDAO dao = new ProductDAO();
    ProductVO newProduct = new ProductVO();
    newProduct.setBookID(bookID);
    newProduct.setBookName(bookName);
    newProduct.setUnitPrice(price);
    newProduct.setDescription(description);
    newProduct.setAuthor(author);
    newProduct.setPublisher(publisher);
    newProduct.setCategory(category);
    newProduct.setUnitsInStock(stock);
    newProduct.setCondition(condition);
    newProduct.setFilename(filename); // 파일 이름 설정

    dao.addProduct(newProduct); // DB에 저장

		// 완료 후 페이지 이동
    response.sendRedirect(request.getContextPath() + "/products.jsp");

%>
