import { LightningElement,api } from 'lwc';
import allTransaction from '@salesforce/apex/ft.allTransaction'
import UserPreferencesTaskRemindersCheckboxDefault from '@salesforce/schema/User.UserPreferencesTaskRemindersCheckboxDefault';


export default class Ft3 extends LightningElement {
    @api recordId;
    data;
    columns = [
        { label: 'Id', fieldName: 'Name' },
        { label: 'Amount', fieldName: 'Amount__c'},
        { label: 'Date', fieldName: 'Date__c'},
        { label: 'Credit', fieldName: 'Credit__c'},
        { label: 'Debit', fieldName: 'Debit__c' },
        { label: 'Tansaction Method', fieldName: 'Transaction_method__c'},
    ];
    connectedCallback(){
        allTransaction({RecordId:this.recordId}).then(response =>{
            this.data = response;
        })
    }
}