<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!-- CSS -->
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/views/assets/css/home.css" />
<style>
	body {
		background-color: #191919;
	}
	#main-header #navbardrop, #top-menu a {
	color: white;
	}
	#main-header row {
	background-color: rgba(68, 68, 68 / 40%) !important;
	}
</style>
<!-- Bootstrap -->
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<c:url var="urlSearchMovie" value="/search/movie"></c:url>
<c:url var="urlViewMovieByCategory" value="/movies/view"></c:url>
<c:url var="urlAccount" value="/account"></c:url>
<c:url var="urlAdmin" value="/admin"></c:url>
<c:url var="urlNewMovie" value="/movie/new"></c:url>
<header id="main-header">
      <div class="main-header">
        <div class="container-fluid">
          <div class="row">
            <div class="col-sm-12">
              <nav class="navbar navbar-expand-lg navbar-light p-0">
                <a href="#" class="navbar-toggler c-toggler" data-toggle="collapse" data-target="#navbarSupportedContent"
                  aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                  <div class="navbar-toggler-icon" data-toggle="collapse">
                    <span class="navbar-menu-icon navbar-menu-icon--top"></span>
                    <span class="navbar-menu-icon navbar-menu-icon--middle"></span>
                    <span class="navbar-menu-icon navbar-menu-icon--bottom"></span>
                  </div>
                </a>
                <a href="/MoviesEntertainment/HomeServlet" class="navbar-brand">
                  <img src="/MoviesEntertainment/views/assets/images/logo.png" class="img-fluid logo" alt="" />
                </a>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                  <div class="menu-main-menu-container">
                    <ul id="top-menu" class="navbar-nav ml-auto">
                      <li class="menu-item"><a href="/MoviesEntertainment/HomeServlet">Trang chủ</a></li>
                      <li class="menu-item">
                        <a href="#">Thể loại</a>
                        <ul class="sub-menu">
                        	<c:forEach var="category" items="${categorysByName}">
                        		  <li class="menu-item">
                        		  	<a href="${urlViewMovieByCategory}/${category.categoryId}">
                        		  		${category.nameCategory}
                        		  	</a>
                        		  </li>
                        	</c:forEach>
                        </ul>
                      </li>
                      <li class="menu-item"><a href="/MoviesEntertainment/MyFavoreMovieController">Phim yêu thích</a></li>
                      <li class="menu-item"><a href="${urlNewMovie}">Mới & Phổ biến</a></li>
                    </ul>
                  </div>
                </div>
                <div class="mobile-more-menu">
                  <a href="javascript:void(0);" class="more-toggle" id="dropdownMenuButton" data-toggle="more-toggle"
                    aria-haspopup="true" aria-expanded="false">
                    <i class="fa fa-ellipsis-h"></i>
                  </a>
                  <div class="more-menu" aria-labelledby="dropdownMenuButton">
                    <div class="navbar-right position-relative">
                      <ul class="d-flex align-items-center justify-content-end list-inline m-0">
                        <li>
                          <a href="#" class="search-toggle">
                            <i class="fa fa-search"></i>
                          </a>
                          <div class="search-box iq-search-bar">
                            <form action="#" class="searchbox">
                              <div class="form-group position-relative">
                                <input type="text" class="text search-input font-size-12"
                                  placeholder="type here to search..." />
                                <i class="search-link fa fa-search"></i>
                              </div>
                            </form>
                          </div>
                        </li>
                      </ul>
                    </div>
                  </div>
                </div>
  
                <div class="navbar-right menu-right">
                  <ul class="d-flex align-items-center list-inline m-0">
                    <li class="nav-item nav-icon">
                      <a href="#" class="search-toggle device-search">
                        <i class="fa fa-search"></i>
                      </a>
                      <div class="search-box iq-search-bar d-search">
                        <form action="${urlSearchMovie}" class="searchbox" method="post">
                          <div class="form-group position-relative">
                            <input type="text" class="text search-input font-size-15"
                              placeholder="Tên phim của bạn.." name="nameMovie"/>
                              <button class="search-link" style="background: none; border: none; outline: none;">
                                <i class="fa fa-search" style="color: white"></i>
                              </button>
                          </div>
                        </form>
                      </div>
                    </li>
                
                    <li class="nav-item dropdown">
                      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                        ${sessionScope.user.fullname}
                      </a>
                      <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">Đổi mật khẩu</a>
                        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#updateInfor">Chỉnh sửa thông tin</a>
                        <c:if test="${sessionScope.user.admin}">
                        	<a class="dropdown-item" href="${urlAdmin}">Quản trị</a>
                        </c:if>
                        <a class="dropdown-item" href="${urlAccount}/logout">Đăng xuất</a>
                      </div>
                    </li>
                  </ul>
                </div>
              </nav>
              <div class="nav-overlay">

              </div>
            </div>
          </div>
        </div>
      </div>
    </header>
</body>
</html>