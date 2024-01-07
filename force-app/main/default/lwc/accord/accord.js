import { LightningElement, track } from 'lwc';

import acccon from '@salesforce/apex/Assessment2.acccon'

export default class Accord extends LightningElement {

    @track acclist = [];

    connectedCallback() {
        acccon()
            .then(result => {
                var acc = result.acc
                console.log(JSON.stringify(acc));
                acc.forEach((element) => {
                    console.log(element.Name);
                    this.acclist.push({ Id: element.Id, Name: element.Name });
                })
            });

    }

}