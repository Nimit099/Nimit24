import { LightningElement,api } from 'lwc';
import registeration from '@salesforce/apex/schoolportal.registration'


export default class C_Registration extends LightningElement {
   @api teacher;
   @api student;
   role = 'teacher';
   firstname;
   lastname;
   email;
   mobile;

   connectedCallback(){
    this.teacher = true;
    this.student = false;
   }
    mstudent(event){
        this.teacher = false;
        this.student = true;
        role = 'student';
    }
    mteacher(event){
        this.student = false;
        this.teacher = true;
        role = 'teacher';
    }
    mfirstname(event){
        this.firstname = event.target.value;
        console.log(this.firstname);
    }
    mlastname(event){
    this.lastname = event.target.value;
    console.log(this.lastname);
    }
    memail(event){
    this.email = event.target.value;
    console.log(this.email);
    }
    mmobile(event){
    this.mobile = event.target.value;
    console.log(this.mobile);
    }
    mregister(){
        registeration({firstname : this.firstname, lastname : this.lastname, email : this.email, mobile : this.mobile, role : this.role}).then(response=>{

        })
    }
}