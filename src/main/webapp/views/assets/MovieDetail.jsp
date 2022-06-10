<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<link rel="shortcut icon" href="<%=request.getContextPath()%>/views/assets/images/favicon.png" type="image/png">
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
<title>Netflix</title>
<style>
      .like-movie {
      	font-weight: bold;
      	color: red;
      }
</style>
</head>
<body style="background-color: #212121">
		<!-- Init Url -->
		<c:url var="urlSearchMovie" value="/search/movie"></c:url>
		<c:url var="urlShareMovie" value="/share/movie"></c:url>
		<c:url var="urlDetailsMovie" value="/movie/view"></c:url>
		<c:url var="urlViewMovieByCategory" value="/movies/view"></c:url>
		<c:url var="urlAccount" value="/account"></c:url>
		<c:url var="urlAdmin" value="/admin"></c:url>
		<c:url var="urlMovieLike" value="/like/movie"></c:url>
		<c:url var="urlCommentMovie" value="/comment/movie"></c:url>
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
                            <form action="${urlSearchMovie}" class="searchbox">
                              <div class="form-group position-relative">
                                <input type="text" class="text search-input font-size-12"
                                  placeholder="type here to search..."/>
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
                              placeholder="Tên phim của bạn.." name="nameMovie" />
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
	<section id="iq-topten" style="padding-top: 100px">
      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-12 overflow-hidden">
            <div class="topten-contents">
              <h5 class="main-title iq-title topten-title">
                Đề xuất cho bạn
              </h5>
              <div style="padding-right: 100px;">
                <div class="row">
                  <div class="col-lg-9 col-md-12">
                      <div class="videos">
                        <div class="video-section">
                          <article class="video-container">
                            <div class="video-trailer">
                              <iframe class="responsive-iframe"
                              src="${movie.linkEmbed}" frameborder="0" style="border: none"></iframe>
                            </div>
                            <div class="video-content">
                              <div class="video-tag">
                                <a href="${urlViewMovieByCategory}/${movie.category.categoryId}">
                                	#${movie.category.nameCategory }
                                </a>
                                <a href="#">#Warner Bros</a>
                                <a href="#">#Action</a>
                              </div>
                              <div class="video-title">
                                <h3>${movie.title} - Trailer[HD]</h3>
                              </div>
                              <div class="video-info">
                                <ul class="list-video-info" style="list-style: none; padding: 0;">
                                  <li class="video-infor__item"><i class="far fa-eye"></i> ${movie.views}</li>
                                  <li class="video-infor__item">
                                  <a href="${urlMovieLike}/${movie.movieId}">
                                  <c:forEach var="item" items="${movies}">
                                  		<c:if test="${item.movieId==movie.movieId}">
                                  			<c:set var="like" value="like-movie"></c:set>
                                  		</c:if>
                                  </c:forEach>
                                  <i class="far fa-thumbs-up ${like}"></i> 
                                  	${countLike}
                                  	</a>
                                  </li>
                                  <li class="video-infor__item"><i class="far fa-thumbs-down"></i> 0</li>
                                  <li class="video-infor__item">
                                  <a href="#" data-toggle="modal" data-target="#share-movie">
	                                  <i class="fas fa-share"></i> Chia sẻ                                  
                                  </a>
                                  </li>
                                </ul>
                                <div style="border: 1px solid gray;">
                                </div>
                              </div>
                            </div>
                            <div class="video-comment" style="margin-bottom: 25px">
                              <div class="row" style="margin-top: 10px">
                                <div class="col-lg-1">
                                    <div class="avatar">
                                      <i class="fas fa-user dark"></i>
                                    </div>
                                </div>
                                <div class="col-lg-11">
                                    <div class="write-comment">
                                      <form action="${urlCommentMovie}/${movie.movieId}" class="form-comment" method="post">
                                        <input  class="mr-sm-2 "type="text" class="form-control"
                                         placeholder="Nhập bình luận của bạn tại đây..." id="comment" name="comment">
                                         <button type="submit" class="btn btn-danger mb-2">Gửi</button>
                                      </form>
                                    </div>                      
                                </div>
                              </div>
                              <div class="row">
                                <small style="margin: 1rem 0 0 2.5rem">${countCmt} Bình luận</small>
                              </div>
	                           <!-- Start Comment -->
                              <c:forEach var="comment" items="${cmts}">
	                               <div class="row" style="margin-top: 25px; align-items: center">
	                                <div class="col-lg-1">
	                                    <div class="avatar">
	                                      <i class="fas fa-user dark"></i>
	                                    </div>
	                                </div>
	                                <div class="col-lg-11">
	                                    <small>${comment.user.fullname}</small>
	                                    <div class="show-comment">
	                                        <input  class="mr-sm-2 "type="text" class="form-control"
	                                         placeholder="Nhập bình luận của bạn tại đây..." id="comment"
	                                         value="${comment.content }" disabled>
	                                    </div>                      
	                                </div>
	                              </div>                                               		
                             </c:forEach>
                              <!-- Start Comment -->
                          
                            </div>
                          </article>
                        </div>
                      </div>
                  </div>
                  <div class="col-lg-3 col-md-12">
             
                  </div>
                </div>
                </div>
        		<!--  Vertical Slide Here -->
         		       <div class="vertical_s">
                <ul id="top-ten-slider-nav" class="list-inline p-0 m-0 d-flex align-items-center">
                <c:forEach var="movie"  items="${moviesSugesstion}">
                  <li>
                    <div class="block-images position-relative">
                      <a href="#">
                        <img src="${movie.poster}" class="img-fluid w-100" alt="" />
                      </a>
                      <div class="block-description">
                        <h5>${movie.title}</h5>
                        <div class="movie-time d-flex align-items-center my-2">
                          <div class="badge badge-secondary p-1 mr-2">
                            10+
                          </div>
                          <span class="text-white">1h 54p</span>
                        </div>
                        <div class="hover-buttons">
                          <a href="${urlDetailsMovie}/${movie.movieId}" class="btn btn-hover" tabindex="0">
                            <i class="fa fa-play mr-1" aria-hidden="true"></i>
                            Xem trailer
                          </a>
                        </div>
                      </div>
                    </div>
                  </li>                    	
                </c:forEach>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- Start Share Mail -->
        <div class="modal fade " id="share-movie" >
	        <div class="modal-dialog" style="width: 400px">
	          <div class="modal-content">
	            <!-- Modal Header -->       
	            <!-- Modal body -->       
	                <form action="${urlShareMovie}/${movie.movieId}" method="get" class="form" id="form-1">
	                  <button type="button" class="close" data-dismiss="modal">&times;</button>
	                <br/>
	                  <div class="signin-heading">Cùng xem với bạn bè</div>
	                  <div class="spacer"></div>
	              
	                  <div class="form-group">
	                    <label for="namemovie" class="form-label">Tên phim</label>
	                    <input id="namemovie" name="namemovie" type="text" class="form-control"
	                     value="${movie.title}">
	                  </div>
	              		
	                  <div class="form-group">
	                    <label for="emailCC" class="form-label">Email người nhận</label>
	                    <input id="emailCC" name="emailCC" type="email"  class="form-control" placeholder="domain@gmail.com">
	                    <span class="form-message"></span>
	                  </div>
	                  <div class="form-group">
	                    <label for="content" class="form-label">Nội dung</label>
	                    <textarea id="content" cols rows="4" placeholder="Type here..." name="content"
	                     style="padding-left: 7px; padding-top:7px;"></textarea>
	                    <span class="form-message"></span>
	                  </div>
	              	  <span class="form-message" style="color: #71d059">${isSuccess}</span>
	                  <button class="form-submit">Chia sẻ</button>
	                </form>
	          </div>
	        </div>
      </div>
      <!-- End send mail -->
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
    <!-- End Share Mail -->
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