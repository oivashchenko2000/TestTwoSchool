import { LightningElement, track } from 'lwc';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';

export default class AccountUpdatesSubscriber extends LightningElement {
	@track receivedMessages = [];
	channelName = '/topic/AccountUpdates';
	subscription = {};

	connectedCallback() {
		this.registerErrorListener();
		this.handleSubscribe();
	}

	handleSubscribe() {
		const messageCallback = (response) => {
			console.log('New message received: ', JSON.stringify(response));

			this.receivedMessages.push({
				time: new Date().toLocaleTimeString(),
				id: response.data.event.replayId,
				message: JSON.stringify(response.data)
			});
		};


		subscribe(this.channelName, -1, messageCallback).then(response => {
			console.log('Subscription request sent to: ', JSON.stringify(response.channel));
			this.subscription = response;
		});
	}

	handleUnsubscribe() {
		unsubscribe(this.subscription, response => {
			console.log('unsubscribed from channel: ', response.channel);
		});
	}

	registerErrorListener() {
		onError(error => {
			console.log('Received error from server: ', JSON.stringify(error));
		});
	}

	disconnectedCallback() {
		this.handleUnsubscribe();
	}
}