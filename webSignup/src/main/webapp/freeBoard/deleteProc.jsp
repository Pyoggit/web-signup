<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="kr.co.pyo.freeBoard.model.FreeBoardDAO"%>
<%@ page import="kr.co.pyo.freeBoard.model.FreeBoardVO"%>

<%
    request.setCharacterEncoding("UTF-8");
    int num = Integer.parseInt(request.getParameter("num"));
    String pageNum = request.getParameter("pageNum");
    String pass = request.getParameter("pass");
%>

<%
    FreeBoardVO vo = new FreeBoardVO();
    vo.setNum(num);
    vo.setPass(pass);
    FreeBoardDAO dao = FreeBoardDAO.getInstance();
    boolean flag = dao.deleteDB(vo);
    if (flag) {
%>

<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum%>">

<%
    } else {
%>

<script language="JavaScript">
    alert("비밀번호가 맞지 않습니다.");
    history.go(-1);
</script>

<%
    }
%>
