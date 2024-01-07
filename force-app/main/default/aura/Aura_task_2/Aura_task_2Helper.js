({

    Onchanges1: function(component,  Names) {
        var action = component.get('c.acclist1');
        action.setParams({ searchkey : Names});
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.conlist1", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },


    Onchanges2: function(component, Names){
        var action = component.get("c.acclist1");
        action.setParams({ searchkey : Names});
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.conlist2", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },

    drop: function(component, contact, account){
        var action = component.get("c.change");
        action.setParams({ contactid : contact,
                            accountid : account});
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.conlist1", response.getReturnValue());
                component.set("v.conlist2", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})