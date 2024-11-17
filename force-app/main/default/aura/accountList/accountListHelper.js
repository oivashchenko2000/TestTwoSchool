({
	loadAccounts : function(component) {
		component.set('v.isLoading', true);

		let action = component.get('c.getAccounts');

		action.setCallback(this, function(response) {
			let state = response.getState();
			if (state === 'SUCCESS') {
				component.set('v.accounts', response.getReturnValue());
			} else {
				console.error('Error loading accounts');
			}
			component.set('v.isLoading', false);
		});

		$A.enqueueAction(action);
	}
});