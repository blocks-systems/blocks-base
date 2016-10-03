package blocks

import blocks.auth.Permission
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
@Secured('ROLE_SUPER_USER')
class PrivilegeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Permission.list(params), model:[permissionInstanceCount: Permission.count()]
    }

    def show(Permission permissionInstance) {
        respond permissionInstance
    }

    def create() {
        respond new Permission(params)
    }

    @Transactional
    def save(Permission permissionInstance) {
        if (permissionInstance == null) {
            notFound()
            return
        }

        if (permissionInstance.hasErrors()) {
            respond permissionInstance.errors, view:'create'
            return
        }

        permissionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'permission.label', default: 'Permission'), permissionInstance.id])
                redirect permissionInstance
            }
            '*' { respond permissionInstance, [status: CREATED] }
        }
    }

    def edit(Permission permissionInstance) {
        respond permissionInstance
    }

    @Transactional
    def update(Permission permissionInstance) {
        if (permissionInstance == null) {
            notFound()
            return
        }

        if (permissionInstance.hasErrors()) {
            respond permissionInstance.errors, view:'edit'
            return
        }

        permissionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Permission.label', default: 'Permission'), permissionInstance.id])
                redirect permissionInstance
            }
            '*'{ respond permissionInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Permission permissionInstance) {

        if (permissionInstance == null) {
            notFound()
            return
        }

        permissionInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Permission.label', default: 'Permission'), permissionInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'permission.label', default: 'Permission'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
