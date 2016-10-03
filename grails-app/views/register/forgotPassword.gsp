<%@ page contentType="text/html;charset=UTF-8"%>
<html>

<head>
<title><g:message code='spring.security.ui.forgotPassword.title' /></title>
<meta name='layout' content='auth' />
</head>

<body>

	<g:if test='${flash.error}'>
		<div class='alert alert-block alert-danger text-center'>
			<h3>
				${flash.error}
			</h3>
		</div>
	</g:if>

	<g:if test='${flash.message}'>
		<div class='alert alert-block alert-info text-center'>
			<h3>
				${flash.message}
			</h3>
		</div>
		<div class="text-center">
			<a class="btn btn-primary" href="${request.contextPath}"><g:message
					code='returnToMainPage' default='Blocks' /></a>
		</div>
	</g:if>

	<g:else>
		<g:form action='forgotPassword' name="forgotPasswordForm"
			autocomplete='off'>
			<div class="text-center">
				<h3 class="page-header">
					<g:message code="spring.security.ui.forgotPassword.header" />
				</h3>
			</div>
			<div class="text-center">

				<h3 style="margin-bottom: 5%; margin-top: 5%;">
					<g:message code='spring.security.ui.forgotPassword.description' />
				</h3>
			</div>
			<div class="text-center">

				<blocks:field fieldName="username" type="text" data-toggle="tooltip"
					id="username" class="ignore-interacted"
					data-placement="bottom" name="username"
					labelCode="spring.security.ui.forgotPassword.username" />

			</div>
			<div class="text-center">
				<a id="reset" class="btn btn-primary"><g:message
						code="spring.security.ui.forgotPassword.submit" /></a> <input
					type='submit' value=' ' id='reset_submit' class='hidden_button' />
			</div>
		</g:form>
		<script>
			$(document).ready(function() {
				$('#username').focus();
				$("#reset").button();
				$('#reset').bind('click', function() {
					document.forms.forgotPasswordForm.submit();
				});
			});
		</script>
	</g:else>
</body>
</html>