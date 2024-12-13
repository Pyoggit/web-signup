function writeSave() {
	if (document.writeForm.writer.value == "") {
		alert("작성자를 입력하십시요.");
		document.writeForm.writer.focus();
		return false;
	}
	if (document.writeForm.subject.value == "") {
		alert("제목을 입력하십시요.");
		document.writeForm.subject.focus();
		return false;
	}
	if (document.writeForm.content.value == "") {
		alert("내용을 입력하십시요.");
		document.writeForm.content.focus();
		return false;
	}

	if (document.writeForm.pass.value == "") {
		alert(" 비밀번호를 입력하십시요.");
		document.writeForm.pass.focus();
		return false;
	}
}

// 패스워드 삭제 패턴검색
function deleteSave() {
		if (document.delForm.pass.value == '') {
			alert("비밀번호를 입력하십시요.");
			document.delForm.pass.focus();
			return false;
		}
	}