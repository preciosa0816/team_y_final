<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<%-- <%@include file="../includes/header.jsp"%> --%>
<%@include file="../includes/index_header.jsp"%>


<style>
#guideline {
	width: 1000px;
	background-color: lightgray;
	margin-bottom: 20px;
	padding: 5px;
}

#app_table {
	border: 1px solid black;
	width: 1000px;
}

#app_table tr, td {
	border: 1px solid black;
	padding: 5px;
}
</style>

<script>
	//새로고침을 통한 동일 내용 전송 차단 +뒤로가기할떄 모달창 다시 뜨는 것 방지
	$(document).ready(
			function() {

				var formObj = $("form");
				//var tableObj = $("table td");

				$('button').on(
						"click",
						function(e) {
							e.preventDefault();
							var operation = $(this).data("oper");//data-oper 
							console.log(operation);

							if (operation === 'remove') {
								formObj.attr("action", "/wish/remove");
							} else if (operation === 'list') {
								//move to list
								formObj.attr("action", "/wish/wishlist_state")
										.attr("method", "get");
								var pageNumTag = $("input[name='pageNum']")
										.clone();
								var amountTag = $("input[name='amount']")
										.clone();
								var typeTag = $("input[name='type']").clone();

								formObj.empty();
								formObj.append(pageNumTag);
								formObj.append(amountTag);
								formObj.append(typeTag);

							} else if (operation === 'modify') {
								if (!formObj.find("#progress option:selected")
										.val()) {
									alert("처리결과를 입력하세요");
									return false;
								}

								console.log("submit clicked");

							}
							formObj.submit();
						});

			});
</script>
<!-- 목록페이지에서 링크를 통해 GET 방식으로 특정한 번호의 게시물을 조회할 수 있는 기능 작성
	게시물 번호를 보여줄 수 있는 필드를 추가하고 모든 데이터는 readonly를 지정해서 작성. 수정/삭제 버튼 추가 -->
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">희망도서 진행상황</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">진행상황 업데이트</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<form role="form" action="/wish/modify" method="post">
					<input type='hidden' name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input type='hidden' name="pageNum"
						value="<c:out value='${cri.pageNum }'/>"> <input
						type='hidden' name="amount"
						value="<c:out value='${cri.amount }'/>"> <input
						type='hidden' name="type" value="<c:out value='${cri.type }'/>">
					<input type='hidden' name="wno"
						value="<c:out value='${wishlist.wno}'/>"> <input
						type='hidden' name="user_id"
						value="<c:out value='${wishlist.user_id}'/>">


					<table id='app_table'>
						<tr>
							<td width="30%;"><label>신청번호</label></td>
							<td><input name="wno" width="500px"
								value='<c:out value="${wishlist.wno}"/>' readonly="readonly"></td>
							<td width="30%;"><label>신청일</label></td>
							<td><input name="regDate" width="500px"
								value='<fmt:formatDate pattern="yyyy-MM-dd hh:mm"
									value="${wishlist.regdate }" />'
								readonly="readonly"></td>
						</tr>
						<tr>
							<td width="30%;"><label>도서형태</label></td>
							<td><input name="title" width="500px"
								value='<c:out value="${wishlist.book_type}"/>'
								readonly="readonly"></td>
							<td width="30%;"><label>도서명</label></td>
							<td><input name="author" width="500px"
								value='<c:out value="${wishlist.title}"/>' readonly="readonly"></td>
						</tr>
						<tr>
							<td width="30%;"><label>저자</label></td>
							<td><input name="title" width="500px"
								value='<c:out value="${wishlist.author}"/>' readonly="readonly"></td>
							<td width="30%;"><label>출판사</label></td>
							<td><input name="publisher" width="500px"
								value='<c:out value="${wishlist.publisher}"/>'
								readonly="readonly"></td>
						</tr>
						<tr>
							<td width="30%;"><label>발행일</label></td>
							<td><input name="pubyear" width="500px"
								value='<fmt:formatDate pattern="yyyy/MM/dd"
									value="${wishlist.pubyear }" />'
								readonly="readonly"></td>

							<td width="30%;"><label>ISBN</label></td>
							<td><input name="ISBN" width="500px"
								value='<c:out value="${wishlist.ISBN}"/>' readonly="readonly"></td>
						</tr>
						<tr>
							<td width="30%;"><label>비고</label></td>
							<td colspan="3"><textarea rows='3' name='comments' cols="95"><c:out
										value="${wishlist.comments}" /></textarea></td>
						</tr>
						<tr>
							<td width="30%;"><label>처리결과</label></td>
							<td colspan="3">
							<c:if test="${wishlist.progress eq '이용자취소'}">
									<input name="ISBN" width="500px"
										value='<c:out value="${wishlist.progress}"/>'
										readonly="readonly"/>
								</c:if>
								<c:if test="${wishlist.progress ne '이용자취소'}">
									<select name="progress" id="progress">
										<option value="">처리결과 선택</option>
										<option value="도서확인중">도서확인중</option>
										<option value="주문진행중">주문진행중</option>
										<option value="도서정리중">도서정리중</option>
										<option value="취소:비고란확인">취소:비고란확인</option>
										<option value="처리완료">처리완료</option>
									</select>
								</c:if>
								</td>



						</tr>
					</table>

					<%-- 					<sec:authentication property="principal" var="pinfo"/> --%>
					<%-- 					<sec:authorize access="isAuthenticated()"> --%>
					<%-- 					<c:if test="${pinfo.username eq wishlist.user_id }"> --%>
					<button type="submit" data-oper='modify' class="btn btn-default">
						수정</button>
					<button type="submit" data-oper='remove' class="btn btn-danger">
						삭제</button>
					<%-- </c:if>		
					</sec:authorize> --%>

					<button type="submit" data-oper='list' class="btn btn-info">
						목록</button>
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
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>
<%@include file="../includes/index_footer.jsp"%>
<%-- <%@include file="../includes/footer.jsp"%> --%>