<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="kr.co.pyo.notice.model.NoticeDAO"%>
<%@ page import="kr.co.pyo.notice.model.NoticeVO"%>

<%
	request.setCharacterEncoding("UTF-8");
 	int num = Integer.parseInt(request.getParameter("num"));
 	String pageNum = request.getParameter("pageNum");
 	String pass = request.getParameter("pass");
%>

<%
	NoticeVO vo = new NoticeVO();
	vo.setNum(num);
	vo.setPass(pass);
 	NoticeDAO ndao = NoticeDAO.getInstance();
 	boolean flag = ndao.deleteDB(vo);
 	if(flag == true){
%>

<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum%>">

<% 
		}else{
%>

<script language="JavaScript"> 
	alert("비밀번호가 맞지 않습니다");
	history.go(-1); 
</script>
 
<%
 }
%>
