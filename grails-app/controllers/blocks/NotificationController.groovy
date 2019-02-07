package blocks

import grails.converters.JSON
import org.apache.commons.logging.LogFactory

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class NotificationController {

    def notificationService

    private static final log = LogFactory.getLog(this)

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Notification.list(params), model:[notificationCount: Notification.count()]
    }

    def show(Notification notification) {
        respond notification
    }

    def create() {
        respond new Notification(params)
    }

    @Transactional
    def save(Notification notification) {
        if (notification == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (notification.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond notification.errors, view:'create'
            return
        }

        notification.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'notification', default: 'Notification'), notification.id])
                redirect notification
            }
            '*' { respond notification, [status: CREATED] }
        }
    }

    def edit(Notification notification) {
        respond notification
    }

    @Transactional
    def update(Notification notification) {
        if (notification == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (notification.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond notification.errors, view:'edit'
            return
        }

        notification.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'notification', default: 'Notification'), notification.id])
                redirect notification
            }
            '*'{ respond notification, [status: OK] }
        }
    }

    @Transactional
    def delete(Notification notification) {

        if (notification == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        notification.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'notification', default: 'Notification'), notification.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Transactional(readOnly = true)
    def unreadedNotifications() {
        def params = [:]
        params.max = 5
        def notifications = notificationService.unreadNotifications(params)
                //Notification.findAllByIsRead(false, params)
        render notifications as JSON
    }

    @Transactional
    def read() {
        log.debug(params)
        if (params.id == null) {
            notFound()
            return
        }

        Notification notification = Notification.findById(params.id)
        notification.isRead = true
        notification.save flush:true

        def ajaxResponse = [:]

        ajaxResponse = [
                'success': true,
                'object': notification,
                'message': message(code: 'default.saved.message', args: [message(code: 'notification', default: 'notification'), notification])
        ]
        render ajaxResponse as JSON
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'notification', default: 'Notification'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
