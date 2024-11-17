trigger ChangeAvailable on SalePropety__c (before insert) {
	List<Property__c> propsUpdate = new List<Property__c>();
    
    for(SalePropety__c slProperty:Trigger.new){
        
       String propId=slProperty.Property__c;
        
        Property__c prop = new Property__c(Id = propId);
   		prop.Available__c = false;
  		propsUpdate.add(prop);
    }
    update propsUpdate;
}