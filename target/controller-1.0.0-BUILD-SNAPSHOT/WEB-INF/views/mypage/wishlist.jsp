<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%-- <%@include file="../includes/header.jsp"%> --%>
<%@include file="../includes/index_header.jsp"%>

<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

.navbars {
	overflow: hidden;
	background-color: #333;
}

.navbars a.active {
	background-color: #4CAF50;
	color: white;
}

.navbars a {
	float: left;
	font-size: 16px;
	color: white;
	text-align: center;
	padding: 14px 16px;
	text-decoration: none;
}

.dropdowns {
	float: left;
	overflow: hidden;
}

.dropdowns .dropbtns {
	font-size: 16px;
	border: none;
	outline: none;
	color: white;
	padding: 14px 16px;
	background-color: inherit;
	font-family: inherit;
	margin: 0;
}

.navbars a:hover, .dropdowns:hover .dropbtns {
	background-color: #ddd;
}

.dropdown-contents {
	display: none;
	position: absolute;
	background-color: #f9f9f9;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.dropdown-contents a {
	float: none;
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
	text-align: left;
}

.dropdown-contents a:hover {
	background-color: #ddd;
}

.dropdowns:hover .dropdown-contents {
	display: block;
}

#guideline {
	margin-top: 10px;
	width: 100%;
	background-color: lightgray;
	margin-bottom: 20px;
	padding: 5px;
}
</style>

<script type="text/javascript">
	//수정 버튼을 누른다면 bno값을 같이 전달하고 list로 이동하는 경우 bno태그를 지우고 리스트페이지로 이동.
	$(document)
			.ready(
					function() {
						<sec:authentication property="principal" var="pinfo" />

						var actionForm = $("#actionForm");

						$(".paginate_button a").on(
								"click",
								function(e) {
									e.preventDefault();
									console.log('click');
									actionForm.find("input[name='pageNum']")
											.val($(this).attr("href"));
									actionForm.submit();
								});

						$(".move")
								.on(
										"click",
										function(e) {
											e.preventDefault();
											actionForm
													.append("<input type='hidden' name='wno' value='"
															+ $(this).attr(
																	"href")
															+ "'>");
											actionForm
													.append('<input type="hidden" name="user_id" value="<c:out value='${pinfo.username}'/>" />');
											actionForm.attr("action",
													"/mypage/wishlistget");
											actionForm.submit();
										});
						//검색시 페이지는 항상1페이지부터 
						var searchForm = $("#searchForm");
						$("#searchForm button").on("click", function(e) {
							if (!searchForm.find("option:selected").val()) {
								alert("검색종류를 선택하세요");
								return false;
							}

							//				if(!searchForm.find("input[name='keyword']").val()){
							//					alert("키워드를 입력하세요");
							//					return false;
							//				}
							searchForm.find("input[name='pageNum']").val("1");
							e.preventDefault();
							searchForm.submit();
						});
					});
</script>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">마이페이지</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="navbars">
	<sec:authentication property="principal" var="pinfo" />
	<a href="/mypage/myinfo" >회원정보</a> <a href="#news">예약도서현황</a>
	<a class='active' href="/mypage/wishlist?user_id=<c:out value="${pinfo.username}"/>">희망도서현황</a>
	<div class="dropdowns">
		<button class="dropbtns">
			내가 쓴 글 <i class="fa fa-caret-downs"></i>
		</button>
		<div class="dropdown-contents">
			<a href="/mypage/myforum?user_id=<c:out value="${pinfo.username}"/>">자유게시판</a>
			<a href="#">Q&A 게시판</a>
		</div>
	</div>
</div>
<div id="guideline">
	- 진행상황이 '신청대기중'인 도서만 수정 및 취소가 가능합니다.<br> - 1년에 신청가능한 도서는 총 10권입니다.
	<br> - 신청부터 대출가능까지 약 2주가 소요됩니다.<br> - 기타 희망도서 신청에 대한 자세한 사항은
	‘<a href='/wish/guide' style='color: blue;'>이용안내</a>’ 를 참조하시기 바랍니다.<br>
</div>
<div class="panel-body">
	<table width="100%"
		class="table table-striped table-bordered table-hover"
		id="dataTables-example">
		<thead>
			<tr>
				<th>번호</th>
				<th>도서명</th>
				<th>저자</th>
				<th>신청일</th>
				<th>진행상황</th>
				<th>비고</th>
				<th></th>
			</tr>
		</thead>

		<c:forEach items="${list}" var="wishlist">
			<tr>
				<td><c:out value="${wishlist.wno}" /></td>

				<!-- 				목록페이지와 뒤로가기 문제해결  새창에서 열려면 a태그에 target='_blink' 지정-->
				<td><a class='move' href='<c:out value="${wishlist.wno}"/>'>
						<c:out value="${wishlist.title }" />
				</a></td>
				<td><c:out value="${wishlist.author}" /></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd"
						value="${wishlist.regdate }" /></td>
				<td><c:out value="${wishlist.progress}" /></td>
				<td><c:out value="${wishlist.comments}" /></td>
				<td><c:if test="${wishlist.progress eq '신청대기중'}">
						<button type='button' data-oper='modify' class="btn btn-danger"
							onclick="location.href = '/mypage/wishlistmodify?wno=<c:out value="${wishlist.wno}"/>' ">
							수정/취소</button>
					</c:if></td>
			</tr>
		</c:forEach>
	</table>



	<div class="row">
		<div class="col-lg-12">
			<form id='searchForm' action="/mypage/wishlist" method="get">
				<select name='type'>
					<option value="ACPRHT"
						<c:out value="${pageMaker.cri.type==null?'selected':''}"/>>진행상황</option>
					<option value="A"
						<c:out value="${pageMaker.cri.type eq 'A'?'selected':''}"/>>신청대기중</option>
					<option value="C"
						<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>도서확인중</option>
					<option value="P"
						<c:out value="${pageMaker.cri.type eq 'P'?'selected':''}"/>>주문진행중</option>
					<option value="R"
						<c:out value="${pageMaker.cri.type eq 'R'?'selected':''}"/>>도서정리중</option>
					<option value="H"
						<c:out value="${pageMaker.cri.type eq 'H'?'selected':''}"/>>취소:비고란확인</option>
					<option value="T"
						<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>처리완료</option>
				</select>
				<!-- 					<select name='typeb'> -->
				<!-- 						<option value="TWC"  -->
				<%-- 						<c:out value="${pageMaker.cri.typeb eq 'TWC'?'selected':''}"/>>--</option>	 --%>
				<!-- 						<option value="T"  -->
				<%-- 						<c:out value="${pageMaker.cri.typeb eq 'T'?'selected':''}"/>>제목</option> --%>
				<!-- 						<option value="C"  -->
				<%-- 						<c:out value="${pageMaker.cri.typeb eq 'C'?'selected':''}"/>>내용</option> --%>
				<!-- 						<option value="W"  -->
				<%-- 						<c:out value="${pageMaker.cri.typeb eq 'W'?'selected':''}"/>>작성자</option> --%>
				<!-- 						<option value="TC"  -->
				<%-- 						<c:out value="${pageMaker.cri.typeb eq 'TC'?'selected':''}"/>>제목/내용</option> --%>
				<!-- 						<option value="TW"  -->
				<%-- 						<c:out value="${pageMaker.cri.typeb eq 'TW'?'selected':''}"/>>제목/작성자</option> --%>
				<!-- 						<option value="TWC"  -->
				<%-- 						<c:out value="${pageMaker.cri.typeb eq 'TWC'?'selected':''}"/>>제목/내용/작성자</option> --%>
				<!-- 					</select> -->
				<%-- 					<input type="text" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>"/> --%>
				<input type="hidden" name="pageNum"
					value="<c:out value='${pageMaker.cri.pageNum}'/>" /> <input
					type="hidden" name="amount"
					value="<c:out value='${pageMaker.cri.amount }'/>" />
				<sec:authentication property="principal" var="pinfo" />
				<input type="hidden" name="user_id"
					value="<c:out value="${pinfo.username}"/>" />

				<button class='btn btn-default'>Search</button>
			</form>
		</div>
	</div>

	<div class='pull-right'>
		<ul class='pagination'>

			<c:if test="${pageMaker.prev}">
				<li class="paginate_button previous"><a
					href="${pageMaker.startPage-1}">Previous</a></li>
			</c:if>

			<c:forEach var="num" begin="${pageMaker.startPage }"
				end="${pageMaker.endPage }">
				<li
					class="paginate_button ${pageMaker.cri.pageNum==num ?'active':''}"><a
					href="${num}">${num }</a></li>
			</c:forEach>

			<c:if test="${pageMaker.next}">
				<li class="paginate_button next"><a
					href="${pageMaker.endPage+1 }">Next</a></li>
			</c:if>

		</ul>
	</div>

	<form id='actionForm' action="/mypage/wishlist" method='get'>
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
		<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
		<input type='hidden' name='type'
			value='<c:out value="${pageMaker.cri.type}"/>'> <input
			type='hidden' name='keyword'
			value='<c:out value="${pageMaker.cri.keyword}"/>'>

	</form>
	<!-- 				Modal 추가 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Modal title</h4>
				</div>
				<div class="modal-body">처리가 완료되었습니다</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>

				</div>
			</div>

		</div>

	</div>


</div>
<!-- /.panel-body -->

<%@include file="../includes/index_footer.jsp"%>
<%-- <%@include file="../includes/footer.jsp"%> --%>