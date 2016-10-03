<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="devoops">
<g:set var="entityName"
	value="${message(code: 'substitution.label', default: 'Substitution')}" />
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
						<g:message code="default.list.label" args="[entityName]" />
					</g:link></li>
				<li><a href="#"><g:message code="default.new.label"
							args="[entityName]" /></a></li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div class="col-xs-12 col-sm-12">
			<div class="box">
				<div class="box-header">
					<div class="box-name">
						<i class="fa fa-random"></i> <span><g:message
								code="default.create.label" args="[entityName]" /></span>
					</div>
					<div class="box-icons">
						<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
						</a> <a class="expand-link"> <i class="fa fa-expand"></i>
						</a> <a class="close-link"> <i class="fa fa-times"></i>
						</a>
					</div>
					<div class="no-move"></div>
				</div>
				<div class="box-content">

					<h4 class="page-header">
						<g:message code="default.create.label" args="[entityName]" />
					</h4>
					<div id="create-substitution" class="content scaffold-create"
						role="main">
						<g:hasErrors bean="${substitution}">
							<blocks:beanErrors bean="${substitution}" />
						</g:hasErrors>
						<g:form class="form-horizontal" role="form"
							url="[resource:substitution, action:'save']"
							method="POST">

							<g:render template="form" />
							<fieldset class="buttons">
								<button type="submit"
									class="btn btn-primary btn-label-left pull-right" name="create"
									id="create"
									value="${message(code: 'default.button.create.label', default: 'Create')}">
									<span><i class="fa fa-check-square-o"></i></span>
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
