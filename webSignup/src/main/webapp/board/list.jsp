<%@ page import="kr.co.pyo.board.model.BoardDAO"%>
<%@ page import="kr.co.pyo.board.model.BoardVO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8"%>


<%
	//페이징 기법 ex) 1페이지 10개의 글
	int pageSize = 10;
	//
	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	//현재페이지 설정
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage - 1)*pageSize + 1; //ex) 4page 시작: (4-1)*10 + 1 = 31
	int end = (currentPage)*pageSize;           //ex) 4page 끝: (4)*10 = 40
	
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); 
%>


<%
		//해당된 페이지 10개
		int number = 0;
		ArrayList<BoardVO> boardList = null;
		BoardDAO bdao = BoardDAO.getInstance();
		//전체글갯수
		int count = bdao.selectCountDB();
		if (count > 0) {
			//현재페이지 내용 10개 가져오기
			boardList = bdao.selectStartEndDB(start, end);
		}
		// ex) 전체페이지 갯수가 100페이지라면 1페이지(100~91), 2페이지(90~81) ...
		number = count - (currentPage - 1) * pageSize;
		
		// depth값에 따라서 5배수 증가를 해서 화면에 출력 ex) depth: 1 => 길이 : 5, 2 => 10
		/*
		int wid = 0;
		if(data.getDepht() > 0){
			wid = 5 * data.getDepth();
			
		}
		*/
%>
<!DOCTYPE html>
<html>
<head>
<title>게시판</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css">
</head>
<body>
	<main>
		<b>글목록(전체 글:<%=count%>)
		</b>
		<table width="700">
			<tr>
				<td align="right">
				<a href="writeForm.jsp">글쓰기</a>
				</td>
			</tr>
		</table>
<%
		if (count == 0) {
%>
		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">게시판에 저장된 글이 없습니다.</td>
			</tr>	
		</table>
<%
		} else {
%>
		<table border="1" width="700" cellpadding="0" cellspacing="0"
			align="center">
			<tr height="30">
				<td align="center" width="50">번 호</td>
				<td align="center" width="250">제 목</td>
				<td align="center" width="100">작성자</td>
				<td align="center" width="150">작성일</td>
				<td align="center" width="50">조 회</td>
				<td align="center" width="100">IP</td>
			</tr>
<%
			
			for ( BoardVO article : boardList ) {
				/* int wid = 0;
				if(article.getDepth() > 0){
					wid = 5 * article.getDepth();					
				}		 */	
%>

			<tr height="30">
				<td align="center" width="50"><%=number--%></td>
				<td width="250">
					<a href="content.jsp?num=<%=article.getNum()%>&pageNum=1">
<%
						 //depth값에 따라서 5배수 증가를 해서 화면에 출력 ex) depth: 1 => 길이 : 5, 2 => 10
						 int wid=0; 
						 if(article.getDepth()>0){
						 wid=5*(article.getDepth());
%>
						 <img src="images/level.gif" width="<%=wid%>" height="16">
						 <img src="images/re.gif">
<%
}
%>								
						<%=article.getSubject()%></a> 
<%
	 if (article.getReadcount() >= 20) {
%> 
			<img src="images/hot.gif" border="0" height="16">
<%
					}
%>
				</td>
					<td align="center" width="100"><a href="mailto:<%=article.getEmail()%>"> <%=article.getWriter()%></a></td>
					<td align="center" width="150"><%=sdf.format(article.getRegdate())%></td>
					<td align="center" width="50"><%=article.getReadcount()%></td>
					<td align="center" width="100"><%=article.getIp()%></td>
			</tr>
<%
			}
%>
		</table>
<%
		}
%>
		<!-- 수정 <7> -->
	</main>
</body>
</html>
