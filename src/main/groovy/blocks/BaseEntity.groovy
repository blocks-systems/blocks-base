package blocks

import blocks.auth.User

/**
 * Created by floyd on 15.11.15.
 */

import grails.plugin.springsecurity.userdetails.GrailsUser
import org.springframework.security.core.context.SecurityContextHolder

abstract class BaseEntity {

    String createdBy = 'SYSTEM'
    Date createdAt = new Date()
    String editedBy = 'SYSTEM'
    Date editedAt = new Date()
    boolean isActive = true

    static constraints = {
        createdBy nullable: true
        createdAt nullable: true
        editedBy nullable: true
        editedAt nullable: true
    }

    static mapping = {
        createdAt column: "created_at"
        createdBy column: "created_by"
        editedAt column: "edited_at"
        editedBy column: "edited_by"
        isActive column: "is_active"
    }

    def beforeInsert() {
        createdAt = new Date()
        if (SecurityContextHolder?.context?.authentication?.principal != null) {
            GrailsUser guser = (GrailsUser) SecurityContextHolder.context.authentication.principal
            createdBy = guser.username
        }
    }

    def beforeUpdate() {
        editedAt = new Date()
        if (SecurityContextHolder?.context?.authentication?.principal != null) {
            GrailsUser guser = (GrailsUser) SecurityContextHolder.context.authentication.principal
            editedBy = guser.username
        }
    }

    def onSave = {
        createdAt = new Date()
        if (SecurityContextHolder?.context?.authentication?.principal != null) {
            GrailsUser user = (GrailsUser) SecurityContextHolder.context.authentication.principal
            createdBy = user.username
        }
    }

    def onChange = {
        editedAt = new Date()
        if (SecurityContextHolder?.context?.authentication?.principal != null) {
            GrailsUser user = (GrailsUser) SecurityContextHolder.context.authentication.principal
            editedBy = user.username
        }
    }
}
