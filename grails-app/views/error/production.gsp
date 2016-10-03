<%@ page contentType="text/html;charset=UTF-8"%>
<html>

<head>
<title><g:message code='application.error' /></title>
<meta name='layout' content='auth' />
</head>

<body>
	<div class="text-center">
		<h1>
			<g:message code='application.error' />
		</h1>
		<p>
			<g:message code='error.generic' />
		</p>
	</div>
	<div class="text-center">
		<a class="btn btn-primary" href="${request.contextPath}"><g:message
				code='returnToMainPage' default='Blocks' /></a>
	</div>
</body>
</html>
