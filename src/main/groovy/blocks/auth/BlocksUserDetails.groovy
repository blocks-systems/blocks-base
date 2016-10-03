/**
 *
 */
package blocks.auth

import grails.plugin.springsecurity.userdetails.GrailsUser
import org.springframework.security.core.GrantedAuthority

/**
 * @author emil.wesolowski
 *
 */
class BlocksUserDetails extends GrailsUser {

    final String fullName

    BlocksUserDetails(User user) {
        super(user.username, user.password, user.enabled, !user.accountExpired, !user.passwordExpired, user.accountNonLocked, user.authorities, user.id)

        this.fullName = user.firstName + " " + user.lastName
    }
}
