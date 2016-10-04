package blocks

import blocks.auth.User
import grails.databinding.BindingFormat

class BaseMessage extends BaseEntity {

    User sender
    String contents = ''
    String subject = ''
    Integer priority = 0
    @BindingFormat('yyyy-MM-dd')
    Date dueDate = new Date()
    Boolean isRead = false
    Boolean isShownToRecipient = true
    BaseMessage replayTo

    static hasMany =[recipients:User]

    static constraints = {
        recipients nullable: true
        sender nullable: true
        contents nullable: false, widget: 'textarea'
        subject nullable: false, maxSize: 128
        isRead nullable: false
        priority nullable: false
        dueDate nullable: false
        replayTo nullable: true
        isShownToRecipient nullable: false
    }

    static mapping = {
        id generator: 'sequence', params:[sequence:'message_seq']
        contents type: 'text'
    }

    @Override
    String toString() {
        [sender, subject].findAll { it }.join(', ')
    }
}
