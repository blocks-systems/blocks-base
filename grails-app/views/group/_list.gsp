
<table
	class="table table-bordered table-striped table-hover table-heading table-datatable"
	id="datatable-1">
	<thead>
		<tr>
			<g:sortableColumn property="name"
				title="${message(code: 'role.name.label', default: 'Name')}" />
		</tr>
	</thead>
	<tbody>
		<g:each in="${roleList}" status="i" var="roleInstance">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
				<td><g:link action="show" id="${roleInstance.id}" controller="group">
						${fieldValue(bean: roleInstance, field: "name")}
					</g:link></td>
			</tr>
		</g:each>
	</tbody>
	<tfoot>
		<tr>
			<g:sortableColumn property="name"
				title="${message(code: 'role.name.label', default: 'Name')}" />
		</tr>
	</tfoot>
</table>