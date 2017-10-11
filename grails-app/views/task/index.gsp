<%@ page import="blocks.Task"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="adminlte">
    <g:set var="entityName"
           value="${message(code: 'task', default: 'Event kind')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <g:javascript>
        $(function () {
            $('[data-toggle="tooltip"]').tooltip()
        })
    </g:javascript>
</head>
<body>
<div class="row">
    <div id="breadcrumb" class="col-md-12">
        <ol class="breadcrumb">
            <li><a class="home" href="${createLink(uri: '/')}"><g:message
                    code="default.home.label" /></a></li>
            <li><a href="#"><g:message code="default.taskslist.label" /></a></li>
        </ol>
    </div>
</div>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary">
                <div class="box-header">
                    <i class="fa fa-tasks"></i> <span><g:message
                        code="default.taskslist.label" /></span>

                    <div class="box-tools">
                        <blocks:ajaxCreateButton id="create_task" class="add create btn btn-primary btn-sm pull-right" controller="task" />
                    </div>
                </div>

                <g:if test="${flash.message}">
                    <bootstrap:alert class="alert-info">
                        ${flash.message}
                    </bootstrap:alert>
                </g:if>
                <g:if test="${flash.error}">
                    <bootstrap:alert class="alert-danger">
                        ${flash.error}
                    </bootstrap:alert>
                </g:if>
                <!-- /.box-header -->
                <div class="box-body table-responsive no-padding">
                <ul class="todo-list">
                    <g:each in="${taskList}" var="task">
                        <g:render template="taskListElement" bean="${task}" />
                    </g:each>
                    <li>
                        <!-- drag handle -->
                        <span class="handle">
                            <i class="fa fa-ellipsis-v"></i>
                            <i class="fa fa-ellipsis-v"></i>
                        </span>
                        <!-- checkbox -->
                        <input type="checkbox" value="">
                        <!-- todo text -->
                        <span class="text">Design a nice theme</span>
                        <!-- Emphasis label -->
                        <small class="label label-danger"><i class="fa fa-clock-o"></i> 2 mins</small>
                        <!-- General tools such as edit or delete-->
                        <div class="tools">
                            <i class="fa fa-edit"></i>
                            <i class="fa fa-trash-o"></i>
                        </div>
                    </li>
                    <li>
                        <span class="handle">
                            <i class="fa fa-ellipsis-v"></i>
                            <i class="fa fa-ellipsis-v"></i>
                        </span>
                        <input type="checkbox" value="">
                        <span class="text">Make the theme responsive</span>
                        <small class="label label-info"><i class="fa fa-clock-o"></i> 4 hours</small>
                        <div class="tools">
                            <i class="fa fa-edit"></i>
                            <i class="fa fa-trash-o"></i>
                        </div>
                    </li>
                    <li>
                        <span class="handle">
                            <i class="fa fa-ellipsis-v"></i>
                            <i class="fa fa-ellipsis-v"></i>
                        </span>
                        <input type="checkbox" value="">
                        <span class="text">Let theme shine like a star</span>
                        <small class="label label-warning"><i class="fa fa-clock-o"></i> 1 day</small>
                        <div class="tools">
                            <i class="fa fa-edit"></i>
                            <i class="fa fa-trash-o"></i>
                        </div>
                    </li>
                    <li>
                        <span class="handle">
                            <i class="fa fa-ellipsis-v"></i>
                            <i class="fa fa-ellipsis-v"></i>
                        </span>
                        <input type="checkbox" value="">
                        <span class="text">Let theme shine like a star</span>
                        <small class="label label-success"><i class="fa fa-clock-o"></i> 3 days</small>
                        <div class="tools">
                            <i class="fa fa-edit"></i>
                            <i class="fa fa-trash-o"></i>
                        </div>
                    </li>
                    <li>
                        <span class="handle">
                            <i class="fa fa-ellipsis-v"></i>
                            <i class="fa fa-ellipsis-v"></i>
                        </span>
                        <input type="checkbox" value="">
                        <span class="text">Check your messages and notifications</span>
                        <small class="label label-primary"><i class="fa fa-clock-o"></i> 1 week</small>
                        <div class="tools">
                            <i class="fa fa-edit"></i>
                            <i class="fa fa-trash-o"></i>
                        </div>
                    </li>
                    <li>
                        <span class="handle">
                            <i class="fa fa-ellipsis-v"></i>
                            <i class="fa fa-ellipsis-v"></i>
                        </span>
                        <input type="checkbox" value="">
                        <span class="text">Let theme shine like a star</span>
                        <small class="label label-default"><i class="fa fa-clock-o"></i> 1 month</small>
                        <div class="tools">
                            <i class="fa fa-edit"></i>
                            <i class="fa fa-trash-o"></i>
                        </div>
                    </li>
                </ul>
                    <g:render contextPath="/templates" template="modalDelete"></g:render>
                </div>
                <div class="box-footer">

                    <div class="pagination">
                        <g:paginate total="${taskListCount ?: 0}" />
                    </div>
                </div>
            </div>
            <!-- /.box -->
        </div>
    </div>
</section>
<g:javascript>
    $('.todo-list').todoList({
        onCheck  : function () {
            window.console.log($(this), 'The element has been checked');
        },
        onUnCheck: function () {
            window.console.log($(this), 'The element has been unchecked');
        }
    });
</g:javascript>

</div>
</body>
</html>