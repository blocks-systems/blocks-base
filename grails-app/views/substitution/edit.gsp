
<%@ page import="blocks.Substitution"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="devoops">
<g:set var="entityName"
	value="${message(code: 'substitution.label', default: 'Substitution')}" />
<title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
	<div class="row">
		<div id="breadcrumb" class="col-md-12">
			<ol class="breadcrumb">
				<li><a class="home" href="${createLink(uri: '/')}"><g:message
							code="default.home.label" /></a></li>
				<li><a
					href="${createLink(controller : 'Substitution', action:'index')}"><g:message
							code="default.list.label" args="[entityName]" /></a></li>
				<li><a href="#"><g:message code="default.edit.label"
							args="[entityName]" /></a></li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div class="col-xs-12 col-sm-12">
			<div class="box">
				<div class="box-header">
					<div class="box-name">
						<i class="fa fa-user"></i> <span><g:message
								code="default.edit.label" args="[entityName]" /></span>
					</div>
					%{--<div class="box-icons">
						<blocks:iconAuditedFields bean="${substitution}" />
					</div>--}%
					<div class="no-move"></div>
				</div>
				<div class="box-content">

					<h4 class="page-header">
						<g:message code="default.edit.label" args="[entityName]" />
					</h4>
					<g:if test="${flash.message}">
						<bootstrap:alert class="alert-info">
							${
								flash.message
							}
						</bootstrap:alert>
					</g:if>
					<g:hasErrors bean="${substitution}">
						<blocks:beanErrors bean="${substitution}" />
					</g:hasErrors>
					<g:form class="form-horizontal" role="form"
						url="[resource:substitution, action:'update']"
						method="PUT">

						<g:render template="form" />
						<fieldset class="buttons">
							<button type="submit"
								class="btn btn-primary btn-label-left pull-right"
								name="_action_update"
								value="${message(code: 'default.button.update.label', default: 'Update')}">
								<span><i class="fa fa-check"></i></span>
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
