<html>

<head>
<title><g:message code='spring.security.ui.resetPassword.title' /></title>
<meta name='layout' content='auth' />
</head>

<body>

	<g:hasErrors bean="${command}">
		<div class='alert alert-block alert-danger'>
			<p class='col-lg-12'>
			<h4 style='font-weight: bold;'>
				<g:message code='bean.errors' />
			</h4>
			</p>
			<a class="close" data-dismiss="alert">&times;</a>
			<g:eachError bean="${command}">
				<p>
					<g:message error='${it}' />
				</p>
			</g:eachError>
		</div>
	</g:hasErrors>

	<h3 class="page-header text-center">
		<g:message code="spring.security.ui.resetPassword.header" />
	</h3>

	<g:form action='resetPassword' name='resetPasswordForm'
		autocomplete='off'>
		<g:hiddenField name='t' value='${token}' />
		<div class="sign-in">
			<div class="form-group col-xs-12 ${hasErrors(bean:command, field:'password', 'has-error')}">
				<div class="col-sm-4" style="padding-top: 5px">
					<label for="password" class="control-label"><g:message
							code='user.password.label' /></label>
				</div>
				<div class="col-sm-8">
					<g:field type="password" id="password" data-toggle="tooltip" class="ignore-interacted"
						class="form-control" value="${command?.password}" name="password"
						data-placement="bottom" />
				</div>

			</div>
			<div class="form-group col-xs-12 ${hasErrors(bean:command, field:'password2', 'has-error')}">
				<div class="col-sm-4" style="padding-top: 5px">
					<label for="password2" class="control-label"><g:message
							code='user.password2.label' /></label>
				</div>
				<div class="col-sm-8">
					<g:field type="password" id="password2" data-toggle="tooltip" class="ignore-interacted"
						class="form-control" value="${command?.password2}"
						name="password2" data-placement="bottom" />
				</div>
			</div>
			<div class="text-center">
				<a id="reset" class="btn btn-primary"><g:message
						code="spring.security.ui.resetPassword.submit" /></a> <input
					type='submit' value=' ' id='reset_submit' class='hidden_button' />
			</div>
		</div>
	</g:form>

	<script>
		$(document).ready(function() {
			$('#password').focus();
			$("#reset").button();
			$('#reset').bind('click', function() {
				document.forms.resetPasswordForm.submit();
			});
		});
	</script>
</body>
</html>