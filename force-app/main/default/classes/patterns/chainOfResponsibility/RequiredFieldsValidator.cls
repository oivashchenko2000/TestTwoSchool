public with sharing class RequiredFieldsValidator extends Validator {
    public override void validate(ValidationContext context) {
        Account acc = (Account)context.record;

        if (String.isBlank(acc.Name)) {
            context.errors.add('Name is required');
        }

        super.validate(context);
    }
}