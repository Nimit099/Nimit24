({
    SearchHelper : function(component, size) {
        var action = component.get('c.searchAccount');
        action.setParams({ searchKeywords : component.get("v.searchKeyword"),
                            limitsize : size });
        action.setCallback(this, function(response){
        var state = response.getState();

           if(state === "SUCCESS"){
               component.set('v.acclist', response.getReturnValue());
            }
           else if(state === "ERROR") {
               var errors = response.getError();
               if(errors){
                   if(errors[0] && errors[0].message){
                       console.log("Error Message: " + errors[0].message);
                   }
               }
               else{
                   console.log("Unknown Error");
               }
           }
       });
       $A.enqueueAction(action);
    },

    searchcount: function(component){
        var action = component.get("c.searchCount");
        action.setParams({ searchKeywords : component.get("v.searchKeyword")});
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.count", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);

    },

    previousacc: function(component,  offsetSize, pageSize, searchKeyword){
        var actions = component.get("c.previousacc");
        actions.setParams({ 
            limitsize : pageSize,
            OffsetSize : offsetSize,
            searchKey : searchKeyword
        });

        actions.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.acclist", response.getReturnValue());
            }
        });
        $A.enqueueAction(actions);
       },
    

       nextacc: function(component, pageSize,offsetSizes, searchKeywords){
        var actions = component.get("c.nextacc");
        actions.setParams({ 
            limitsize : pageSize,
            OffsetSize : offsetSizes,
            searchKey : searchKeywords
         });

        actions.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.acclist", response.getReturnValue());
            }
        });
        $A.enqueueAction(actions);
    },
    

    acclists : function(component,sizes) {
        var actions = component.get("c.getAccounts");
        actions.setParams({ size :sizes ,
                            searchKeywords : component.get("v.searchKeyword")});
        actions.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.acclist", response.getReturnValue());
            }
        });
        $A.enqueueAction(actions);
    },



    count: function(component){
        var actions = component.get("c.getcount");
        actions.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.count", response.getReturnValue());
            }
        });
        $A.enqueueAction(actions);
    }


})