<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%-- <%@include file="../includes/header.jsp"%> --%>
<%@include file="../includes/index_header.jsp"%>

<!-- 목록페이지에서 링크를 통해 GET 방식으로 특정한 번호의 게시물을 조회할 수 있는 기능 작성
	게시물 번호를 보여줄 수 있는 필드를 추가하고 모든 데이터는 readonly를 지정해서 작성. 수정/삭제 버튼 추가 -->
<script type="text/javascript">
	//수정 버튼을 누른다면 bno값을 같이 전달하고 list로 이동하는 경우 bno태그를 지우고 리스트페이지로 이동.
	$(document).ready(function() {

		var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/wish/modify").submit();
		});
		$("button[data-oper='delete']").on("click", function(e) {
			operForm.attr("action", "/wish/remove").attr("method","post").submit();
		}); 
		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#wno").remove();
			operForm.attr("action", "/wish/wishlist_state");
			operForm.submit();
		});

	});
</script>
<style>
	#guideline{
		width:1000px;
		background-color: lightgray;
		margin-bottom:20px;
		padding:5px;
	}
	#app_table{
	border: 1px solid black;
	width:1000px;
	}
	#app_table tr,td{
	border:1px solid black;
	padding:5px;
	
	}
</style>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">[관리자]희망도서 신청현황</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">희망도서 신청서</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
			<table id='app_table'>
				<tr>
					<td width="30%;"><label>신청번호</label></td>
					<td><input name="wno"
						value='<c:out value="${wishlist.wno}"/>' readonly="readonly"></td>
					<td width="30%;"><label>신청일</label></td>
					<td><input name="regDate"
						value='<fmt:formatDate pattern="yyyy-MM-dd hh:mm"
									value="${wishlist.regdate }" />' readonly="readonly"></td>
				</tr>
				<tr>
					<td width="30%;"><label>도서형태</label></td>
					<td><input  name="title" 
						value='<c:out value="${wishlist.book_type}"/>' readonly="readonly"></td>
					<td width="30%;"><label>도서명</label></td>
					<td><input  name="author"
						value='<c:out value="${wishlist.title}"/>' readonly="readonly"></td>
				</tr>
				<tr>
					<td width="30%;"><label>저자</label></td>
					<td><input name="title" 
						value='<c:out value="${wishlist.author}"/>' readonly="readonly"></td>
					<td width="30%;"><label>출판사</label></td>
					<td><input name="publisher" 
						value='<c:out value="${wishlist.publisher}"/>' readonly="readonly"></td>
				</tr>
				<tr>
					<td width="30%;"><label>발행일</label></td>
					<td><input name="pubyear" 
						value='<fmt:formatDate pattern="yyyy-MM-dd"
									value="${wishlist.regdate }" />' readonly="readonly"></td>

					<td width="30%;"><label>ISBN</label></td>
					<td><input name="ISBN"
						value='<c:out value="${wishlist.ISBN}"/>'  readonly="readonly"></td>
				</tr>
				<tr>
					<td width="30%;"><label>비고</label></td>
					<td colspan="3"><textarea rows='3' name='comments' cols="95"
						 readonly="readonly"><c:out value="${wishlist.comments}"/></textarea></td>				
				</tr>
				<tr>
					<td width="30%;"><label>처리결과</label></td>
					<td colspan="3"><input name="progress" 
						value='<c:out value="${wishlist.progress}"/>' readonly="readonly"></td>				
				</tr>
			</table>
				

<%-- 				<sec:authentication property="principal" var="pinfo"/> --%>
<%-- 				<sec:authorize access="isAuthenticated()"> --%>
<%-- 					<c:if test="${pinfo.username eq forum.user_id}"> --%>
					<button data-oper='modify' class="btn btn-default"
<%-- 						onclick='location.href="/forum/modify?bno=<c:out value='${forum.bno}'/>"'> --%>
						>
						수정</button>
<%-- 					</c:if> --%>
<%-- 				</sec:authorize> --%>
				
<%--  				<sec:authorize access="isAuthenticated()"> --%>
<%-- 					<c:if test="${pinfo.username eq forum.user_id}"> --%>
					<button data-oper='delete' class="btn btn-danger">
						삭제</button>
<%-- 					</c:if> --%>
<%-- 				</sec:authorize>  --%>
				
					
				<button data-oper='list' class="btn btn-info"
					onclick="location.href='/wish/wishlist_state'">목록</button>

				<form id="operForm" action="/wish/modify" method="get">
					<input type="hidden" id="wno" name="wno"
						value="<c:out value='${wishlist.wno }'/>"> 
					<input type="hidden" name="pageNum"
						value='<c:out value="${cri.pageNum }"/>'> 
					<input type="hidden" name="amount"
						value='<c:out value="${cri.amount }"/>'> 
					<input type="hidden" name="keyword"
						value='<c:out value="${cri.keyword }"/>'> 
					<input type="hidden" name="type" 
						value='<c:out value="${cri.type}"/>'>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>   
				</form>
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-6 -->
</div>
<!-- /.row -->

<style type="text/css">
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align:center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span{
	color:white;
}

.bigPictureWrapper{
	position:absolute;
	display: none;
	justify-content:center;
	align-items: center;
	top:0%;
	width:100%;
	height:100%;
	background-color: gray;
	z-index:100;
	background:rgba(255,255,255,0.5);
}

.bigPicture{
	position:relative;
	display:flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img{
	width:600px;
}

</style>
<%@include file="../includes/index_footer.jsp"%>
<%-- <%@include file="../includes/footer.jsp"%> --%>