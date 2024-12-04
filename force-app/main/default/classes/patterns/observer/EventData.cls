public with sharing class EventData {
    public String eventType { get; set; }
    public Object payload { get; set; }

    public EventData(String eventType, Object payload) {
        this.eventType = eventType;
        this.payload = payload;
    }
}