<%@ page import="blocks.auth.Role"%>

<div class="form-group">
	<blocks:field id="name" fieldName="name" type="text"
		data-toggle="tooltip"
		error="${hasErrors(bean:role, field:'name', 'has-error')}"
		data-placement="bottom" name="name" labelCode="name"
		value="${role?.name}" />

	<blocks:select hideShow="${true}"
		error="${hasErrors(bean:role, field:'roles', 'has-error')}"
		id="roles" name="roles" labelCode="role.roles.label"
		from="${blocks.auth.Permission.list()}" multiple="multiple"
		optionKey="id" size="5" optionValue="name"
		value="${role?.roles*.id}" class="selectable many-to-many" />

</div>
