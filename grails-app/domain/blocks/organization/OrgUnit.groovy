package blocks.organization

import blocks.BaseEntity
import blocks.auth.User

class OrgUnit extends BaseEntity {

    String code
    String name
    OrgUnit parentUnit
    String addressLine1
    String addressLine2
    String phone
    String email
    //User supervisor

    static hasMany =[members:User]
    static belongsTo = User

    static constraints = {
        code nullable: false
        name nullable: false
        parentUnit nullable: true
        members nullable: true
        addressLine1 nullable: true
        addressLine2 nullable: true
        phone nullable: true
        email nullable: true
        //supervisor nullable: true
    }

    static mapping = {
        id generator: 'sequence', params:[sequence:'id_org_unit_seq']
    }

    @Override
    String toString() {
        [code, name].findAll { it }.join(':')
    }
}
