package blocks

import blocks.auth.User
import grails.plugin.springsecurity.annotation.Secured
import grails.plugin.springsecurity.userdetails.GrailsUser
import grails.transaction.Transactional
import org.springframework.security.core.context.SecurityContextHolder

@Transactional(readOnly = true)
@Secured('IS_AUTHENTICATED_FULLY')
class ProfileController {

    static allowedMethods = [update: "POST"]

    def messageSource
    def saltSource
    def mailService
    def springSecurityService

    def index() {
        render view: '/user/show', model: [userInstance: getLoggedUser()]
    }

    def edit(User userInstance) {
        render view: '/user/edit', model: [userInstance: getLoggedUser()]
    }

    @Transactional
    def update(User userInstance) {
        final User user = getLoggedUser()
        if (user == null) {
            notFound()
            return
        }
        user.firstName = userInstance.firstName
        user.lastName = userInstance.lastName

        user.validate()

        if (user.hasErrors()) {
            render view: '/user/edit', model: [userInstance: user]
            return
        }

        user.save flush:true

        flash.message = message(code: 'profile.updated')
        redirect action: 'index'
    }

    @Transactional
    def changePassword(ResetPasswordCommand command) {

        if (!request.post) {
            render view: '/user/changePassword', model: [command: new ResetPasswordCommand()]
            return
        }

        final User user = getLoggedUser()

        command.username = user.username
        command.validate()

        if (command.hasErrors()) {
            command.password = null
            command.password2 = null
            render view: '/user/changePassword', model: [command: command]
            return
        }

        User.withTransaction { status ->
            user.password = command.password
            user.save()
        }

        springSecurityService.reauthenticate user.username

        flash.message = message(code: 'spring.security.ui.changePassword.success')
        redirect action: 'index'
    }


    private User getLoggedUser() {
        GrailsUser user = (GrailsUser) SecurityContextHolder.context.authentication.principal
        return User.findById(user.id)
    }
}
