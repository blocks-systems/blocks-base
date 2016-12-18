package blocks.traits

import grails.artefact.Enhances
import grails.plugin.springsecurity.userdetails.GrailsUser
import org.grails.core.artefact.DomainClassArtefactHandler
import org.springframework.security.core.context.SecurityContextHolder

/**
 * Created by fgroch on 19.12.16.
 */
@Enhances(DomainClassArtefactHandler.TYPE)
trait BaseEntityTrait {
    def getActorUserName() {
        String uname = 'unknown'
        if (SecurityContextHolder?.context?.authentication?.principal != null) {
            GrailsUser guser = (GrailsUser) SecurityContextHolder.context.authentication.principal
            uname  = guser?.username
        }
        uname
    }

}