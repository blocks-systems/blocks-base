

<%@ page import="blocks.auth.Role" %>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="devoops">
<g:set var="entityName"
	value="${message(code: 'role.label', default: 'Role')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<div class="row">
		<div id="breadcrumb" class="col-md-12">
			<ol class="breadcrumb">
				<li><a class="home" href="${createLink(uri: '/')}"><g:message
							code="default.home.label" /></a></li>
				<li><a href="#"><g:message code="role.label" /></a></li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div id="list-actIdUser" class="content scaffold-list" role="main">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-header">
						<div class="box-name">
							<i class="fa fa-users"></i> <span><g:message
									code="role.label" /></span>
						</div>
						<div class="box-icons"></div>
						<div class="no-move"></div>
					</div>
					<div class="box-content no-padding">
						<g:if test="${flash.message}">
							<bootstrap:alert class="alert-info">
								${flash.message}
							</bootstrap:alert>
						</g:if>
						<table
							class="table table-bordered table-striped table-hover table-heading table-datatable"
							id="datatable-1">
							<thead>
								<tr>
									
									<g:sortableColumn property="name" title="${message(code: 'role.name.label', default: 'Name')}" />
										
									<th><g:link class="create btn btn-primary pull-right"
											action="create">
											<span class="glyphicon glyphicon-plus"></span>
										</g:link></th>
								</tr>
							</thead>
							<tbody>
								<g:each in="${roleList}" status="i"
									var="roleInstance">
									<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
										
										<td><g:link action="show" id="${roleInstance.id}">${fieldValue(bean: roleInstance, field: "name")}</g:link></td>
									
										<td class="text-right"><a
											href="${createLink(action:'show', id:roleInstance.id)}"
											class="btn btn-app-sms btn-success"> <span
												class="glyphicon glyphicon-eye-open"></span>
										</a> <a class='btn btn-app-sms btn-info'
											href="${createLink(action:'edit', id:roleInstance.id)}"><span
												class="glyphicon glyphicon-edit"></span></a></td>
									</tr>
								</g:each>
							</tbody>
							<tfoot>
								<tr>
									
										<g:sortableColumn property="name" title="${message(code: 'role.name.label', default: 'Name')}" />
											
								
									<th />
								</tr>
							</tfoot>
						</table>

						<div class="pagination">
							<g:paginate total="${roleInstanceCount ?: 0}" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
