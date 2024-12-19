<%@ page import="kr.co.pyo.board.model.BoardDAO" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!-- 1.사용자정보를 가져온다  -->
<%
request.setCharacterEncoding("UTF-8"); 
%>
<jsp:useBean id="vo" scope="page" class="kr.co.pyo.board.model.BoardVO">
   <jsp:setProperty name="vo" property="*"/>
</jsp:useBean>
<!-- 2.curd  -->
<!-- 3.화면설계(자바코드에 해야되는데 - > jsp service함수에서 진행한다. -->
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
		alert("게시판글등록이 실패되었습니다.");
		history.go(-1);
</script>
<%		
}
%>
