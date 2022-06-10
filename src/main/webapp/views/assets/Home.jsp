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
</head>
<body>

	<!-- Create URL  -->
	<c:url var="urlSearchMovie" value="/search/movie"></c:url>
	<c:url var="urlDetailsMovie" value="/movie/view"></c:url>
	<c:url var="urlLikeMovie" value="/movie/like"></c:url>
	<c:url var="urlViewMovieByCategory" value="/movies/view"></c:url>
	<c:url var="urlAccount" value="/account"></c:url>
	<c:url var="urlAdmin" value="/admin"></c:url>
	<c:url var="urlNewMovie" value="/movie/new"></c:url>
	<!--  Header -->
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
                      <li class="menu-item">
                      	<a href="/MoviesEntertainment/MyFavoreMovieController">Phim yêu thích</a>
                      </li>
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
	
	<!-- Carousel Start -->
	
	 <div id="demo" class="carousel slide" data-ride="carousel">
      <div class="carousel-inner">
      <!--  Movie 1 -->
        <div class="carousel-item active">
          <img src="/MoviesEntertainment/views/assets/images/slider/twenty-five.jpg" alt="Los Angeles" width="1280" height="575">
          <div class="carousel-caption">
            <div class="channel-logo fadeInLeft animated"
             data-animation-in="fadeInLeft" data-delay-in="0.5" 
             style="opacity: 1; animation-delay: 0.5s;">
              <img src="/MoviesEntertainment/views/assets/images/logo.png" class="c-logo" alt="">
            </div>
            <!-- Title -->
            <h1 class="slider-text big-title title text-uppercase fadeInLeft animated"
             data-animation-in="fadeInLeft" data-delay-in="0.6" style="opacity: 1; animation-delay: 0.6s; font-size: 3rem">
              Tuổi 25, Tuổi 21
            </h1>
            <!-- Description -->
            <p style="opacity: 1; animation-delay: 0.5s;" data-animation-in="fadeInLeft" data-delay-in="0.5" >
              Thanh xuân là đóa hoa chỉ nở rộ duy nhất một lần trong đời
            </p>
            <div class="trending-list" data-animation-in="fadeInUp" data-delay-in="1.2">
              <div class="text-primary title starring">
                Starring :
                <span class="text-body">Kim Tae-ri, Nam Joo-hyuk, Bona</span>
              </div>
            </div>
            <!-- Start -->
            <div class="d-flex flex-wrap align-items-center fadeInLeft animated"
                  data-animation-in="fadeInLeft"
                  style="opacity: 1; margin-bottom: 100px; animation-delay: 0.5s">
                  <div class="slider-ratting d-flex align-items-center mr-4 mt-2 mt-md-3">
                    <ul
                      class="ratting-start p-0 m-0 list-inline text-primary d-flex align-items-center justify-content-left">
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star-half"></i></li>
                    </ul>
                  </div>
                  <div class="d-flex align-items-center mt-2 mt-md-3">
                    <span class="badge badge-secondary p-2">15+</span>
                    <span class="ml-3">16 Tập</span>
                  </div>
                </div>
          </div>   
        </div>
        <!--  Movie 2 -->
        <div class="carousel-item">
          <img src="/MoviesEntertainment/views/assets/images/slider/insidious-chapter-2.jpg" alt="Los Angeles" width="1280" height="575">
          <div class="carousel-caption">
            <div class="channel-logo fadeInLeft animated" data-animation-in="fadeInLeft" data-delay-in="0.5" style="opacity: 1; animation-delay: 0.5s;">
              <img src="/MoviesEntertainment/views/assets/images/logo.png" class="c-logo" alt="">
            </div>
            <!-- Tile -->
            <h1 class="slider-text big-title title text-uppercase fadeInLeft animated" data-animation-in="fadeInLeft" data-delay-in="0.6" style="opacity: 1; animation-delay: 0.6s; font-size: 3rem">
              INSIOUS 2
            </h1>
            <!-- Descript -->
            <p style="opacity: 1; animation-delay: 0.5s;" data-animation-in="fadeInLeft" data-delay-in="0.5" >Những inh hồn đầy thù hận đến từ thế giới khác</p>
            <!-- Cast -->
            <div class="trending-list" data-animation-in="fadeInUp" data-delay-in="1.2">
              <div class="text-primary title starring">
                Starring :
                <span class="text-body">Patrick Wilson, James Wan, Lin Shaye</span>
              </div>
            </div>
            <!-- Vote -->
            <div class="d-flex flex-wrap align-items-center fadeInLeft animated" data-animation-in="fadeInLeft"
                  style="opacity: 1; margin-bottom: 100px; animation-delay: 0.5s">
                  <div class="slider-ratting d-flex align-items-center mr-4 mt-2 mt-md-3">
                    <ul
                      class="ratting-start p-0 m-0 list-inline text-primary d-flex align-items-center justify-content-left">
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star-half"></i></li>
                    </ul>
                  </div>
                  <div class="d-flex align-items-center mt-2 mt-md-3">
                    <span class="badge badge-secondary p-2">18+</span>
                    <span class="ml-3">1h 42min</span>
                  </div>
                </div>
          </div>   
        </div>
        <!--  Movie 3 -->
        <div class="carousel-item">
          <img src="/MoviesEntertainment/views/assets/images/slider/demon-slayder.jpg" alt="Los Angeles" width="1280" height="575">
          <div class="carousel-caption">
            <div class="channel-logo fadeInLeft animated" data-animation-in="fadeInLeft" data-delay-in="0.5" style="opacity: 1; animation-delay: 0.5s;">
              <img src="/MoviesEntertainment/views/assets/images/logo.png" class="c-logo" alt="">
            </div>
            <!-- Title -->
            <h1 class="slider-text big-title title text-uppercase fadeInLeft animated" data-animation-in="fadeInLeft" data-delay-in="0.6" style="opacity: 1; animation-delay: 0.6s; font-size: 3rem">
              Demon Slayer
            </h1>
            <!-- Description -->
            <p style="opacity: 1; animation-delay: 0.5s;"
             data-animation-in="fadeInLeft" data-delay-in="0.5" >Bí mật về sức mạnh và tiềm lực của Tanjirou</p>
            <!-- Cast -->
            <div class="trending-list" data-animation-in="fadeInUp" data-delay-in="1.2">
              <div class="text-primary title starring">
                Starring :
                <span class="text-body">Rengoku Kyoyuro, Kamado Tanjiro, Akaza</span>
              </div>
            </div>
            <!-- Vote -->
            <div class="d-flex flex-wrap align-items-center fadeInLeft animated" data-animation-in="fadeInLeft"
                  style="opacity: 1; margin-bottom: 100px; animation-delay: 0.5s">
                  <div class="slider-ratting d-flex align-items-center mr-4 mt-2 mt-md-3">
                    <ul
                      class="ratting-start p-0 m-0 list-inline text-primary d-flex align-items-center justify-content-left">
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star"></i></li>
                      <li><i class="fa fa-star-half"></i></li>
                    </ul>
                  </div>
                  <div class="d-flex align-items-center mt-2 mt-md-3">
                    <span class="badge badge-secondary p-2">13+</span>
                    <span class="ml-3">2h 12min</span>
                  </div>
                </div>
          </div>   
        </div>
      </div>
      <a class="carousel-control-prev" href="#demo" data-slide="prev">
        <span class="carousel-control-prev-icon"></span>
      </a>
      <a class="carousel-control-next" href="#demo" data-slide="next">
        <span class="carousel-control-next-icon"></span>
      </a>
    </div>
	<!-- Carousel End -->	
	<!-- Header End -->
	
	<!--  Main content Start-->
	<div class="main-content">
        <!-- TOP 10 IN VIET NAM TODAY - Start-->
         <section id="iq-favorites">
          <div class="container-fluid">
            <div class="row">
              <div class="col-sm-12 overflow-hidden">
                <div class="iq-main-header d-flex align-items-center justify-content-between">
                  <h4 class="main-title">Top 10 in Vietnam Today</h4>
                </div>
                <div class="favorite-contens">
                  <ul class="favorites-slider list-inline row p-0 mb-0">
                  <!-- Movies Popular -->
           
                  <c:forEach var="movie" items="${popularMovies}">
                    <li class="slide-item">
                      <div class="block-images position-relative">
                        <div class="img-box">
                          <img src="${movie.poster}" class="img-fluid" alt="">
                        </div>
                        <div class="block-description">
                          <h6 class="iq-title">
                            <a href="#">
                              ${movie.title}
                            </a>
                          </h6>
                          <div class="movie-time d-flex align-items-center my-2">
                            <div class="badge badge-secondary p-1 mr-2">18+</div>
                            <span class="text-white">1h 43min</span>
                          </div>
                          <div class="hover-buttons">
                            <a href="${urlDetailsMovie}/${movie.movieId}" class="btn btn-hover iq-button">
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
                              		<span class="count-box">${movie.views}</span>
                            </li>
                            <li>                 
                            	<a href="${urlLikeMovie}/${movie.movieId}" style="margin-left:5px">
	                                 <!-- Xử lý nếu Video nào đc Like bởi User sẽ Highlight nút Like -->
	                              <c:set var="countsExist" value="false" scope="page"></c:set>
	                              <c:forEach var="item" items="${favMoviesByUser}">
	                              		<c:if test="${item.movieId == movie.movieId}">
	                              				<c:remove var="countsExist"/>
	                              				<c:set var="countsExist" value="true" scope="page"></c:set>
	                              		</c:if>         		
	                              </c:forEach>                            	
	                        		<c:if test="${countsExist}">
	                        			    <span class="is-like">
			                                <i class="fas fa-thumbs-up"></i>
			                              </span>      
	                        		</c:if>
	                              <c:if test="${!countsExist}">
	                        			    <span class="">
			                                <i class="fas fa-thumbs-up"></i>
			                              </span>      
	                        		</c:if>                    	
                            	</a>
                            	<c:forEach var="item" items="${moviesLike}">
									<c:choose>
										<c:when test="${item.key==movie.movieId}">
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
          </div>
        </section>
		<!--  Top 10 VN TODAY - END -->
		
		<!--  Category Movie - Start -->
		 <section id="iq-favorites">
          <div class="container-fluid">
          <c:forEach var="category" items="${categorys}">
            <div class="row">
              <div class="col-sm-12 overflow-hidden">
                <div class="iq-main-header d-flex align-items-center justify-content-between">
                  <h4 class="main-title">${category.key}</h4>
                </div>
                <div class="favorite-contens">
                  <ul class="favorites-slider list-inline row p-0 mb-0">
                  <!-- Movies Popular -->
           
                  <c:forEach var="movie" items="${category.value}">
                    <li class="slide-item">
                      <div class="block-images position-relative">
                        <div class="img-box">
                          <img src="${movie.poster}" class="img-fluid" alt="">
                        </div>
                        <div class="block-description">
                          <h6 class="iq-title">
                            <a href="#">
                              ${movie.title}
                            </a>
                          </h6>
                          <div class="movie-time d-flex align-items-center my-2">
                            <div class="badge badge-secondary p-1 mr-2">18+</div>
                            <span class="text-white">1h 43min</span>
                          </div>
                          <div class="hover-buttons">
                            <a href="${urlDetailsMovie}/${movie.movieId}" class="btn btn-hover iq-button">
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
                              		<span class="count-box">${movie.views}</span>
                            </li>
                            <li>                 
                            	<a href="${urlLikeMovie}/${movie.movieId}" style="margin-left:5px">
	                              <!-- Xử lý nếu Video nào đc Like bởi User sẽ Highlight nút Like -->
	                              <c:set var="countExist" value="false" scope="page"></c:set>
	                              <c:forEach var="item" items="${favMoviesByUser}">
	                              		<c:if test="${item.movieId == movie.movieId}">
	                              				<c:remove var="countExist"/>
	                              				<c:set var="countExist" value="true" scope="page"></c:set>
	                              		</c:if>         		
	                              </c:forEach>                            	
	                        		<c:if test="${countExist}">
	                        			    <span class="is-like">
			                                <i class="fas fa-thumbs-up"></i>
			                              </span>      
	                        		</c:if>
	                              <c:if test="${!countExist}">
	                        			    <span class="">
			                                <i class="fas fa-thumbs-up"></i>
			                              </span>      
	                        		</c:if>
				                
	                            <c:forEach var="item" items="${moviesLike}">
									<c:choose>
										<c:when test="${item.key==movie.movieId}">
		                                	<span class="count-box">${item.value}</span>										
										</c:when>
									</c:choose>
								</c:forEach>                
                            	</a>
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
		<!--  Category Movie - End -->
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
	<!--  Main content End -->
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="<%=request.getContextPath()%>/views/assets/js/main.js"></script>
    <script src="<%=request.getContextPath()%>/views/assets/js/slick.min.js"></script>
    <script src="<%=request.getContextPath()%>/views/assets/js/slick-animation.min.js"></script>
</body>
</html>