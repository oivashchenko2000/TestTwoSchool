public with sharing class CSVExport implements IExportStrategy {
    public void exportData(List<SObject> records) {
        System.debug('Run CSV Export');
    }
}