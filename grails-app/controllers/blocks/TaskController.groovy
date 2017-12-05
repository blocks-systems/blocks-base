package blocks

import blocks.auth.User
import grails.converters.JSON
import grails.plugin.springsecurity.userdetails.GrailsUser
import org.apache.commons.logging.LogFactory
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.web.servlet.support.RequestContextUtils

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TaskController {

    def taskService

    private static final log = LogFactory.getLog(this)

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def taskList = taskService.getTasksforLoggedUser([:])
        log.debug(taskList)
        respond taskList, model:[taskCount: taskList.size()]
        //respond Task.list(params), model:[taskCount: Task.count()]
    }

    def show(Task task) {
        respond task
    }

    def create() {
        Task task = new Task(params)
        task.user = task.user ?: taskService.currentUser
        respond task
    }

    @Transactional
    def save(Task task) {
        if (task == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        task.user = task.user ?: taskService.currentUser

        if (task.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond task.errors, view:'create'
            return
        }

        task.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'task.label', default: 'Task'), task.id])
                redirect task
            }
            '*' { respond task, [status: CREATED] }
        }
    }

    def edit(Task task) {
        respond task
    }

    @Transactional
    def update(Task task) {
        if (task == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        task.user = task.user ?: taskService.currentUser

        if (task.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond task.errors, view:'edit'
            return
        }

        task.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'task.label', default: 'Task'), task.id])
                redirect task
            }
            '*'{ respond task, [status: OK] }
        }
    }

    @Transactional
    def delete(Task task) {

        if (task == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        task.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'task.label', default: 'Task'), task.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    def ajaxCreate() {
        Task task = new Task(params)
        task.user = task.user ?: taskService.currentUser
        render template: 'form',
                model: [task: task],
                contentType: 'text/plain'
    }

    def ajaxEdit(Task task) {
        if (task == null) {
            notFound()
            return
        }
        task.user = task.user ?: taskService.currentUser
        render template: 'form',
                model: [task:task],
                contentType: 'text/plain'
    }

    @Transactional
    def ajaxSave(Task task) {
        log.debug(task)
        if (task == null) {
            notFound()
            return
        }

        task.user = task.user ?: taskService.currentUser

        def ajaxResponse = [:]

        if (task.hasErrors()) {
            def errors = new ArrayList<String>();
            for (fieldErrors in task.errors) {
                for (error in fieldErrors.allErrors) {
                    //errors.add(messageSource.getMessage(error, RequestContextUtils.getLocale(request)))
                    errors.add(error.toString())
                }
            }
            ajaxResponse = ['success': false, 'errors': errors]
        } else {
            task.save flush:true
            flash.message = message(code: 'default.saved.message', args: [message(code: 'task', default: 'task'), task])
            ajaxResponse = [
                    'success': true,
                    'object': task,
                    'message': message(code: 'default.saved.message', args: [message(code: 'task', default: 'task'), task])
            ]

        }
        render ajaxResponse as JSON
    }

    @Transactional
    def ajaxUpdate() {

        log.debug(params)
        if (params.id == null) {
            notFound()
            return
        }

        Task task = Task.findById(params.id)
        //event.eventDate = new Date().parse("yyyy-MM-dd", params.eventdate)
        task.title = params.title
        task.description = params.description
        task.priority = params.prority
        task.done = params.done
        task.user = task.user ?: taskService.currentUser

        def ajaxResponse = [:]

        if (task.hasErrors()) {
            def errors = new ArrayList<String>();
            for (fieldErrors in task.errors) {
                for (error in fieldErrors.allErrors) {
                    errors.add(error.toString())
                    //errors.add(messageSource.getMessage(error, RequestContextUtils.getLocale(request)))
                }
            }
            ajaxResponse = ['success': false, 'errors': errors]
        } else {
            task.save flush:true
            flash.message = message(code: 'default.saved.message', args: [message(code: 'task', default: 'task'), task])
            ajaxResponse = [
                    'success': true,
                    'object': task,
                    'message': message(code: 'default.saved.message', args: [message(code: 'task', default: 'task'), task])
            ]

        }
        render ajaxResponse as JSON
    }

    @Transactional
    def done() {
        log.debug(params)
        if (params.id == null) {
            notFound()
            return
        }

        Task task = Task.findById(params.id)
        task.done = true

        task.save flush:true
        flash.message = message(code: 'default.saved.message', args: [message(code: 'task', default: 'task'), task])
        redirect action: "index", method: "GET"
    }

    @Transactional
    def undone() {
        log.debug(params)
        if (params.id == null) {
            notFound()
            return
        }

        Task task = Task.findById(params.id)
        task.done = false

        task.save flush:true
        flash.message = message(code: 'default.saved.message', args: [message(code: 'task', default: 'task'), task])
        redirect action: "index", method: "GET"
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
