<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="kr.co.pyo.board.model.BoardDAO"%>
<%@ page import="kr.co.pyo.board.model.BoardVO"%>

<%
	request.setCharacterEncoding("UTF-8");
	int num = 0;
	String pageNum = request.getParameter("pageNum");
	try {
	    num = Integer.parseInt(request.getParameter("num"));
	} catch (NumberFormatException e) {
	    num = -1;
	}
%>
<%
	BoardVO vo = new BoardVO();
	vo.setNum(num);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	BoardDAO bdao = BoardDAO.getInstance();
	BoardVO bvo = bdao.selectBoardDB(vo);
	if (bvo == null) {
	    out.println("<script>alert('해당 게시글을 찾을 수 없습니다.'); history.back();</script>");
	    return;
	}
%>


<!DOCTYPE html>
<html>
<head>
<title>게시판</title>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css">
</head>
<body>
    <main>
        <b>글내용 보기</b> <br></br>
        <form>
            <table width="500" border="1" cellspacing="0" cellpadding="0" align="center">
                <tr height="30">
                    <td align="center" width="125">글번호</td>
                    <td align="center" width="125"><%=bvo.getNum()%></td>
                    <td align="center" width="125">조회수</td>
                    <td align="center" width="125"><%=bvo.getReadcount()%></td>
                </tr>
                <tr height="30">
                    <td align="center" width="125">작성자</td>
                    <td align="center" width="125"><%=bvo.getWriter()%></td>
                    <td align="center" width="125">작성일</td>
                    <td align="center" width="125"><%= sdf.format(bvo.getRegdate())%></td>
                </tr>
                <tr height="30">
                    <td align="center" width="125">글제목</td>
                    <td align="center" width="375" colspan="3"><%=bvo.getSubject()%></td>
                </tr>
                <tr>
                    <td align="center" width="125">글내용</td>
                    <td align="left" width="375" colspan="3"><pre><%=bvo.getContent()%></pre></td>
                </tr>
                <tr height="30">
                    <td colspan="4" align="right">
                        <input type="button" value="글수정"
                            onclick="document.location.href='updateForm.jsp?num=<%=bvo.getNum()%>&pageNum=<%=pageNum%>'">
                        &nbsp;&nbsp;&nbsp;&nbsp; 
                        <input type="button" value="글삭제"
                            onclick="document.location.href='deleteForm.jsp?num=<%=bvo.getNum()%>&pageNum=<%=pageNum%>'">
                        &nbsp;&nbsp;&nbsp;&nbsp; 
                        <input type="button" value="글목록"
                            onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
                    </td>
                </tr>
            </table>
        </form>
    </main>
</body>
</html>
