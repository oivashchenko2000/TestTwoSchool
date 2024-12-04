public with sharing class Account_Builder {
    private Account account;

    public Account_Builder() {
        this.account = new Account();
    }

    public Account_Builder withName(String name) {
        this.account.Name = name;
        return this;
    }

    public Account_Builder withPhone(String phone) {
        this.account.Phone = phone;
        return this;
    }

    public Account_Builder withType(String type) {
        this.account.Type = type;
        return this;
    }

    public Account build() {
        return account;
    }
}