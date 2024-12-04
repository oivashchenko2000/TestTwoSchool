public with sharing class ActivityReport extends ReportGenerator {
    protected override String createBody() {
        return 'Activity Data...';
    }

    protected override String createHeader() {
        return 'Activity Report Header\n';
    }
}