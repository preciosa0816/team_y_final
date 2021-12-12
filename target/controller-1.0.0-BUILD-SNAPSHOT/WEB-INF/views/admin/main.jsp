<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- <%@include file="../includes/header.jsp"%> --%>
<%@include file="../includes/index_header.jsp"%>
<style>
.admin_page{
	border : 1px solid black;
	width:50%;
	height:600px;
	
}
.admin_page tr, td{
	width:17%;
	border: 1px solid black;
	text-align: center;
	font-size: 35px;
	
	
}
</style>
	<table class='admin_page'>
		<tr>
			<td><a href=#>회원관리</a></td>
			<td><a href=#>Q&A</a></td>
			<td><a href=#>도서등록</a></td>
		</tr>
		
		<tr>
			<td><a href='/wish/wishlist_state'>희망도서관리</a></td>
			<td><a href=#>게시글관리</a></td>
			<td><a href=#>공지사항관리</a></td>
		</tr>
	</table>
<%@include file="../includes/index_footer.jsp"%>
<%-- <%@include file="../includes/footer.jsp"%> --%>