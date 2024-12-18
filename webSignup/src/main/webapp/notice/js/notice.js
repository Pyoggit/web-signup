window.onload = function() {
	carousel();
};


// 게시글 작성 폼 검증
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
		alert("비밀번호를 입력하십시요.");
		document.writeForm.pass.focus();
		return false;
	}
}

function deleteSave() {
	if (document.delForm.pass.value == '') {
		alert("비밀번호를 입력하십시요.");
		document.delForm.pass.focus();
		return false;
	}
}

function replySave() {
    if (document.replyForm.content.value == "") {
        alert("답변 내용을 입력하십시요.");
        document.replyForm.content.focus();
        return false;
    }
}



document.addEventListener("DOMContentLoaded", function () {
    // 로그인 팝업창 열기
    const loginButtons = document.querySelectorAll(".start-btn");
    loginButtons.forEach(function (button) {
        button.addEventListener("click", function (event) {
            event.preventDefault();

            const popupWidth = 550;
            const popupHeight = 800;

            const screenWidth = window.screen.width;
            const screenHeight = window.screen.height;

            const popupX = Math.round((screenWidth - popupWidth) / 2);
            const popupY = Math.round((screenHeight - popupHeight) / 2);

            const popup = window.open(
                button.href,
                "LoginPopup",
                `width=${popupWidth},height=${popupHeight},left=${popupX},top=${popupY},scrollbars=no,resizable=no`
            );

            if (!popup) {
                alert("팝업 차단이 활성화되어 있습니다. 팝업을 허용해주세요.");
            }
        });
    });
});
