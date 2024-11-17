import { LightningElement, track } from 'lwc';
import getAccountOwner from '@salesforce/apex/FindAccController.getAccountOwner'
export default class EventExample extends LightningElement {
    @track contacts;
    @track error;

    load(){
        getAccountOwner({"accountName":this.template.querySelector('lightning-input').value})
        .then(result=>{
            this.contacts=result;
            console.log(this.contacts);
        })
        .catch(error=>{
            this.error=error; 
        });
    }
}