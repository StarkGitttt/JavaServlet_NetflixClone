<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
  <link rel="shortcut icon" href="<%=request.getContextPath()%>/views/assets/images/favicon.png" type="image/png">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/views/assets/css/change-pass.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<title>Sign-up</title>
<style>
	.spacer {
		margin-top: 0px !important
	}
</style>
</head>
<body style="background-color: #323232">
		<c:url var="urlAccount" value="/account"></c:url>
		<div class="main">
        <form action="${urlAccount}/sign-up" method="post" class="form" id="form-1">
            <h3 class="heading">Đăng ký</h3>
            <div class="spacer"></div>
          <div class="form-group">
            <label for="idstudent" class="form-label">Tài khoản</label>
            <input id="idstudent" name="userId" type="text" class="form-control" value=${username} >
            <span class="form-message">${isExistUser}</span>
          </div>
          
      		<div class="form-group">
              <label for="email" class="form-label">Email</label>
              <input id="email" name="email" type="email" class="form-control">
              <span class="form-message">${errEmail}</span>
            </div>
      		<div class="form-group">
              <label for="fullname" class="form-label">Họ và tên</label>
              <input id="fullname" name="fullname" type="text" class="form-control" >
              <span class="form-message">${errFullname}</span>
            </div>
      		<div class="form-group">
              <label for="password" class="form-label">Mật khẩu</label>
              <input id="password" name="password" type="password" class="form-control">
              <span class="form-message">${errPass}</span>
            </div>
      		<div class="form-group">
              <label for="password" class="form-label">Nhập lại mật khẩu</label>
              <input id="password" name="passwordConfirm" type="password" class="form-control">
              <span class="form-message">${errConfirmPass}</span>
            </div>
             <div class="form-group">
	                    <label for="password" class="form-label">
	                    	<a href="/MoviesEntertainment/index">Về trang chủ?</a>
	                    </label>
	          </div>
			<span class="form-message" style="color: #79c267">${isSuccess}</span>
              <span class="form-message">${isRequired}</span>
          <button class="form-submit">Sign-up</button>
        </form>       
    </div>
</body>
</html>