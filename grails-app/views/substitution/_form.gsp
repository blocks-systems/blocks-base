<%@ page import="blocks.Substitution"%>

<div class="form-group">
	<blocks:datetimepicker beanName="substitution"
		error="${hasErrors(bean:substitution, field:'startDate', 'has-error')}"
		fieldName="startDate" id="startDate"
		value="${substitution?.startDate}" />

	<blocks:datetimepicker beanName="substitution"
		error="${hasErrors(bean:substitution, field:'finishDate', 'has-error')}"
		fieldName="finishDate" id="finishDate"
		value="${substitution?.finishDate}" />

</div>
<div class="form-group">

	<blocks:select id="actingPerson"
		error="${hasErrors(bean:substitution, field:'actingPerson', 'has-error')}"
		labelCode="substitution.actingPerson.label"
		from="${blocks.auth.User.list()}" optionKey="id"
		name="actingPerson.id"
		value="${substitution?.actingPerson?.id}"
		class="selectable many-to-one" />

	<blocks:select id="replacedPerson"
		error="${hasErrors(bean:substitution, field:'replacedPerson', 'has-error')}"
		code="substitution.replacedPerson.label"
		from="${blocks.auth.User.list()}" optionKey="id"
		name="replacedPerson.id"
		value="${substitution?.replacedPerson?.id}"
		class="selectable many-to-one" />

</div>
<div class="form-group">
	<blocks:field fieldName="accepted" type="checkbox" name="accepted"
		id="accepted"
		error="${hasErrors(bean:substitution, field:'accepted', 'has-error')}"
		labelCode="substitution.accepted.label"
		value="${testRosubstitutionotInstance?.accepted}" />
	<blocks:field fieldName="withBpmRoles" type="checkbox"
		name="withBpmRoles" id="withBpmRoles"
		error="${hasErrors(bean:substitution, field:'withBpmRoles', 'has-error')}"
		labelCode="substitution.withBpmRoles.label"
		value="${substitution?.withBpmRoles}" />

</div>