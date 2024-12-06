<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="./signup.css">
</head>
<body>
    <form action="registerServlet.do" method="post">
        <table>
            <thead>
                <tr>
                    <th colspan="2">회원 기본 정보</th>
                </tr>
            </thead>
            <tr>
                <th class="title">아이디:</th>
                <td><input type="text" name="id" id="id" required><i>4~12자의 영문 대소문자와 숫자로만 입력</i></td>
            </tr>
            <tr>
                <th class="title">비밀번호:</th>
                <td><input type="password" name="pwd" id="pwd" required><i>4~12자의 영문 대소문자와 숫자로만 입력</i></td>
            </tr>
            <tr>
                <th class="title">비밀번호확인:</th>
                <td><input type="password" name="pwdtest" id="pwdtest" required></td>
            </tr>
            <tr>
                <th class="title">메일주소:</th>
                <td><input type="text" name="email" id="email" required><i>ex) abcd@gmail.com</i></td>
            </tr>
            <tr>
                <th class="title">이름:</th>
                <td><input type="text" name="name" id="name" required></td>
            </tr>
            <tr>
                <th class="title">생년월일:</th>
                <td><input type="text" name="birth" id="birth"><i>ex) 20000101</i></td>
            </tr>
        </table>

        <footer>
            <hr>
            <button type="submit">회원 가입</button>
            <button type="reset">다시 입력</button>
        </footer>
    </form>
</body>
</html>
