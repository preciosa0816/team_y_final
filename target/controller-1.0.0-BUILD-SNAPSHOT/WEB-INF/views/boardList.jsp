<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">
  <meta name="author" content="Kyusup">
  <meta name="description" content="반응형 웹 도서관 사이트">
  <meta name="keywords" content="반응형사이트, 웹퍼블리셔, 웹접근성, HTML5">
  <title>도서관 프로젝트</title>

  <!-- style -->
  <link href="resources/html/css/reset.css" rel="stylesheet" type="text/css">
  <link href="resources/html/css/style.css" rel="stylesheet" type="text/css">
  <link href="resources/html/css/font-awesome.css" rel="stylesheet" type="text/css">
  <link href="resources/html/css/slick.css" rel="stylesheet" type="text/css">
  <link href="resources/html/css/lightgallery.css" rel="stylesheet" type="text/css">
  <link href="resources/html/css/border.css" rel="stylesheet" type="text/css">
  
  <!-- 웹 폰트 -->
  <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Nanum+Brush+Script" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Abel" rel="stylesheet">

  <!-- HTLM5shiv ie6~8 -->
  <!--[if lt IE 9]>
        <script src="resources/html/js/html5shiv.min.js"></script>
        <script type="text/javascript">
            alert("현재 당신이 보는 브라우저는 지원하지 않습니다. 최신 브라우저로 업데이트해주세요!");
        </script>
    <![endif]-->

</head>

<body>

  <header id="header">
    <div class="container">
      <div class="row">
        <div class="header">
          <div class="header_menu">
            <a href="resources/html/form/loginForm.html">로그인</a>
            <a href="#">회원가입</a>
            <select name = "language">
              <option value="ko">한국어</option>
              <option value="en">English</option>
            </select>
          </div>
          <!-- //header_menu -->
          <div class="header_tit">
            <form>
              <fieldset>
                <input type="search"/>
				<input type = "button" onclick = "location.href = '/boardList'"/>
              </fieldset>
            </form>
          </div>
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
              <li><a href="#">희망 도서 관리</a></li>
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
              <li><a href="#">자유 게시판</a></li>
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
        <a href="#" class="btn">
       		<i class="fa fa-angle-down" aria-hidden="true"></i>
        	<span class="ir_su">전체메뉴 보기</span>
        </a>
      </div>
    </div>
  </article>
  <!-- //title -->

  <!-- main -->
    <section id="contents">
      <div class="container">
        <h2 class="ir_su">반응형 사이트 컨텐츠</h2>
        <section id="cont_left">
          <h3 class="ir_su">메뉴 및 게시판 컨텐츠 영역</h3>
          <article class="column col1">
            <h4 class="col_tit">Menu</h4>
            <p class="col_desc">이 곳은 메뉴 영역입니다.</p>
            <!-- 메뉴 -->
            <div class="menu">
              <ul>
                <li><a href="#">도서관 소개 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a></li>
                <li><a href="/boardList">소장 도서관리 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a></li>
               	<li><a href="#">예약 도서관리 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a></li>
                <li><a href="#">희망 도서관리 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a></li>
                <li><a href="#">추천 도서관리 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a></li>
              	<li><a href="#">열람실 관리 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a></li>
                <li><a href="#">공지사항 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a></li>
                <li><a href="#">자유 게시판 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a></li>
                <li><a href="#">Q&A 게시판 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a></li>
              </ul>
            </div>
            <!--//메뉴 -->
          </article>
          <!-- //col1 -->

        </section>
        <!-- //cont_left -->
		
		<!-- cont_center -->
		<section id = "cont_center">
		<div class="boardcss_list_table">
			<h2>소장도서 관리</h2>
			<table class = "list_table">
				<caption>소장도서 관리</caption>
				<thead>
					<tr>
						<th>도서번호</th>
						<th>분류기호</th>
						<th>도서명</th>
						<th>작성자</th>
						<th>출판사</th>
						<th>발행일</th>
						<th>ISBN</th>
						<th>부록여부</th>
						<th>예약여부</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="book" items="${list}">
					<tr>
						<td>${book.bno}</td>
						<td>${book.sign}</td>
						<td>${book.title}</td>
						<td>${book.author}</td>
						<td>${book.publisher}</td>
						<td>${book.redate}</td>
						<td>${book.ISBN}</td>
						<td>${book.sup_check}</td>
						<td>${book.reserve}</td>
						<td>${book.views}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>
		</section>

      </div>
    </section>
    <!-- //contents -->
  </main>

  <footer id="footer">
    <div class="container">
      <div class="row">
        <div class="footer">
          <ul>
            <li><a href="#">사이트 도움말</a></li>
            <li><a href="#">사이트 이용약관</a></li>
            <li><a href="#">사이트 운영원칙</a></li>
            <li><a href="#"><strong>개인정보취급방침</strong></a></li>
            <li><a href="#">책임의 한계와 법적고지</a></li>
            <li><a href="#">게시중단요청서비스</a></li>
            <li><a href="#">고객센터</a></li>
          </ul>
          <address>
            Copyright &copy;<strong>중앙 501 A조</strong> All Rights Reserved.
          </address>
        </div>
      </div>
    </div>
  </footer>
  <!-- //footer -->

  <!-- JavaScript Libraries -->
  <script src="resources/html/js/jquery.min_1.12.4.js"></script>
  <script src="resources/html/js/modernizr-custom.js"></script>
  <script src="resources/html/js/slick.min.js"></script>
  <script src="resources/html/js/lightgallery.min.js"></script>
  <script src="resources/html/js/script.js"></script>
