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
	var address = sido + " " + gugun + " " + dong + " " + bunji;
	opener.document.regForm.zipcode.value = zipcode;
	opener.document.regForm.address1.value = address;
	self.close();
}