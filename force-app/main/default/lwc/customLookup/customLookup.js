import { LightningElement, api, track } from 'lwc';

export default class CustomLookup extends LightningElement {
	@api lines;
	@api selectedLine = {};
	@track boxClass = "slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus";
	@track searchItem;

	@api
	handleRemovePill() {
		this.selectedLine = {};
	}

	handleClick() {
		this.boxClass = "slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus slds-is-open";
	}

	onBlur() {
		setTimeout(() => { this.boxClass = "slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus" }, 300);
	}

	onSelect(event) {
		this.selectedLine.id = event.currentTarget.dataset.id;
		this.selectedLine.name = event.currentTarget.dataset.name;
		this.boxClass = "slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus";
	}

	onChange(event) {
		this.searchItem = event.target.value;
	}

	get currentLines() {
		if (!this.searchItem) { return this.lines; }
		return this.lines.filter(line => {
			return line.label.toUpperCase().includes(this.searchItem.toUpperCase());
		});
	}
}