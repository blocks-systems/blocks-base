<%@ page contentType="text/html;charset=UTF-8"%>
<html>

<head>
<title><g:message code='application.error' /></title>
<asset:stylesheet src="errors.css"/>
</head>

<body>
	<g:renderException exception="${exception}" />
</body>
</html>