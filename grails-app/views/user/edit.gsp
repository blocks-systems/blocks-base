<%@ page import="blocks.auth.User"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="adminlte">
<g:set var="entityName"
	value="${message(code: 'user')}" />
<title><g:message code="default.user.label" /></title>
</head>
<body>
	<div class="row">
		<div id="breadcrumb" class="col-md-12">
			<ol class="breadcrumb">
				<li><a class="home" href="${createLink(uri: '/')}"><g:message
							code="default.home.label" /></a></li>
				<li><a
					href="${createLink(controller : 'User', action:'index')}"><g:message
							code="default.users.label" /></a></li>
				<li><a href="#"><g:message code="default.user.label" /></a></li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div class="col-xs-12 col-sm-12">
			<div class="box">
				<div class="box-header">
					<div class="box-name">
						<i class="fa fa-user"></i> <span><g:message
								code="default.user.label" /></span>
					</div>
					%{--<div class="box-icons">
						<blocks:iconAuditedFields bean="${user}" />
					</div>--}%
					<div class="no-move"></div>
				</div>
				<div class="box-content">

					<h4 class="page-header">
						<g:message code="default.user.label" />
					</h4>
					<g:if test="${flash.message}">
						<bootstrap:alert class="alert-info">
							${flash.message}
						</bootstrap:alert>
					</g:if>
					<g:hasErrors bean="${user}">
						<blocks:beanErrors bean="${user}" />
					</g:hasErrors>
					<g:form class="form-horizontal" role="form" action="update" method="POST">
						<sec:ifAnyGranted roles="ROLE_ADMIN">
							<g:hiddenField name='id' value='${id}' />
						</sec:ifAnyGranted>
						<g:render template="/user/form" />
						<div class="form-group col-lg-12">
							<fieldset class="buttons">
									<g:link class="btn btn-danger btn-label-left" action="index">
										<span><i class="fa fa-times"></i></span>
										<g:message code="default.button.cancel.label" />
									</g:link>
								<button type="submit" class="btn btn-primary pull-right"
									name="_action_update"
									value="${message(code: 'default.button.update.label', default: 'Update')}">
									<g:message code="default.button.update.label" default="Update" />
								</button>
							</fieldset>
						</div>
					</g:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>