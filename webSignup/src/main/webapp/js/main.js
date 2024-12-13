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

// 게시글 삭제 폼 검증
function deleteSave() {
    const password = document.delForm.pass.value;

    // 패스워드 패턴: 최소 8자, 영문자, 숫자, 특수문자 포함
    const pattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

    if (!password) {
        alert("비밀번호를 입력해 주세요.");
        document.delForm.pass.focus();
        return false;
    }

    if (!pattern.test(password)) {
        alert("비밀번호는 최소 8자 이상, 영문자, 숫자, 특수문자를 포함해야 합니다.");
        document.delForm.pass.focus();
        return false;
    }

    return true; // 패스워드가 유효하면 폼 제출
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
    slideshow_slides.addEventListener("mouseenter", (event)=>{
        clearInterval(timerID);
    });
    slideshow_slides.addEventListener("mouseleave", (event)=>{
        startTimer();
    });
    
    prev.addEventListener("mouseenter", (event)=>{
        clearInterval(timerID);
    });
    prev.addEventListener("mouseleave", (event)=>{
        startTimer();
    });
    
    next.addEventListener("mouseenter", (event)=>{
        clearInterval(timerID);
    });
    next.addEventListener("mouseleave", (event)=>{
        startTimer();
    });

    prev.addEventListener("click", (event)=>{
        event.preventDefault(); //anchor tag가 가지고 있는 페이지 이동 기본 기능을 막아라
        currentIndex = currentIndex - 1
        if(currentIndex< 0 ){
            currentIndex = slideCount -1;
        }
        gotoslide(currentIndex);
    });

    next.addEventListener("click", (event)=>{
        event.preventDefault(); //anchor tag가 가지고 있는 페이지 이동 기본 기능을 막아라
        currentIndex = currentIndex + 1
        if(currentIndex > (slideCount-1) ){
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

// 로그인 페이지 팝업창 이동기능
document.addEventListener("DOMContentLoaded", function () {
    const startButton = document.querySelector(".header-icons a"); 

    startButton.addEventListener("click", function (event) {
        event.preventDefault();

        const popupWidth = 500;
        const popupHeight = 600;

        // 브라우저 창의 가로/세로 크기 계산
        const screenWidth = window.screen.width;
        const screenHeight = window.screen.height;

        // 팝업 창의 위치 계산 (가운데 정렬)
        const popupX = Math.round((screenWidth - popupWidth) / 2);
        const popupY = Math.round((screenHeight - popupHeight) / 2);

        const popup = window.open(
            startButton.href,
            "StartPopup",
            `width=${popupWidth},height=${popupHeight},left=${popupX},top=${popupY},scrollbars=no,resizable=no`
        );

        if (!popup) {
            alert("팝업 차단이 활성화되어 있습니다. 팝업을 허용해주세요.");
        }
    });
});

