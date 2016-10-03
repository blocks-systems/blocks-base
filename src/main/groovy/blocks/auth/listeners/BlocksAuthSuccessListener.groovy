/**
 *
 */
package blocks.auth.listeners

import blocks.auth.User
import blocks.auth.BlocksUserDetails
import grails.transaction.Transactional
import org.springframework.context.ApplicationListener
import org.springframework.security.authentication.event.AuthenticationSuccessEvent

/**
 * @author emil.wesolowski
 *
 */
@Transactional
class BlocksAuthSuccessListener implements ApplicationListener<AuthenticationSuccessEvent> {

    @Override
    public void onApplicationEvent(AuthenticationSuccessEvent event) {
        def BlocksUserDetails ud = (BlocksUserDetails) event.authentication.principal
        def user = User.findWhere(username: ud.username)
        if(user){
            user.setWrongAttempts(0)
            user.setLastSuccessfulAttempt(new Date())
            user.save(flush: true)
        }
    }

}
