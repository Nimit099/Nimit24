import { LightningElement } from 'lwc';

export default class ALL_LWC_TASK extends LightningElement {
    task1 = false;
    task3 = false;
    task4 = false;
    task5 = false;

    select(event){

        if(event.target.checked == true){
            if(event.target.label == 'Task 1'){
                this.task1 = true;
                this.task3 = false;
                this.task4 = false;
                this.task5 = false;
            }
            else if(event.target.label == 'Task 3'){
                this.task1 = false;
                this.task3 = true;
                this.task4 = false;
                this.task5 = false;
            }
            else if(event.target.label == 'Task 4'){
                this.task1 = false;
                this.task3 = false;
                this.task4 = true;
                this.task5 = false;
            }
            else if(event.target.label == 'Task 5'){
                this.task1 = false;
                this.task3 = false;
                this.task4 = false;
                this.task5 = true;
            }
        }
        else{
            if(event.target.label == 'Task 1'){
                this.task1 = false;
            }
            else if(event.target.label == 'Task 3'){
                this.task3 = false;
            }
            else if(event.target.label == 'Task 4'){
                this.task4 = false;
            }
            else if(event.target.label == 'Task 5'){
                this.task5 = false;
            }
        }
    }
}