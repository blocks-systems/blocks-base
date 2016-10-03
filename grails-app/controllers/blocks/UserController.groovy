package blocks

import blocks.auth.User
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
@Secured('ROLE_SUPER_USER')
class UserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond User.list(params), model:[userInstanceCount: User.count()]
    }

    def show(User userInstance) {
        respond userInstance
    }

    def create() {
        respond new User(params)
    }

    @Transactional
    def save(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'create'
            return
        }

        userInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance])
                redirect userInstance
            }
            '*' { respond userInstance, [status: CREATED] }
        }
    }

    def edit(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }
        final RegisterCommand command = new RegisterCommand();
        command.mapFromEntity(userInstance)

        render view: '/user/edit', model: [id: params.id, userInstance: command]
    }

    @Transactional
    def update(RegisterCommand command) {
        if (!params.id) {
            flash.error = message(code: 'error.badRequest')
            redirect action:"index", method:"GET"
        }

        final User user = User.findById(params.id)
        if (user == null) {
            notFound()
            return
        }

        command.mapToEntity(user)

        user.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'User.label', default: 'User'), user])
                redirect user
            }
            '*'{ respond user, [status: OK] }
        }
    }

    @Transactional
    def delete(User userInstance) {
        User.withTransaction { status ->
            try {
                userInstance.delete()
                render message(code: 'default.records.deleted',  args: [message(code: 'users')])
            } catch (Exception ex) {
                status.setRollbackOnly();
                log.error(ex.getMessage());
                render message(code: 'error.generic')
            }
        }
    }

    @Transactional
    def unlock(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        userInstance.lastWrongAttempt = null
        userInstance.wrongAttempts = 0

        userInstance.save(flush : true)

        flash.message = message(code: 'user.unlock.message')
        redirect action:"index", method:"GET"
    }

    @Transactional
    def changePassword(ResetPasswordCommand command) {
        if (!params.id) {
            flash.error = message(code: 'error.badRequest')
            redirect action:"index", method:"GET"
        }

        if (!request.post) {
            render view: '/user/changePassword', model: [id: params.id, command: new ResetPasswordCommand()]
            return
        }

        final User user = User.findById(params.id)

        command.username = user.username
        command.validate()

        if (command.hasErrors()) {
            command.password = null
            command.password2 = null
            render view: '/user/changePassword', model: [id: params.id, command: command]
            return
        }

        User.withTransaction { status ->
            user.password = command.password
            user.save()
        }

        flash.message = message(code: 'spring.security.ui.changePassword.success')
        redirect action: 'index'
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def findById(User userInstance) {
        def result = [id: userInstance.id, text: userInstance.toString()]
        render result as JSON
    }

    def autocomplete() {
        def users = User.findAllByUsernameIlikeOrFirstNameIlikeOrLastNameIlike("%${params.term}%", "%${params.term}%", "%${params.term}%", [max: params.limit, offset: params.offset, sort: "id", order: "desc"])
        def items = users.collectAll{[id :it.id, text : it.toString()] }.toList()
        def totalItems = User.countByUsernameIlikeOrFirstNameIlikeOrLastNameIlike("%${params.term}%", "%${params.term}%", "%${params.term}%")
        def result = [items:items, total:totalItems]
        render result as JSON
    }
}
