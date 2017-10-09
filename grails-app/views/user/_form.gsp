<%@ page import="blocks.auth.User"%>
<%@ page import="blocks.auth.Permission"%>
<%@ page import="blocks.auth.Role"%>

<div class="form-group col-lg-12">
	<blocks:field fieldName="username" type="text" data-toggle="tooltip" id="username"
		error="${hasErrors(bean:user, field:'username', 'has-error')}"
		data-placement="bottom" name="username" disabled="true"
		labelCode="user.username.label" value="${user?.username}" />

	<blocks:field fieldName="email" type="text" data-toggle="tooltip" id="email"
		error="${hasErrors(bean:user, field:'email', 'has-error')}"
		data-placement="bottom" name="email"
		labelCode="user.email.label" value="${user?.email}" />
</div>

<sec:ifAnyGranted roles="ROLE_ADMIN">
	<div class="form-group col-lg-12">
		<blocks:field fieldName="enabled" type="checkbox" name="enabled"
			id="enabled" error="${hasErrors(bean:user, field:'enabled', 'has-error')}"
			labelCode="user.enabled.label" value="${user?.enabled}" />
	</div>
</sec:ifAnyGranted>

<div class="form-group col-lg-12">
	<blocks:field fieldName="firstName" type="text" data-toggle="tooltip"
		error="${hasErrors(bean:user, field:'firstName', 'has-error')}"
		data-placement="bottom" name="firstName" id="firstName"
		labelCode="user.firstName.label" value="${user?.firstName}" />

	<blocks:field fieldName="lastName" type="text" data-toggle="tooltip"
		error="${hasErrors(bean:user, field:'lastName', 'has-error')}"
		data-placement="bottom" name="lastName" id="lastName"
		labelCode="user.lastName.label" value="${user?.lastName}" />
</div>
<sec:ifAnyGranted roles="ROLE_ADMIN">
	<div class="form-group col-lg-12">
		<blocks:select id="recipients" name="coach" labelCode="recipients" hideShow="${true}"
		create="recipients" from="${blocks.auth.User.list()}" multiple="multiple" optionKey="id"
		error="${hasErrors(bean:baseMessage, field:'recipients', 'has-error')}"
		value="${baseMessage?.recipients*.id}" class="selectable many-to-many"
		readOnly="${readOnly}" />

		<blocks:select id="roles" name="roles" multiple="multiple"
			hideShow="${true}"
			error="${hasErrors(bean:user, field:'roles', 'has-error')}"
			labelCode="permission.label" from="${Permission.list()}"
			optionKey="id" value="${user?.roles*.id}" optionValue="name"
			class="selectable many-to-many" />
	</div>
</sec:ifAnyGranted>