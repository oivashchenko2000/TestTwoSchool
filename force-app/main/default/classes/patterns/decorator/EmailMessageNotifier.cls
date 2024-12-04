public with sharing class EmailMessageNotifier implements INotifier {
    public void send(String message) {
        System.debug('Sending email: ' + message);
    }
}