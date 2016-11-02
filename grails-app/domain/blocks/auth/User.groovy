package blocks.auth

import blocks.BaseEntity
import blocks.organization.OrgUnit
import org.apache.commons.lang3.StringUtils
import grails.databinding.BindingFormat
import org.springframework.security.core.GrantedAuthority

class User extends BaseEntity {

    transient springSecurityService

    static searchable = {
        root false
    }

    Long id
    String username
    String password
    String email
    String firstName
    String lastName
    boolean enabled = true
    @BindingFormat('yyyy-MM-dd')
    Date passwordExpire
    @BindingFormat('yyyy-MM-dd')
    Date accountExpire
    int wrongAttempts
    Date lastWrongAttempt
    Date lastSuccessfulAttempt

    Set<GrantedAuthority> grantedAuthorities = new HashSet<GrantedAuthority>();

    static transients = [
            'springSecurityService',
            'grantedAuthorities'
    ]

    static constraints = {
        username blank: false, unique: true
        password blank: false
        email email: true, blank: false
        firstName blank: false, nullable: true
        lastName blank: false, nullable: true
        passwordExpire nullable: true
        accountExpire nullable: true
        lastWrongAttempt nullable: true
        lastSuccessfulAttempt nullable: true
        groups nullable: true
        roles nullable: true
        orgUnits nullable: true
    }

    static hasMany = [
            groups: Role,
            roles: Permission,
            orgUnits: OrgUnit
    ]

    static mapping = {
        table 'sec_user'
        password column: '`password`'
    }

    Set<GrantedAuthority> getAuthorities() {
        return grantedAuthorities;
    }

    // TODO transfer constant to some properties
    boolean isAccountNonLocked() {
        Calendar c = Calendar.getInstance();
        c.setTime(new Date());
        c.add(Calendar.MINUTE, -90);
        return wrongAttempts < 5 || (lastWrongAttempt != null && lastWrongAttempt.before(c.getTime()));
    }

    boolean isAccountExpired() {
        return false;
    }

    boolean isPasswordExpired() {
        return false;
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
    }

    @Override
    String toString() {
        if (StringUtils.isBlank(firstName) && StringUtils.isBlank(lastName)){
            return email
        }
        final StringBuilder sb = new StringBuilder()
        if (StringUtils.isNotBlank(firstName)) {
            sb.append(firstName).append(" ")
        }
        if (StringUtils.isNotBlank(lastName)) {
            sb.append(lastName).append(" ")
        }
        sb.append("(" + email + ")")
        return sb.toString()
    }
}
