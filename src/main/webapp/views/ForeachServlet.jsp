<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>

		<c:forEach var="movie" items="${movies}">
			<h3 style="color: red">${movie.key}</h3>
			<c:forEach var="nameMovie" items="${movie.value}">
				<h4>${nameMovie.title}</h4>
				<h4>${nameMovie.movieId}</h4>
			</c:forEach>
		</c:forEach>
</body>
</html>