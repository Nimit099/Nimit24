({
    acclists:function(component, event, helper){
        var action = component.get('c.aclist');
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.conlist1", response.getReturnValue());
                component.set("v.conlist2", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },

    onchange1 : function(component, event, helper) {
        var Name = component.find("searching1").get("v.value");
        component.set('v.searchKeyword1', Name);
        helper.Onchanges1(component,Name);
    },

    onchange2 : function(component, event, helper) {
        var Name = component.find("searching2").get("v.value");
        component.set('v.searchKeyword2', Name);
        helper.Onchanges2(component,Name);
    },
    drag: function(component, event, helper){
        event.dataTransfer.setData('Text', event.target.id);
        component.set('v.dragcontact',  event.target.id);
    },
    allowdrop : function(component, event, helper){
        event.preventDefault();
    },
    drop : function(component, event,helper){
        var contact = component.get("v.dragcontact");
        var account = event.target.id;
        helper.drop(component,contact,account);
    }
})