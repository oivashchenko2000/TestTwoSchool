public with sharing abstract class ReportGenerator {

    public String generateReport() {
        String header = createHeader();
        String body = createBody();
        String footer = createFooter();

        if (includePageNumbers()) {
            addPageNumbers();
        }

        return formatReport(header, body, footer);
    }

    protected abstract String createBody();

    protected virtual String createHeader() {
        return 'Standard Report Header\n';
    }

    protected  String createFooter() {
        return '\nStandard Report Footer';
    }

    protected virtual Boolean includePageNumbers() {
        return false;
    }

    private void addPageNumbers() {

    }

    private String formatReport(String header, String body, String footer) {
        return header + body + footer;
    }
}