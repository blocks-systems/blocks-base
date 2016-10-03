package blocks

import blocks.auth.User
import grails.plugin.springsecurity.userdetails.GrailsUser
import grails.transaction.Transactional
import org.springframework.security.core.context.SecurityContextHolder

@Transactional
class BaseMessageService {

    def create(params) {
        BaseMessage baseMessageInstance = new BaseMessage(params)
        baseMessageInstance.sender = getCurrentUser()
        return baseMessageInstance
    }

    def delete(BaseMessage baseMessageInstance) {
        if (baseMessageInstance.sender == getCurrentUser()) {
            baseMessageInstance.isShownToRecipient = false
            baseMessageInstance.save flush:true
        }
        if (baseMessageInstance.recipients.contains(getCurrentUser())) {
            baseMessageInstance.recipients?.remove(getCurrentUser())
            baseMessageInstance.save flush:true
        }
        if (baseMessageInstance.recipients.isEmpty() && !baseMessageInstance.isShownToRecipient) {
            baseMessageInstance.delete flush:true
        }
    }

    def unreadCount() {
        def c = BaseMessage.createCriteria()
        def results = c.list {
            eq("isRead", false)
            eq("isShownToRecipient",true)
            recipients {
                eq("id",getCurrentUser().id)
            }
        }
        return results?.size() ?: 0;
    }

    def getUnread(params) {
        def c = BaseMessage.createCriteria()
        //c.maxResults(0)
        //.setFirstResult(params.offset ?: 0).setFetchSize(params.max ?: 10)
        return c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq("isRead", false)
            eq("isShownToRecipient",true)
            recipients {
                eq("id",getCurrentUser().id)
            }
        }
    }

    def importantCount() {
        def c = BaseMessage.createCriteria()
        def results = c.list {
            gt("priority", 50)
            eq("isShownToRecipient",true)
            recipients {
                eq("id",getCurrentUser().id)
            }
        }
        return results?.size() ?: 0;
    }

    def getImportant(params) {
        def c = BaseMessage.createCriteria()
        //.setFirstResult(params.offset ?: 0).setFetchSize(params.max ?: 10)
        return c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            gt("priority", 50)
            eq("isShownToRecipient",true)
            recipients {
                eq("id",getCurrentUser().id)
            }
        }
    }

    def sentCount() {
        return BaseMessage.findAllBySender(getCurrentUser())?.size() ?: 0
    }

    def getSent(params) {
        params.offset = params.offset ?: 0
        params.max = params.max ?: 10
        return BaseMessage.findAllBySender(getCurrentUser(), params)
    }

    def count() {
        def c = BaseMessage.createCriteria()
        def results = c.list {
            eq("isShownToRecipient",true)
            recipients {
                eq("id",getCurrentUser().id)
            }
        }
        return results?.size() ?: 0;
    }

    def getMessages(params) {
        def c = BaseMessage.createCriteria()
        def results =  c.list(max: params.max ?: 10, offset: params.offset ?: 0) {
            eq("isShownToRecipient",true)
            recipients {
                eq("id",getCurrentUser().id)
            }
        }
        return results
    }

    def getCurrentUser() {
        GrailsUser user = (GrailsUser) SecurityContextHolder.context.authentication.principal
        return User.findById(user.id)
    }
}
