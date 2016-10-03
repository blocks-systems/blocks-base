/**
 *
 */
package blocks.auth.listeners

import blocks.auth.User
import blocks.auth.BlocksUserDetails
import org.springframework.context.ApplicationListener
import org.springframework.security.authentication.event.AuthenticationFailureBadCredentialsEvent

/**
 * @author emil.wesolowski
 *
 */
class BlocksFailureSuccessListener implements ApplicationListener<AuthenticationFailureBadCredentialsEvent> {

    @Override
    public void onApplicationEvent(AuthenticationFailureBadCredentialsEvent event) {
        def username = event.authentication.principal
        def user = User.findWhere(username: username)
        if(user){
            user.setWrongAttempts(user.wrongAttempts + 1)
            user.setLastWrongAttempt(new Date())
            user.save(flush: true)
        }

    }

}
