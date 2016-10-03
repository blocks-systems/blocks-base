package blocks

import com.google.common.base.CaseFormat
import org.apache.commons.lang3.StringUtils
import org.apache.commons.logging.LogFactory
import org.hibernate.SQLQuery
import org.springframework.transaction.annotation.Transactional

@Transactional
class DomainCounterService {


    private static final LOG = LogFactory.getLog(this)

    private final static String separator = "_";
    private final static String sequencePrefix = "seq_";

    /**
     *
     * Metoda pobiera aktualny numer z sekwencji dla obiektu i symbolu
     * Zalozenie jest takie, ze jesli jest przekazany symbol musi byc przekazany rok
     * opcjonalnie moze byc przekazany rowniez miesiac
     */
    @Transactional(readOnly = false)
    public Long getActualNumber(String objectName, String symbol, Integer year, Integer month) {
        DomainCounter.withNewSession { session ->
            DomainCounter.withTransaction {
                LOG.debug(String.format("Pobranie aktualnego numeru dla obiektu: %s", objectName))
                DomainCounter counter
                if (StringUtils.isNotBlank(symbol)) {
                    symbol = symbol.toUpperCase()
                    if (month != null) {
                        counter = DomainCounter.findWhere(objectName: objectName, symbol: symbol, year: year, month: month)
                    } else {
                        counter = DomainCounter.findWhere(objectName: objectName, symbol: symbol, year: year)
                    }
                } else {
                    counter = DomainCounter.findWhere(objectName: objectName)
                }
                LOG.debug("Znaleziony counter: " + counter);
                if (counter == null) {
                    counter = new DomainCounter(objectName: objectName, symbol: symbol, year: year, month: month)

                    LOG.debug(String.format("Sekwencja dla: %s nie istnieje. Tworze obiekt", objectName))

                    final StringBuilder sb = new StringBuilder()
                    sb.append("CREATE SEQUENCE ")
                    sb.append(sequencePrefix)
                    final String objectPrefix = CaseFormat.LOWER_CAMEL.to(CaseFormat.LOWER_UNDERSCORE, objectName)
                    sb.append(objectPrefix)
                    if (symbol != null) {
                        sb.append(separator)
                        sb.append(symbol.toLowerCase())
                    }
                    if (year != null) {
                        sb.append(separator)
                        sb.append(year)
                    }
                    if (month != null) {
                        sb.append(separator)
                        sb.append(month)
                    }
                    sb.append(" START 1 INCREMENT BY 1")
                    final String seqName = buildSequenceName(objectName, symbol, year, month)
                    counter.seqName = seqName

                    // Zabezpieczenie przed tym, ze w tabeli nie istnieje wpis natomiast sekwencja juz istnieje
                    if (!checkSequenceExist(session, seqName)) {
                        LOG.debug(String.format("Sekwencja: %s nie istnieje", seqName))
                        LOG.debug(String.format("Zapytanie tworzace sekwencje: %s", sb.toString()))
                        final SQLQuery query = session.createSQLQuery(sb.toString())
                        query.executeUpdate()
                    }
                    counter.save(flush:true, failOnError:true)
                }

                String sql = "select nextval('" + counter.seqName + "')"
                final SQLQuery sqlQuery = session.createSQLQuery(sql)
                Long actualValue = ((BigDecimal) sqlQuery.uniqueResult()).longValue()

                LOG.debug(String.format("Aktualny numer dla %s to: %d", objectName, actualValue))
                return actualValue
            }
        }
    }

    /**
     * Budowaine nazwy sekwencji
     *
     * @param objectName
     * @param symbol
     * @return
     */
    private String buildSequenceName(String objectName, String symbol, Integer year, Integer month) {
        String seqName = new String()
        seqName += sequencePrefix

        final String objectPrefix = CaseFormat.LOWER_CAMEL.to(CaseFormat.LOWER_UNDERSCORE, objectName)
        seqName += objectPrefix

        if (symbol != null) {
            seqName += separator
            seqName += symbol.toLowerCase()
        }
        if (year != null) {
            seqName += separator
            seqName += year
        }
        if (month != null) {
            seqName += separator
            seqName += month
        }
        return seqName
    }

    /**
     * Sprawdzenie czy sekwencja istnieje
     *
     * @param seqName
     * @return
     */
    private boolean checkSequenceExist(def session, String seqName) {
        LOG.debug(String.format("Sprawdzam czy istnieje sekwencja: %s", seqName))
        final String sql = "SELECT COUNT(*) FROM pg_class WHERE relname = '" + seqName + "'"
        final SQLQuery sqlQuery = session.createSQLQuery(sql)
        if (((BigDecimal) sqlQuery.uniqueResult()).longValue() == 1) {
            LOG.debug(String.format("Sekwencja: %s istnieje", seqName))
            return true
        }
        return false
    }
}
