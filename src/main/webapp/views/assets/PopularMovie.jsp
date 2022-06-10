<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="shortcut icon" href="<%=request.getContextPath()%>/views/assets/images/favicon.png" type="image/png">
<title>Netflix</title>
 <!-- Font-awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <!-- CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/views/assets/css/home.css">
    <!-- Slick CSS-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/views/assets/css/animate.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/views/assets/css/slick-animation.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/views/assets/css/slick-theme.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/views/assets/css/slick.css">
  
	<style>
	 #iq-favorites .row:nth-child(1) {
        padding-top: 100px;
      }
		.li.slide-item {
			margin-bottom: 25px;
		}
		.slick-track {
			display: flex;
			align-items: baseline;
		}
	</style>
</head>
<body>
		<c:url var="urlSearchMovie" value="/search/movie"></c:url>
		<c:url var="urlDetailsMovie" value="/movie/view"></c:url>
		<c:url var="urlLikeFavMovie" value="/movie/fav/like"></c:url>
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
                      <li class="menu-item"><a href="#"> ${sessionScope.user.fullname}</a>
                      	<ul class="sub-menu">
                         	<li class="menu-item">
                        		  	<a href="${urlAccount}/change-password">
                        		  		Đổi mật khẩu
                        		  	</a>
                        	</li>
                         	<li class="menu-item">
                        		  	<a href="#" data-toggle="modal" data-target="#updateInfor">
                        		  		Chỉnh sửa thông tin
                        		  	</a>
                        	</li>
                        	<c:if test="${sessionScope.user.admin}">
                        		<li class="menu-item">
                        		  	<a href="${urlAdmin}">
                        		  		Quản trị
                        		  	</a>
                        		</li>
                        	</c:if>
                         	<li class="menu-item">
                        		  	<a href="${urlAccount}/logout">
                        		  		Đăng xuất
                        		  	</a>
                        	</li>
                        </ul>
                      </li>
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
	<!-- VIEW MOVIES BY CATEGORY -->
	<div class="main-content">
	  <section id="iq-favorites">
          <div class="container-fluid">
          	<c:forEach var="movie" items="${movies}">
	            <div class="row">
	              <div class="col-sm-12 overflow-hidden">
	                <div class="iq-main-header d-flex align-items-center justify-content-between">
	                  <h4 class="main-title">${movie.key}</h4>
	                </div>
	                <div class="favorite-contens">
	                  <ul class="favorites-slider list-inline row p-0 mb-0">
	                  <!-- Movies Popular -->
	           
	                  <c:forEach var="movieItem" items="${movie.value}">
	                    <li class="slide-item">
	                      <div class="block-images position-relative">
	                        <div class="img-box">
	                          <img src="${movieItem.poster}" class="img-fluid" alt="">
	                        </div>
	                        <div class="block-description">
	                          <h6 class="iq-title">
	                            <a href="#">
	                              ${movieItem.title}
	                            </a>
	                          </h6>
	                          <div class="movie-time d-flex align-items-center my-2">
	                            <div class="badge badge-secondary p-1 mr-2">18+</div>
	                            <span class="text-white">1h 43min</span>
	                          </div>
	                          <div class="hover-buttons">
	                            <a href="${urlDetailsMovie}/${movieItem.movieId}" class="btn btn-hover iq-button">
	                              <i class="fa fa-play mr-1"></i>
	                              Xem Trailer
	                            </a>
	                          </div>
	                        </div>
	                        <div class="block-social-info">
	                          <ul class="list-inline p-0 m-0 music-play-lists">
	                            <li class="share">
	                              <span><i class="fa fa-share-alt"></i></span>
	                              <div class="share-box">
	                                <div class="d-flex align-items-center">
	                                  <a href="#" class="share-ico"><i class="far fa-envelope"></i></a>
	                                </div>
	                              </div>
	                            </li>
	                            <li>
	                              <span><i class="far fa-eye"></i></span>
	                              		<span class="count-box">${movieItem.views}</span>
	                            </li>
	                            <li>                 
	                            	<a href="${urlLikeFavMovie}?id=${movieItem.movieId}" style="margin-left:5px">
		                                 <!-- Xử lý nếu Video nào đc Like bởi User sẽ Highlight nút Like -->
		                              <c:set var="countsExist" value="false" scope="page"></c:set>
		                              <c:forEach var="item" items="${favMoviesByUser}">
		                              		<c:if test="${item.movieId == movieItem.movieId}">
		                              				<c:remove var="countsExist"/>
		                              				<c:set var="countsExist" value="true" scope="page"></c:set>
		                              		</c:if>         		
		                              </c:forEach> 
		                              <!--  Trường hợp có Like Phim -->                           	
		                        		<c:if test="${countsExist}">
		                        			    <span class="is-like">
				                                <i class="fas fa-thumbs-up"></i>
				                              </span>      
		                        		</c:if>
		                        		<!--  Trường hợp không Like Phim -->
		                              <c:if test="${!countsExist}">
		                        			    <span class="">
				                                <i class="fas fa-thumbs-up"></i>
				                              </span>      
		                        		</c:if>                    	
	                            	</a>
	                            	<c:forEach var="item" items="${moviesLike}">
										<c:choose>
											<c:when test="${item.key==movieItem.movieId}">
			                                	<span class="count-box">${item.value}</span>										
											</c:when>
										</c:choose>
									</c:forEach>                           				
	                            </li>
	                          </ul>
	                        </div>
	                      </div>
	                    </li>        
	                  </c:forEach>                 
	                  </ul>
	                </div>
	              </div>
	            </div> 	
          	</c:forEach>
          </div>
        </section>
    </div>
             <!-- Update Information -->
         <div class="modal fade " id="updateInfor" >
	        <div class="modal-dialog" style="width: 400px">
	          <div class="modal-content">
	            <!-- Modal Header -->       
	            <!-- Modal body -->       
	                <form action="${urlAccount}/update-infor" method="post" class="form" id="form-1">
	                  <button type="button" class="close" data-dismiss="modal">&times;</button>
	                <br/>
	                  <div class="signin-heading">Cập nhập thông tin</div>
	                  <div class="spacer"></div>
	              
	                  <div class="form-group">
	                    <label for="userId" class="form-label">Tài khoản</label>
	                    <input id="userId" name="userId" type="text" class="form-control"
	                     value="${sessionScope.user.userId}">
	                  </div>
	              		
	                  <div class="form-group">
	                    <label for="fullname" class="form-label">Họ và tên</label>
	                    <input id="fullname" name="fullname" type="text"  class="form-control"
	                    value="${sessionScope.user.fullname}">
	                    <span class="form-message">${errUpdateName}</span>
	                  </div>
	                  <div class="form-group">
	                    <label for="email" class="form-label">Email</label>
	                    <input id="email" name="email" type="email" class="form-control"
	                    value="${sessionScope.user.email}">
	                    <span class="form-message">${errUpdateEmail}</span>
	                  </div>
	              	  <span class="form-message">${isSuccess}</span>
	                  <button class="form-submit">Cập nhập</button>
	                </form>
	          </div>
	        </div>
      </div>
      <!-- Update Information End -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="<%=request.getContextPath()%>/views/assets/js/main.js"></script>
    <script src="<%=request.getContextPath()%>/views/assets/js/slick.min.js"></script>
    <script src="<%=request.getContextPath()%>/views/assets/js/slick-animation.min.js"></script>
</body>
</html>