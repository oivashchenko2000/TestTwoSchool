import { LightningElement, wire, api } from 'lwc';
import getUserInfo from '@salesforce/apex/bikeSection.getUserDetails';

export default class bikeSection extends LightningElement {
    @wire(getUserInfo)  userData;

    onEmailAction(){
        debugger;
        this.userData;
        debugger;
    }
}