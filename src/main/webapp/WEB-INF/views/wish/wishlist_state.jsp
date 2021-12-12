<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- <%@include file="../includes/header.jsp"%> --%>
<%@include file="../includes/index_header.jsp"%>

<script>
	//새로고침을 통한 동일 내용 전송 차단 +뒤로가기할떄 모달창 다시 뜨는 것 방지
	$(document).ready(
			function() {

				var result = '<c:out value="${result}"/>';
				checkModal(result);

				history.replaceState({}, null, null);

				function checkModal(result) {
					if (result === '' || history.state) {
						return;
					}
					if (parseInt(result) > 0) {
						$(".modal-body").html(
								"게시글 " + parseInt(result) + " 번이 등록되었습니다.");
					}

					$("#myModal").modal("show");
				}

// 				$("#regBtn").on("click", function() {
					
// 					self.location = "/forum/register";
					
// 				});

				var actionForm = $("#actionForm");

				$(".paginate_button a").on(
						"click",
						function(e) {
							e.preventDefault();
							console.log('click');
							actionForm.find("input[name='pageNum']").val(
									$(this).attr("href"));
							actionForm.submit();
						});

				$(".move").on("click",function(e){
					e.preventDefault();
					actionForm.append("<input type='hidden' name='wno' value='"+
							$(this).attr("href")+"'>");
					actionForm.attr("action","/wish/get");
					actionForm.submit();					
				});
				
				//검색시 페이지는 항상1페이지부터 
				var searchForm=$("#searchForm");
				$("#searchForm button").on("click", function(e){
					if(!searchForm.find("option:selected").val()){
						alert("검색종류를 선택하세요");
						return false;
					}
					
// 					if(!searchForm.find("input[name='keyword']").val()){
// 						alert("키워드를 입력하세요");
// 						return false;
// 					}
					searchForm.find("input[name='pageNum']").val("1");
					e.preventDefault();
					searchForm.submit();
				});
				
// 				$("input[type='checkbox']").change(function(e){
// 					var formData=new FormData();
// 					var self_value = $("input[name='self']").val();
// 					var user_id_value='<c:out value="${forum.user_id}"/>';
					
// 					$.ajax({
// 						url : '/forum/list',
// 						processData : false,
// 						contentType : false,
// 						data : {"self":self_value, "user_id":user_id_value},
// 						type : 'GET',
// 						dataType:'json',
// 						success : function(result) {
// 							console.log(result);
// 						}

// 					}); //$.ajax

// 				});
				
			});
</script>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">[관리자]희망도서 신청 현황</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">희망도서 신청 현황
			
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<table width="100%"
					class="table table-striped table-bordered table-hover"
					id="dataTables-example">
					<thead>
						<tr>
							<th>번호</th>
							<th>도서명</th>
							<th>신청자</th>
							<th>신청일</th>
							<th>진행상황</th>
						</tr>
					</thead>

					<c:forEach items="${list}" var="wishlist">
						<tr>
							<td><c:out value="${wishlist.wno}" /></td>
							
							<!-- 				목록페이지와 뒤로가기 문제해결  새창에서 열려면 a태그에 target='_blink' 지정-->
							<td><a class='move'
								href='<c:out value="${wishlist.wno}"/>'> 
								<c:out value="${wishlist.title }" /></a></td>
							<td><c:out value="${wishlist.user_id}" /></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${wishlist.regdate }" /></td>
							<td><c:out value="${wishlist.progress}" /></td>
						</tr>
					</c:forEach>
				</table>
				
				
				
				<div class="row">
				<div class="col-lg-12">
				<form id='searchForm' action="/wish/wishlist_state" method="get" style="height:50px;">
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
						<c:out value="${pageMaker.cri.type eq 'P'?'selected':''}"/>>도서정리중</option>
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
					<input type="hidden" name="pageNum" value="<c:out value='${pageMaker.cri.pageNum}'/>"/>		
					<input type="hidden" name="amount" value="<c:out value='${pageMaker.cri.amount }'/>"/>		
					<%-- <input type="hidden" name="type" value="<c:out value='${pageMaker.cri.type }'/>"/> --%>
					<%-- <input type="hidden" name="typea" value="<c:out value='${pageMaker.cri.typea }'/>"/>		
					<input type="hidden" name="typeb" value="<c:out value='${pageMaker.cri.typeb }'/>"/>		 --%>
		
					<!-- <input type="hidden" name="bcategory" value="자유게시판"/>	 -->	
					<button class='btn btn-default yun_btn'>Search</button>
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

				<form id='actionForm' action="/wish/wishlist_state" method='get'>
					<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'> 
					<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
<%-- 					<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>'> --%>
					<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>'>
					<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'>

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
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
								<button type="button" class="btn btn-primary">Save
									changes</button>

							</div>
						</div>

					</div>

				</div>


			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-6 -->
</div>
<!-- /.row -->
<style>
.yun_btn{
	width: 60px;
	height: 25px;
	float: right;
	right:65%;
/* 	color: white; */
/* 	background-color: red; */
	padding:0;
}
</style>
<%@include file="../includes/index_footer.jsp"%>
<%-- <%@include file="../includes/footer.jsp"%> --%>