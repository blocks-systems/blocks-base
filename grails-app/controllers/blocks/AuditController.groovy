package blocks

import blocks.BlocksAuditLogEvent
import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_ADMIN')
class AuditController {

    static allowedMethods = [delete: 'POST', save: 'POST', update: 'POST']

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond BlocksAuditLogEvent.list(params), model:[auditLogEventInstanceCount: BlocksAuditLogEvent.count()]
    }

    def show(BlocksAuditLogEvent auditLogEventInstance) {
        if (auditLogEventInstance == null) {
            notFound()
            return
        }

        [auditLogEventInstance: auditLogEventInstance]
    }

    def delete() {
        redirect(action: 'list')
    }

    def edit() {
        redirect(action: 'list')
    }

    def update() {
        redirect(action: 'list')
    }

    def create() {
        redirect(action: 'list')
    }

    def save() {
        redirect(action: 'list')
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [
                        message(code: 'AuditLogEvent.label'),
                        params.id
                ])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND, text: message(code: 'default.not.found.message', args: [
                    message(code: 'address.AuditLogEvent.label'),
                    params.id
            ]) }
        }
    }
}