package blocks

import java.util.Date;

import blocks.helpers.UserHelper
import grails.validation.Validateable;
import blocks.auth.Permission
import blocks.auth.Role
import blocks.auth.User

/**
 * @author emil.wesolowski
 *
 */

class RegisterCommand implements Validateable{
    Long id
    String createdBy
    Date createdAt
    String editedBy
    Date editedAt
    String username
    String email
    String firstName
    String lastName
    boolean enabled
    String password
    String password2

    Set<Role> groups
    Set<Permission> roles

    static constraints = {
        username blank: false, validator: { value, command ->
            if (value) {
                if (User.findByUsernameIlike(value)) {
                    return 'registerCommand.username.unique'
                }
            }
        }
        id nullable: true
        email blank: false, email: true
        firstName nullable: true, blank: true
        lastName nullable: true, blank: true
        createdBy nullable: true
        createdAt nullable: true
        editedBy nullable: true
        editedAt nullable: true
        password blank: false, validator: UserHelper.passwordValidator
        password2 validator: UserHelper.password2Validator
        groups nullable: true
        roles nullable: true
    }

    public void mapFromEntity(final User user) {
        id = user.id
        createdBy = user.createdBy
        createdAt = user.createdAt
        editedBy = user.editedBy
        editedAt = user.editedAt
        username = user.username
        email = user.email
        firstName = user.firstName
        lastName = user.lastName
        enabled = user.enabled
        groups = user.groups
        roles = user.roles
    }

    public void mapToEntity(final User user) {
        user.firstName = firstName
        user.lastName = lastName
        user.enabled = enabled
        user.email = email
        user.roles = roles
        user.groups = groups
    }
}
