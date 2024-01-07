import { LightningElement, track, wire } from 'lwc';
import Objectname from '@salesforce/apex/CSVMaker.Objectname';
import fieldLists from '@salesforce/apex/CSVMaker.fieldList';
import generateCSV from '@salesforce/apex/CSVMaker.generateCSV';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Type', fieldName: 'Type' }
];
export default class CSVMaker extends LightningElement {

    @track objectlist = [];
    @track fieldList = [];
    @track objectselect
    @track columns = columns;
    @track selectfieldlist = [];


    @wire(Objectname)
    wiredContacts({ error, data }) {
        if (data) {
            const op = [{ label: 'Select', value: 'Select' }]
            data.forEach((obj) => {
                op.push({ label: obj, value: obj });
            })
            this.objectlist = op;
        } else if (error) {
            console.error(error);
        }
    }

    objectselected(event) {
        try {
            this.objectselect = event.detail.value;

            fieldLists({ objectname: this.objectselect }).then(response => {
                var field = [];
                for (var key in response) {
                    field.push({ Name: key, Type: response[key] })
                }
                this.fieldList = field;
            }).catch(e => {
                console.log('OUTPUT : ', e);
            })
        } catch (e) {
            console.log('OUTPUT : ', e);
            console.log('OUTPUT : ', e.message);
        }
    }

    generateCSV() {

        try {
            var selectedRecords = this.template.querySelector("lightning-datatable").getSelectedRows();
            if (selectedRecords.length > 0) {
                selectedRecords.forEach(currentItem => {
                    this.selectfieldlist.push(currentItem.Name);
                });
                generateCSV({ objectname: this.objectselect, fields: this.selectfieldlist }).then(response => {
                    console.log(response);
                    console.log(JSON.stringify(response));
                    console.log(JSON.parse(JSON.stringify(response)));
                    

                    if (response != null) {
                        alert('CSV FILE IS GENERATED. DOWNLOAD ID : '+ response.Id );
                        this.objectselect = '';
                        this.selectfieldlist = [];
                        this.fieldList = [];
                    } else {
                        alert('ERROR IN GENERATING CSV');
                    }
                })
            } else {
                alert('SELECT FIELD');
            }
        } catch (e) {
            alert(e.message);
        }
    }
}