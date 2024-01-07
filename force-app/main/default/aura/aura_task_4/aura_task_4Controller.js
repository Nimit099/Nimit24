({
    previous : function(component, event, helper) {
       
        if(component.get("v.Task2") == true){
            component.set("v.Task2", false);
            component.set("v.Task1", true);

        }
        else if(component.get("v.Task3") == true){
            component.set("v.Task3", false);
            component.set("v.Task2", true);
        }
        else if(component.get("v.Task5") == true){
            component.set("v.Task5", false);
            component.set("v.Task3", true);
        }
    },

    next : function(component, event, helper) {
        var task1 = component.get("v.Task1"); 

        if(task1 == true){
            component.set("v.Task1", false);
            component.set("v.Task2", true);
        }
        else if(component.get("v.Task2") == true){
            component.set("v.Task2", false);
            component.set("v.Task3", true);
        }
        else if(component.get("v.Task3") == true){
            component.set("v.Task3", false);
            component.set("v.Task5", true);
        }
    }
})