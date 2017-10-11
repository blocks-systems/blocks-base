package blocks

import blocks.auth.User
import grails.databinding.BindingFormat

class Task extends BaseEntity {

    static searchable = {
        root false
        except = ['createdAt',
                  'createdBy',
                  'editedAt',
                  'editedBy',
                  'isActive',
                  'dueDate',
                  'priority',
                  'done'
        ]
    }

    static belongsTo = [user: User]

    @BindingFormat('yyyy-MM-dd')
    Date dueDate = new Date()
    String title
    String description
    Integer priority = 0
    Boolean done = false

    static constraints = {
        user nullable: false
        title nullable: false, blank: false
        description nullable: true, maxSize: 2000
        priority nullable: true
        done nullable: true
    }

    static mapping = {
        id generator: 'sequence', params:[sequence:'task_seq']
        description type: 'text'
    }

    @Override
    String toString() {
        title
    }
}
