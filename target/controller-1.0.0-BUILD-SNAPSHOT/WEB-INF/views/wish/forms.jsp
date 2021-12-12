<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%-- <%@include file="../includes/header.jsp"%> --%>
<%@include file="../includes/index_header.jsp"%>

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
<script>
$(document).ready(function(e) {
	var application=$("form[role='form']");
	$("button[type='submit']").on("click", function(e){
		if(!application.find("input[name='title']").val()){
			alert("도서명을 입력하세요");
			return false;
		}
		
		if(!application.find("input[name='author']").val()){
			alert("저자명을 입력하세요");
			return false;
		}
		
		if(!application.find("input[name='publisher']").val()){
			alert("출판사를 입력하세요");
			return false;
		}
		
		var pubyear = application.find("input[name='pubyear']").val();
		var pattern = /[0-9]{4}\/(0[1-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])/;

		if(!pattern.test(pubyear)) {
		    alert("발행일의 형식을 확인해주세요.\n 발행일 미상의 경우 '2222/12/31' 을 입력해주세요");
		    return false;		    
		} 
		
		if(!application.find("input[name='ISBN']").val()){
			alert("ISBN을 입력하세요");
			return false;
		}
		//e.preventDefault();
		application.submit();
	});
	$("button[type='button']").on("click", function(e){
		window.open('https://book.naver.com/search/search.nhn?sm=sta_hty.book&sug=&where=nexearch&query='+application.find("input[name='title']").val());
	});
});


</script>
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">희망도서 신청</h1>
                </div>+
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            	희망도서 신청서
                        </div>
                        <div>
                        <div><a href='/wish/guide' style="font-size:15px; float:left; margin-left:7px; border:1px solid lightblue;">이용안내</a></div>
                        <div><a style="background-color: lightblue; color:white; font-size:15px; float:left; margin-left:7px;  border:1px solid lightblue;">신청</a></div>
                        </div>
                        <hr>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-6">
                                    <form role="form" action="/wish/register" method="post">
                                    	<div id="guideline">
                                    	- 대학도서관 장서로 적합한 자료에 한해 구입이 가능합니다.<br>
                                    	- 재학생의 신청은 1개월에 5권이며, US$50.00이 넘는 외국도서는 신청서 양식을 다운로드하여 소속 학과장의 날인(사인)을 받아 수서실로 제출해주십시오.<br>
                                    	- 전자책 구입 신청 시 비고란에 '전자책' 또는 'ebook'을 입력하여 주십시오.<br>
                                    	- 기타 희망도서 신청에 대한 자세한 사항은 ‘이용안내’ 를 참조하시기 바랍니다.<br>
                                    	- 책찾기 참고 사이트 : <a href='https://book.naver.com/' target='_blink'>https://book.naver.com</a>
                                    	                                   	
                                    	</div>
                                       <table id='app_table'>                                      
                                       		<tr>
                                       			<td>자료형태(<i style='color:red'>*</i>)</td>
                                       			<td><select name="book_type">
													<option value="단행본" selected="selected">단행본</option>
													<option value="지도자료">지도자료</option>
													<option value="연간물">연간물</option>
													<option value="시청각자료">시청각자료</option>
													<option value="비도서기타">비도서기타</option>
													</select></td>
                                       		</tr>
                                       		<tr>
                                       			<td width="30%;">서명(<i style='color:red'>*</i>)</td>
                                       			<td><input type="text" name="title" width="500px"><button type="button" value="도서 검색" >도서검색</button></td>
                                       		
                                       		</tr>
                                       		<tr>
                                       			<td width="30%;">저자(<i style='color:red'>*</i>)</td>
                                       			<td><input type="text" name="author" width="500px"></td>
                                       		</tr>
                                       		<tr>
                                       			<td width="30%;">출판사(<i style='color:red'>*</i>)</td>
                                       			<td><input type="text" name="publisher" width="500px"></td>
                                       		</tr>
                                       		<tr>
                                       			<td width="30%;">발행연도(<i style='color:red'>*</i>)<br>(일자구분은 띄어쓰기 없이 '/'사용)</td>
                                       			<td><input type="text" name="pubyear" width="500px"></td>
                                       		</tr>
                                       		<tr>
                                       			<td width="30%;">ISBN(<i style='color:red'>*</i>)</td>
                                       			<td><input type="number" name="ISBN" width="500px"></td>
                                       		</tr>
                                       		<tr>
                                       			<td width="30%;">비고</td>
                                       			<td><textarea rows='3' name='comments' cols="90"></textarea></td>
                                       		</tr>
                                       </table>
                                       <div style="width:50%; padding:5px;">
                                       <button type="submit" class="btn btn-default">제출</button>
									   <button type="reset" class="btn btn-default">다시 작성</button>
                                       </div>                                
                                            
                                       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>      
                                       <input type="hidden" name="user_id" value="<sec:authentication property='principal.username'/>"/>      
                                    </form>
                                </div>
                                <!-- /.col-lg-6 (nested) -->
                            </div>
                            <!-- /.row (nested) -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
       <%@include file="../includes/index_footer.jsp"%>
<%-- <%@include file="../includes/footer.jsp"%> --%>