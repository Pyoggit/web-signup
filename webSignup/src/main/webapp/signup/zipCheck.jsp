<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.pyo.signup.model.ZipCodeDAO"%>
<%@page import="kr.co.pyo.signup.model.ZipCodeVO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 1.사용자정보를 가져온다  -->
<!-- 2.curd  -->
<%
request.setCharacterEncoding("UTF-8");
String dong = request.getParameter("dong");
String check = request.getParameter("check");
ArrayList<ZipCodeVO> zipList = null; 

if (check.equals("n") == true) {
	ZipCodeVO zvo = new ZipCodeVO();
	zvo.setDong(dong);
	ZipCodeDAO zdao = new ZipCodeDAO();
	zipList = zdao.selectZipCode(zvo);
}
%>
<!-- 3.화면설계(자바코드에 해야되는데 - > jsp service함수에서 진행한다. -->

<html>
<head>
<title>우편번호검색</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/signup/css/zipCheck.css">
<script src="/webSignup/js/check.js"></script>
</head>
<body bgcolor="#FFFFCC">
	<main>
		<b>우편번호 찾기</b>
		<form name="zipForm" method="post" action="zipCheck.jsp">
			<input type="hidden" name="check" value="n">
			<table>
				<tr>
					<td>동이름 입력 : <input name="dong" type="text"> <input
						type="button" value="검색" onclick="dongCheck()" />
					</td>
				</tr>
			</table>
		</form>
		<table>
			<%
			if (check.equals("n")) {
				if (zipList.isEmpty()) {
			%>
			<tr>
				<td align="center"><br />검색된 결과가 없습니다.</td>
			</tr>
			<%
			} else {
			%>
			<tr>
				<td align="center"><br /> ※검색 후, 아래 우편번호를 클릭하면 자동으로 입력됩니다.</td>
			</tr>
			<%
			for (ZipCodeVO data : zipList) {
				String tempZipcode = data.getZipcode();
				String tempSido = data.getSido();
				String tempGugun = data.getGugun();
				String tempDong = data.getDong();
				String tempBunji = data.getBunji();
				if (tempBunji == null) {
					tempBunji = " ";
				}
			%>
			<tr>
				<td><a href="javascript:sendAddress('<%=tempZipcode%>','<%=tempSido%>','<%=tempGugun%>','<%=tempDong%>','<%=tempBunji%>')">
						<%= data.toString()%></a><br>
					<%
					} //end for
					} //zipList.isEmpty() end else
					} //check.equals("n") end
					%></td>
			</tr>
			<tr>
				<td align="center"><a href="javascript:this.close();">닫기</a></td>
			</tr>
		</table>
	</main>
</body>
</html>