package blocks.organization

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.apache.commons.logging.LogFactory
import org.grails.web.json.JSONWriter
import org.springframework.web.servlet.support.RequestContextUtils

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
@Secured('ROLE_SUPER_USER')
class OrgUnitController {

    private static final log = LogFactory.getLog(this)

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond OrgUnit.list(params), model:[orgUnitCount: OrgUnit.count()]
    }

    def diagram(Integer max) {
        def orgUnits = OrgUnit.findAll([sort: "parentUnit", order: "desc"])
        params.max = Math.min(max ?: 10, 100)
        respond OrgUnit.list(params), model:[orgUnitCount: OrgUnit.count()]
    }

    def show(OrgUnit orgUnit) {
        respond orgUnit
    }

    def create() {
        respond new OrgUnit(params)
    }

    @Transactional
    def save(OrgUnit orgUnit) {
        if (orgUnit == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (orgUnit.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond orgUnit.errors, view:'create'
            return
        }

        orgUnit.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'orgUnit', default: 'OrgUnit'), orgUnit.id])
                redirect action: 'diagram'
            }
            '*' { respond orgUnit, [status: CREATED] }
        }
    }

    def edit(OrgUnit orgUnit) {
        respond orgUnit
    }

    @Transactional
    def update(OrgUnit orgUnit) {
        if (orgUnit == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (orgUnit.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond orgUnit.errors, view:'edit'
            return
        }

        orgUnit.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'orgUnit', default: 'OrgUnit'), orgUnit.id])
                redirect orgUnit
            }
            '*'{ respond orgUnit, [status: OK] }
        }
    }

    @Transactional
    def delete(OrgUnit orgUnit) {

        if (orgUnit == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        orgUnit.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'orgUnit', default: 'OrgUnit'), orgUnit.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'orgUnit', default: 'OrgUnit'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def ajaxCreateChild(OrgUnit orgUnit) {
        log.debug("[ajaxCreateChild] orgUnit:")
        log.debug(orgUnit)
        if (orgUnit == null) {
            notFound()
            return
        }
        OrgUnit childOrgUnit = new OrgUnit()
        childOrgUnit.parentUnit = orgUnit

        render template: 'form',
                model: [orgUnit:childOrgUnit],
                contentType: 'text/plain'
    }

    def ajaxCreate() {
        render template: 'form',
                model: [orgUnit:new OrgUnit(params)],
                contentType: 'text/plain'
    }

    def ajaxEdit(OrgUnit orgUnit) {
        if (orgUnit == null) {
            notFound()
            return
        }
        render template: 'form',
                model: [orgUnit:orgUnit],
                contentType: 'text/plain'
    }

    @Transactional
    def ajaxSave(OrgUnit orgUnit) {
        if (orgUnit == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        def ajaxResponse = [:]

        if (orgUnit.hasErrors()) {
            transactionStatus.setRollbackOnly()
            def errors = new ArrayList<String>();
            for (fieldErrors in orgUnit.errors) {
                for (error in fieldErrors.allErrors) {
                    errors.add(messageSource.getMessage(error, RequestContextUtils.getLocale(request)))
                }
            }
            ajaxResponse = ['success': false, 'errors': errors]
        } else {
            orgUnit.save flush:true
            ajaxResponse = [
                    'success': true,
                    'object': orgUnit,
                    'message': message(code: 'default.saved.message', args: [message(code: 'orgUnit', default: 'OrgUnit'), orgUnit])
            ]

        }
        render ajaxResponse as JSON
    }
}
