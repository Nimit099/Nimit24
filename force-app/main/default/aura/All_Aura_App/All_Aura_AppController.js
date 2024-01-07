({
    task1 : function(component, event, helper) {
        component.set('v.task1',true);
        component.set('v.task2',false); 
        component.set('v.task3',false);
        component.set('v.task5',false);

    },
    task2 : function(component, event, helper) {
        component.set('v.task1',false);
        component.set('v.task2',true);
        component.set('v.task3',false);
        component.set('v.task5',false);
    },
    task3 : function(component, event, helper) {
        component.set('v.task1',false);
        component.set('v.task2',false);
        component.set('v.task3',true);
        component.set('v.task5',false);

    },
    task5 : function(component, event, helper) {
        component.set('v.task1',false);
        component.set('v.task2',false);
        component.set('v.task3',false);
        component.set('v.task5',true);
    }
})