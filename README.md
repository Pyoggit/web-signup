# JSP 기반 웹 프로젝트 - 게시판 및 사용자 관리 시스템

> **이 프로젝트는 Spring Boot를 도입하기 전에 **MVC1 패턴**과 **MVC2 패턴**을 경험함으로써 웹 개발의 흐름과 기능을 심도 있게 이해하기 위한 세미 프로젝트입니다.**


## 🗓 제작 기간
- 2024년 12월 6일 ~ 12월 28일

## 🎯 프로젝트 목표

1. 사용자가 게시글을 작성하고 관리할 수 있는 기능 제공
2. 로그인 사용자에 한해 게시판 및 쇼핑몰 이용 가능
3. **MVC 패턴**을 활용한 구조화된 코드 구현
4. 사용자 친화적인 UI/UX 디자인 제공


## 🛠 개발 환경
### Language
- **Java**: JDK 17.0.13

### IDE
- **Eclipse IDE**: 2023-09 (4.29)

### Database
- **Oracle Database**: 21c Express Edition
- **SQL Developer**: Version 23.1

### Server
- **Tomcat**: Apache Tomcat 9.0.97

---

## 📌 주요 기능
1. **로그인 기능**
   - 로그인한 사용자만 게시판 및 쇼핑몰 이용 가능
   - 세션 활용: 사용자 정보 유지 및 로그아웃 시 세션 무효화(invalidate)
     
2. **회원 가입**
   - 회원가입, 정보 수정/삭제 기능 제공
   - 중복 ID 검색 및 우편번호 검색 기능

3. **게시판 기능**
   - 자유게시판: 댓글 작성 가능
   - 문의하기(Q&A): 답변 형태로 게시글 연결
   - 공지사항: 읽기 전용 게시판
   - 작성자 본인만 글 수정 및 삭제 가능 (비밀번호 확인 추가)
<details>
<summary>💻문의화면</summary>
   <img src="https://github.com/user-attachments/assets/6dd5d52d-253c-4664-a75f-6a050d9ed4f0" alt="문의하기보기" width="70%">
</details>

<details>
<summary>💻공지화면</summary>
   <img src="https://github.com/user-attachments/assets/64029037-7698-4f5d-8439-325189f91e55" alt="공지사항보기" width="70%">
</details>


4. **상품 및 쇼핑몰 기능**
   - 상품 등록: 이미지 업로드(cos 라이브러리 사용), 상품 정보 저장
   - 상품 목록 페이징: 한 페이지에 5개씩 표시
   - 검색 기능: 상품 이름으로 상품 검색 가능
    
5. **장바구니 기능**
   - 장바구니 추가하여 주문하기 기능
   - 장바구니 상품 체크박스 사용하여 선택삭제 가능
   - 상품별 주문 금액 합계 확인후 결제하기 기능
   - 결제완료 후 주문내역 보기 기능 제공

## 🚧 핵심 트러블 슈팅

### 1. 로그인 연동 및 세션 관리
- 비로그인 상태로 특정 페이지 접근 시, 로그인 페이지로 리다이렉트 처리
<details>
<summary>[관련 코드보기]</summary>
<div markdown="1">
   
```java
if (session.getAttribute("userName") == null) {
    response.sendRedirect("login.jsp");
    return;
}
```
</div>
</details>


- `Session` 객체를 활용해 사용자 인증 상태를 유지하고 자동 입력 구현
<details>
<summary>[관련 코드보기]</summary>
<div markdown="1">
   
```java
String userId = (String) session.getAttribute("userId");
UserVO user = null;
if (userId != null) {
   UserDAO udao = UserDAO.getInstance();
   user = udao.getUserById(userId);
}
```
</div>
</details>


### 2. 페이징 처리
- 문의글 목록에서 한 페이지에 5개씩만 표시되도록 페이징 처리 구현
<details>
<summary>[관련 코드보기]</summary>
<div markdown="1">

```java
// JSP 파일에서 페이징 처리
<%
    int currentPage = 1; // 기본 페이지
    int pageSize = 5;    // 한 페이지에 표시할 항목 수
    String pageParam = request.getParameter("page");

    if (pageParam != null) {
        currentPage = Integer.parseInt(pageParam);
    }

    QuestionDAO questionDAO = new QuestionDAO();
    int totalQuestions = questionDAO.getTotalQuestionCount();
    int totalPages = (int) Math.ceil(totalQuestions / (double) pageSize);
    int startIndex = (currentPage - 1) * pageSize;

    ArrayList<QuestionVO> questions = questionDAO.getQuestionsByPage(startIndex, pageSize);
%>

<div class="paging">
    <ul>
        <% if (currentPage > 1) { %>
            <li><a href="?page=<%= currentPage - 1 %>">이전</a></li>
        <% } %>
        <% for (int i = 1; i <= totalPages; i++) { %>
            <li><a href="?page=<%= i %>" class="<%= (i == currentPage) ? "current-page" : "" %>"><%= i %></a></li>
        <% } %>
        <% if (currentPage < totalPages) { %>
            <li><a href="?page=<%= currentPage + 1 %>">다음</a></li>
        <% } %>
    </ul>
</div>
```
</div>
</details>

- `limit`과 `offset`을 활용한 효율적인 데이터베이스 쿼리 작성
<details>
<summary>[관련 코드보기]</summary>
<div markdown="1">

```java
// DAO 클래스의 메서드
public ArrayList<QuestionVO> getQuestionsByPage(int startIndex, int pageSize) {
    ArrayList<QuestionVO> questions = new ArrayList<>();
    String sql = "SELECT * FROM QUESTIONS ORDER BY CREATED_DATE DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    try (Connection con = ConnectionPool.getInstance().dbCon();
         PreparedStatement pstmt = con.prepareStatement(sql)) {
        pstmt.setInt(1, startIndex);
        pstmt.setInt(2, pageSize);
        try (ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                QuestionVO question = new QuestionVO();
                question.setId(rs.getInt("ID"));
                question.setTitle(rs.getString("TITLE"));
                question.setContent(rs.getString("CONTENT"));
                question.setCreatedDate(rs.getDate("CREATED_DATE"));
                questions.add(question);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return questions;
}
```
</div>
</details>
  

### 3. 이미지 업로드 처리
- cos 라이브러리를 사용하여 이미지 업로드 처리
- 업로드 파일의 유효성 검사 및 저장 경로 설정

<details>
<summary>[관련 코드보기]</summary>
<div markdown="1">
   
```java

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

```
</div>
</details>


## 📜 구조 설계

### 1. MVC 패턴
  - **Model**: VO, DAO (데이터 관리 및 처리)
  - **View**: JSP 파일 (UI 구현)
  - **Controller**: 서블릿 (비즈니스 로직 처리)


## 💻 실행 화면
https://github.com/user-attachments/assets/0eb1ebf5-51c1-4e3d-969b-1354cb0a2f43
