<%@ page contentType="text/html;charset=UTF-8"%>
<html>

<head>
<title><g:message code='spring.security.ui.invalidToken.title' /></title>
<meta name='layout' content='auth' />
</head>

<body>

		<div class='alert alert-block alert-danger text-center'>
			<h3>
				<g:message code='spring.security.ui.invalidToken' />
			</h3>
		</div>
		<div class="text-center">
			<a class="btn btn-primary" href="${request.contextPath}"><g:message
					code='returnToMainPage' default='Blocks' /></a>
		</div>

</body>
</html>