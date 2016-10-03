package blocks

import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class BaseMessageController {

    def baseMessageService

    static allowedMethods = [sent: "GET", save: "POST", update: "POST", delete: "POST"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond baseMessageService.getMessages(params), model:[
                messageCount: baseMessageService.count(),
                unreadCount: baseMessageService.unreadCount(),
                importantCount: baseMessageService.importantCount(),
                sentCount: baseMessageService.sentCount()
        ]
    }

    def unread(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond baseMessageService.getUnread(params), model:[
                messageCount: baseMessageService.count(),
                unreadCount: baseMessageService.unreadCount(),
                importantCount: baseMessageService.importantCount(),
                sentCount: baseMessageService.sentCount()
        ], view:'index'
    }

    def important(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond baseMessageService.getImportant(params), model:[
                messageCount: baseMessageService.count(),
                unreadCount: baseMessageService.unreadCount(),
                importantCount: baseMessageService.importantCount(),
                sentCount: baseMessageService.sentCount()
        ], view:'index'
    }

    def sent(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond baseMessageService.getSent(params), model:[
                messageCount: baseMessageService.count(),
                unreadCount: baseMessageService.unreadCount(),
                importantCount: baseMessageService.importantCount(),
                sentCount: baseMessageService.sentCount()
        ], view:'index'
    }

    def show(BaseMessage baseMessageInstance) {
        respond baseMessageInstance
    }

    def create() {
        respond baseMessageService.create()
    }

    @Transactional
    def save(BaseMessage baseMessageInstance) {
        if (baseMessageInstance == null) {
            notFound()
            return
        }

        if (baseMessageInstance.hasErrors()) {
            respond baseMessageInstance.errors, view:'create'
            return
        }

        baseMessageInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'baseMessage', default: 'Message'), baseMessageInstance.id])
                redirect action: 'index'
            }
            '*' { respond baseMessageInstance, [status: CREATED] }
        }
    }

    @Transactional
    def edit(BaseMessage baseMessageInstance) {
        baseMessageInstance.isRead = true;
        baseMessageInstance.save flush: true
        respond baseMessageInstance
    }

    @Transactional
    def update(BaseMessage baseMessageInstance) {
        if (baseMessageInstance == null) {
            notFound()
            return
        }

        if (baseMessageInstance.hasErrors()) {
            respond baseMessageInstance.errors, view:'edit'
            return
        }

        baseMessageInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'baseMessage', default: 'Message'), baseMessageInstance.id])
                redirect action: 'index'
            }
            '*'{ respond baseMessageInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(BaseMessage baseMessageInstance) {

        if (baseMessageInstance == null) {
            notFound()
            return
        }

        baseMessageService.delete(baseMessageInstance)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'baseMessage', default: 'Message'), baseMessageInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'baseMessage', default: 'Message'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
