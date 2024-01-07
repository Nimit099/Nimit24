({
   saveaccount: function(component,Name,Phone,Rating){
    var action = component.get("c.getsaveacc");
        action.setParams({ accountName: Name,
                            accountPhone: Phone,
                            accountRating: Rating
                           });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.accountid", response.getReturnValue());
                component.set("v.number", 2);
                component.set("v.showaccount", "false")
                component.set("v.showcontact", "true");
                component.set("v.progress", 34);
                component.set("v.previous", 2);
            }
        });
        $A.enqueueAction(action);
   },

   savecon: function(component,firstname, lastname, phone, accountid){
    var action = component.get("c.savecon");
    action.setParams({ 
        Firstname : firstname,
        Lastname : lastname,
        Phones : phone,
        AccountIds : accountid
    });
    action.setCallback(this,function(response){
        var state = response.getState();
        if(state === "SUCCESS"){
            component.set("v.contactid", response.getReturnValue());
            component.set("v.number", 3);
            component.set("v.showcontact", "false");
            component.set("v.showevent", "true");
            component.set("v.progress", 75);
            component.set("v.previous", 3);
        }
    });
    $A.enqueueAction(action);
   },

   saveeve: function(component,subject,startdate,enddate,whoid){
    var action = component.get("c.saveeve");
    action.setParams({ 
                    subject:subject,
                    startdate:startdate,
                    enddate:enddate,
                    whoid:whoid
    });
    action.setCallback(this,function(response){
        var state = response.getState();
        if(state === "SUCCESS"){
            component.set("v.progress", 100);
            component.set("v.showevent" , 'false');
            component.set("v.msg", 'Inserted');
        }
    });
    
    $A.enqueueAction(action);
   }
})