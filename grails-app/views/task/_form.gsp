<div class="form-group col-lg-12">
    <blocks:datepicker id="dueDate" beanName="taks" fieldName="dueDate" required="${true}"
                       error="${hasErrors(bean:task, field:'dueDate', 'has-error')}" labelCode="dueDate"
                       value="${task?.dueDate}" />
    <blocks:field id="title" type="text" class="form-control" data-toggle="tooltip"
                  data-placement="bottom" maxlength="128" name="title" required="${true}"
                  value="${task?.title}" readOnly="${readOnly}"
                  error="${hasErrors(bean:task, field:'title', 'has-error')}" labelCode="task.title" />
</div>

<div class="form-group col-lg-12">
    <blocks:field id="description" type="textarea" class="form-control" data-toggle="tooltip"
                  data-placement="bottom" maxlength="2000" name="description" required="${false}"
                  value="${task?.description}" readOnly="${readOnly}" extended="${true}"
                  error="${hasErrors(bean:task, field:'description', 'has-error')}" labelCode="description" />
</div>

<div class="form-group col-lg-12">
    <blocks:field fieldName="done" type="checkbox" name="done"  id="done"
                  error="${hasErrors(bean:task, field:'done', 'has-error')}" labelCode="done"
                  value="${task?.done}" />
    <blocks:select2 id="user"  error="${hasErrors(bean:task, field:'user', 'has-error')}"
                    labelCode="user" from="${blocks.auth.User.list()}" optionKey="id"
                    name="user.id" value="${task?.user?.id}"
                    class="selectable many-to-one" required="${true}" />
</div>