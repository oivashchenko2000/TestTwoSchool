public with sharing class PushTopicExample {

    public static void createPushTopic() {
        List<PushTopic> pts = [SELECT Id FROM PushTopic WHERE Name = 'AccountUpdates' LIMIT 10];

        if (!pts.isEmpty()) {
            delete pts;
        }

        PushTopic pushTopic = new PushTopic();
        pushTopic.Name = 'AccountUpdates';
        pushTopic.Query = 'SELECT Id, Name, Industry, Rating, Phone FROM Account WHERE Industry != null';
        pushTopic.ApiVersion = 54.0;
        pushTopic.NotifyForOperationCreate = true;
        pushTopic.NotifyForOperationUpdate = true;
        pushTopic.NotifyForOperationDelete = true;
        pushTopic.NotifyForOperationUndelete = true;
        pushTopic.NotifyForFields = 'Referenced'; // All, Referenced, Select, Where

        insert pushTopic;
    }
}