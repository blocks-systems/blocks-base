package blocks.auth

import blocks.BaseEntity
import org.springframework.security.core.GrantedAuthority

class Permission extends BaseEntity implements GrantedAuthority {

    String authority
    String name

    static searchable = false

    static mapping = {
        table 'sec_permissions'
        cache true
    }

    static constraints = {
        authority blank: false, unique: true
    }
}