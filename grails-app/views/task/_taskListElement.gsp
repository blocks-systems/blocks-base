<li class="${task.done ? 'done' : ''}">
    <span class="handle">
        <i class="fa fa-ellipsis-v"></i>
        <i class="fa fa-ellipsis-v"></i>
    </span>
    <g:checkBox class="task-done" name="taskDone${task?.id}" id="taskDone${task?.id}" value="${task?.done}" data-id="${task?.id}"></g:checkBox>
    %{--<input type="checkbox" value="">--}%
    <span class="text">${task?.title}</span>
    <small class="label label-${task?.remainingDays < 1 ? 'danger' : 'success'}"><i class="fa fa-clock-o"></i> ${task?.remainingSpan} dni</small>
    <div class="tools">
        <blocks:ajaxEditButton id="task-edit${task?.id}" class="btn btn-info btn-xs" iconClass="fa fa-edit"
                               controller="task" objectId="${task?.id}" />
        <button type="button" class="btn btn-xs btn-danger task-delete" data-id="${task?.id}">
            <span class="fa fa-trash-o"></span>
        </button>
    </div>
</li>