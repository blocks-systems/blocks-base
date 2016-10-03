
<%@ page import="blocks.auth.Role"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="devoops">
<g:set var="entityName"
	value="${message(code: 'role.label', default: 'Role')}" />
<title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
	<div class="row">
		<div id="breadcrumb" class="col-md-12">
			<ol class="breadcrumb">
				<li><a class="home" href="${createLink(uri: '/')}"><g:message
							code="default.home.label" /></a></li>
				<li><a
					href="${createLink(controller : 'Group', action:'index')}"><g:message
							code="role.label" /></a></li>
				<li><a href="#"><g:message code="role.label" /></a></li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div class="col-xs-12 col-sm-12">
			<div class="box">
				<div class="box-header">
					<div class="box-name">
						<i class="fa fa-user"></i> <span><g:message
								code="role.label" /></span>
					</div>
					%{--<div class="box-icons">
						<blocks:iconAuditedFields bean="${role}" />
					</div>--}%
					<div class="no-move"></div>
				</div>
				<div class="box-content">

					<h4 class="page-header">
						<g:message code="role.label" />
					</h4>
					<g:if test="${flash.message}">
						<bootstrap:alert class="alert-info">
							${flash.message}
						</bootstrap:alert>
					</g:if>
					<g:hasErrors bean="${role}">
						<blocks:beanErrors bean="${role}" />
					</g:hasErrors>
					<g:form class="form-horizontal" role="form"
						url="[resource:role, action:'update']" method="PUT">

						<g:render template="form" />
						<fieldset class="buttons">
							<button type="submit" class="btn btn-primary pull-right"
								name="_action_update"
								value="${message(code: 'default.button.update.label', default: 'Update')}">
								<g:message code="default.button.update.label" default="Update" />
							</button>
						</fieldset>
					</g:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
