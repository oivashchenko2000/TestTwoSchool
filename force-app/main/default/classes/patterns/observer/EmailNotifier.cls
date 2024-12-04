public with sharing class EmailNotifier implements IEventObserver {
    public void handleEvent(EventData eventData) {
        System.debug('Sending email for event: ' + eventData.eventType);
    }
}