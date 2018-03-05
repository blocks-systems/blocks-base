package blocks

import blocks.auth.User
import grails.plugin.springsecurity.userdetails.GrailsUser
import grails.transaction.Transactional
import org.springframework.security.core.context.SecurityContextHolder

@Transactional
class NotificationService {

    def unreadNotifications(Map params) {
        unreadNotifications(getCurrentUser(), params)
    }

    def readNotifications(Map params) {
        readNotifications(getCurrentUser(), params)
    }

    def allNotifications(Map params) {
        allNotifications(getCurrentUser(), params)
    }

    def unreadNotifications(User user, Map params) {
        Notification.findAllByUserAndIsRead(user, false, params)
    }

    def readNotifications(User user, Map params) {
        Notification.findAllByUserAndIsRead(user, true, params)
    }

    def allNotifications(User user, Map params) {
        Notification.findAllByUser(user, params)
    }

    def unreadNotificationsCount(Map params) {
        unreadNotificationsCount(getCurrentUser(), params)
    }

    def unreadNotificationsCount(User user, Map params) {
        Notification.countByUserAndIsRead(user, false, params)
    }

    def getCurrentUser() {
        GrailsUser user = (GrailsUser) SecurityContextHolder.context.authentication.principal
        return User.findById(user.id)
    }

}
