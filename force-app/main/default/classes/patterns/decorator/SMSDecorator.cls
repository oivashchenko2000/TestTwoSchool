public with sharing class SMSDecorator extends NotifierDecorator {
    public SMSDecorator(INotifier notifier) {
        super(notifier);
    }

    private void sendSMS(String message) {
        System.debug('Sending SMS: ' + message);
    }

    public override void send(String message) {
        super.send(message);
        sendSMS(message);
    }
}