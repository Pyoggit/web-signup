function idCheck() {
    const idInput = document.getElementById("id").value;

    if (!idInput) {
        alert("아이디를 입력하세요.");
        return;
    }

    // JSP 페이지의 정확한 경로를 지정합니다.
    const url = `${window.location.origin}/webSignup/signup/idCheck.jsp?id=${encodeURIComponent(idInput)}`;

    // 팝업 창을 엽니다.
    window.open(url, "idCheck", "width=500,height=300,resizable=no");
}


