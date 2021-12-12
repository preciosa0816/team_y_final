<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%-- <%@include file="../includes/header.jsp"%> --%>
<%@include file="../includes/index_header.jsp"%>

<!-- 목록페이지에서 링크를 통해 GET 방식으로 특정한 번호의 게시물을 조회할 수 있는 기능 작성
	게시물 번호를 보여줄 수 있는 필드를 추가하고 모든 데이터는 readonly를 지정해서 작성. 수정/삭제 버튼 추가 -->

<script type="text/javascript" src="/resources/js/reply_forum.js"></script>
<script>
	$(document).ready(function() {
		
		(function(){//즉시실행 함수를 이용하여 첨부파일의 데이터를 가져오는 부분을 처리
			var fno="<c:out value='${forum.fno}'/>";
			$.getJSON("/forum/getAttachList", {fno:fno}, function(arr){
				console.log(arr);
				
				var str="";
				
				$(arr).each(function(i,attach){
					//image type
					if(attach.fileType){
						var fileCallPath= encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
						
						str+="<li ";
						str+="data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"
								+attach.fileName+"'data-type='"+attach.fileType+"'><div>";
						str+="<img src='/display?fileName="+fileCallPath+"'>";
						str+="</div></li>";				
					
					}else{
						str+="<li ";
						str+="data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"
								+attach.fileName+"'data-type='"+attach.fileType+"'><div>";
						str+="<span>"+attach.fileName+"</span><br/>";
						str+="<img src='/resources/img/attach.png'>";
						str+="</div></li>";
						
					}
					
				});
				
				$(".uploadResult ul").html(str);
				
			}); //end getjson
		})();//end function

		$(".uploadResult").on("click","li",function(e){
			console.log("view image");
			var liObj = $(this);
			var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
			
			if(liObj.data("type")){//파일경로의 경우 함수로 전달시 문제가 생기므로 replace()를 이용해서 변환후 전달
				showImage(path.replace(new RegExp(/\\/g)),"/");
			}else{
				//download
				self.location="/download?fileName="+path;
			}
		});
		
		function showImage(fileCallPath){
			alert(fileCallPath);
			$(".bigPictureWrapper").css("display","flex").show();
			
			$(".bigPicture").html("<img src='/display?fileName="+fileCallPath+"'>")
							.animate({width:'100%',height:'100%'}, 1000);
		}
		
		$(".bigPictureWrapper").on("click", function(e){
			$(".bigPicture").animate({width:'0%', height:'0%'},1000);
			setTimeout(function(){
				$('.bigPictureWrapper').hide();
			},1000);
		});
		
 		var fnoValue = '<c:out value="${forum.fno}"/>';
 		var replyUL = $(".chat");
 		showList(1);

		//댓글 페이지 호출
		function showList(page) {//페이지 번호를 파라미터로 받도록 설계하고, 만일 파라미터가 없는 경우에는 자동으로 1페이지가 설정되도록함.
		//브라우저에서 DOM처리가 끝나면 자동으로 showList()호출되어 <ul>태그 내에 내용으로 처리됨.
		//1페이지가 아닌 경우 기존 <ul>에 <li>들이 추가되는 형태
		console.log("show list : "+page)
		replyService.getList({fno : fnoValue,page : page || 1},
							function(replyCnt,list) {
							console.log("replyCnt: "+replyCnt);
							console.log("list: "+list);
							console.log(list);
							
							if(page==-1){//마지막페이지 찾아서 호출
								pageNum=Math.ceil(replyCnt/10.0);
								showList(pageNum);
								return;
							}
							
			
								var str = "";
								if (list == null|| list.length == 0) {
									return;
								}
								//var modalInputReplyer=modal.find("input[name='replyer']");
								//var originalReplyer = modalInputReplyer.val();
								var check = '<c:out value="${forum.user_id}"/>';
								
									for (var i = 0, len = list.length || 0; i < len; i++) {
										str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
										if(check==list[i].replyer){
										str += "<div><div class='header'><strong class='primary-font'>["
												+ list[i].rno+"] "+list[i].replyer+"<img width='0.5px' height='5px' src='/resources/img/writer.png'>"+ "</strong>";
										}else{
											str += "<div><div class='header'><strong class='primary-font'>["
												+ list[i].rno+"] "+list[i].replyer+ "</strong>";
										}
										str += "<small class='pull-right text-muted'>"
												+ replyService.displayTime(list[i].replyDate)
												+ "</small></div>";//시간순배열(해당일은 시분초, 전날은 년월일 )
										str += "<p>"+ list[i].reply+ "</p></div></li>";
										
								}
									
								
								
									replyUL.html(str);
									showReplyPage(replyCnt);
							});//end function

				}//end showList
				
				var modal=$(".modal");
				var modalInputReply = modal.find("input[name='reply']");
				var modalInputReplyer=modal.find("input[name='replyer']");
				var modalInputReplyDate=modal.find("input[name='replyDate']");
				
				var modalModBtn=$("#modalModBtn");
				var modalRemoveBtn=$("#modalRemoveBtn");
				var modalRegisterBtn=$("#modalRegisterBtn");
				
				var replyer=null;
				
				<sec:authorize access="isAuthenticated()">
					replyer='<sec:authentication property="principal.username"/>';
				</sec:authorize>
				
				var csrfHeaderName = "${_csrf.headerName}";
				var csrfTokenValue="${_csrf.token}"; 
				
				$("#addReplyBtn").on("click", function(e){
					
					modal.find("input").val("");
					//댓글을 보여주는 모달창에 현재 로그인한 사용자의 이름으로 replyer항목이 고정되도록수정.
					modal.find("input[name='replyer']").val(replyer); 
					modalInputReplyDate.closest("div").hide();
					modal.find("button[id!='modalCloseBtn']").hide();
					
					modalRegisterBtn.show();
					
					$(".modal").modal("show");
					//jQuery(".modal").modal("show");
					//window.$(".modal").modal("show");
				});
				
				//Ajax spring security header...
				$(document).ajaxSend(function(e,xhr,options){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				});
				//=> ajaxSend 이용시 모든 Ajax전송시 CSRF토큰을 같이 전송하도록 세팅되기 때문에 
				//	  매번 AJAX사용시 beforeSend를 호출해야하는 번거로움을 줄일수있음.
				
				modalRegisterBtn.on("click", function(e){
					var reply={
							reply:modalInputReply.val(),
							replyer:modalInputReplyer.val(),
							fno:fnoValue
					};
				
					replyService.add(reply, function(result){
						alert(result);
						
						modal.find("input").val("");
						modal.modal("hide");
						//showList(1);
						showList(-1);// 댓글 추가시 전체 댓글의 숫자를 파악하고 마지막페이지를 호출하여 댓글 확인
					});
				});
				
				
				
				//댓글 조회 클릭 이벤트 처리
				$(".chat").on("click","li", function(e){
					var originalReplyer = modalInputReplyer.val();
					var reply={rno:modal.data("rno"),
							reply:modalInputReply.val(),
							replyer:originalReplyer};
					var rno=$(this).data("rno");
					replyService.get(rno, function(reply){
						modalInputReply.val(reply.reply);
						modalInputReplyer.val(reply.replyer);
						modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
						modal.data("rno",reply.rno);
						
						modal.find("button[id!='modalCloseBtn']").hide();
						
						if(replyer == originalReplyer){
							modalModBtn.show();
							modalRemoveBtn.show();
						}
						
						
						$(".modal").modal("show");
					});
					//console.log(rno);
				});

				modalModBtn.on("click",function(e){
					
					var originalReplyer = modalInputReplyer.val();
										
					var reply={rno:modal.data("rno"),
							reply:modalInputReply.val(),
							replyer:originalReplyer};
					
					if(!replyer){
						alert("로그인 후 수정이 가능합니다.");
						modal.modal("hide");
						return;
					}
					
					
					console.log("Original replyer: "+originalReplyer); //댓글의 원래 작성자
					
					if(replyer != originalReplyer){
						alert("자신이 작성한 댓글만 수정이 가능합니다.");
						modal.modal("hide");
						return;
					}
					
					replyService.update(reply,function(result){
						alert(result);
						modal.modal("hide");
						showList(pageNum);
					});
				});
				
				modalRemoveBtn.on("click",function(e){
					var rno=modal.data("rno");
					
					console.log("RNO: "+rno);
					console.log("REPLYER: "+replyer);
					
					if(!replyer){
						alert("로그인 후 삭제가 가능합니다.");
						modal.modal("hide");
						return;
					}
					
					var originalReplyer= modalInputReplyer.val();
					
					console.log("Original replyer: "+originalReplyer); //댓글의 원래 작성자
					
					if(replyer != originalReplyer){
						alert("자신이 작성한 댓글만 삭제가 가능합니다.");
						modal.modal("hide");
						return;
					}
					
					replyService.remove(rno, originalReplyer, function(result){
						alert(result);
						modal.modal("hide");
						showList(pageNum);
					});
				});

				
				
				
				var pageNum=1;
				var replyPageFooter=$(".panel-footer");
				
				function showReplyPage(replyCnt){
					var endNum=Math.ceil(pageNum/10.0)*10;
					var startNum=endNum-9;
					
					var prev = startNum!=1;
					var next = false;
					
					if(endNum*10 >=replyCnt){
						endNum=Math.ceil(replyCnt/10.0);
					}
					
					if(endNum*10 <replyCnt){
						next=true;
					}
					
					var str="<ul class='pagination pull-right'>";
					
					if(prev){
						str+="<li class='page-item'><a class='page-link' href='"
								+(startNum-1)+"'>Previous</a></li>";
					}
					
					for(var i =startNum; i<=endNum; i++){
						var active = pageNum==i? "active":"";
						str+="<li class='page-item "+active+"'><a class='page-link' href='"
							+i+"'>"+i+"</a></li>";
					}
					
					if(next){
						str+="<li class='page-item'><a class='page-link' href='"
								+(endNum+1)+"'>Next</a></li>";
					}
					
					str+="</ul></div>";
					console.log(str);
					replyPageFooter.html(str);
				}
				//페이지의 번호를 클릭했을 때 새로운 댓글 가져오기 
				replyPageFooter.on("click","li a",function(e){
					e.preventDefault();
					console.log("page click");
					var targetPageNum=$(this).attr("href");
					console.log("targetPageNum:"+targetPageNum);
					pageNum=targetPageNum;
					showList(pageNum);
						//<a>태그의 기본동작을 제한(e.preventDefault())하고 댓글 페이지 번호를 변경한 후 해당페이지의 댓글 가져옴
					});
		});
</script>
<script>
	console.log("=====================");
	console.log("JS TEST");

	var fnoValue = '<c:out value="${forum.fno}"/>';

	//for replyService add test //계속 오류 ::org.springframework.security.authentication.UsernamePasswordAuthenticationToken
// 	replyService.add({
// 		reply : "JS TEST",
// 		replyer : "tester",
// 		fno : fnoValue
// 	}, function(result) {
// 		alert("RESULT: " + result);
// 	});

	//reply List Test
// 	replyService.getList({
// 		fno : fnoValue,
// 		page : 1
// 	}, function(list) {
// 		for (var i = 0, len = list.length || 0; i < len; i++) {
// 			console.log(list[i]);
// 		}
// 	});

	//13번 댓글 삭제 테스트 
	// 	replyService.remove(13, function(count) {
	// 		console.log(count);
	// 		if (count === "success") {
	// 			alert("REMOVED");
	// 		}
	// 	}, function(err) {
	// 		alert('ERROR...');
	// 	});

	//22번 댓글 수정
// 	replyService.update({
// 		rno : 22,
// 		fno : fnoValue,
// 		reply : "MODIFIED Reply...."
// 	}, function(result) {
// 		alert("수정 완료...");
// 	});

	//댓글 조회 처리 
// 	replyService.get(10, function(data) {
// 		console.log(data);
// 	});
</script>

<script type="text/javascript">
	//수정 버튼을 누른다면 bno값을 같이 전달하고 list로 이동하는 경우 bno태그를 지우고 리스트페이지로 이동.
	$(document).ready(function() {

		var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/forum/modify").submit();
		});
		$("button[data-oper='delete']").on("click", function(e) {
			operForm.attr("action", "/forum/remove").attr("method","post").submit();
		}); 
		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.attr("action", "/forum/list");
			operForm.submit();
		});
		
		
		
	});
</script>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">자유게시판</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">게시글보기</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
			<table>
				<tr>
					<td><label>게시글번호</label></td>
					<td><input class="form-control" name="bno"
						value='<c:out value="${forum.bno}"/>' readonly="readonly"></td>
					<td><label>등록일</label></td>
					<td><input class="form-control" name="regDate"
						value='<fmt:formatDate pattern="yyyy-MM-dd hh:mm"
									value="${forum.regdate }" />' readonly="readonly"></td>
					<td><label>수정일</label></td>
					<td><input class="form-control" name="updateDate"
						value='<fmt:formatDate pattern="yyyy-MM-dd hh:mm"
									value="${forum.updateDate }" />' readonly="readonly"></td>
				</tr>
				<tr>
					<td><label>카테고리</label></td>
					<td><input class="form-control" name="pcategory" 
						value='<c:out value="${forum.pcategory}"/>' readonly="readonly"></td>
					<td><label>조회수</label></td>
					<td><input class="form-control" name="views"
						value='<c:out value="${forum.views}"/>' readonly="readonly"></td>
					<td><label>작성자</label></td>
					<td><input class="form-control" name="user_id"
						value='<c:out value="${forum.user_id}"/>' readonly="readonly"></td>
				</tr>
			</table>
				<div class="form-group">
					<label>제목</label> <input class="form-control" name="title"
						value='<c:out value="${forum.title}"/>' readonly="readonly">
				</div>

				<div class="form-group">
					<label>내용</label>
					<textArea class="form-control" rows="3" name='content'
						readonly="readonly"><c:out value="${forum.tbl_contents}" />
				</textArea>
				</div>

				<div class="form-group">
					<label>작성자</label> <input class="form-control" name="user_id"
						value='<c:out value="${forum.user_id}"/>' readonly="readonly">
				</div>

				<sec:authentication property="principal" var="pinfo"/>
				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq forum.user_id}">
					<button data-oper='modify' class="btn btn-default"
<%-- 						onclick='location.href="/forum/modify?bno=<c:out value='${forum.bno}'/>"'> --%>
						>
						수정</button>
					</c:if>
				</sec:authorize>
				
 				<sec:authorize access="isAuthenticated()">
					<c:if test="${pinfo.username eq forum.user_id}">
					<button data-oper='delete' class="btn btn-danger">
						삭제</button>
					</c:if>
				</sec:authorize> 
				
					
				<button data-oper='list' class="btn btn-info"
					onclick="location.href='/forum/list'">목록</button>

				<form id="operForm" action="/forum/modify" method="get">
					<input type="hidden" id="bno" name="bno"
						value="<c:out value='${forum.bno }'/>"> 
					<input type="hidden" id="fno" name="fno"
						value="<c:out value='${forum.fno }'/>"> 
					<input type="hidden" name="pageNum"
						value='<c:out value="${cri.pageNum }"/>'> 
					<input type="hidden" name="amount"
						value='<c:out value="${cri.amount }"/>'> 
					<input type="hidden" name="keyword"
						value='<c:out value="${cri.keyword }"/>'> 
					<input type="hidden" name="typea" 
						value='<c:out value="${cri.typea}"/>'>
					<input type="hidden" name="typeb" 
						value='<c:out value="${cri.typeb}"/>'>
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

<div class='bigPictureWrapper'>
	<div class='bigPicture'></div>
</div>


<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
	
		<div class="panel-heading">Files</div>
		<!-- /.panel-heading -->
		<div class="panel-body">
		<div class='uploadResult'>
			<ul>
			</ul>
		</div>
		</div>
		<!-- end panel-body -->
		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /. row -->

<div class="row">
	<div class="col-lg-12">
		<!-- /.panel -->
		<div class="panel panel-default">
<!-- 			<div class="panel-heading"> -->
<!-- 				<i class="fa fa-comments fa-fw"></i>Reply -->
<!-- 			</div> -->
			<!-- /.panel-heading -->
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>댓글목록
				<sec:authorize access="isAuthenticated()">
				<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>댓글 작성</button>
				</sec:authorize>
			</div>

			<div class="panel-body">
				<ul class="chat">
					<!-- start reply -->
					<li class="left clearfix" data-rno="12">
						<div>
							<div class="header">
								<strong class="primary-font">user00</strong> <small
									class="pull-right text-muted">2018-01-01 13:13</small>
							</div>
							<p>Good Job!</p>
						</div>
					</li>
					<!-- End reply -->
				</ul>
				<!-- End ul -->
			</div>
			<!-- /.panel .chat-panel -->
			<div class="panel-footer">
			
			
		</div>
	</div>
	<!-- ./End row -->
</div>
</div>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label> <input class="form-control" name='reply'
						value='New Reply!!!!'>
				</div>
				<div class="form-group">
					<label>Replyer</label> <input class="form-control" name='replyer'
						value="replyer" readonly="readonly">
				</div>
				<div class="form-group">
					<label>Reply Date</label> <input class="form-control" name='replyDate'
						value="">
				</div>

			</div>
			<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
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