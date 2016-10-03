<%@ page import="blocks.auth.User"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="devoops">
<g:set var="entityName"
	value="${message(code: 'user.label', default: 'User')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
	<div class="row">
		<div id="breadcrumb" class="col-md-12">
			<ol class="breadcrumb">
				<li><a class="home" href="${createLink(uri: '/')}"><g:message
							code="default.home.label" /></a></li>
				<li><a href="${createLink(action:'index')}"><g:message
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
						<i class="fa fa-user"></i> <span> <g:message
								code="default.user.label" />
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
					<g:if test="${flash.message}">
						<h4 class="page-header">
							<bootstrap:alert class="alert-info">
								${flash.message}
							</bootstrap:alert>
						</h4>
					</g:if>
					<div class="row">
						<div class="col-xs-6 col-sm-6">
							<dl class="dl-horizontal">
								<dt>
									<g:message code="user.username.label" default="Username" />
								</dt>
								<dd>
									<span class="property-value" aria-labelledby="username-label"><g:fieldValue
											bean="${user}" field="username" /></span>
								</dd>
								<sec:ifAnyGranted roles="ROLE_ADMIN">
									<dt>
										<g:message code="user.enabled.label" default="Enabled" />
									</dt>
									<dd>
										<span class="property-value" aria-labelledby="enabled-label"><g:formatBoolean
												boolean="${user?.enabled}" /> </span>
									</dd>
								</sec:ifAnyGranted>
								<dt>
									<g:message code="user.firstName.label" default="First Name" />
								</dt>
								<dd>
									<span class="property-value" aria-labelledby="firstName-label"><g:fieldValue
											bean="${user}" field="firstName" /></span>
								</dd>

							</dl>
						</div>

						<div class="col-xs-6 col-sm-6">
							<dl class="dl-horizontal">
								<dt>
									<g:message code="user.email.label" default="Email" />
								</dt>
								<dd>
									<span class="property-value" aria-labelledby="email-label"><g:fieldValue
											bean="${user}" field="email" /></span>
								</dd>

								<dt>
									<g:message code="user.lastName.label" default="Last Name" />
								</dt>
								<dd>
									<span class="property-value" aria-labelledby="lastName-label"><g:fieldValue
											bean="${user}" field="lastName" /></span>
								</dd>

							</dl>
						</div>
					</div>
					<sec:ifAnyGranted roles="ROLE_ADMIN">
						<h4 class="page-header">
							<g:message code="privileges" default="Privileges" />
						</h4>
						<ul class="nav nav-tabs" role="tablist">
							<li class="active"><a href="#groups" data-toggle="tab"><g:message
										code="role.label" default="Groups" /></a></li>
							<li><a href="#roles" data-toggle="tab"><g:message
										code="role.roles.label" default="Authorities" /></a></li>
						</ul>
						<div id="myTabContent" class="tab-content">
							<div class="tab-pane active in" id="groups">
								<form id="groups-tab">
									<g:render template="/group/list" bean="${user?.groups}"
										var="roleInstanceList" />
								</form>
							</div>
							<div class="tab-pane fade" id="roles">
								<form id="roles-tab">
									<g:render template="/privilege/list"
										bean="${user?.roles}" var="permissionInstanceList" />
								</form>
							</div>
						</div>
					</sec:ifAnyGranted>

					<g:form url="[resource:user, action:'edit']" method="GET"
						class="form-horizontal" role="form">
						<fieldset class="buttons">

							<g:if test="${controllerName == 'profile'}">
								<a href="${createLink(action:'edit')}" class='btn btn-primary'>
									<span><g:message code="default.button.edit.label"
											default="Edit" /></span>
								</a>
								<a href="${createLink(action:'changePassword')}" class='btn btn-primary'>
									<span><g:message code="user.changePassword"
											default="Change Password" /></span>
								</a>								
							</g:if>
							<g:else>
								<a href="${createLink(action:'edit', id:user.id)}"
									class='btn btn-primary'> <span><g:message
											code="default.button.edit.label" default="Edit" /></span></a>
								<a href="${createLink(action:'changePassword', id:user.id)}"
									class='btn btn-primary'> <span><g:message code="user.changePassword"
											default="Change Password" /></span></a>
							</g:else>
						</fieldset>
					</g:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>