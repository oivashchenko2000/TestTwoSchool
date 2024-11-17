import { LightningElement, api, track } from "lwc";
import getLines from "@salesforce/apex/BusLineManagementController.getLinesInfo";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import deleteBusLine from "@salesforce/apex/BusLineManagementController.deleteBusLine";
import getAllLines from "@salesforce/apex/BusLineManagementController.getAllLines";
import addNewBusLine from "@salesforce/apex/BusLineManagementController.addNewBusLine";

export default class BusLineManagement extends LightningElement {
	@api recordId;
	@track visible = false;
	@track showSpinner = true;
	@track emptyMessage = "No data found...";
	@track allLines;
	@track lines = [];
	@track columns = [
		{ label: "Name", fieldName: "lineName" },
		{ label: "LastModifiDate", fieldName: "lastModifiedDate" },
		{
			label: "Delete Line",
			type: "button",
			typeAttributes: {
				disabled: false,
				title: "delete",
				iconPosition: "center",
				iconName: "utility:delete"
			}
		}
	];
	@track confirmModalAction = {};

	closeQuickAction() {
		this.dispatchEvent(new CustomEvent("close"));
	}

	closeConfirmModal() {
		this.confirmModalAction.isOpen = false;
		this.confirmModalAction = {};
	}

	openConfirmModal(event) {
		if (event.target.label === "Add") {
			this.confirmModalAction.message = "Do you really want to add this Route ?";
			this.confirmModalAction.lineId = this.template.querySelector("c-custom-lookup").selectedLine.id;
			this.confirmModalAction.actionName = "Insert";
		} else {
			this.confirmModalAction.busLineId = event.detail.row.id;
			this.confirmModalAction.message = "Do you really want to delete this Route ?";
			this.confirmModalAction.actionName = "Delete";
		}
		this.confirmModalAction.isOpen = true;
	}

	performAction() {
		if (this.confirmModalAction.actionName === "Insert") {
			this.insertBusLine(this.confirmModalAction.lineId);
			this.template.querySelector("c-custom-lookup").handleRemovePill();
		} else if (this.confirmModalAction.actionName === "Delete") {
			this.deleteLine(this.confirmModalAction.busLineId);
		}
		this.confirmModalAction.isOpen = false;
		this.confirmModalAction = {};
	}

	connectedCallback() {
		this.showSpinner = true;

		getLines({ busId: this.recordId })
			.then(result => {
				this.lines = result.map(busLine => {
					return {
						lineId: busLine.line.id,
						lineName: busLine.line.name,
						lastModifiedDate: busLine.lastModifiedDate,
						id: busLine.id
					};
				});
				this.showSpinner = false;
			})
			.catch(() => {
				this.dispatchEvent(
					new ShowToastEvent({
						title: "Something has gone wrong",
						message: "Error getting the lines",
						variant: "error"
					})
				);
				this.showSpinner = false;
			});
	}

	deleteLine(busLineId) {
		this.showSpinner = true;

		deleteBusLine({ busLineId })
			.then(() => {
				this.lines = this.lines.filter(line => line.id !== busLineId);
				this.dispatchEvent(
					new ShowToastEvent({
						title: "Success",
						message: "BusLine has been deleted",
						variant: "success"
					})
				);
				this.showSpinner = false;
			})
			.catch(() => {
				this.dispatchEvent(
					new ShowToastEvent({
					title: "Something has gone wrong",
					message: "Error deleting the line",
					variant: "error"
					})
				);
				this.showSpinner = false;
			});
	}

	changeVisible() {
		this.visible = !this.visible;

		if (!this.allLines) {
			getAllLines()
				.then(result => {
					this.allLines = result.map(line => {
						return {
							label: line.name,
							value: line.id
						};
					});
				})
				.catch(() => {
					this.dispatchEvent(
						new ShowToastEvent({
							title: "Something has gone wrong",
							message: "Error change value in combobox",
							variant: "error"
						})
					);
				});
		}
	}

	insertBusLine(lineId) {
		this.showSpinner = true;

		addNewBusLine({ busId: this.recordId, lineId })
			.then(result => {
				const lines = this.lines;
				lines.push({
					lineId: result.line.id,
					lineName: result.line.name,
					lastModifiedDate: result.lastModifiedDate,
					id: result.id
				});
				this.dispatchEvent(
					new ShowToastEvent({
						title: "Success",
						message: "BusLine has been inserted",
						variant: "success"
					})
				);

				this.lines = [ ... lines ];
				this.showSpinner = false;
			})
			.catch(() => {
				this.dispatchEvent(
					new ShowToastEvent({
						title: "Something has gone wrong",
						message: "Error adding a line",
						variant: "error"
					})
				);
				this.showSpinner = false;
			});
	}

	get options() {
		if (!this.allLines) { return; }
		return this.allLines.filter(availableLine => {
			return !this.lines.find(busLine => {
				return availableLine.value === busLine.lineId;
			});
		});
	}
}