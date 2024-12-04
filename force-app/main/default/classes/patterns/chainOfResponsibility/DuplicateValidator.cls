public with sharing class DuplicateValidator extends Validator {
    public override void validate(ValidationContext context) {
        Account acc = (Account)context.record;

        List<Account> duplicates = [
            SELECT Id
            FROM Account
            WHERE Name = :acc.Name
        ];

        if (!duplicates.isEmpty()) {
            context.errors.add('Duplicate account exists');
        }

        super.validate(context);
    }
}