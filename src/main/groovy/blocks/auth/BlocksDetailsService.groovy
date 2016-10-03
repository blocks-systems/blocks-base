/**
 *
 */
package blocks.auth;

import blocks.auth.User
//import org.apache.commons.logging.LogFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import grails.plugin.springsecurity.userdetails.GrailsUserDetailsService;

/**
 * @author emil.wesolowski
 *
 */
public class BlocksDetailsService implements GrailsUserDetailsService {

    //private static final log = LogFactory.getLog(this)
    /**
     /* (non-Javadoc)
     * @see org.springframework.security.core.userdetails.UserDetailsService#loadUserByUsername(java.lang.String)
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User.withTransaction { status ->

            //log.debug("loadUserByUsername - with status ${status} and username: ${username}")
            User user = User.findWhere(username: username)

            if (!user) throw new UsernameNotFoundException('User not found ${username}')

            user.groups.each() {
                user.grantedAuthorities.addAll(it.roles)
            }
            user.grantedAuthorities.addAll(user.roles)

            return new BlocksUserDetails(user);
        }
    }
    /**
     /* (non-Javadoc)
     * @see grails.plugin.springsecurity.userdetails.GrailsUserDetailsService#loadUserByUsername(java.lang.String, boolean)
     */
    @Override
    public UserDetails loadUserByUsername(String username, boolean loadRoles)
            throws UsernameNotFoundException, DataAccessException {
        return loadUserByUsername(username)
    }
}

