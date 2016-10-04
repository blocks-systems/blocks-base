package blocks

import blocks.auth.User
import grails.databinding.BindingFormat

class Substitution extends BaseEntity {

    Boolean accepted = true
    Boolean withBpmRoles = false
    @BindingFormat('yyyy-MM-dd')
    Date startDate
    @BindingFormat('yyyy-MM-dd')
    Date finishDate
    User replacedPerson
    User actingPerson

    //static belongsTo = [actingPerson: User]

    //static mappedBy = [ actingPerson: "none", replacedPerson: "none" ]

    static mapping = {
        actingPerson column: 'actingPersonId'
        replacedPerson column: 'replacedPersonId'
        id generator: 'sequence', params:[sequence:'id_substitution_seq']
    }

    static constraints = {
        finishDate nullable: true
    }

    @Override
    String toString() {
        [actingPerson, actingPerson].findAll { it }.join(', ')
    }
}
