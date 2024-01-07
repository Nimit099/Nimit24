({
    acclists : function(component, event, helper) { 
    var size = parseInt(component.get("v.pageSize"));
    helper.acclists(component,size)
    helper.count(component);
    },

    onChange1: function (component, event, helper) {
        var selectedLimit = component.find("searching").get("v.value");
        component.set('v.searchKeyword', selectedLimit);
        var size = component.get('v.pageSize');
        helper.SearchHelper(component,size);
        helper.searchcount(component);
   },

   previous: function(component, event, helper){
    var pageSize = parseInt(component.get("v.pageSize"));
    var offsetSizes = parseInt(component.get("v.offsetSize"));
    var searchKeywords = component.get("v.searchKeyword");  
    offsetSizes -= pageSize;
    if(offsetSizes >= 0 ){
    helper.previousacc(component,offsetSizes,pageSize, searchKeywords);
    }
    else{
        offsetSizes = 0;
    }
    component.set('v.offsetSize', offsetSizes);
   },

   next: function(component, event,helper){
    
    var pageSize = parseInt(component.get("v.pageSize"));
    var offsetSizes = parseInt(component.get("v.offsetSize"));
    var count = parseInt(component.get("v.count"));
    var searchKeywords = component.get("v.searchKeyword");  
    offsetSizes += pageSize;

    if(offsetSizes < count){
    helper.nextacc(component,pageSize,offsetSizes,searchKeywords);
    }
    else{
        offsetSizes -= pageSize;
    }
    component.set('v.offsetSize', offsetSizes); 
   },

   First: function(component,event,helper){
    var offsetSizes = 0;
    var pageSize = parseInt(component.get("v.pageSize"));
    var searchKeywords = component.get("v.searchKeyword"); 

    component.set('v.offsetSize', offsetSizes); 
    helper.previousacc(component,offsetSizes,pageSize, searchKeywords);
   },

   Last: function(component,event,helper){
    var count = parseInt(component.get("v.count"));
    var offsetSizes = parseInt(component.get("v.offsetSize"));
    var pageSize = parseInt(component.get("v.pageSize"));
    var searchKeywords = component.get("v.searchKeyword");
    while(offsetSizes < count){
        offsetSizes+=pageSize;
        if(offsetSizes > count){
            offsetSizes-=pageSize;
            break;
        }
    }
    component.set('v.offsetSize', offsetSizes); 
    helper.previousacc(component,offsetSizes,pageSize, searchKeywords);

   },


   select: function(component, event, helper){
    var sizes = event.getParam("value");
    component.set("v.pageSize",sizes);
    var search = component.get("v.searchKeyword");
    var actions = component.get("c.getAccounts");
    actions.setParams({ size : sizes,
                        searchKeywords : search});
    actions.setCallback(this,function(response){
        var state = response.getState();
        if(state === "SUCCESS"){
            component.set("v.acclist", response.getReturnValue());
        }
    });
    $A.enqueueAction(actions);
    }

})