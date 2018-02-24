package blocks

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserPreferenceController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond UserPreference.list(params), model:[userPreferenceCount: UserPreference.count()]
    }

    def show(UserPreference userPreference) {
        respond userPreference
    }

    def create() {
        respond new UserPreference(params)
    }

    @Transactional
    def save(UserPreference userPreference) {
        if (userPreference == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (userPreference.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond userPreference.errors, view:'create'
            return
        }

        userPreference.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'userPreference', default: 'User Preference'), userPreference.id])
                redirect userPreference
            }
            '*' { respond userPreference, [status: CREATED] }
        }
    }

    def edit(UserPreference userPreference) {
        respond userPreference
    }

    @Transactional
    def update(UserPreference userPreference) {
        if (userPreference == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (userPreference.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond userPreference.errors, view:'edit'
            return
        }

        userPreference.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'userPreference', default: 'User Preference'), userPreference.id])
                redirect userPreference
            }
            '*'{ respond userPreference, [status: OK] }
        }
    }

    @Transactional
    def delete(UserPreference userPreference) {

        if (userPreference == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        userPreference.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'userPreference', default: 'User Preference'), userPreference.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'userPreference', default: 'User Preference'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
