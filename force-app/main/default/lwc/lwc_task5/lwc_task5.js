import { LightningElement } from 'lwc';
import listrecord from '@salesforce/apex/Accounthandler.sosl';

export default class Lwc_task5 extends LightningElement {

// for input -------------------- 
    object = [];
    searchkeyword;
// ===================================

// for output data ----------
    accdata;
    condata;
    oppdata;
    leaddata;
// =============================

// for showing data table -----------------
    accounttrue = false;
    contacttrue = false;
    opportunitytrue = false;
    leadtrue = false;
// ============================== 

// for column ----------------------
    column = [
        { label:'Id', fieldName: 'Id' },
        { label:'Name', fieldName: 'Name' },
    ];
    column2 = [
        { label:'Id', fieldName: 'Id' },
        { label:'FirstName', fieldName: 'FirstName' }
    ];
    options =[
            { label: 'Account', value:'Account'},
            { label: 'Contact', value:'Contact'},
            { label: 'Opportunity', value:'Opportunity'},
            { label: 'Lead', value:'Lead'}
        ];
// ====================================================

    Account = 'Accounts';
    Contacts = 'Contacts';
    Opportunity = 'Opportunity';
    Lead = 'Leads';

    keyword(event){
        this.searchkeyword = event.target.value;
    }

    objecttype(event){
        this.object = event.detail.value;
    }


    search(event){
        this.accounttrue = false;
        this.contacttrue = false;
        this.opportunitytrue = false;
        this.leadtrue = false;
        this.condata = '';
        this.oppdata = '';
        this.leaddata = '';
        this.accdata = '';

        if(this.searchkeyword !== undefined){
            listrecord({obj:this.object, keyword:this.searchkeyword}).then(response=>{
            
                for(let i = 0; i < this.object.length; i++){
                    if(this.object[i] == 'Account'){
                        if(response[i].length>0){
                        this.Account = 'Accounts';
                        this.accounttrue = true;
                        this.accdata = response[i];
                        }
                        else{
                            this.accounttrue = true;
                            this.Account = 'There is no such records in Account';
                        }
                    }
                    else if(this.object[i] == 'Contact'){
                        if(response[i].length > 0){
                        this.Contacts = 'Contacts';
                        this.condata = response[i];
                        this.contacttrue = true;
                    }
                    else{
                        this.contacttrue = true;
                        this.Contacts = 'There is no such records in Contacts';
                    }
                
                }
                    else if(this.object[i] == 'Opportunity'){
                        if(response[i].length > 0){
                        this.Opportunity = 'Opportunities';
                        this.oppdata = response[i];
                        this.opportunitytrue = true;
                        }
                        else{
                            this.opportunitytrue = true;
                            this.Opportunity = 'There is no such records in Opportunity';
                        }
                    }
                    else if(this.object[i] == 'Lead'){
                        if(response[i].length > 0){
                        this.Lead = 'Leads';
                        this.leaddata = response[i];
                        this.leadtrue = true;
                        }
                        else{
                            this.leadtrue = true;
                            this.Lead = 'There is no such records in Lead';
                        }
                    }
                }
            }) 
        }
    }
}