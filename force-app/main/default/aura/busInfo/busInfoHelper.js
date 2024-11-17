({
	fetchTable : function(component, event, helper) {
		const action = component.get("c.getBuses");
		action.setParams({ recordId: component.get("v.recordId") });
		action.setCallback(this, function(response) {

			if (response.getState() === 'SUCCESS') {
				component.set("v.buses", response.getReturnValue());
			} else {
				this.showError(response.getError());
			}
		});
		$A.enqueueAction(action);
	},

	showError: function(errors) {
		let toastParams = {
			title: 'Error',
			message: 'Data error',
			type: 'error'
		};

		if (errors && Array.isArray(errors) && errors.length > 0) {
			toastParams.message = errors[0].message;
		}
		let toastEvent = $A.get("e.force:showToast");
		toastEvent.setParams(toastParams);
		toastEvent.fire();
	}
})