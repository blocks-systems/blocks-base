package blocks.auth

import blocks.BaseEntity;

class Role extends BaseEntity {

    String name

    static searchable = false

    static hasMany = [
            roles: Permission
    ]

    static mapping = {
        table 'sec_roles'
        cache true
    }

    Set<Permission> getAuthorities() {
        RoleGroupRole.findAllByRoleGroup(this).collect { it.role }
    }

    static constraints = {
        name blank: false, unique: true
    }
}
