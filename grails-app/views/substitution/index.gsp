<%@ page import="blocks.Substitution"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta name="layout" content="adminlte">
<g:set var="entityName"
	value="${message(code: 'substitution.label', default: 'Substitution')}" />
<title><g:message code="substitution.list" Default="Substitutions list" /></title>
</head>
<body>
  <div class="row">
		<div id="breadcrumb" class="col-md-12">
			<ol class="breadcrumb">
				<li><a class="home" href="${createLink(uri: '/')}"><g:message
							code="default.home.label" /></a></li>
			</ol>
		</div>
	</div>
  
  <div class="row">
		<div id="list-substitution" class="content scaffold-list" role="main">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-header">
						<div class="box-name">
							<i class="fa fa-random"></i> <span><g:message
									code="substitution.list" default="Substitutions list" /></span>
						</div>
						<div class="box-icons"></div>
						<div class="no-move"></div>
					</div>
					<div class="box-content no-padding">
						<g:if test="${flash.message}">
							<bootstrap:alert class="alert-info">
								${flash.message}
							</bootstrap:alert>
						</g:if>
						<table
							class="table table-bordered table-striped table-hover table-heading table-datatable"
							id="datatable-1">
							<thead>
								<tr>

									<g:sortableColumn property="startDate"
										title="${message(code: 'substitution.startDate', default: 'Start date')}" />

									<g:sortableColumn property="finishDate"
										title="${message(code: 'substitution.finishDate', default: 'Finish date')}" />

									<g:sortableColumn property="actingPerson"
										title="${message(code: 'substitution.actingPerson', default: 'Acting person')}" />

									<g:sortableColumn property="replacedPerson"
										title="${message(code: 'substitution.replacedPerson', default: 'Replaced person')}" />

									<g:sortableColumn property="accepted"
										title="${message(code: 'substitution.accepted', default: 'Acceptance')}" />

									<g:sortableColumn property="withBpmRoles"
										title="${message(code: 'substitution.withBpmRoles', default: 'BPM roles delgation')}" />

									<th><g:link class="create btn btn-primary pull-right"
											action="create">
											<span class="fa fa-plus"></span>
										</g:link></th>
								</tr>
							</thead>
							<tbody>
								<g:each in="${substitutionList}" status="i" var="substitutionInstance">
									<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

										<td><g:link action="show" id="${substitutionInstance.id}">
												${fieldValue(bean: substitutionInstance, field: "startDate")}
											</g:link></td>
										
										<td>
											${fieldValue(bean: substitutionInstance, field: "finishDate")}
										</td>
										
										<td>
											${fieldValue(bean: substitutionInstance, field: "actingPerson")}
										</td>

										<td>
											${fieldValue(bean: substitutionInstance, field: "replacedPerson")}
										</td>

										<td>
											${fieldValue(bean: substitutionInstance, field: "accepted")}
										</td>

										<td>
											${fieldValue(bean: substitutionInstance, field: "withBpmRoles")}
										</td>

										<td class="text-right"><a
											href="${createLink(action:'show', id:substitutionInstance.id)}"
											class="btn btn-app-sms btn-success"> <span
												class="fa fa-eye"></span>
										</a> <a class='btn btn-app-sms btn-info'
											href="${createLink(action:'edit', id:substitutionInstance.id)}"><span
												class="fa fa-edit"></span></a></td>
									</tr>
								</g:each>
							</tbody>
							<tfoot>
								<tr>

									<g:sortableColumn property="startDate"
										title="${message(code: 'substitution.startDate', default: 'Start Date')}" />

									<g:sortableColumn property="finishDate"
										title="${message(code: 'substitution.finishDate', default: 'Finish Date')}" />

									<g:sortableColumn property="actingPerson"
										title="${message(code: 'substitution.actingPerson', default: 'Acting person')}" />

									<g:sortableColumn property="replacedPerson"
										title="${message(code: 'substitution.replacedPerson', default: 'Replaced person')}" />

									<g:sortableColumn property="accepted"
										title="${message(code: 'substitution.accepted', default: 'Acceptance')}" />

									<g:sortableColumn property="withBpmRoles"
										title="${message(code: 'substitution.withBpmRoles', default: 'BPM roles delegation')}" />

									<th />
								</tr>
							</tfoot>
						</table>

						<div class="pagination">
							<g:paginate total="${substitutionInstanceCount ?: 0}" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>