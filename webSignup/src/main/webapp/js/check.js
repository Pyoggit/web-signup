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
/*회원가입폼 주소체크*/
function zipCheck() {
	url = "zipCheck.jsp?check=y";
	window.open(url, "post", "toolbar=no ,width=600 ,height=300, directories=no,status=yes,scrollbars=yes,menubar=no");
}
/*회원가입폼 동체크*/
function dongCheck() {
	let value = document.zipForm.dong.value;
	if (value === "") {
		alert("동이름을 입력해 주세요.");
		document.zipForm.dong.focus();
		return;
	}
	document.zipForm.submit();
}
/*주소내용을 불러주는 윈도우창 각 요소저장*/
function sendAddress(zipcode, sido, gugun, dong, bunji) {
    const address = `${sido} ${gugun} ${dong} ${bunji}`;
    if (opener && opener.document) {
        const signupForm = opener.document.signup; // signup 폼으로 변경
        if (signupForm) {
            signupForm.zipcode.value = zipcode;
            signupForm.address1.value = address;
        } else {
            alert("회원가입 폼을 찾을 수 없습니다.");
        }
    } else {
        alert("부모 창이 존재하지 않습니다.");
    }
    self.close();
}