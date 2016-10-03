/**
 *
 */
package blocks

import blocks.helpers.UserHelper
import grails.validation.Validateable

/**
 * @author emil.wesolowski
 *
 */

class ResetPasswordCommand implements Validateable {
    String username
    String password
    String password2

    static constraints = {
        password blank: false, validator: UserHelper.passwordValidator
        password2 validator: UserHelper.password2Validator
    }
}
