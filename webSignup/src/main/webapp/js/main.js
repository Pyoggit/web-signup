window.onload = function() {
    carousel();
};

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