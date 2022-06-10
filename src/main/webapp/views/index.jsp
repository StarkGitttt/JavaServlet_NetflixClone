<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html lang>
<head>
<meta charset="utf-8">
<link rel="shortcut icon" href="<%=request.getContextPath()%>/views/assets/images/favicon.png" type="image/png">
<title>Netflix</title>
<!-- Css -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/views/assets/css/index.css" />
<!-- Bootstrap -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- Font awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" integrity="sha512-5A8nwdMOWrSz20fDsjczgUidUBR8liPYU+WymTZP1lmY9G6Oc7HlZv156XqnsgNUzTyMefFTcsFH/tnJE/+xBg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<style>
	.login-google {
		color: #f02630;
	}
	.login-google:hover {
		color: #ed3e46;
	}
</style>
</head>
<body>
	<c:url var="url" value="/index"></c:url>
	<c:url var ="urlAccount" value="/account"></c:url>
	<fmt:setLocale value="${sessionScope.lang}"/>
	<fmt:setBundle basename="resources.app" var="lang"/>
    <div class="container-fluid">
        <div class="header">
            <div class="header-top">
                <img src="<%=request.getContextPath()%>/views/assets/images/logo.png" alt="Netflix Logo">
                <div class="header-top__nav">
                    <div class="lang-selection header-top__item">                   
                        <ul class="nav nav-pills">
							  <li class="nav-item dropdown" style="border: 2px solid white">
							    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" 
							    style="color: white;">
							    <fmt:message key="index.language" bundle="${lang}"></fmt:message>
							    </a>
							    <div class="dropdown-menu">
							      <a class="dropdown-item" href="?lang=vi_VN">Tiếng Việt</a>
							      <a class="dropdown-item" href="?lang=en_US">English</a>
							    </div>
							  </li>
			
						</ul>
                    </div>
                    <div class="header-top__item">
                        <a href="#" class="btn btn-danger" style="font-size: 1.2rem; font-weight:400; padding: 10px"
                        data-toggle="modal" data-target="#signIn">
                        <fmt:message key="index.signin" bundle="${lang}"></fmt:message>
                        </a>
                    </div>
                </div>
            </div>
            <div class="header-content">
                <h1><fmt:message key="index.heading1" bundle="${lang}"></fmt:message></h1>
                <form action="" class="email-form" method="post">
                    <h3 class="email-form-title">
                    <fmt:message key="index.heading3" bundle="${lang}"></fmt:message>
                    </h3>
                    <div class="email-form-lockup">
                        <div class="form-group">
                            <input type="email" class="form-control" name="email-form-lockup" placeholder="Email address"
                            style="width: 454px; height: 4rem; padding-left: 1.5rem;">
                        </div>
                        <button class="btn btn-danger" type="submit" 
                        style="border-radius: 0px 5px 5px 0px; height: 4rem; font-size: 1.3rem">
                            <span><fmt:message key="index.started" bundle="${lang}"></fmt:message></span>
                            <span><i class="fa fa-angle-right" aria-hidden="true"></i></span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
        <section class="cards">
            <div class="card-0 row">
                <div class="col-lg-6 col-md-12">
                    <img class="img-fluid" src="<%=request.getContextPath()%>/views/assets/images/kid.png" alt="Kids Mobile">                   
                </div>
                <div class="desc-0 col-lg-6 col-md-12">
                    <h1>
                        <fmt:message key="index.kidsTitle" bundle="${lang}"></fmt:message>
                    </h1>
                    <h3>
                        <fmt:message key="index.kidsHeading" bundle="${lang}"></fmt:message>
                    </h3>
                </div>
            </div>
            <div class="card-1 row" style="justify-content: flex-end;">
                <div class="desc-1 col-lg-6 col-md-12">
                    <h1>
                        <fmt:message key="index.tvTitle" bundle="${lang}"></fmt:message>
                    </h1>
                    <h3>
                        <fmt:message key="index.tvHeading" bundle="${lang}"></fmt:message>
                    </h3>
                </div>
                <div class="col-lg-6 col-md-12">
                    <div style="position: relative">
                        <img class="img-fluid" src="<%=request.getContextPath()%>/views/assets/images/tv.png" alt="Tv">   
                    </div>
                    <video class="video-1" autoplay="" playsinline="" muted="" loop="">
                        <source src="<%=request.getContextPath()%>/views/assets/videos/video-tv-0819.m4v" type="video/mp4">
                    </video>                
                </div>
            </div>
            <div class="card-2 row">
                <div class="col-lg-6 col-md-12">
                    <img class="img-fluid" src="<%=request.getContextPath()%>/views/assets/images/vn.jpg" alt="Vn">                   
                </div>
                <div class="desc-2 col-lg-6 col-md-12">
                    <h1>
                        <fmt:message key="index.phoneTitle" bundle="${lang}"></fmt:message>
                    </h1>
                    <h3>
                        <fmt:message key="index.phoneHeading" bundle="${lang}"></fmt:message>
                    </h3>
                </div>
            </div>
        </section>
        <!--  Câu hỏi thường gặp -->
        <div id="accordion">
            <h1 class="caption text-center"><fmt:message key="ask.popular" bundle="${lang}"></fmt:message></h1>
            <div class="card-container">
                <div class="card">
                <div class="card-header">
                    <h3 class="card-link" data-toggle="collapse" href="#collapseOne">
                    	<fmt:message key="faqOne" bundle="${lang}"></fmt:message>
                    </h3>
                </div>
                <div id="collapseOne" class="collapse" data-parent="#accordion">
                    <div class="card-body">
                    <div class="card-heading">
                        <fmt:message key="ansOne.One" bundle="${lang}"></fmt:message>
                    </div>
                    <div class="card-heading">
                        <fmt:message key="ansOne.Two" bundle="${lang}"></fmt:message>
                    </div>
                    </div>
                </div>
                </div>
            
                <div class="card">
                <div class="card-header">
                    <h3 class="collapsed card-link" data-toggle="collapse" href="#collapseTwo">
                        <fmt:message key="faqTwo" bundle="${lang}"></fmt:message>
                    </h3>
                </div>
                <div id="collapseTwo" class="collapse" data-parent="#accordion">
                    <div class="card-body">
                    <div class="card-heading">
                       <fmt:message key="ansTwo" bundle="${lang}"></fmt:message>
                    </div>
                    </div>
                </div>
                </div>
            
                <div class="card">
                <div class="card-header">
                    <h3 class="collapsed card-link" data-toggle="collapse" href="#collapseThree">
                        <fmt:message key="faqThree" bundle="${lang}"></fmt:message>
                    </h3>
                </div>
                <div id="collapseThree" class="collapse" data-parent="#accordion">
                    <div class="card-body">
                    <div class="card-heading">
                         <fmt:message key="ansThree.One" bundle="${lang}"></fmt:message>
                    </div>
                    <div class="card-heading">
                       <fmt:message key="ansThree.Two" bundle="${lang}"></fmt:message>
                    </div>
                    </div>
                </div>
                </div>

                <div class="card">
                <div class="card-header">
                    <h3 class="collapsed card-link" data-toggle="collapse" href="#collapseFour">
                       <fmt:message key="faqFour" bundle="${lang}"></fmt:message>
                    </h3>
                </div>
                <div id="collapseFour" class="collapse" data-parent="#accordion">
                    <div class="card-body">
                    <div class="card-heading">
                       <fmt:message key="ansFour" bundle="${lang}"></fmt:message>
                    </div>
                    </div>
                </div>
                </div>

                <div class="card">
                <div class="card-header">
                    <h3 class="collapsed card-link" data-toggle="collapse" href="#collapseFive">
                       <fmt:message key="faqFive" bundle="${lang}"></fmt:message>
                    </h3>
                </div>
                <div id="collapseFive" class="collapse" data-parent="#accordion">
                    <div class="card-body">
                        <div class="card-heading">
                            <fmt:message key="ansFive" bundle="${lang}"></fmt:message>
                        </div>
                    </div>
                </div>
                </div>
                
                <div class="card">
                <div class="card-header">
                    <h3 class="collapsed card-link" data-toggle="collapse" href="#collapseSix">
                        <fmt:message key="faqSix" bundle="${lang}"></fmt:message>
                    </h3>
                </div>
                <div id="collapseSix" class="collapse" data-parent="#accordion">
                    <div class="card-body">
                    <div class="card-heading">
                        <fmt:message key="ansSix.One" bundle="${lang}"></fmt:message>
                    </div>
                    <div class="card-heading">
                        <fmt:message key="ansSix.Two" bundle="${lang}"></fmt:message>
                    </div>
                    </div>
                </div>
                </div>
            </div>
          </div>
          <div class="footer" id="footer">
              <div class="container">
              <div class="row">
                <div class="footer-col col-6 col-md-3 col-lg-3">
                  <h4>Công ty</h4>
                  <ul class="list-unstyled">
                    <li><a href="#">Về chúng tôi</a></li>
                    <li><a href="#">Dịch vụ của chúng tôi</a></li>
                    <li><a href="#">Chính sách bảo mật</a></li>
                    <li><a href="#">Liên kết</a></li>
                  </ul>
                </div>
                <div class="footer-col col-6 col-md-3 col-lg-3">
                  <h4>Giúp đỡ</h4>
                  <ul class="list-unstyled">
                        <li><a href="#">FAQ</a></li>
                        <li><a href="#">Shipping</a></li>
                        <li><a href="#">Trả lại</a></li>
                        <li><a href="#">Order status</a></li>
                        <li><a href="#">Phương thức thanh toán</a></li>
                  </ul>
                </div>
                <div class="footer-col col-6 col-md-3 col-lg-3">
                  <h4>Trung tâm</h4>
                  <ul class="list-unstyled">
                        <li><a href="#">AMA</a></li>
                        <li><a href="#">Ms.Hoa</a></li>
                        <li><a href="#">Academy</a></li>
                        <li><a href="#">F8</a></li>
                  </ul>
                </div>
                <div class="footer-col col-6 col-md-3 col-lg-3">
                  <h4>Follow up</h4>
                    <div class="social-links" style="color: white;">
                      <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                      <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
                      <a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                      <a href="#"><i class="fa fa-github" aria-hidden="true"></i></a>
                    </div>           
                </div>
              </div>
            </div>
          </div>      
    </div>
    <!-- Login -->
         <div class="modal fade" id="signIn">
	        <div class="modal-dialog" style="width: 400px">
	          <div class="modal-content">
	            <!-- Modal Header -->       
	            <!-- Modal body -->       
	                <form action="${url}/login" method="post" class="form" id="form-1">
	                  <button type="button" class="close" data-dismiss="modal">&times;</button>
	                <br/>
	                  <div class="signin-heading">ĐĂNG NHẬP</div>
	                  <div class="spacer"></div>
	              
	                  <div class="form-group">
	                    <label for="username" class="form-label">Tài khoản</label>
	                    <input id="username" name="username" type="text" placeholder="VD: email@domain.com" class="form-control email-signUp">
	                    <span class="form-message">${errorExistUser}</span>
	                  </div>
	              
	                  <div class="form-group">
	                    <label for="password" class="form-label">Mật khẩu</label>
	                    <input id="password" name="password" type="password" placeholder="Nhập mật khẩu" class="form-control password-signUp">
	                    <span class="form-message">${errorInvalidPw}</span>
	                  </div>
	                  <div class="form-group">
								<a class="login-google" href="http://accounts.google.com/o/oauth2/auth?scope=email%20profile%20openid
								&redirect_uri=http://localhost:8080/MoviesEntertainment/index
								&response_type=code
								&client_id=936408264015-t8h56ddde9r8dhkcqiasmk1c36ula55j.apps.googleusercontent.com
								&approval_prompt=force"><i class="fab fa-google"></i> Đăng nhập với Google</a>
	                  </div>
	                  <div class="form-group">
	                    <label for="password" class="form-label">
	                    	<a href="${urlAccount}/sign-up">Tạo tài khoản mới?</a>
	                    </label>
	                  </div>
	              		<span class="form-message">${isLoginSuccess}</span>
	                  <button class="form-submit">Đăng nhập</button>
	                </form>
	          </div>
	        </div>
      </div>
</body>
</html>