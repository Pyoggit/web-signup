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


function carousel() {
	let slideshow = document.querySelector(".slideshow");
	let slideshow_slides = document.querySelector(".slideshow_slides");
	let aSlidesArray = document.querySelectorAll(".slideshow_slides a");

	let prev = document.querySelector(".prev");
	let next = document.querySelector(".next");
	let indicatorArray = document.querySelectorAll(".slideshow_indicator a"); // 수정됨

	// 현재 이미지 인덱스
	let currentIndex = 0;
	let timerID = null;
	let slideCount = aSlidesArray.length; // 수정됨

	// 현재 이미지를 한 줄로 정렬
	for (let i = 0; i < slideCount; i++) {
		let newLeft = `${i * 100}%`;
		aSlidesArray[i].style.left = newLeft; // 수정됨
	}

	// 화면 전환 함수
	function gotoslide(index) {
		currentIndex = index;
		let newLeft = `${index * -100}%`;
		slideshow_slides.style.left = newLeft;

		// 인디케이터의 위치를 업데이트
		for (let i = 0; i < slideCount; i++) {
			indicatorArray[i].classList.remove('active');
		}
		indicatorArray[index].classList.add('active');
	}

	// 타이머 시작 함수
	function startTimer() {
		timerID = setInterval(() => {
			let index = (currentIndex + 1) % slideCount;
			gotoslide(index);
		}, 3000);
	}

	// 타이머 시작
	startTimer();

	// 초기 슬라이드 호출
	gotoslide(0);


	//이벤트 등록 핸들러기능
	slideshow_slides.addEventListener("mouseenter", (event) => {
		clearInterval(timerID);
	});
	slideshow_slides.addEventListener("mouseleave", (event) => {
		startTimer();
	});

	prev.addEventListener("mouseenter", (event) => {
		clearInterval(timerID);
	});
	prev.addEventListener("mouseleave", (event) => {
		startTimer();
	});

	next.addEventListener("mouseenter", (event) => {
		clearInterval(timerID);
	});
	next.addEventListener("mouseleave", (event) => {
		startTimer();
	});

	prev.addEventListener("click", (event) => {
		event.preventDefault(); //anchor tag가 가지고 있는 페이지 이동 기본 기능을 막아라
		currentIndex = currentIndex - 1
		if (currentIndex < 0) {
			currentIndex = slideCount - 1;
		}
		gotoslide(currentIndex);
	});

	next.addEventListener("click", (event) => {
		event.preventDefault(); //anchor tag가 가지고 있는 페이지 이동 기본 기능을 막아라
		currentIndex = currentIndex + 1
		if (currentIndex > (slideCount - 1)) {
			currentIndex = 0;
		}
		gotoslide(currentIndex);
	});

	//indicator 클릭하면 해당된 페이지로 이동

	indicatorArray.forEach((indicator, index) => {
		indicator.addEventListener("mouseenter", () => clearInterval(timerID));
		indicator.addEventListener("mouseleave", startTimer);
		indicator.addEventListener("click", (event) => {
			event.preventDefault();
			gotoslide(index);
		});
	});


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

// 슬라이드쇼 기능
document.addEventListener("DOMContentLoaded", function () {
    const slides = document.querySelectorAll(".slideshow_slides a");
    const indicators = document.querySelectorAll(".slideshow_indicator a");
    let currentIndex = 0;
    const slideInterval = 3000;

    function goToSlide(index) {
        slides.forEach((slide, i) => {
            slide.style.transform = `translateX(${100 * (i - index)}%)`;
        });
        indicators.forEach((indicator, i) => {
            indicator.classList.toggle("active", i === index);
        });
        currentIndex = index;
    }

    function nextSlide() {
        const nextIndex = (currentIndex + 1) % slides.length;
        goToSlide(nextIndex);
    }

    // 초기화
    goToSlide(currentIndex);
    setInterval(nextSlide, slideInterval);

    // 네비게이션 버튼
    document.querySelector(".slideshow_nav .prev").addEventListener("click", () => {
        goToSlide((currentIndex - 1 + slides.length) % slides.length);
    });
    document.querySelector(".slideshow_nav .next").addEventListener("click", () => {
        nextSlide();
    });
});

// 드롭다운 메뉴 기능
document.querySelectorAll(".dropdown").forEach((dropdown) => {
    dropdown.addEventListener("mouseenter", function () {
        this.querySelector(".dropdown-content").style.display = "block";
    });
    dropdown.addEventListener("mouseleave", function () {
        this.querySelector(".dropdown-content").style.display = "none";
    });
});

/*// 폼 유효성 검사
document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form[name='newProduct']");

    if (form) {
        form.addEventListener("submit", function (e) {
            const bookID = form.bookID.value.trim();
            const bookName = form.bookName.value.trim();
            const unitPrice = form.unitPrice.value.trim();

            if (!bookID || !bookName || !unitPrice) {
                alert("도서코드, 도서명, 가격은 필수 입력 항목입니다.");
                e.preventDefault();
            } else if (isNaN(unitPrice)) {
                alert("가격은 숫자만 입력 가능합니다.");
                e.preventDefault();
            }
        });
    }
});

// 상품 주문 버튼 알림
document.addEventListener("click", function (e) {
    if (e.target.classList.contains("btn-info")) {
        e.preventDefault();
        alert("상품 주문 기능은 아직 준비 중입니다!");
    }
});

// 페이지 상단으로 이동 버튼 (선택 사항)
document.addEventListener("DOMContentLoaded", function () {
    const scrollToTopBtn = document.createElement("button");
    scrollToTopBtn.textContent = "▲";
    scrollToTopBtn.style.cssText = `
        position: fixed;
        bottom: 20px;
        right: 20px;
        padding: 10px;
        background-color: #166cea;
        color: white;
        border: none;
        border-radius: 50%;
        cursor: pointer;
        display: none;
    `;
    document.body.appendChild(scrollToTopBtn);

    scrollToTopBtn.addEventListener("click", function () {
        window.scrollTo({ top: 0, behavior: "smooth" });
    });

    window.addEventListener("scroll", function () {
        if (window.scrollY > 200) {
            scrollToTopBtn.style.display = "block";
        } else {
            scrollToTopBtn.style.display = "none";
        }
    });
});*/


function toggleAll(selectAllCheckbox) {
    const checkboxes = document.querySelectorAll('input[name="selectedIds"]');
    checkboxes.forEach(checkbox => checkbox.checked = selectAllCheckbox.checked);
}

