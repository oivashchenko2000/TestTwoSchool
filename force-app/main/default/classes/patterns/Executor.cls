public with sharing class Executor {

    public static void runSingleton() {
        Singleton.getInstance().writeText();
    }

    public static void runFactory(String carName) {
        Car newCar = CarFactory.createCar(carName);
        newCar.runEngine();
    }

    public static void runStrategy() {
        List<Account> accounts = [SELECT Id, Name FROM Account LIMIT 10];
        DataExporter exporter = new DataExporter(new XMLExport());
        exporter.exportData(accounts);
    }

    public static void runObserver() {
        EventPublisher publisher = new EventPublisher();
        publisher.subscribe('AccountCreated', new EmailNotifier());
        publisher.subscribe('AccountCreated', new SlackNotifier());

        publisher.publish('AccountCreated', new Account(Name = 'Test Account'));
    }

    public static void runBuilder() {
        Account acc = new Account_Builder()
                .withName('Test Name')
                .withPhone('1234567890')
                .withType('Customer')
                .build();

        System.debug(JSON.serializePretty(acc));
    }

    public static void runDecorator() {
        INotifier notifier = new SlackDecorator(
            new SMSDecorator(
                new EmailMessageNotifier()
            )
        );

        notifier.send('Kurva bober I perdoly sho za shtuka');
    }

    public static void runChainOfResponsibility() {
        Validator requiredFields = new RequiredFieldsValidator();
        Validator duplicateCheck = new DuplicateValidator();

        requiredFields.setNext(duplicateCheck);

        Account acc = new Account();
        ValidationContext context = new ValidationContext(acc);
        requiredFields.validate(context);
    }

    public static void runTemplate() {
        ReportGenerator activityReport = new ActivityReport();
        activityReport.generateReport();
    }
}