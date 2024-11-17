import { LightningElement, track, api } from 'lwc';

export default class IframeExample extends LightningElement {
	@api iframeUrl;
	@track isLoading = true;
	@track hasError = false;
	@track errorMessage = '';

	connectedCallback() {
		window.addEventListener('message', this.handleMessage.bind(this));
	}

	disconnectedCallback() {
		window.removeEventListener('message', this.handleMessage.bind(this));
	}

	handleIframeLoad(event) {
		this.isLoading = false;
		console.log('Iframe loaded successfully');

		try {
			const iframe = event.target;

			console.log('Iframe URL:', iframe.src);

		} catch (error) {
			this.handleError(error);
		}
	}

	handleIframeError(event) {
		this.isLoading = false;
		this.hasError = true;
		this.errorMessage = 'Failed to load Wikipedia page. Please try again later.';
		console.error('Iframe loading error:', event);

	}

	handleMessage(event) {
		try {
			const message = event.data;
			console.log('Received message from iframe:', JSON.stringify(message));
		} catch (error) {
			console.error('Error handling iframe message:', error);
		}
	}

	handleError(error) {
		this.hasError = true;
		this.errorMessage = error.message || 'An unexpected error occurred';
		console.error('Error:', error);
	}
}