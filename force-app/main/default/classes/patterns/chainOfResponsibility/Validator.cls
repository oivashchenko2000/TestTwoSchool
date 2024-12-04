public with sharing abstract class Validator {
    protected Validator nextValidator;

    public void setNext(Validator validator) {
        this.nextValidator = validator;
    }

    public virtual void validate(ValidationContext context) {
        if (nextValidator != null) {
            nextValidator.validate(context);
        }
    }
}