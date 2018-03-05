package blocks

import blocks.auth.User
import grails.databinding.BindingFormat

class Notification extends BaseEntity {

    User user
    String title
    String contents
    @BindingFormat('yyyy-MM-dd HH:mm')
    Date dueDate = new Date()
    Boolean isRead = false

    static constraints = {
        user nullable: true
        title nullable: false, blank: false
        contents nullable: true, blank: true
        dueDate nullable: true
        isRead nullable: true
    }

    static mapping = {
        id generator: 'sequence', params:[sequence:'notification_seq']
    }

    @Override
    String toString() {
        title
    }
}
