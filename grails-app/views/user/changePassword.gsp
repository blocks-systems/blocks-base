<html>

<head>
<title><g:message code='spring.security.ui.changePassword.title' /></title>
<meta name='layout' content='adminlte' />
</head>

<body>
	<div class="row">
		<div class="col-xs-12 col-sm-12">
			<div class="box">
				<div class="box-header"></div>
				<div class="box-content">

					<h4 class="page-header">
						<g:message code="spring.security.ui.changePassword.title" />
					</h4>
					<g:if test="${flash.message}">
						<bootstrap:alert class="alert-info">
							${flash.message}
						</bootstrap:alert>
					</g:if>
					<g:hasErrors bean="${command}">
						<blocks:beanErrors bean="${command}" />
					</g:hasErrors>
					<g:form class="form-horizontal" role="form" action="changePassword"
						method="POST" autocomplete='off'>
						<sec:ifAnyGranted roles="ROLE_ADMIN">
							<g:hiddenField name='id' value='${id}' />
						</sec:ifAnyGranted>
						<div class="form-group">
							<blocks:field fieldName="password" type="password"
								data-toggle="tooltip" id="password"
								error="${hasErrors(bean:command, field:'password', 'has-error')}"
								data-placement="bottom" name="password"
								labelCode="user.password.label" value="${command?.password}" />

							<blocks:field fieldName="password2" type="password"
								data-toggle="tooltip" id="password2"
								error="${hasErrors(bean:command, field:'password2', 'has-error')}"
								data-placement="bottom" name="password2"
								labelCode="user.password2.label" value="${command?.password2}" />
						</div>

						<fieldset class="buttons">
								<g:link class="btn btn-danger btn-label-left" action="index">
									<span><i class="fa fa-times"></i></span>
									<g:message code="default.button.cancel.label" />
								</g:link>
							<button type="submit" class="btn btn-primary pull-right"
								value="${message(code: 'spring.security.ui.changePassword.submit', default: 'Change')}">
								<g:message code="spring.security.ui.changePassword.submit"
									default="Change" />
							</button>
						</fieldset>
					</g:form>
				</div>
			</div>
		</div>
	</div>

</body>
</html>