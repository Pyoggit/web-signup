<%@ page import="kr.co.pyo.board.model.BoardDAO"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="vo" scope="page" class="kr.co.pyo.board.model.BoardVO">
 <jsp:setProperty name="vo" property="*"/>
</jsp:useBean>

<%
	vo.setRegdate(new Timestamp(System.currentTimeMillis()) );
	vo.setIp(request.getRemoteAddr());
	BoardDAO bdao = BoardDAO.getInstance();
	boolean flag = bdao.insertDB(vo);
	if(flag == true){
		response.sendRedirect("list.jsp");		
	}else{
%>
<script>
	alert("게시판 등록에 실패하였습니다.");
	history.go(-1);
</script>
<% 
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>