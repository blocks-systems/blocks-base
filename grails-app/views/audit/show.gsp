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
				<li><g:link class="list" action="index">
						<g:message code="default.list.label" args="[entityName]" />
					</g:link></li>
				<li>${entityName}</li>
			</ol>
		</div>
	</div>

	<div class="row">
		<div class="col-xs-12 col-sm-12">
			<div class="box">
				<div class="box-header">
					<div class="box-name">
						<i class="fa fa-map-marker"></i> <span>${entityName}</span>
					</div>
					<div class="no-move"></div>
				</div>
				<div class="box-content">
					<div id="create-address" class="content scaffold-create"
						role="main">
						<div class="form-group col-lg-12">
							<div class="col-sm-2 control-label">
								<label for="id"><g:message code="id" /></label>
							</div>
							<div class="col-sm-4">
								<span id="id">
									${fieldValue(bean:auditLogEventInstance, field:'id')}
								</span>
							</div>
							<div class="col-sm-2 control-label">
								<label for="actor"><g:message code="actor" /></label>
							</div>
							<div class="col-sm-4">
								<span id="actor">
									${fieldValue(bean:auditLogEventInstance, field:'actor')}
								</span>
							</div>
						</div>
						<div class="form-group col-lg-12">
							<div class="col-sm-2 control-label">
								<label for="uri"><g:message code="uri" /></label>
							</div>
							<div class="col-sm-4">
								<span id="uri">
									${fieldValue(bean:auditLogEventInstance, field:'uri')}
								</span>
							</div>
							<div class="col-sm-2 control-label">
								<label for="className"><g:message code="className" /></label>
							</div>
							<div class="col-sm-4">
								<span id="className">
									${fieldValue(bean:auditLogEventInstance, field:'className')}
								</span>
							</div>
						</div>
						<div class="form-group col-lg-12">
							<div class="col-sm-2 control-label">
								<label for="persistedObjectId"><g:message
										code="persistedObjectId" /></label>
							</div>
							<div class="col-sm-4">
								<span id="persistedObjectId">
									${fieldValue(bean:auditLogEventInstance, field:'persistedObjectId')}
								</span>
							</div>
							<div class="col-sm-2 control-label">
								<label for="persistedObjectVersion"><g:message
										code="persistedObjectVersion" /></label>
							</div>
							<div class="col-sm-4">
								<span id="persistedObjectVersion">
									${fieldValue(bean:auditLogEventInstance, field:'persistedObjectVersion')}
								</span>
							</div>
						</div>
						<div class="form-group col-lg-12">
							<div class="col-sm-2 control-label">
								<label for="eventName"><g:message code="eventName" /></label>
							</div>
							<div class="col-sm-4">
								<span id="eventName">
									${fieldValue(bean:auditLogEventInstance, field:'eventName')}
								</span>
							</div>
							<div class="col-sm-2 control-label">
								<label for="propertyName"><g:message code="propertyName" /></label>
							</div>
							<div class="col-sm-4">
								<span id="propertyName">
									${fieldValue(bean:auditLogEventInstance, field:'propertyName')}
								</span>
							</div>
						</div>
						<div class="form-group col-lg-12">
							<div class="col-sm-2 control-label">
								<label for="oldValue"><g:message code="oldValue" /></label>
							</div>
							<div class="col-sm-4">
								<span id="oldValue">
									${fieldValue(bean:auditLogEventInstance, field:'oldValue')}
								</span>
							</div>
							<div class="col-sm-2 control-label">
								<label for="newValue"><g:message code="newValue" /></label>
							</div>
							<div class="col-sm-4">
								<span id="newValue">
									${fieldValue(bean:auditLogEventInstance, field:'newValue')}
								</span>
							</div>
						</div>
						<div class="form-group col-lg-12">
							<div class="col-sm-2 control-label">
								<label for="dateCreated"><g:message code="dateCreated" /></label>
							</div>
							<div class="col-sm-4">
								<span id="dateCreated">
									<g:formatDate date="${auditLogEventInstance.dateCreated}" format="yyyy-MM-dd HH:mm:ss" />
								</span>
							</div>
							<div class="col-sm-2 control-label">
								<label for="lastUpdated"><g:message code="lastUpdated" /></label>
							</div>
							<div class="col-sm-4">
								<span id="lastUpdated">
									<g:formatDate date="${auditLogEventInstance.lastUpdated}" format="yyyy-MM-dd HH:mm:ss" />
								</span>
							</div>
						</div>
						<div class="form-group col-lg-12">
							<fieldset class="buttons">

								<g:link class="btn btn-danger btn-label-left pull-right"
									action="index">
									<span><i class="fa fa-times"></i></span>
									<g:message code="default.button.close.label" />
								</g:link>
							</fieldset>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>