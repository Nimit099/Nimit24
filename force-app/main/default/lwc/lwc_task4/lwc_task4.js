import { LightningElement,wire } from 'lwc';
import getAccountList from '@salesforce/apex/Accounthandler.accounts';
import sendemail from '@salesforce/apex/Accounthandler.sendEmail';
import getContactList from '@salesforce/apex/Contacthandler.contacts';
import getLeadList from '@salesforce/apex/Contacthandler.leads';
import Id from '@salesforce/user/Id';
import EMAIL_FIELD from '@salesforce/schema/User.Email';
import { getRecord } from 'lightning/uiRecordApi';

export default class Lwc_task4 extends LightningElement {

// for columns ---------------------------------
    column = [];
    conColumn = [
        { label: 'FirstName', fieldName: 'firstName'},
        { label: 'Lastname', fieldName: 'lastName'},
        { label: 'Email', fieldName: 'email'}
    ];
     accColumn = [
        { label: 'Name', fieldName: 'name'},
        { label: 'Email', fieldName:'email'}
    ];
    option = [
         { label: 'Account', value: 'Account' }, 
         { label: 'Contact', value: 'Contact' },
         { label: 'Lead', value: 'Lead' },
     ];
// ==========================================================

// to get record list ---------------------------------------
    accounts = [];
    contacts =[];
    leads = [];
// ==========================================================

// for email data -------------------------------------------
    subject;
    body;
// ==========================================================

// for showing data table ----------- 
    first = true;
    second = false;
    third = false;
    trueacc = false;
    truecon = false;
    truelead = false;
    fourth = false;
// ============================ 

// for selected object --------------------------------------
    value;
// ==========================================================

//  for selected record -------------------------------------
    emails=[];
// ==========================================================

// user email -----------------------------------------------
    email;

    @wire(getRecord, { recordId: Id, fields: [EMAIL_FIELD]}) 
    userDetails({error, data}) {
        if (data) {
            this.email = data.fields.Email.value;
        } else if (error) {
        }
    }
// ==========================================================
    
    selectobject(event){
        this.value = event.detail.value;

        if(event.detail.value == 'Account'){
            getAccountList().then(response=>{
                for(let i = 0; i < response.length; i++){
                    this.accounts.push({ name:response[i].Name, email:response[i].Email__c});   
                    this.column = this.accColumn;
                    this.truecon = false;
                    this.truelead = false;
                    this.trueacc = true;
                }
            })

                
            }
            else if(event.detail.value == 'Contact'){

                getContactList().then(response=>{
                    for(let i = 0; i < response.length; i++){
                        this.contacts.push({ firstName:response[i].FirstName, lastName:response[i].LastName, email:response[i].Email})   
                        this.column = this.conColumn;
                        this.trueacc = false;
                        this.truelead = false;
                        this.truecon = true;
                    }
                })

                
            }
            else if(event.detail.value == 'Lead'){
                getLeadList().then(response=>{
                    for(let i = 0; i < response.length; i++){
                        this.leads.push({ firstName:response[i].FirstName, lastName:response[i].LastName, email:response[i].Email})   
                    }
                    this.column = this.conColumn;
                    this.trueacc = false;
                    this.truecon = false;
                    this.truelead = true;
                })
            

            }
    }


    subjects(event){
        this.subject = event.target.value;
    }


    bodies(event){
        this.body = event.target.value;
    }


    select(event){
        this.emails = [];
            for(let i = 0; i < event.detail.selectedRows.length; i++){
                if(event.detail.selectedRows[i].email !== undefined){
                this.emails.push(event.detail.selectedRows[i].email);
                }
            }
    }


    next(){
        if(this.first == true){
            this.first = false;
            this.second = true;
        }
        else if(this.second == true){
            this.second = false
            this.third = true;
        }
        else if(this.third == true){
            sendemail({email:this.emails, Subject:this.subject, Mail:this.body}).then(response =>{
                this.third = false;
                this.fourth = true;
            })
        }
    }


    previous(){
        if(this.third == true){
            this.third = false;
            this.second = true;
        }
        else if(this.second == true){
            this.second = false
            this.first = true;
        }
        else if(this.first == true){
        }
    }
}