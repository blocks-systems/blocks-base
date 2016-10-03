/**
 *
 */
package blocks.signature.listeners

import blocks.DomainCounter
import blocks.signature.exceptions.SignatureException
import org.apache.commons.logging.LogFactory
import org.grails.datastore.mapping.core.Datastore
import org.grails.datastore.mapping.engine.event.AbstractPersistenceEvent
import org.grails.datastore.mapping.engine.event.AbstractPersistenceEventListener
import org.grails.datastore.mapping.engine.event.PreInsertEvent
import org.grails.datastore.mapping.reflect.ClassPropertyFetcher
import org.springframework.context.ApplicationEvent

/**
 * @author emil.wesolowski
 *
 */
class SignatureListener extends AbstractPersistenceEventListener {
    def counterService

    private static final log = LogFactory.getLog(this)

    public static final String SIGNATUREABLE_PROPERTY_NAME = "signatureable";

    public SignatureListener(final Datastore datastore) {
        super (datastore)
    }

    @Override
    public boolean supportsEventType(Class<? extends ApplicationEvent> eventType) {
        return eventType.isAssignableFrom(PreInsertEvent)
    }

    @Override
    protected void onPersistenceEvent(AbstractPersistenceEvent event) {
        def signatureConfig = ClassPropertyFetcher.forClass(event.entityObject.class).getPropertyValue(SIGNATUREABLE_PROPERTY_NAME) as Map
        if (signatureConfig != null && signatureConfig instanceof Map && !signatureConfig.empty) {
            try {
                log.trace(String.format("Generating signature for class: %s with params: %s", event.entityObject.class.simpleName, signatureConfig))

                def fieldName = signatureConfig.field
                if (!fieldName) {
                    throw new SignatureException("Invalid config, field property must be defined!")
                }

                def symbol = signatureConfig.symbol
                if (!symbol) {
                    throw new SignatureException("Invalid config, symbol property must be defined!")
                }

                def objectName = signatureConfig.objectName
                if (!objectName) {
                    objectName = event.entityObject.class.simpleName
                }

                def year = null
                if (signatureConfig.year) {
                    year = Calendar.getInstance().get(Calendar.YEAR)
                }

                def month = null
                if (signatureConfig.month) {
                    month = Calendar.getInstance().get(Calendar.MONTH)
                }

                def separator = '/'
                if (signatureConfig.separator) {
                    separator = signatureConfig.separator
                }

                final Long actualNumber = counterService.getActualNumber(objectName, symbol, year, month)

                final StringBuilder sb = new StringBuilder()
                if (!signatureConfig.affix || DomainCounter.PREFIX.equals(signatureConfig.affix)){
                    sb.append(symbol)
                    sb.append(separator)
                }
                sb.append(actualNumber)
                sb.append(separator)
                if (year) {
                    sb.append(year)
                }
                if (month) {
                    sb.append(separator)
                    sb.append(month)
                }
                if (DomainCounter.POSTFIX.equals(signatureConfig.affix)) {
                    sb.append(separator)
                    sb.append(symbol)
                }

                log.trace(String.format("Generated signature: %s for class: %s", sb.toString(), event.entityObject.class.simpleName))
                event.entityObject."$fieldName" = sb.toString()
            } catch (final SignatureException ex) {
                log.error("Generating signature threw this exception: ", ex)
            } catch (final Exception ex) {
                log.error(ex.getMessage(), ex)
            }
        }
    }

}
