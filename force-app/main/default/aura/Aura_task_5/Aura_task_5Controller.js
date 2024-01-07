({
    getuser : function(component, event, helper){
        var action = component.get("c.methodName");

        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
               component.set("v.check", true);
            }
        });
        
        $A.enqueueAction(action);
    },

    image : function(component, event, helper) {
        component.set("v.image", component.find("image").get("v.value"));
    },

    fontsize : function(component,event,helper){
        component.set("v.fontsize", component.find("fontsize").get("v.value"));
        var i = component.find("fontsize").get("v.value");
        component.set("v.fontsizes",i+'px');
        
    },

    description : function(component,event,helper){
        component.set("v.description", component.find("description").get("v.value"));

    },
    backgroundColor : function(component, event, helper){
        var element = component.find('card1');
        $A.util.addClass(element, 'cards');
    }
})