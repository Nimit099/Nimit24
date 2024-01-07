({
  next: function(component, event, helper){
    var number = component.get("v.previous");
    if( number == 1){
      component.set("v.number", 2);
      component.set("v.progress", 34);
      component.set("v.showcontact", 'true');
      component.set("v.showaccount", 'false');
    } 
    else if( number == 2){
      component.set("v.number", 3);
      component.set("v.progress", 75);
      component.set("v.showcontact", 'false');
      component.set("v.showevent", 'true');
    }
  },
  previous: function(component, event, helper){
    var number = component.get("v.previous");
    if( number == 2){
      component.set("v.number", 1);
      component.set("v.progress", 10);
      component.set("v.showcontact", 'false');
      component.set("v.showaccount", 'true');
    } 
    else if( number == 3){
      component.set("v.number", 2);
      component.set("v.progress", 34);
      component.set("v.showcontact", 'true');
      component.set("v.showevent", 'false');
    }
  },
   
  save: function(component, event, helper){
    var number = component.get("v.number");
    
    if(number == '1'){
        var Name = component.find("accName").get("v.value");
        var Phone = component.find("accPhone").get("v.value");
        var Rating = component.find("accRating").get("v.value");
        helper.saveaccount(component,Name,Phone,Rating);
    }
    else if(number == '2'){
        var firstname = component.find("firstname").get("v.value");
        var lastname = component.find("lastname").get("v.value");
        var phone = component.find("phone").get("v.value");
        var accountid = component.find("accountid").get("v.value");
        helper.savecon(component,firstname,lastname,phone,accountid);
    }
    else if(number == '3'){

        var subject = component.find("evtSubject").get("v.value");
        var startdate = component.find("startdate").get("v.value");
        var enddate = component.find("enddate").get("v.value");
        var whoid = component.find("whoid").get("v.value");
        helper.saveeve(component,subject, startdate, enddate, whoid);
    }
  }
})