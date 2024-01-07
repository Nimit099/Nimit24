import { LightningElement, api } from 'lwc';
import auth from '@salesforce/apex/integration_task_2.methodName';


export default class Integration_task_2 extends LightningElement {
    @api
    myRecordId;

    get acceptedFormats() {
        return ['.pdf', '.png'];
    }

    connectedCallback(){
        auth().then(response=>{
           console.log(response);
    })
    }

    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        alert('No. of files uploaded : ' + uploadedFiles.length);
    }

    createfolder(event){

    }
    createfile(event){

    }
}