public with sharing class ValidationContext {
    public SObject record { get; set; }
    public List<String> errors { get; set; }

    public ValidationContext(SObject record) {
        this.record = record;
        this.errors = new List<String>();
    }
}