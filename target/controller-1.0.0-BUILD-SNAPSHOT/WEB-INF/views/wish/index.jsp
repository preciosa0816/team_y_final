<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  <style>

  </style>
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
				<input type = "button" onclick = "location.href = '/boardList'">
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
                <li><a href="/wish/guide">희망 도서관리 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a></li>
                <li><a href="#">추천 도서관리 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a></li>
                <li><a href="#">열람실 관리 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a></li>
                <li><a href="#">공지사항 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a></li>
                <li><a href="/forum/list">자유 게시판 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a></li>
                <li><a href="#">Q&A 게시판 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a></li>
              </ul>
            </div>
            <!--//메뉴 -->
          </article>
          <!-- //col1 -->

          <article class="column col2">
            <h4 class="col_tit">게시판</h4>
            <p class="col_desc">이 곳은 게시판 영역입니다.</p>
            <!-- 게시판 -->
            <div class="notice1">
              <h5>자유 게시판</h5>
              <ul>
                <li><a href="#">이 곳 클릭시 자유게시판 1글로 넘어갑니다.</a></li>
                <li><a href="#">이 곳 클릭시 자유게시판 2글로 넘어갑니다.</a></li>
                <li><a href="#">이 곳 클릭시 자유게시판 3글로 넘어갑니다.</a></li>
                <li><a href="#">이 곳 클릭시 자유게시판 4글로 넘어갑니다.</a></li>
              </ul>
              <a href="#" class="more" title="더 보기">More <i class="fa fa-plus-circle" aria-hidden="true"></i></a>
            </div>
            <!--//게시판 -->
            <!-- 게시판 -->
            <div class="notice2 mt15">
              <h5>Q&A 게시판</h5>
              <ul>
                <li><a href="#">이 곳 클릭시 Q&A 1글로 넘어갑니다.</a></li>
                <li><a href="#">이 곳 클릭시 Q&A 2글로 넘어갑니다.</a></li>
                <li><a href="#">이 곳 클릭시 Q&A 3글로 넘어갑니다.</a></li>
                <li><a href="#">이 곳 클릭시 Q&A 4글로 넘어갑니다.</a></li>
              </ul>
              <a href="#" class="more" title="더 보기">More <i class="fa fa-plus-circle" aria-hidden="true"></i></a>
            </div>
            <!--//게시판2 -->
          </article>
          <!-- //col2 -->

          <article class="column col3">
            <h4 class="col_tit">도서관 소개</h4>
            <p class="col_desc">해당 영역은 도서관 소개 영역입니다.</p>
            <!-- blog -->
            <div class="blog1">
              <h5 class="ir_su">Image1</h5>
              <figure>
                <img src="resources/html/img/blog4_@1.jpg" class="img-normal" alt="normal image">
                <img src="resources/html/img/blog4_@2.jpg" class="img-retina" alt="retina image">
                <figcaption>이 곳은 도서관 소개글 영역입니다.</figcaption>
              </figure>
            </div>
            <!--//blog -->
            <!-- blog2 -->
            <div class="blog2 mt15">
              <div class="img-retina">
                <h5>Image2</h5>
              </div>
              <p>이 곳은 도서관 찾아오시는 글 영역입니다.</p>
            </div>
            <!--//blog2 -->
          </article>
          <!-- //col3 -->
        </section>
        <!-- //cont_left -->

        <section id="cont_center">
          <h3 class="ir_su">반응형 사이트 가운데 컨텐츠</h3>
          <article class="column col4">
            <h4 class="col_tit">추천 도서</h4>
            <p class="col_desc">도서 소개 영역입니다.</p>
            <!-- 이미지 슬라이드 -->
            <div class="slider">
              <div>
                <figure>
                  <img src="resources/html/img/slider001.jpg" alt="이미지1">
                  <figcaption><em>Responsive Site</em><span>슬라이드 플러그인을 이용한 반응형 이미지 슬라이드 입니다.</span></figcaption>
                </figure>
              </div>
              <div>
                <figure>
                  <img src="resources/html/img/slider001.jpg" alt="이미지2">
                  <figcaption><em>Responsive Site</em><span>슬라이드 플러그인을 이용한 반응형 이미지 슬라이드 입니다.</span></figcaption>
                </figure>
              </div>
              <div>
                <figure>
                  <img src="resources/html/img/slider001.jpg" alt="이미지3">
                  <figcaption><em>Responsive Site</em><span>슬라이드 플러그인을 이용한 반응형 이미지 슬라이드 입니다.</span></figcaption>
                </figure>
              </div>
            </div>
            <!--//이미지 슬라이드 -->
          </article>
          <!-- //col4 -->

          <article class="column col5">
            <h4 class="col_tit">도서 소개 영역</h4>
            <p class="col_desc">해당 영역은 도서 소개 영역입니다.</p>
            <!-- lightbox -->
            <div class="lightbox square clearfix">
              <a href="resources/html/img/light01_s.jpg"><img src="resources/html/img/light01.jpg" alt="이미지"><em>blur</em></a>
              <a href="resources/html/img/light02_s.jpg"><img src="resources/html/img/light02.jpg" alt="이미지"><em>brightness</em></a>
              <a href="resources/html/img/light03_s.jpg"><img src="resources/html/img/light03.jpg" alt="이미지"><em>contrast</em></a>
              <a href="resources/html/img/light04_s.jpg"><img src="resources/html/img/light04.jpg" alt="이미지"><em>grayscale</em></a>
              <a href="resources/html/img/light05_s.jpg"><img src="resources/html/img/light05.jpg" alt="이미지"><em>hue-rotate</em></a>
              <a href="resources/html/img/light06_s.jpg"><img src="resources/html/img/light06.jpg" alt="이미지"><em>invert</em></a>
              <a href="resources/html/img/light07_s.jpg"><img src="resources/html/img/light07.jpg" alt="이미지"><em>opacity</em></a>
              <a href="resources/html/img/light08_s.jpg"><img src="resources/html/img/light08.jpg" alt="이미지"><em>saturate</em></a>
              <a href="resources/html/img/light09_s.jpg"><img src="resources/html/img/light09.jpg" alt="이미지"><em>sepia</em></a>
              <a href="resources/html/img/light10_s.jpg"><img src="resources/html/img/light10.jpg" alt="이미지"><em>Mix</em></a>
            </div>
            <!--//lightbox -->
          </article>
          <!-- //col5 -->

          <article class="column col6">
            <h4 class="col_tit">도서관 영상 소개</h4>
            <p class="col_desc">이 곳은 영상을 보여주는 영역입니다.</p>
            <!-- video -->
            <!-- <video autoplay="autoplay" controls="controls" loop="loop">
							<source src="resources/html/img/video.mp4" type="video/mp4">
						</video> -->
            <div class="video">
              <iframe width="560" height="315" src="https://www.youtube.com/embed/akJu8OLkiI8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            </div>
            <!--//video -->
          </article>
          <!-- //col6 -->
        </section>
        <!-- //cont_center -->
        <section id="cont_right">
          <h3 class="ir_su">반응형 사이트 오른쪽 컨텐츠</h3>
          <article class="column col7">
            <h4 class="col_tit">희망 도서 관리</h4>
            <p class="col_desc">해당 그림 클릭 시, 희망 도서 관리 페이지로 이동합니다.</p>
            <!-- side1 -->
            <div class="side1">
              <figure class="front">
                <img src="resources/html/img/side1.jpg" alt="이미지2">
              </figure>
              <div class="back">
                <i class="fa fa-heart fa-4x" aria-hidden="true"></i>
              </div>
            </div>
            <!-- side1//-->
          </article>
          <!-- //col7 -->

          <article class="column col8">
            <h4 class="col_tit">열람실 관리</h4>
            <p class="col_desc">해당 그림 클릭 시, 열람실 관리 페이지로 이동합니다.</p>
            <!-- side2 -->
            <div class="side2">
              <figure class="front">
                <img src="resources/html/img/side2.jpg" alt="이미지2">
                <figcaption>
                  <h3>Hover Effect</h3>
                </figcaption>
              </figure>
              <figure class="back">
                <img src="resources/html/img/side4.jpg" alt="이미지2">
                <figcaption>
                  <h3>Hover Effect</h3>
                </figcaption>
              </figure>
            </div>
            <!-- side2//-->
          </article>
          <!-- //col8 -->

          <article class="column col9">
            <h4 class="col_tit">희망도서 관리</h4>
            <p class="col_desc">이 곳은 희망도서 관리 영역입니다.</p>
            <!-- side3 -->
            <div class="side3">
              <figure>
                <img src="resources/html/img/side3.jpg" alt="이미지3">
                <figcaption>
                  <h3>Hover<em>Effect</em></h3>
                </figcaption>
              </figure>
            </div>
            <!-- side3//-->
          </article>
          <!-- //col9 -->
        </section>
        <!-- //cont_right -->
      </div>
    </section>
    <!-- //contents -->
<!--   </main> -->

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

</body>

</html>