

<%@ page import="blocks.auth.Role"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="devoops">
<g:set var="entityName"
	value="${message(code: 'role.label', default: 'Role')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
	<div class="row">
		<div id="breadcrumb" class="col-md-12">
			<ol class="breadcrumb">
				<li><a class="home" href="${createLink(uri: '/')}"><g:message
							code="default.home.label" /></a></li>
				<li><a
					href="${createLink(controller : 'Role', action:'index')}"><g:message
							code="default.list.label" args="[entityName]" /></a></li>
				<li><a href="#"><g:message code="default.show.label"
							args="[entityName]" /></a></li>
			</ol>
		</div>
	</div>
	<div class="row">
		<div class="col-xs-12 col-sm-12">
			<div class="box">
				<div class="box-header">
					<div class="box-name">
						<i class="fa fa-user"></i> <span> <g:message
								code="default.show.label" args="[entityName]" />
						</span>
					</div>
					<div class="box-icons">
						<a class="collapse-link"> <i
							class="glyphicon glyphicon-chevron-up"></i>
						</a> <a class="expand-link"> <i
							class="glyphicon glyphicon-resize-full"></i>
						</a> <a class="close-link"> <i class="glyphicon glyphicon-remove"></i>
						</a>
					</div>
					<div class="no-move"></div>
				</div>
				<div class="box-content">
					<h4 class="page-header">
						<g:message code="default.show.label" args="[entityName]" />
					</h4>
					<g:if test="${flash.message}">
						<bootstrap:alert class="alert-info">
							${flash.message}
						</bootstrap:alert>
					</g:if>
					<div class="row">
						<div class="col-xs-6 col-sm-6">
							<dl class="dl-horizontal">

								<g:if test="${role?.name}">
									<dt>
										<g:message code="role.name.label" default="Name" />
									</dt>
									<dd>

										<span class="property-value" aria-labelledby="name-label"><g:fieldValue
												bean="${role}" field="name" /></span>

									</dd>
								</g:if>
							</dl>
						</div>
					</div>

					<g:if test="${role?.roles}">
						<div class="row">
							<div class="col-xs-6 col-sm-6">
								<dl class="dl-horizontal">
									<dt>
										<g:message code="role.roles.label" default="Permissions" />
									</dt>
								</dl>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-6 col-sm-6">
								<table
									class="table table-bordered table-striped table-hover table-heading table-datatable"
									id="datatable-1">
									<thead>
										<tr>
											<th><g:message code="permission.authority.label"
													default="Authority" /></th>
											<th><g:message code="permission.name.label"
													default="Name" /></th>
										</tr>
									</thead>
									<tbody>
										<g:each in="${role?.roles}" status="i"
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
								</table>
							</div>
						</div>
					</g:if>

					<g:form method="DELETE" controller="group" action="edit" id="${role.id}"
						class="form-horizontal" role="form">
						<fieldset class="buttons">
							<g:link class="btn btn-primary edit" action="edit"
								id="${role.id}">
								<g:message code="default.button.edit.label" default="Edit" />
							</g:link>
							<button type="submit" class="btn btn-danger"
								name="_action_delete"
								value="${message(code: 'default.button.delete.label', default: 'Delete')}"
								onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
								<g:message code="default.button.delete.label" default="Delete" />
							</button>
						</fieldset>
					</g:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
