import { LightningElement,wire} from 'lwc';
import getContactList from '@salesforce/apex/Contacthandler.contacts';
import getOpportunityList from '@salesforce/apex/Opportunityhandler.opportunity';
import {subscribe,MessageContext} from 'lightning/messageService';
import messenger from '@salesforce/messageChannel/message__c';


export default class Lwc_task3_2 extends LightningElement {

// for message -------------------------------------------
    subscribtion = null;
    @wire(MessageContext) accountid;
// =======================================================

// for outcome -------------------------------------------
    cons
    opps
// =======================================================

// To display -------------------------------------------- 
    contact = 'Contact'
    opportunity = 'Opportunity'
//  ======================================================

// for input ---------------------------------------------
    AccountId;
//  ======================================================

// To display column -------------------------------------

    contrue = false;
    opptrue = false;
    oppColumn = [
        { label: 'Id', fieldName: 'Id' },
        { label: 'Name', fieldName: 'Name'}
    ];
    
    conColumn = [
        { label: 'Id', fieldName: 'Id'},
        { label: 'FirstName', fieldName: 'FirstName'},
        { label: 'Lastname', fieldName: 'LastName'},
        { label: 'Email', fieldName: 'Email'}
    ];
//  ======================================================



    connectedCallback(){
        this.subscribeToMessageChannel();
    }
    subscribeToMessageChannel(){
        this.subscribtion = subscribe(
            this.accountid,
            messenger,
            (message) => this.setId(message.AccountId)
        );
    }
    setId(AccountId){
        this.AccountId = AccountId
            getContactList({AccountId:this.AccountId}).then(response=>{
                this.cons = response;
                    if(this.cons.length > 0){
                        this.contrue = true;
                        this.contact = 'Contact';
                    }
                    else{
                        this.contact = 'There is no Contact';
                        this.contrue = false;
                    }
                })

            getOpportunityList({AccountId:this.AccountId}).then(response=>{
                this.opps = response;      
                    if(this.opps.length>0){
                        this.opptrue = true;
                        this.opportunity = 'Opportunity';
                    }
                    else{
                        this.opptrue = false;
                        this.opportunity = 'There is no Opportunity';
                    }
                })
        }
}