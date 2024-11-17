({
    doInit : function(component, event, helper) {
        var action = component.get("c.getAccounts");
        action.setCallback(this,function(response){   
        
            var state = response.getState();
            if(state === "SUCCESS"){
                var records = response.getReturnValue();
                var newItems=[];
                for (var i=0; i< records.length; i++)
                {
                    var record = records[i];
                    var Item = {title: record.Name, id: record.Id, status: "Unassigned"};
                    newItems.push(Item);
                }
                component.set("v.allItems", newItems);
            }
        });
        $A.enqueueAction(action);
    }
})