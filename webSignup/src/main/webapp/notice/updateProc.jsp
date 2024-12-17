<%@ page import="kr.co.pyo.notice.model.NoticeDAO"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String pageNum = request.getParameter("pageNum");
%>

<jsp:useBean id="vo" scope="page" class="kr.co.pyo.notice.model.NoticeVO">
	<jsp:setProperty name="vo" property="*" />
</jsp:useBean>

<%
		NoticeDAO ndao = NoticeDAO.getInstance();
		int check = ndao.updateDB(vo);
		//1:성공 2:패스워드문제 3:수정문제
			if (check == 1) {
%>

<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum%>">

<%
				} else if(check == 2){
%>

<script language="JavaScript"> 
    alert("비밀번호가 맞지 않습니다"); 
    history.go(-1);
</script>
<%
			}else{			
%>
<script language="JavaScript"> 
    alert("수정 입력이 맞지 않습니다."); 
    history.go(-1);
</script>
<%
			}
%>
