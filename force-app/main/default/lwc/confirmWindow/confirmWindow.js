import { LightningElement, api } from 'lwc';

export default class ConfirmWindow extends LightningElement {
	@api message;

	close() {
		this.dispatchEvent(new CustomEvent("close"));
	}

	performAction() {
		this.dispatchEvent(new CustomEvent("perform"));
	}
}