package blocks

class Owner {

    String code
    String name

    static searchable = {
        root false
    }


    static constraints = {
        code nullable: false
        name nullable: false
    }
}
