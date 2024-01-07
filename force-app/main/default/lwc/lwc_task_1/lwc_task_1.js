import { LightningElement,api } from 'lwc';

export default class Lwc_task_1 extends LightningElement {
    @api cvId;
    @api imagename;

    get acceptedFormats(){
        return['.jpg','.png'];
    }

    handleUploadFinished(event){
        const file =  event.detail.files[0];
        this.cvId = '/sfc/servlet.shepherd/version/download/'+file.contentVersionId;
        this.imagename = file.name;
    }
    
}