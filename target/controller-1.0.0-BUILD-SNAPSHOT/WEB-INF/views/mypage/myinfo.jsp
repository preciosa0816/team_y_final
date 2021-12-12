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
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
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
</style>
<script type="text/javascript">
	//수정 버튼을 누른다면 bno값을 같이 전달하고 list로 이동하는 경우 bno태그를 지우고 리스트페이지로 이동.
	$(document).ready(function() {

		$("button[type='button']").on("click", function(e){
			href.location('/mypage/wish_modify');
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
	<sec:authentication property="principal" var="pinfo"/>
  <a href="/mypage/myinfo" class='active'>회원정보</a>
  <a href="#news">예약도서현황</a>
  <a href="/mypage/wishlist?user_id=<c:out value="${pinfo.username}"/>">희망도서현황</a>
  <div class="dropdowns">
    <button class="dropbtns">내가 쓴 글 
      <i class="fa fa-caret-downs"></i>
    </button>
    <div class="dropdown-contents">
      <a href="/mypage/myforum?user_id=<c:out value="${pinfo.username}"/>">자유게시판</a>
      <a href="#">Q&A 게시판</a>
    </div>
  </div> 
</div>

					
<%@include file="../includes/index_footer.jsp"%>
<%-- <%@include file="../includes/footer.jsp"%> --%>