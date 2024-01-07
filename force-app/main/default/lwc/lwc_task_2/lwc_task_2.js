import { LightningElement,api } from 'lwc';
import uploadFile from '@salesforce/apex/lwc_task2.uploadFile'
// import upload from '@salesforce/apex/lwc_task2.upload'

import first from '@salesforce/apex/lwc_task2.first'

export default class Lwc_task_2 extends LightningElement {

    @api recordId;
    @api docid;
    @api cvid;
    @api photos;
    @api count;
    @api number;
    @api photo;
    fileData;
    filename;
    base64;

    connectedCallback(){
        first({Recordid:this.recordId}).then(response =>{

            if(response !== null){
            this.count = response.length;
            this.number = 0;
            this.photo = [];
            
            for(let i = 0; i < response.length; i++){
                this.photo.push({Id:'/sfc/servlet.shepherd/version/download/'+response[i].Id});
            }
            this.photos = this.photo[0].Id;
        }
        })
    }


    // upload(event){
    //     this.count = response.length;
    //     this.number = 0;
    //     const file = event.detail.files[0];
    //     this.docid = file.documentId;
    //     upload({Recordid:this.recordId, docid:this.docid}).then(response =>{
    //         this.photo = [];
            
    //         for(let i = 0; i<response.length; i++){
    //             this.photo.push({Id:'/sfc/servlet.shepherd/version/download/'+response[i].Id});
    //         }
    //         this.photos = this.photo[0].Id;
    //     })
    // }

    uploadFile(event){
        const file = event.target.files[0]
        var reader = new FileReader()
        reader.onload =() =>{
            var base64 = reader.result.split(',')[1]
            this.filename = file.name;
            this.base64 = base64;
            uploadFile({ base64:this.base64, filename:this.filename, recordId:this.recordId }).then(response=>{
                this.photo = [];
                this.count = response.length;
                this.number = 0;
                for(let i = 0; i<response.length; i++){
                    this.photo.push({Id:'/sfc/servlet.shepherd/version/download/'+response[i].Id});
                }
                this.photos = this.photo[0].Id;
               
            })
        }
        reader.readAsDataURL(file);
    }

    previous(){
        if(this.number > 0){
            this.number -= 1;
            this.photos = this.photo[this.number].Id;
        }
        else{}
    }


    next(){
        if(this.number < (this.count-1)){
            this.number += 1;
            this.photos = this.photo[this.number].Id;
        }
        else{}
    }
}