public with sharing class EventPublisher {
    private Map<String, List<IEventObserver>> observersByEventType;

    public EventPublisher() {
        this.observersByEventType = new Map<String, List<IEventObserver>>();
    }

    public void subscribe(String eventType, IEventObserver observer) {
        if (!observersByEventType.containsKey(eventType)) {
            observersByEventType.put(eventType, new List<IEventObserver>());
        }
        observersByEventType.get(eventType).add(observer);
    }

    public void publish(String eventType, Object payload) {
        EventData eventData = new EventData(eventType, payload);
        if (observersByEventType.containsKey(eventType)) {
            for (IEventObserver observer : observersByEventType.get(eventType)) {
                observer.handleEvent(eventData);
            }
        }
    }
}