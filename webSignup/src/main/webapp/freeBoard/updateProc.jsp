<%@ page import="kr.co.pyo.freeBoard.model.FreeBoardDAO"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String pageNum = request.getParameter("pageNum");
%>

<jsp:useBean id="vo" scope="page" class="kr.co.pyo.freeBoard.model.FreeBoardVO">
	<jsp:setProperty name="vo" property="*" />
</jsp:useBean>

<%
    FreeBoardDAO dao = FreeBoardDAO.getInstance();
    int check = dao.updateDB(vo);
    // 1: 성공, 2: 비밀번호 문제, 3: 수정 실패
    if (check == 1) {
%>
<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum%>">

<%
    } else if (check == 2) {
%>
<script language="JavaScript"> 
    alert("비밀번호가 맞지 않습니다."); 
    history.go(-1);
</script>
<%
    } else {			
%>
<script language="JavaScript"> 
    alert("수정 입력이 맞지 않습니다."); 
    history.go(-1);
</script>
<%
    }
%>
