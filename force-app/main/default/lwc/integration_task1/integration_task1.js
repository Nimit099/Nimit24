import { LightningElement,wire,api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import sendemail from '@salesforce/apex/All_Task.sendemail';


const FIELDS = [
    'Contact.Name',
    'Contact.Email',
];

export default class Integration_task1 extends LightningElement {
    @api recordId;
    popup = false;
    subject;
    body;
    filename = '';
    cv;

    handleUploadFinished(event){
        this.filename = event.detail.files[0].name;
        this.cv = event.detail.files[0].contentVersionId;
    }

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    contact;

    get email() {
        return this.contact.data.fields.Email.value;
    }

    showpopup() {  
        this.popup = true;
    }

    hidepopup() {  
        this.popup = false;
    }
    subjects(event){
        this.subject = event.target.value;
    }

    bodies(event){
        this.body = event.target.value;
    }

    sendemails(){
        sendemail({email:this.email, Subjects:this.subject, Mail:this.body, cvid:this.cv}).then(response=>{
                this.subject = '';
                this.body ='';
                this.popup = false;
        })
    }

}