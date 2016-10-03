
<table
	class="table table-bordered table-striped table-hover table-heading table-datatable"
	id="datatable-1">
	<thead>
		<tr>
			<g:sortableColumn property="authority"
				title="${message(code: 'permission.authority.label', default: 'Authority')}" />

			<g:sortableColumn property="name"
				title="${message(code: 'permission.name.label', default: 'Name')}" />
		</tr>
	</thead>
	<tbody>
		<g:each in="${permissionList}" status="i"
			var="permissionInstance">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

				<td>
					${fieldValue(bean: permissionInstance, field: "authority")}
				</td>

				<td>
					${fieldValue(bean: permissionInstance, field: "name")}
				</td>
			</tr>
		</g:each>
	</tbody>
	<tfoot>
		<tr>
			<g:sortableColumn property="authority"
				title="${message(code: 'permission.authority.label', default: 'Authority')}" />

			<g:sortableColumn property="name"
				title="${message(code: 'permission.name.label', default: 'Name')}" />
		</tr>
	</tfoot>
</table>