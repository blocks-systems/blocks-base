<%@ page contentType="text/html;charset=UTF-8"%>
<html>

<body>
<g:message code="email.forgotPassword.greetings" args="${user.username}" />
	<br />
	<br /> 
<g:message code="email.forgotPassword.firstLine" />
	<br />
	<br /> 
<g:message code="email.forgotPassword.secondLine" />
	<br />
	<br /> 
<g:message code="email.forgotPassword.thirdLine" />&nbsp;<a href="${url}"><g:message code="here" /></a>&nbsp;<g:message code="email.forgotPassword.forthLine" />

</body>
</html>