package blocks

import blocks.auth.User

class UserPreference extends BaseEntity {

    static searchable = {
        root false
    }

    User user
    UserPreferenceType userPreferenceType = UserPreferenceType.STRING
    String userPreferenceValue
    String userPreferenceName

    static constraints = {
        user nullable: false
        userPreferenceType nullable: true
        userPreferenceValue nullable: true, blank: true
        userPreferenceName nullable: false, blank: false
    }

    static mapping = {
        id generator: 'sequence', params:[sequence:'user_preference_seq']
    }
}
