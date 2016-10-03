package blocks

class DomainCounter extends BaseEntity {

    static auditable = false

    public static final Integer PREFIX = 1
    public static final Integer POSTFIX = 2

    String objectName
    String symbol
    String seqName
    Integer month
    Integer year

    static constraints = {
        objectName blank: false
        symbol blank: true, nullable: true
        seqName blank: false
        month nullable: true
        year nullable: true
    }

    static mapping = {
        id generator: 'sequence', params:[sequence:'counter_seq']
    }
}
