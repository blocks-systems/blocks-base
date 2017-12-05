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
        respond User.list(params), model:[userCount: User.count()]
    }

    def show(User user) {
        respond user
    }

    def create() {
        respond new User(params)
    }

    @Transactional
    def save(User user) {
        if (user == null) {
            notFound()
            return
        }

        if (user.hasErrors()) {
            respond user.errors, view:'create'
            return
        }

        user.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user', default: 'User'), user])
                redirect user
            }
            '*' { respond user, [status: CREATED] }
        }
    }

    def edit(User user) {
        if (user == null) {
            notFound()
            return
        }
        final RegisterCommand command = new RegisterCommand();
        command.mapFromEntity(user)

        render view: '/user/edit', model: [id: params.id, user: command]
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
                flash.message = message(code: 'default.updated.message', args: [message(code: 'user', default: 'User'), user])
                redirect user
            }
            '*'{ respond user, [status: OK] }
        }
    }

    @Transactional
    def delete(User user) {
        User.withTransaction { status ->
            try {
                user.delete()
                render message(code: 'default.records.deleted',  args: [message(code: 'users')])
            } catch (Exception ex) {
                status.setRollbackOnly();
                log.error(ex.getMessage());
                render message(code: 'error.generic')
            }
        }
    }

    @Transactional
    def unlock(User user) {

        if (user == null) {
            notFound()
            return
        }

        user.lastWrongAttempt = null
        user.wrongAttempts = 0

        user.save(flush : true)

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
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'userl', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def findById(User user) {
        def result = [id: user.id, text: user.toString()]
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
