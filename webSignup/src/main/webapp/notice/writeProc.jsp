<%@ page import="kr.co.pyo.notice.model.NoticeDAO" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // 인코딩 설정
    request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="vo" scope="page" class="kr.co.pyo.notice.model.NoticeVO">
    <jsp:setProperty name="vo" property="*" />
</jsp:useBean>

<%
    vo.setRegdate(new Timestamp(System.currentTimeMillis())); // 현재 시간 설정
    vo.setIp(request.getRemoteAddr()); // IP 주소 설정

    // DAO 인스턴스 생성
    NoticeDAO ndao = NoticeDAO.getInstance();

    // 답변글인지 새글인지 확인
    boolean flag = ndao.insertDB(vo);

    if (flag) {
        // 게시글 등록 성공 시 리스트 페이지로 리다이렉트
        response.sendRedirect("list.jsp");
    } else {
%>
        <script>
            alert("공지사항 등록에 실패하였습니다.");
            history.go(-1);
        </script>
<%
    }
%>
