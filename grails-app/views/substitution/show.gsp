

<%@ page import="blocks.Substitution" %>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="adminlte">
<g:set var="entityName"
	value="${message(code: 'substitution.label', default: 'Substitution')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
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
						<a class="collapse-link"> <i class="glyphicon glyphicon-chevron-up"></i>
						</a> <a class="expand-link"> <i class="glyphicon glyphicon-resize-full"></i>
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
								
								<g:if test="${substitution?.finishDate}">
									<dt>
										<g:message code="substitution.finishDate.label" default="Finish Date" />
									</dt>
									<dd>
										
											<span class="property-value" aria-labelledby="finishDate-label"><g:formatDate date="${substitution?.finishDate}" /></span>
										
									</dd>
								</g:if>
								
							
							
								<g:if test="${substitution?.actingPerson}">
									<dt>
										<g:message code="substitution.actingPerson.label" default="Acting Person" />
									</dt>
									<dd>
										
											<span class="property-value" aria-labelledby="actingPerson-label"><g:link controller="user" action="show" id="${substitution?.actingPerson?.id}">${substitution?.actingPerson?.encodeAsHTML()}</g:link></span>
										
									</dd>
								</g:if>
								
							
							
								<g:if test="${substitution?.startDate}">
									<dt>
										<g:message code="substitution.startDate.label" default="Start Date" />
									</dt>
									<dd>
										
											<span class="property-value" aria-labelledby="startDate-label"><g:formatDate date="${substitution?.startDate}" /></span>
										
									</dd>
								</g:if>
								
							
							
							</dl>
						</div>
						<div class="col-xs-6 col-sm-6">
							<dl class="dl-horizontal">
								
								
								<g:if test="${substitution?.accepted}">
								
									<dt>
										<g:message code="substitution.accepted.label" default="Accepted" />
									</dt>
									<dd>
										
											<span class="property-value" aria-labelledby="accepted-label"><g:formatBoolean boolean="${substitution?.accepted}" /></span>
										
									</dd>
									</g:if>
								
								
								
								<g:if test="${substitution?.replacedPerson}">
								
									<dt>
										<g:message code="substitution.replacedPerson.label" default="Replaced Person" />
									</dt>
									<dd>
										
											<span class="property-value" aria-labelledby="replacedPerson-label"><g:link controller="user" action="show" id="${substitution?.replacedPerson?.id}">${substitution?.replacedPerson?.encodeAsHTML()}</g:link></span>
										
									</dd>
									</g:if>
								
								
								
								<g:if test="${substitution?.withBpmRoles}">
								
									<dt>
										<g:message code="substitution.withBpmRoles.label" default="With Bpm Roles" />
									</dt>
									<dd>
										
											<span class="property-value" aria-labelledby="withBpmRoles-label"><g:formatBoolean boolean="${substitution?.withBpmRoles}" /></span>
										
									</dd>
									</g:if>
								
								
							</dl>
						</div>
					</div>

					<g:form  class="form-horizontal" role="form" url="[resource:substitution, action:'delete']" method="DELETE">
						<fieldset class="buttons">
						
							<button type="submit"
								class="btn btn-danger btn-label-left"
								name="_action_delete"
								value="${message(code: 'action.delete.label', default: 'Delete')}"
								onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
								<span><i class="fa fa-trash"></i></span>
								<g:message code="action.delete.label" default="Delete" />
							</button>
							
							<g:link class="edit btn btn-primary btn-label-left  pull-right" action="edit" resource="${substitution}">
								<span><i class="fa fa-check"></i></span>
								<g:message code="default.button.edit.label" default="Edit" />
							</g:link>
							
						</fieldset>
					</g:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
