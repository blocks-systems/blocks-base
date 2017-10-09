<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="adminlte">
<g:set var="entityName"
	value="${message(code: 'role.label', default: 'Role')}" />
<title><g:message code="default.create.label"
		args="[entityName]" /></title>
</head>
<body>
	<div class="row">
		<div id="breadcrumb" class="col-md-12">
			<ol class="breadcrumb">
				<li><a class="home" href="${createLink(uri: '/')}"><g:message
							code="default.home.label" /></a></li>
				<li><g:link class="list" action="index">
						<g:message code="role.label" />
					</g:link></li>
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
						<g:message code="role.label" />
					</h4>
					<div id="create-role" class="content scaffold-create" role="main">
						<g:hasErrors bean="${role}">
							<blocks:beanErrors bean="${role}" />
						</g:hasErrors>
						<g:form class="form-horizontal" role="form"
							url="[resource:role, action:'save']" method="POST">

							<g:render template="form" />
							<fieldset class="buttons">
								<button type="submit" class="save btn btn-primary pull-right"
									name="create" id="create"
									value="${message(code: 'default.button.create.label', default: 'Create')}">
									<g:message code="default.button.create.label" default="Create" />
								</button>
							</fieldset>
						</g:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
