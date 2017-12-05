<%@ page import="blocks.auth.User"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="adminlte">
<g:set var="entityName"
	value="${message(code: 'user.label', default: 'User')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
<g:javascript>
$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
</g:javascript>
</head>
<body>
	<div class="row">
		<div id="breadcrumb" class="col-md-12">
			<ol class="breadcrumb">
				<li><a class="home" href="${createLink(uri: '/')}"><g:message
							code="default.home.label" /></a></li>
				<li><a href="#"><g:message code="default.users.label" /></a></li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div id="list-actIdUser" class="content scaffold-list" role="main">
			<div class="col-xs-12">
				<div class="box box-primary">
					<div class="box-header">
						<i class="fa fa-users"></i> <span><g:message
							code="default.users.label" /></span>
					</div>
					<g:if test="${flash.message}">
						<bootstrap:alert class="alert-info">
							${flash.message}
						</bootstrap:alert>
					</g:if>
					<g:if test="${flash.error}">
						<bootstrap:alert class="alert-danger">
							${flash.error}
						</bootstrap:alert>
					</g:if>
					<div class="box-body table-responsive no-padding">

						<table class="table table-hover" id="datatable-1">
							<thead>
								<tr>

									<g:sortableColumn property="id"
										title="${message(code: 'user.id.label')}" />

									<g:sortableColumn property="username"
										title="${message(code: 'user.username.label')}" />

									<g:sortableColumn property="firstName"
										title="${message(code: 'user.firstName.label')}" />

									<g:sortableColumn property="lastName"
										title="${message(code: 'user.lastName.label')}" />

									<th><g:message code="user.enabled.label" /></th>

									<th><g:message code="user.locked.label" /></th>

									<th style="width:15%;"><g:link class="create btn btn-primary pull-right" controller="register"
											action="index">
											<span class="fa fa-plus"></span>
										</g:link></th>
								</tr>
							</thead>
							<tbody>
								<g:each in="${userList}" status="i" var="userInstance">
									<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

										<td>
											${fieldValue(bean: userInstance, field: "id")}
										</td>

										<td><g:link action="show" id="${userInstance.id}">
												${fieldValue(bean: userInstance, field: "username")}
											</g:link></td>

										<td>
											${fieldValue(bean: userInstance, field: "firstName")}
										</td>

										<td>
											${fieldValue(bean: userInstance, field: "lastName")}
										</td>

										<td>
											<g:formatBoolean boolean="${userInstance.enabled}" />
										</td>

										<td>
											<g:formatBoolean boolean="${!userInstance.accountNonLocked}" />
										</td>

										<td class="text-right">
										<a href="${createLink(action:'show', id:userInstance.id)}" class="btn btn-app-sms btn-success" data-toggle="tooltip" data-placement="top" title="${message(code: 'action.show.label')}">
											<span class="fa fa-eye"></span>
										</a>
										<a href="${createLink(action:'edit', id:userInstance.id)}" class='btn btn-app-sms btn-info' data-toggle="tooltip" data-placement="top" title="${message(code: 'action.edit.label')}">
											<span class="fa fa-edit"></span></a>
										<a href="${createLink(action:'changePassword', id:userInstance.id)}" class='btn btn-app-sms btn-info' data-toggle="tooltip" data-placement="top" title="${message(code: 'action.changePassword.label')}">
											<span class="fa fa-cog"></span></a>											
										<a href="${createLink(action:'unlock', id:userInstance.id)}" class="btn btn-app-sms btn-info" data-toggle="tooltip" data-placement="top" title="${message(code: 'action.unlock.label')}">
											<span class="fa fa-unlock"></span>
										</a>
										<blocks:deleteLink id="${userInstance.id}" controller="user" />
										</td>
									</tr>
								</g:each>
							</tbody>
						</table>


					</div>
					<div class="box-footer">
						<div class="pagination">
							<g:paginate total="${userCount ?: 0}" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>