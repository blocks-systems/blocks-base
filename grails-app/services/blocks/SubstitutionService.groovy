package blocks

import blocks.auth.User
import grails.plugin.springsecurity.userdetails.GrailsUser
import grails.transaction.Transactional
import org.springframework.security.core.context.SecurityContextHolder

@Transactional
class SubstitutionService {

    static Integer count

    List<Substitution> getCurrentUserSubstitutions(Map params) {
        List<Substitution> substitutions = new ArrayList<Substitution>()
        GrailsUser ud = (GrailsUser) SecurityContextHolder.context.authentication.principal
        User user = User.findById(ud.id)
        substitutions = Substitution.findAllByReplacedPerson(user, params)
        count = substitutions.size()
        return substitutions
    }

    List<Substitution> getReplacedUserSubstitutions(Map params, String username) {
        List<Substitution> substitutions = new ArrayList<Substitution>()
        User user = User.findByUsername(username)
        substitutions = Substitution.findAllByReplacedPerson(user, params)
        count = substitutions.size()
        return substitutions
    }

    List<Substitution> getActingUserSubstitutions(Map params, String username) {
        List<Substitution> substitutions = new ArrayList<Substitution>()
        User user = User.findByUsername(username)
        substitutions = Substitution.findAllByActingPerson(user, params)
        count = substitutions.size()
        return substitutions
    }

    List<Substitution> getReplacedOrActedUserSubstitutions(Map params, String username) {
        List<Substitution> substitutions = new ArrayList<Substitution>()
        User user = User.findByUsername(username)
        substitutions = Substitution.findAllByReplacedPersonOrActingPerson(user, user, params)
        count = substitutions.size()
        return substitutions
    }
}
