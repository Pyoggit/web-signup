<%@ page import="kr.co.pyo.notice.model.NoticeDAO" %>
<%@ page import="kr.co.pyo.notice.model.NoticeVO" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    try {
        request.setCharacterEncoding("UTF-8");

        // 로그인 정보 가져오기 (암시적 객체 session 사용)
        String userName = (String) session.getAttribute("userName");
        String userEmail = (String) session.getAttribute("userEmail");

        // 로그인 확인
        if (userName == null || userEmail == null) {
            response.sendRedirect(request.getContextPath() + "/signup/login.jsp");
            return;
        }

        // 게시글 데이터 설정
        NoticeVO vo = new NoticeVO();
        vo.setWriter(userName);
        vo.setEmail(userEmail);
        vo.setSubject(request.getParameter("subject"));
        vo.setContent(request.getParameter("content"));
        vo.setPass(request.getParameter("pass"));
        vo.setRegdate(new Timestamp(System.currentTimeMillis())); // 현재 시간 설정
        vo.setIp(request.getRemoteAddr()); // IP 주소 설정

        // DAO 인스턴스 생성
        NoticeDAO ndao = NoticeDAO.getInstance();

        // 게시글 저장
        boolean flag = ndao.insertDB(vo);

        if (flag) {
            // 게시글 등록 성공 시 리스트 페이지로 리다이렉트
            response.sendRedirect("list.jsp");
        } else {
            throw new Exception("공지사항 등록에 실패하였습니다.");
        }
    } catch (Exception e) {
%>
        <script>
            alert("<%= e.getMessage() %>");
            history.back();
        </script>
<%
    }
%>
