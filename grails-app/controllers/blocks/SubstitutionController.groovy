package blocks

import grails.transaction.Transactional;

class SubstitutionController {

    SubstitutionService substitutionService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond substitutionService.getCurrentUserSubstitutions(params), model:[substitutionInstanceCount: SubstitutionService.count]
    }

    def show(Substitution substitutionInstance) {
        println "show, ID:"
        println substitutionInstance.id
        respond substitutionInstance
        println "end show, ID:"
    }

    def create() {
        println "create"
        respond new Substitution(params)
        println "end create, ID:"
    }

    @Transactional
    def save(Substitution substitutionInstance) {
        println "saving...:"
        println "saving, ID:"
        println substitutionInstance.id
        println  substitutionInstance
        println "saved?"
        if (substitutionInstance == null) {
            println "substitutionInstance is null"
            notFound()
            return
        }

        if (substitutionInstance.hasErrors()) {
            println "substitutionInstance has errors"
            println substitutionInstance.errors
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
        println "edit, ID:"
        println substitutionInstance.id
        respond substitutionInstance
        println "end edit"
    }

    @Transactional
    def update(Substitution substitutionInstance) {
        println "uodate, ID:"
        println substitutionInstance.id
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
        println "end show"
    }

    @Transactional
    def delete(Substitution substitutionInstance) {
        println " DELETE substitutionInstance, ID:"
        println substitutionInstance.id
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
