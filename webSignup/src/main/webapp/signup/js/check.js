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

/* 주소내용을 불러주는 윈도우창 각 요소저장 */
function sendAddress(zipcode, sido, gugun, dong, bunji) {
	const address = `${sido} ${gugun} ${dong} ${bunji}`;
	if (opener && opener.document) {
		const signupForm = opener.document.signup;
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

/* 패턴검색 */
document.addEventListener("DOMContentLoaded", function() {
	const idPattern = /^[\w]{3,}$/;
	const pwdPattern = /^[\w]{6,10}$/;
	const namePattern = /^[가-힣]{2,4}|[A-Z]{1}[a-zA-Z\x20]{1,19}$/;
	const emailPattern = /^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;

	const id = document.querySelector("#id");
	const pwd = document.querySelector("#pwd");
	const pwdtest = document.querySelector("#pwdtest");
	const name = document.querySelector("#name");
	const email = document.querySelector("#email");

	const validateInput = (input, pattern, message) => {
		const feedback = input.nextElementSibling;
		if (pattern.test(input.value)) {
			feedback.textContent = "유효합니다.";
			feedback.style.color = "blue";
		} else {
			feedback.textContent = message;
			feedback.style.color = "red";
			input.focus();
		}
	};

	id.addEventListener("blur", () => {
		validateInput(id, idPattern, "영문자, 숫자, 3글자 이상 입력하세요.");
	});

	pwd.addEventListener("blur", () => {
		validateInput(pwd, pwdPattern, "영문자와 숫자, 6~10자 입력하세요.");
	});

	pwdtest.addEventListener("blur", () => {
		if (pwd.value !== pwdtest.value) {
			const feedback = pwdtest.nextElementSibling;
			feedback.textContent = "비밀번호가 일치하지 않습니다.";
			feedback.style.color = "red";
			pwdtest.focus();
		} else {
			validateInput(pwdtest, pwdPattern, "영문자와 숫자, 6~10자 입력하세요.");
		}
	});

	name.addEventListener("blur", () => {
		validateInput(name, namePattern, "한글 2~4자 또는 영어 2~20자로 입력하세요.");
	});

	email.addEventListener("blur", () => {
		validateInput(email, emailPattern, "유효한 이메일 형식을 입력하세요.");
	});

	document.querySelector("form").addEventListener("submit", (event) => {
		event.preventDefault();
		if (id.value === "" || pwd.value === "" || pwdtest.value === "" || name.value === "" || email.value === "") {
			alert("모든 필드를 올바르게 입력해주세요.");
			return;
		}
		alert("회원가입이 완료되었습니다.");
		event.target.submit();
	});
});

// 생년월일 체크 이벤트처리
document.addEventListener("DOMContentLoaded", function() {
	const yearInput = document.getElementById("year");
	const monthSelect = document.getElementById("month");
	const daySelect = document.getElementById("day");
	const birthInput = document.getElementById("birth");

	function updateBirthField() {
		const year = yearInput.value;
		const month = monthSelect.value;
		const day = daySelect.value;

		if (year && month && day) {
			birthInput.value = `${year}${month.padStart(2, '0')}${day.padStart(2, '0')}`;
		} else {
			birthInput.value = ""; // 값이 하나라도 비어 있으면 초기화
		}
	}

	// 이벤트 리스너 추가
	yearInput.addEventListener("input", updateBirthField);
	monthSelect.addEventListener("change", updateBirthField);
	daySelect.addEventListener("change", updateBirthField);
});

