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
                        <g:render template="taskListElement" bean="${task}" var="task" />
                    </g:each>
                </ul>
                    <g:render contextPath="/templates" template="modalDelete"></g:render>
                </div>
                <div class="box-footer">

                    %{--<div class="pagination">
                        <g:paginate total="${taskListCount ?: 0}" />
                    </div>--}%
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
            var id = $(this).data('id');
            $.ajax({
                type: 'POST',
                url: "/wazon-app/task/done",
                data: {id: id},
                success: function() {
                    location.reload();
                }
            });
        },
        onUnCheck: function () {
            window.console.log($(this), 'The element has been unchecked');
            var id = $(this).data('id');
            $.ajax({
                type: 'POST',
                url: "/wazon-app/task/undone",
                data: {id: id},
                success: function() {
                    location.reload();
                }
            });
        }
    });
    $(".task-delete").on('click', function (event) {
        var id = $(this).data('id');
        $.ajax({
            type: 'DELETE',
            url: "/wazon-app/task/delete/" + id,
            success: function() {
                location.reload();
            }
        });
    });
</g:javascript>

</div>
</body>
</html>