import { api,wire, LightningElement } from 'lwc';
import transfer from '@salesforce/apex/ft.Transfer'
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import Email__c from "@salesforce/schema/Person__c.Email__c";


const fields = [Email__c];
export default class Ft_buttons extends LightningElement {

    @wire(getRecord, {
        recordId: "$recordId",
        fields
      })
      person;

      get email() {
        return getFieldValue(this.person.data, Email__c);
      }
    
    isShowModal =false;
    isShowModalemail = false;
    subject = 'Your weekly Report';
    mail;
    value = 'None';
    amount;
    p1;
    p2;
    fromacc;
    toacc;
    c;
    credit;

    @api
    recordId;

    get options() {
        return [
            { label: 'SBI', value: 'SBI' },
            { label: 'BOB', value: 'BOB' },
            { label: 'HDFC', value: 'HDFC' },
            { label: 'KALUPUR', value: 'KALUPUR' },
        ];
    }
    
    showModalBox(event) {  
        if(event.target.label == 'Transfer'){
        this.isShowModal = true;
        }
        else if(event.target.label == 'Email'){
            this.isShowModalemail = true;
        }
    }
    hideModalBox() {  
        this.isShowModal = false;
        this.isShowModalemail = false;
    }

    person1(event){
        this.p1 = event.target.value;
        console.log(this.p1);
    }

    person2(event){
        this.p2 = event.target.value;
        console.log(this.p2);
    }

    check(event){
      this.c = event.target.label;
    }

    creditm(event){
        this.credit = event.target.label;
    }

    amountm(event){
        this.amount = event.target.value;
        console.log(this.amount);
    }

    fromaccm(event){
        this.fromacc = event.target.value;
    }

    toaccm(event){
        this.toacc = event.target.value;
    }

    save(){
        transfer({amount: this.amount,p1:this.p1, p2:this.p2, check:this.c, credit:this.credit, fromacc:this.fromacc, toacc:this.toacc}).then(response =>{
            this.isShowModal = false;
        })
    }

    subjectm(event){
        this.subject = event.target.value;
    }

    mailm(event){
        this.mail = event.target.value;

    }
}