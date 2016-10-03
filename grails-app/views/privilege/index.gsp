

<%@ page import="blocks.auth.Permission" %>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="devoops">
<g:set var="entityName"
	value="${message(code: 'permission.label', default: 'Permission')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<div class="row">
		<div id="breadcrumb" class="col-md-12">
			<ol class="breadcrumb">
				<li><a class="home" href="${createLink(uri: '/')}"><g:message
							code="default.home.label" /></a></li>
				<li><a href="#"><g:message code="default.list.label"
							args="[entityName]" /></a></li>
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
									code="default.list.label" args="[entityName]" /></span>
						</div>
						<div class="box-icons"></div>
						<div class="no-move"></div>
					</div>
					<div class="box-content no-padding">
						<table
							class="table table-bordered table-striped table-hover table-heading table-datatable"
							id="datatable-1">
							<thead>
								<tr>
									<g:sortableColumn property="authority" title="${message(code: 'permission.authority.label', default: 'Authority')}" />
										
									<g:sortableColumn property="name" title="${message(code: 'permission.name.label', default: 'Name')}" />
								</tr>
							</thead>
							<tbody>
								<g:each in="${permissionList}" status="i"
									var="permissionInstance">
									<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
										
										<td>${fieldValue(bean: permissionInstance, field: "authority")}</td>
									
										<td>${fieldValue(bean: permissionInstance, field: "name")}</td>
									</tr>
								</g:each>
							</tbody>
							<tfoot>
								<tr>
										<g:sortableColumn property="authority" title="${message(code: 'permission.authority.label', default: 'Authority')}" />
											
										<g:sortableColumn property="name" title="${message(code: 'permission.name.label', default: 'Name')}" />
								</tr>
							</tfoot>
						</table>

						<div class="pagination">
							<g:paginate total="${permissionInstanceCount ?: 0}" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
