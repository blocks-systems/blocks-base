package blocks

import grails.transaction.Transactional
import org.apache.commons.logging.LogFactory;

class SubstitutionController {

    private static final log = LogFactory.getLog(this)

    SubstitutionService substitutionService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond substitutionService.getCurrentUserSubstitutions(params), model:[substitutionInstanceCount: SubstitutionService.count]
    }

    def show(Substitution substitutionInstance) {
        respond substitutionInstance
    }

    def create() {
        respond new Substitution(params)
    }

    @Transactional
    def save(Substitution substitutionInstance) {
        if (substitutionInstance == null) {
            notFound()
            return
        }

        if (substitutionInstance.hasErrors()) {
            respond substitutionInstance.errors, view:'create'
            return
        }

        substitutionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'substitution.label', default: 'Substitution'), substitutionInstance.id])
                redirect substitutionInstance
            }
            '*' { respond substitutionInstance, [status: CREATED] }
        }
    }

    def edit(Substitution substitutionInstance) {
        respond substitutionInstance
    }

    @Transactional
    def update(Substitution substitutionInstance) {
        if (substitutionInstance == null) {
            notFound()
            return
        }

        if (substitutionInstance.hasErrors()) {
            respond substitutionInstance.errors, view:'edit'
            return
        }

        substitutionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Substitution.label', default: 'Substitution'), substitutionInstance.id])
                redirect substitutionInstance
            }
            '*'{ respond substitutionInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Substitution substitutionInstance) {
        if (substitutionInstance == null) {
            println "DELETE substitutionInstance is null"
            notFound()
            return
        }

        substitutionInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Substitution.label', default: 'Substitution'), substitutionInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'substitution.label', default: 'Substitution'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
