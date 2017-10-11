<span class="handle">
    <i class="fa fa-ellipsis-v"></i>
    <i class="fa fa-ellipsis-v"></i>
</span>
<g:checkBox name="taskDone${task.id}" id="taskDone${task.id}" value="${task.done}"></g:checkBox>
%{--<input type="checkbox" value="">--}%
<span class="text">${task.title}</span>
<small class="label label-warning"><i class="fa fa-clock-o"></i> 1 day</small>
<div class="tools">
    <i class="fa fa-edit"></i>
    <i class="fa fa-trash-o"></i>
</div>