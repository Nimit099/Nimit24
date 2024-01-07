// import { LightningElement,track} from 'lwc';
// import listrecord from '@salesforce/apex/obj.obj';
// import field from '@salesforce/apex/obj.fields';
// import save from '@salesforce/apex/obj.save';



// export default class Obj extends LightningElement {

//     list = [];
//     valu;
//     field = [];
//     value1;
//     value2;
//     value3;
//     f1;
//     f2;
//     f3;

//     connectedCallback(){
//         listrecord().then(response=>{
//             let lis = [];
//             for(let i = 0; i < response.length; i++){
//                 lis.push({label:response[i], value:response[i]});
//             }
//             this.list = lis;
//         })
//     }
//     handleChange(event) {
//         this.valu = event.detail.value;
//         field({oobject: this.valu}).then(response=>{
//             let lis = [];
//             for(let i = 0; i < response.length; i++){
//                 lis.push({label:response[i], value:response[i]});
//             }
//             this.field = lis;
//         })
//     }

//     field1(event){
//         if(event.currentTarget.dataset.name == 'Object'){
//             this.f1 = event.target.value;
//         }
//         else{
//         this.value1 = event.target.value;
//         }
//     }

//     field2(event){
//         if(event.currentTarget.dataset.name == 'Object'){
//             this.f2 = event.target.value;
//         }
//         else{
//         this.value2 = event.target.value;
//         }
//     }

//     field3(event){
//         if(event.currentTarget.dataset.name == 'Object'){
//             this.f3 = event.target.value;
//         }
//         else{
//         this.value3 = event.target.value;
//         }
//     }

//     Save(){
//         save().then(response=>{

//         })
//     }

//     Cancel(){
//         this.f1 = '';
//         this.f2 = '';
//         this.f3 = '';

//         this.valu = '';
//         this.value1 = '';
//         this.value2 = '';
//         this.value3 = '';

//     }
// }



import { LightningElement,api,wire,track } from 'lwc';
import getForm from '@salesforce/apex/obj.getForm';
import listrecord from '@salesforce/apex/obj.obj';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Obj extends LightningElement {
    @api objectName = 'Account';
    @api recordId;
    @api fieldSet = 'Account';
    @track fields;
    @track list;

    connectedCallback()
    {
        listrecord().then(response=>{
            let lis = [];
            for(let i = 0; i < response.length; i++){
                lis.push({label:response[i], value:response[i]});
            }
            this.list = lis;
        })
    }

    getfields(event){

        this.objectName = event.detail.value;
        this.fieldSet = event.detail.value;
        
        getForm({ recordId: this.recordId,objectName:this.objectName, fieldSetName:this.fieldSet})
        .then(result => {
            console.log('Data:'+ JSON.stringify(result));
            if (result) {
                this.fields = result.Fields;
                this.error = undefined;
            }
        }) .catch(error => {
            console.log(error);
            this.error = error;
        });

    }

    saveClick(e)
    {
        const inputFields = e.detail.fields;
        this.template.querySelector('lightning-record-edit-form').submit(inputFields);
    }
    validateFields() {
        return [...this.template.querySelectorAll("lightning-input-field")].reduce((validSoFar, field) => {
            return (validSoFar && field.reportValidity());
        }, true);
    }
    handleSuccess(e)
    {
        this.showMessage('Record Saved Successfully','success');
    }
    handleError(e)
    {
        this.template.querySelector('[data-id="message"]').setError(e.detail.detail);
        e.preventDefault();
    }

    showMessage(message,variant)
    {
        const event = new ShowToastEvent({
            title: 'Record Save',
            variant: variant,
            mode: 'dismissable',
            message: message
        });
        this.dispatchEvent(event);
    }
}