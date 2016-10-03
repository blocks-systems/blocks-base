<%@ page import="blocks.auth.Permission"%>
<%@ page import="blocks.auth.Role"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>

<head>
<meta name='layout' content='devoops' />
<title><g:message code='spring.security.ui.register.title' /></title>
</head>

<body>
	<div id="create-user" class="content scaffold-create" role="main">
		<h3 class='page-header text-center'
			style="padding-top: 1%; padding-bottom: 1%;">
			<g:message code="spring.security.ui.register.description" />
		</h3>

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
		</g:if>

		<g:else>
			<g:form action='register' name='registerForm' class='form-horizontal' method="POST">
				<g:hasErrors bean="${command}">
					<blocks:beanErrors bean="${command}" />
				</g:hasErrors>

				<div class="form-group col-lg-12">
					<blocks:field fieldName="username" type="text"
						data-toggle="tooltip"
						error="${hasErrors(bean:command, field: 'username', 'has-error')}"
						data-placement="bottom" name="username" id="username"
						labelCode="user.username.label" value="${command?.username}" />

					<blocks:field fieldName="email" type="text" data-toggle="tooltip"
						error="${hasErrors(bean:command, field:'email', 'has-error')}"
						data-placement="bottom" name="email" labelCode="user.email.label"
						value="${command?.email}" />
				</div>

				<div class="form-group col-lg-12">
					<blocks:field fieldName="password" type="password"
						data-toggle="tooltip" id="password"
						error="${hasErrors(bean: command, field: 'password', 'has-error')}"
						data-placement="bottom" name="password"
						labelCode="user.password.label" value="${command?.password}" />

					<blocks:field fieldName="password2" type="password"
						data-toggle="tooltip" id="password2"
						error="${hasErrors(bean:command, field:'password2', 'has-error')}"
						data-placement="bottom" name="password2"
						labelCode="user.password2.label" value="${command?.password2}" />
				</div>
				<div class="form-group col-lg-12">
					<blocks:field fieldName="firstName" type="text" data-toggle="tooltip"
						error="${hasErrors(bean:command, field:'firstName', 'has-error')}"
						data-placement="bottom" name="firstName" id="firstName"
						labelCode="user.firstName.label" value="${command?.firstName}" />
				
					<blocks:field fieldName="lastName" type="text" data-toggle="tooltip"
						error="${hasErrors(bean:command, field:'lastName', 'has-error')}"
						data-placement="bottom" name="lastName" id="lastName"
						labelCode="user.lastName.label" value="${command?.lastName}" />
				</div>
				<div class="form-group col-lg-12">
					<blocks:select id="groups" name="groups" multiple="multiple"
						id="groups" hideShow="${true}"
						error="${hasErrors(bean:command, field:'groups', 'has-error')}"
						labelCode="role.label" from="${Role.list()}" optionKey="id"
						value="${command.groups*.id}" optionValue="name"
						class="selectable many-to-many" />

					<blocks:select id="roles" name="roles" multiple="multiple"
						id="roles" hideShow="${true}"
						error="${hasErrors(bean:command, field:'roles', 'has-error')}"
						labelCode="permission.label" from="${Permission.list()}"
						optionKey="id" value="${command.roles*.id}" optionValue="name"
						class="selectable many-to-many" />
				</div>
				<div class="text-center" style="clear: both; padding-top: 2%;">
					<fieldset class="buttons">
							<g:link class="btn btn-danger cancel pull-left" controller="user"
								action="index">
								<g:message code="default.button.cancel.label" default="Cancel" />
							</g:link>
						<g:submitButton name="create" class="btn btn-primary pull-right"
							value="${message(code: 'spring.security.ui.register.submit', default: 'Create')}" />
					</fieldset>
				</div>
			</g:form>

		</g:else>

		<script>
			$(document).ready(function() {
				$('#username').focus();
			});
		</script>
	</div>
</body>
</html>