const axios = require('axios');

class SalesforceBulkAPI2 {
	constructor(instanceUrl, accessToken) {
		this.instanceUrl = instanceUrl;
		this.accessToken = accessToken;
	}

	// Create a query job
	async createQueryJob(query) {
		const endpoint = `${this.instanceUrl}/services/data/v57.0/jobs/query`;

		try {
			const response = await axios.post(endpoint, {
				operation: 'query',
				query: query,
				contentType: 'CSV'
			}, {
				headers: {
					'Authorization': `Bearer ${this.accessToken}`,
					'Content-Type': 'application/json'
				}
			});

			return response.data.id;
		} catch (error) {
			console.error('Error creating query job:', error.response?.data || error.message);
			throw error;
		}
	}

	// Get job status
	async getJobStatus(jobId) {
		const endpoint = `${this.instanceUrl}/services/data/v57.0/jobs/query/${jobId}`;

		try {
			const response = await axios.get(endpoint, {
				headers: {
					'Authorization': `Bearer ${this.accessToken}`
				}
			});

			return response.data;
		} catch (error) {
			console.error('Error checking job status:', error.response?.data || error.message);
			throw error;
		}
	}

	// Get query results
	async getQueryResults(jobId) {
		const endpoint = `${this.instanceUrl}/services/data/v57.0/jobs/query/${jobId}/results`;

		try {
			const response = await axios.get(endpoint, {
				headers: {
					'Authorization': `Bearer ${this.accessToken}`
				}
			});

			return response.data;
		} catch (error) {
			console.error('Error getting query results:', error.response?.data || error.message);
			throw error;
		}
	}
}

const bulkQuery = async () => {
	const bulk = new SalesforceBulkAPI2(
		'https://oivashchenko-ascendix-20-dev-ed.my.salesforce.com',
		'00D3X000004XgRc!AQQAQKXfQUq1Oi.YTxacnfBaSTjoyNVww6Ot63Yi0ZCJ9e7ZMXeF7ijXVUNYcesYrCTkKD1t0yKSqZSTolbgQ5OPck9pUCLf'
	);

	try {
		// Define your query
		const query = 'SELECT Id, Name, Industry FROM Account WHERE CreatedDate = TODAY';

		// Create query job
		console.log('Creating query job...');
		const jobId = await bulk.createQueryJob(query);
		console.log('Job created:', jobId);

		// Poll for job completion
		let jobComplete = false;
		while (!jobComplete) {
			const jobStatus = await bulk.getJobStatus(jobId);
			console.log('Job status:', jobStatus.state);

			if (jobStatus.state === 'JobComplete') {
				jobComplete = true;
			} else if (jobStatus.state === 'Failed') {
				throw new Error('Job failed: ' + jobStatus.errorMessage);
			} else {
				// Wait 5 seconds before next check
				await new Promise(resolve => setTimeout(resolve, 5000));
			}
		}

		// Get results
		console.log('Getting query results...');
		const results = await bulk.getQueryResults(jobId);
		console.log('Query Results:', results);

		return results;

	} catch (error) {
		console.error('Error in bulk query:', error);
		throw error;
	}
};

bulkQuery()
	.then(results => console.log('Query completed successfully'))
	.catch(error => console.error('Query failed:', error));