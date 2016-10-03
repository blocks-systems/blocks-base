package blocks

import blocks.auth.RegistrationCode
import blocks.auth.User
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import grails.plugin.springsecurity.authentication.dao.NullSaltSource
import groovy.text.SimpleTemplateEngine
import org.apache.commons.logging.LogFactory

class RegisterController {

    private static final log = LogFactory.getLog(this)

    //def grailsApplication

    static defaultAction = 'index'

    static allowedMethods = [register: 'POST']

    def messageSource
    def saltSource
    def mailService
    def springSecurityService

    @Secured(['ROLE_ADMIN'])
    def index() {
        def copy = [:] + (flash.chainedParams ?: [:])
        copy.remove 'controller'
        copy.remove 'action'
        [command: new RegisterCommand(copy)]
    }

    @Secured(['ROLE_ADMIN'])
    def register(RegisterCommand command) {

        grail

        if (command.hasErrors()) {
            render view: 'index', model: [command: command]
            return
        }

        String salt = saltSource instanceof NullSaltSource ? null : command.username
        def user = new User(email: command.email, username: command.username, firstName: command.firstName, lastName:command.lastName, password: command.password, accountLocked: true, enabled: true, roles: command.roles, groups: command.groups)

        try {
            user.save(flush : true)
        } catch (final Exception e) {
            log.error(e.getMessage(), e)
            flash.error = message(code: 'spring.security.ui.register.miscError')
            render view: 'index', model: [command: command]
            return
        }

        flash.message = message(code: 'spring.security.account.register.created')
        redirect (controller: "user", action: "index")
    }

    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def forgotPassword() {

        if (!request.post) {
            // show the form
            return
        }

        String username = params.username
        if (!username) {
            flash.error = message(code: 'spring.security.ui.forgotPassword.username.missing')
            redirect action: 'forgotPassword'
            return
        }

        def user = User.findWhere(username : username)
        if (!user) {
            flash.error = message(code: 'spring.security.ui.forgotPassword.user.notFound')
            redirect action: 'forgotPassword'
            return
        }

        def registrationCode = new RegistrationCode(username: user.username)
        registrationCode.save(flush: true)

        String url = generateLink('resetPassword', [t: registrationCode.token])

        mailService.sendMail {
            to user.email
            from grailsApplication.config.mailFrom
            subject message(code: 'spring.security.ui.resetPassword.title')
            html  g.render( template: '/emails/forgotPassword', plugin:"blocks-base", model: [user:user, url:url])
        }

        flash.message = message(code: 'spring.security.ui.forgotPassword.sent')
        redirect action: 'forgotPassword'
    }

    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def resetPassword(ResetPasswordCommand command) {

        String token = params.t

        def registrationCode = token ? RegistrationCode.findByToken(token) : null
        if (!registrationCode) {
            flash.error = message(code: 'spring.security.ui.resetPassword.badCode')
            redirect(action: "invalidToken")
            return
        }

        if (!request.post) {
            return [token: token, command: new ResetPasswordCommand()]
        }

        command.username = registrationCode.username
        command.validate()

        if (command.hasErrors()) {
            command.password = null
            command.password2 = null
            return [token: token, command: command]
        }

        String salt = saltSource instanceof NullSaltSource ? null : registrationCode.username
        RegistrationCode.withTransaction { status ->
            def user = User.findWhere(username: registrationCode.username)
            user.password = command.password
            user.save()
            registrationCode.delete()
        }

        springSecurityService.reauthenticate registrationCode.username

        flash.message = message(code: 'spring.security.ui.resetPassword.success')

        def conf = SpringSecurityUtils.securityConfig
        redirect uri: conf.successHandler.defaultTargetUrl
    }

    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def invalidToken() {
        render view: 'invalidToken'
    }

    protected String generateLink(String action, linkParams) {
        createLink(base: "$request.scheme://$request.serverName:$request.serverPort$request.contextPath",
                controller: 'register', action: action,
                params: linkParams)
    }

    protected String evaluate(s, binding) {
        new SimpleTemplateEngine().createTemplate(s).make(binding)
    }
}
