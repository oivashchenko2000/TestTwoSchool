public with sharing class DataExporter {
    private IExportStrategy exportStrategy;

    public DataExporter(IExportStrategy iExportStrategy) {
        this.exportStrategy = iExportStrategy;
    }

    public void exportData(List<SObject> records ) {
        exportStrategy.exportData(records);
    }
}