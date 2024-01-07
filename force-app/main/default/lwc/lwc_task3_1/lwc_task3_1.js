import { LightningElement, wire } from 'lwc';
import getAccountList from '@salesforce/apex/Accounthandler.accounts';
import { publish,MessageContext } from 'lightning/messageService';
import messenger from '@salesforce/messageChannel/message__c';

export default class Lwc_task3_1 extends LightningElement {
    @wire(getAccountList) accounts;
    @wire(MessageContext) accountid;

    select(event){
        var acc = { AccountId:event.detail.value}
        publish(this.accountid,messenger,acc);
    }
}