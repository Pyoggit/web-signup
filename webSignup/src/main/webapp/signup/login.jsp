<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>로그인 페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/signup/css/login.css?ver=1.0" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/signup/js/check.js"></script>
</head>

<body>
    <section class="login-form">
        <h1>로그인</h1>
        <form action="/webSignup/loginCheckServlet.do" method="post">
            <div class="int-area">
                <input type="text" name="id" id="id" autocomplete="off" required />
                <label for="id">USER NAME</label>
            </div>
            <div class="int-area">
                <input type="password" name="pass" id="pwd" autocomplete="off" required />
                <label for="pwd">PASSWORD</label>
            </div>
            <div class="btn-area">
                <button type="submit" id="btn">LOGIN</button>
            </div>
        </form>
        <div class="caption">
            <a href="/webSignup/signup/signup.jsp">회원가입</a>
        </div>
    </section>

    <script>
        $(document).ready(function () {
            let id = $('#id');
            let pwd = $('#pwd');
            let btn = $('#btn');

            $(btn).on('click', function (event) {
                if ($(id).val() === "") {
                    event.preventDefault();
                    $(id).next('label').addClass('warning');
                    setTimeout(function () {
                        $('label').removeClass('warning');
                    }, 1500);
                } else if ($(pwd).val() === "") {
                    event.preventDefault();
                    $(pwd).next('label').addClass('warning');
                    setTimeout(function () {
                        $('label').removeClass('warning');
                    }, 1500);
                }
            });
        });
    </script>
</body>

</html>
