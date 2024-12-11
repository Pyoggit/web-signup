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
                <label for="pwd">비밀번호</label>
            </div>
            <div class="int-area">
                <input type="password" name="pwdtest" id="pwdtest" autocomplete="off" required>
                <label for="pwdtest">비밀번호 확인</label>
            </div>
            <div class="int-area">
                <input type="email" name="email" id="email" autocomplete="off" required>
                <label for="email">이메일</label>
            </div>
            <div class="int-area">
                <input type="text" name="name" id="name" autocomplete="off" required>
                <label for="name">이름</label>
            </div>
            <div class="int-area">
                <input type="text" name="birth" id="birth" autocomplete="off">
                <label for="birth">생년월일 (예: 20000101)</label>
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
