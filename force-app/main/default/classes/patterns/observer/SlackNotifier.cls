public with sharing class SlackNotifier implements IEventObserver {
    public void handleEvent(EventData eventData) {
        System.debug('Sending Slack message for event: ' + eventData.eventType);
    }
}