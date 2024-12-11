<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup.css">
    <script src="/webSignup/js/idCheck.js"></script>
</head>
<body>
    <div class="signup-form">
        <h1>회원가입</h1>
        <form action="${pageContext.request.contextPath}/registerServlet.do" method="post">
            <div class="int-area">
                <div class="input-wrapper">
                    <input type="text" name="id" id="id" autocomplete="off" required>
                    <label for="id">아이디</label>
                    <div class="button-wrapper">
                        <input type="button" value="중복확인" onClick="idCheck()">
                    </div>
                </div>
            </div>
            <div class="int-area">
                <input type="password" name="pwd" id="pwd" autocomplete="off" required>
                <label for="pwd">패스워드</label>
            </div>
            <div class="int-area">
                <input type="password" name="pwdtest" id="pwdtest" autocomplete="off" required>
                <label for="pwdtest">패스워드 확인</label>
            </div>
            <div class="int-area">
                <input type="text" name="name" id="name" autocomplete="off" required>
                <label for="name">이름</label>
            </div>
            <div class="int-area">
                <input type="text" name="birth" id="birth" autocomplete="off" required>
                <label for="birth">생년월일 (예: 20210101)</label>
            </div>
            <div class="int-area">
                <input type="text" name="phone" id="phone" autocomplete="off" required>
                <label for="phone">전화번호 (예: 010-1234-5678)</label>
            </div>
            <div class="int-area">
                <input type="email" name="email" id="email" autocomplete="off" required>
                <label for="email">이메일</label>
            </div>
            <div class="int-area">
                <div class="input-wrapper">
                    <input type="text" name="zipcode" id="zipcode" autocomplete="off" required>
                    <label for="zipcode">우편번호</label>
                    <div class="button-wrapper">
                        <input type="button" value="우편번호찾기" onClick="idCheck()">
                    </div>
                </div>
            </div>
            <div class="int-area">
                <input type="text" name="address1" id="address1" autocomplete="off" required>
                <label for="address1">주소</label>
            </div>
            <div class="int-area">
                <input type="text" name="address2" id="address2" autocomplete="off" required>
                <label for="address2">상세주소</label>
            </div>
            <div class="caption">
                <button type="reset">다시 입력</button>
            </div>
            <div class="btn-area">
                <button type="submit">회원 가입</button>
            </div>
        </form>
    </div>
</body>
</html>
