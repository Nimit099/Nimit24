import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import Name_Field from "@salesforce/schema/Person__c.Name";

import component1 from '@salesforce/apex/ft.component1'
const fields = [Name_Field];


export default class Ft1 extends LightningElement {
    @api recordId;
    cash;
    bank;
    stock;
    creditcash;
    creditbank;
    creditstock;
    debitcash;
    debitbank;
    debitstock;

    @wire(getRecord, {
        recordId: "$recordId",
        fields
      })
      account;

    get Name() {
        return getFieldValue(this.account.data, Name_Field);
      }
      
    connectedCallback(){
        component1({RecordId: this.recordId}).then(response =>{
            this.cash = response[0];
            this.bank = response[1];
            this.stock = response[2];
            this.creditcash = response[3];
            this.creditbank = response[4];
            this.creditstock = response[5];
            this.debitcash = response[6];
            this.debitbank = response[7];
            this.debitstock = response[8];
        })
    }
}