package blocks

import blocks.auth.User
import grails.gorm.DetachedCriteria
import grails.plugin.springsecurity.userdetails.GrailsUser
import grails.transaction.Transactional
import org.apache.commons.logging.LogFactory
import org.springframework.security.core.context.SecurityContextHolder

@Transactional
class TaskService {

    private static final log = LogFactory.getLog(this)

    def getTasksforLoggedUser(Map params) {
        params.sort = params.sort ?: 'priority'
        params.order = params.order ?: 'desc'
        User loggedUser = getCurrentUser()
        DetachedCriteria<Task> query = Task.where {
            user.id == loggedUser.id
            isActive == true
        }
        def taskResults = query.list(params)
        return taskResults
    }

    def getUndoneTasksCountForLoggedUser() {
        User loggedUser = getCurrentUser()
        Task.where {
            user.id == loggedUser.id
            isActive == true
            done == false
        }.count()
    }

    def getDoneTasksCountForLoggedUser() {
        User loggedUser = getCurrentUser()
        Task.where {
            user.id == loggedUser.id
            isActive == true
            done == true
        }.count()
    }

    def getDonePercentForLoggedUser() {
        def undone = getUndoneTasksCountForLoggedUser()
        def done = getDoneTasksCountForLoggedUser()
        if (undone == 0 || done == 0) {
            return 0.0
        } else {
            return (100*done)/(undone+done)
        }
    }

    def getCurrentUser() {
        GrailsUser user = (GrailsUser) SecurityContextHolder.context.authentication.principal
        return User.findById(user.id)
    }
}
