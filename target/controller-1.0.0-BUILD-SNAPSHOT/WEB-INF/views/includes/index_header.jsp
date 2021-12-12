<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">
<meta name="author" content="Kyusup">
<meta name="description" content="반응형 웹 도서관 사이트">
<meta name="keywords" content="반응형사이트, 웹퍼블리셔, 웹접근성, HTML5">
<title>도서관 프로젝트</title>

<!-- style -->
<link href="../resources/html/css/reset.css" rel="stylesheet"
	type="text/css">
<link href="../resources/html/css/style.css" rel="stylesheet"
	type="text/css">
<link href="../resources/html/css/font-awesome.css" rel="stylesheet"
	type="text/css">
<link href="../resources/html/css/slick.css" rel="stylesheet"
	type="text/css">
<link href="../resources/html/css/lightgallery.css" rel="stylesheet"
	type="text/css">
<link href="../resources/html/css/border.css" rel="stylesheet"
	type="text/css">

<!-- 파비콘 -->
<!--
  <link rel="shortcut icon" href="icon/favicon.ico">
  <link rel="apple-touch-icon-precomposed" href="icon/favicon-152.png">
  <link rel="icon" href="path/to/favicon.png">
  <link rel="icon" href="icon/favicon-16.png" sizes="16x16">
  <link rel="icon" href="icon/favicon-32.png" sizes="32x32">
  <link rel="icon" href="icon/favicon-48.png" sizes="48x48">
  <link rel="icon" href="icon/favicon-64.png" sizes="64x64">
  <link rel="icon" href="icon/favicon-128.png" sizes="128x128">
-->
<!-- 웹 폰트 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nanum+Brush+Script"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Abel"
	rel="stylesheet">

<!-- HTLM5shiv ie6~8 -->
<!--[if lt IE 9]>
        <script src="resources/html/js/html5shiv.min.js"></script>
        <script type="text/javascript">
            alert("현재 당신이 보는 브라우저는 지원하지 않습니다. 최신 브라우저로 업데이트해주세요!");
        </script>
    <![endif]-->

<!-- 교재 속 css -->
<!-- Bootstrap Core CSS -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- DataTables CSS -->
<link
	href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css"
	rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link
	href="/resources/vendor/datatables-responsive/dataTables.responsive.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
</style>
</head>

<body>

	<header id="header">
		<div class="container">
			<div class="row">
				<div class="header">
					<div class="header_menu">
					<sec:authorize access="isAuthenticated()">
					<sec:authorize access="hasRole('ROLE_ADMIN')"> 
								<a href="/admin/main">관리자페이지</a>
							</sec:authorize>
						<a href="/mypage/myinfo">마이페이지</a>
						<a href="/customLogout">로그아웃</a>
					</sec:authorize>
					<sec:authorize access="isAnonymous()">
						<a href="/customLogin">
								로그인</a><a href="#">회원가입</a>
						</sec:authorize>
						<select name="language">
							<option value="ko">한국어</option>
							<option value="en">English</option>
						</select>
					</div>
					<!-- //header_menu -->
					<div class="header_tit">
						<form>
							<fieldset>
								<input type="search" /> <input type="button"
									onclick="location.href = '/boardList'">
								<!--                   <button type="submit" onclick="location.href='/bookList'"> -->
								<!--                   	<i class="fa fa-search"> -->
								<!--                   	</i> -->
								</button>
							</fieldset>
						</form>
					</div>
					<!-- //header_tit -->
					<!--          <div class="header_icon">
            <ul>
              <li><a href="#"><i class="fa fa-html5" aria-hidden="true"></i><span>HTML5</span></a></li>
              <li><a href="#"><i class="fa fa-github" aria-hidden="true"></i><span>GitHub</span></a></li>
              <li><a href="#" class="facebook"><i class="fa fa-facebook-square" aria-hidden="true"></i><span>Fackbook</span></a></li>
              <li><a href="#" class="twitter"><i class="fa fa-twitter" aria-hidden="true"></i><span>twitter</span></a></li>
            </ul>
          </div>1
-->
					<!-- //header_icon -->
				</div>
			</div>
		</div>
	</header>
	<!-- //nav -->

	<nav id="nav">
		<div class="container">
			<div class="row">
				<div class="nav">
					<h2 class="ir_su">전체 메뉴</h2>
					<div>
						<h3>도서관 소개</h3>
						<ol>
							<li><a href="#">도서관 소개</a></li>
							<li><a href="#">도서관 시설</a></li>
							<li><a href="#">도서관 이용 안내</a></li>
							<li><a href="#">찾아오시는 길</a></li>
						</ol>
					</div>
					<div>
						<h3>도서 관리</h3>
						<ol>
							<li><a href="/boardList">소장 도서 관리</a></li>
							<li><a href="#">예약 도서 관리</a></li>
							<li><a href="/wish/guide">희망 도서 관리</a></li>
							<li><a href="#">추천 도서 관리</a></li>
						</ol>
					</div>
					<div>
						<h3>열람실 관리</h3>
						<ol>
							<li><a href="#">열람실 예약</a></li>
						</ol>
					</div>
					<div>
						<h3>공지사항</h3>
						<ol>
							<li><a href="#">공지사항</a></li>
						</ol>
					</div>
					<div>
						<h3>게시판</h3>
						<ol>
							<li><a href="/forum/list">자유 게시판</a></li>
							<li><a href="#">Q&A 게시판</a></li>
						</ol>
					</div>
				</div>
			</div>
		</div>
	</nav>
	<!-- //nav -->

	<article id="title">
		<div class="container">
			<div class="title">
				<h2>list</h2>
				<a href="#" class="btn"> <i class="fa fa-angle-down"
					aria-hidden="true"></i> <span class="ir_su">전체메뉴 보기</span>
				</a>
			</div>
		</div>
	</article>
	<!-- //title -->