<%@ page
	import="blocks.BlocksAuditLogEvent"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="devoops">
<g:set var="entityName" value="${message(code: 'auditLogEvent')}" />
<title><g:message code="auditLogsEvent" /></title>
</head>
<body>

	<div class="row">
		<div id="breadcrumb" class="col-md-12">
			<ol class="breadcrumb">
				<li><a class="home" href="${createLink(uri: '/')}"><g:message
							code="default.home.label" /></a></li>
				<li><a href="#"><g:message code="auditLogsEvent" /></a></li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div id="list-actIdUser" class="content scaffold-list" role="main">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-header">
						<div class="box-name">
							<i class="fa fa-map-marker"></i> <span><g:message
									code="auditLogsEvent" /></span>
						</div>
						<div class="box-icons">
							<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
							</a> <a class="expand-link"> <i class="fa fa-expand"></i>
							</a> <a class="close-link"> <i class="fa fa-times"></i>
							</a>
						</div>
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
									<g:sortableColumn property="id" title="${message(code: 'id')}" />

									<g:sortableColumn property="actor"
										title="${message(code: 'actor')}" />

									<g:sortableColumn property="className"
										title="${message(code: 'className')}" />

									<g:sortableColumn property="persistedObjectId"
										title="${message(code: 'persistedObjectId')}" />

									<g:sortableColumn property="persistedObjectVersion"
										title="${message(code: 'persistedObjectVersion')}" />
									<th />
								</tr>
							</thead>
							<tbody>
								<g:each in="${blocksAuditLogEventList}" status="i"
									var="auditLogEventInstance">
									<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

										<td><g:link action="show"
												id="${auditLogEventInstance.id}">
												${fieldValue(bean:auditLogEventInstance, field:'id')}
											</g:link></td>

										<td>
											${fieldValue(bean:auditLogEventInstance, field:'actor')}
										</td>

										<td>
											${fieldValue(bean:auditLogEventInstance, field:'className')}
										</td>

										<td>
											${fieldValue(bean:auditLogEventInstance, field:'persistedObjectId')}
										</td>

										<td>
											${fieldValue(bean:auditLogEventInstance, field:'persistedObjectVersion')}
										</td>

										<td class="text-right"><a
											href="${createLink(action:'show', id:auditLogEventInstance.id)}"
											class="btn btn-app-sms btn-success"> <span
												class="fa fa-eye"></span>
										</a></td>
									</tr>
								</g:each>
							</tbody>
							<tfoot>
								<tr>
									<g:sortableColumn property="id" title="${message(code: 'id')}" />

									<g:sortableColumn property="actor"
										title="${message(code: 'actor')}" />

									<g:sortableColumn property="className"
										title="${message(code: 'className')}" />

									<g:sortableColumn property="persistedObjectId"
										title="${message(code: 'persistedObjectId')}" />

									<g:sortableColumn property="persistedObjectVersion"
										title="${message(code: 'persistedObjectVersion')}" />
									<th />
								</tr>
							</tfoot>
						</table>

						<div class="pagination">
							<g:paginate total="${auditLogEventInstanceCount ?: 0}" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
