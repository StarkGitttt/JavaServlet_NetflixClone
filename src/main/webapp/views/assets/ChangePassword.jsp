<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="shortcut icon" href="<%=request.getContextPath()%>/views/assets/images/favicon.png" type="image/png">
<title>Change Password</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/views/assets/css/change-pass.css" />
</head>
<body style="background-color: #212121">
	<jsp:include page="/views/assets/component-layout/header.jsp"/>
	<c:url var="urlAccount" value="/account"></c:url>
	<div class="main">
        <form action="${urlAccount}/change-password" method="post" class="form" id="form-1">
            <h3 class="heading">Đổi mật khẩu</h3>
            <div class="spacer"></div>
          <div class="form-group">
            <label for="idstudent" class="form-label">Tài khoản</label>
            <input id="idstudent" name="username" type="text" class="form-control" value="${sessionScope.user.userId}"
            disabled>
          </div>
          
      		<div class="form-group">
              <label for="password" class="form-label">Mật khẩu cũ</label>
              <input id="password" name="passwordOld" type="password" class="form-control">
              <span class="form-message">${errPassOldSession}</span>
            </div>
      		<div class="form-group">
              <label for="password" class="form-label">Mật khẩu mới</label>
              <input id="password" name="passwordNew" type="password" class="form-control"  value=${confirmPass}>
              <span class="form-message">${errPassConfirm}</span>
            </div>
      		<div class="form-group">
              <label for="password" class="form-label">Nhập lại mật khẩu</label>
              <input id="password" name="passwordConfirm" type="password" class="form-control">
              <span class="form-message">${errPassConfirm}</span>
            </div>
			<span class="form-message" style="color: #79c267">${isSuccess}</span>
              <span class="form-message">${errRequired}</span>
          <button class="form-submit">Sign-in</button>
        </form>       
    </div>
</body>
</html>