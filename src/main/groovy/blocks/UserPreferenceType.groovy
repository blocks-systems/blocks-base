package blocks

enum UserPreferenceType {
    LIST("List"),
    MAP("Map"),
    JSON("Json"),
    XML("Xml"),
    STRING("String"),
    INT("Int"),
    DOUBLE("Double"),
    UNDEFINED("Undefined")

    String value

    UserPreferenceType(String value) {
        this.value = value
    }

    String toString() { value }
    String getKey() { name()}
}