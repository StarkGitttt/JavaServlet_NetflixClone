<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<fmt:setLocale value="en_US"/>
	<fmt:setBundle basename="resources.app" var="lang"/>
	<h1><fmt:message key="content" bundle="${lang}"></fmt:message> </h1>
	<!-- <jsp:include page="/views/index.jsp"/> -->
	<!-- <c:forEach var="obj"  items="objs">
		<c:forEach var="item" items="obj">
			${item}
		</c:forEach>
	</c:forEach>
	<div>${name}</div> -->
	<!-- <div>${obj}</div> -->
</body>
</html>