import { LightningElement, api } from 'lwc';
import subscription from '@salesforce/apex/CPQ.subscription'

export default class CPQ_Button extends LightningElement {

    @api recordId
    text = 'Subscrition';
    create_subscription(){
        subscription({Recordid:this.recordId}).then(response =>{
            this.text = response;
        })
    }
}