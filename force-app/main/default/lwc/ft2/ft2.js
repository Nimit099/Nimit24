import { LightningElement,api } from 'lwc';
import component2 from '@salesforce/apex/ft.component2'


export default class Ft2 extends LightningElement {
    @api recordId;
    TotalAmount;
    Stock;
    Credit;
    Debit;

    connectedCallback(){
        component2({RecordId:this.recordId}).then(response =>{
            this.TotalAmount = response[0];
            this.Stock = response[1];
            this.Credit = response[2];
            this.Debit = response[3];
        })
    }

}