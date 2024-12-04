public with sharing class SlackDecorator extends NotifierDecorator {
    public SlackDecorator(INotifier notifier) {
        super(notifier);
    }

    public override void send(String message) {
        super.send(message);
        sendSlackMessage(message);
    }

    private void sendSlackMessage(String message) {
        System.debug('Sending Slack message: ' + message);
    }
}