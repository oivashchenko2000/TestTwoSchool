public abstract with sharing class NotifierDecorator implements INotifier {
    protected INotifier wrapper;

    public NotifierDecorator(INotifier notifier) {
        this.wrapper = notifier;
    }

    public virtual void send(String message) {
        wrapper.send(message);
    }
}