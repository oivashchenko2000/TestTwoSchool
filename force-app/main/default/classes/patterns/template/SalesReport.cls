public with sharing class SalesReport extends ReportGenerator {
    protected override String createBody() {
        return 'Sales Data...';
    }

    protected override Boolean includePageNumbers() {
        return true;
    }
}