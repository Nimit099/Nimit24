global class saop_callout {
  webservice static Account acc;
  webservice static List<Contact> con = new List<Contact>();
  webservice static List<Account> acclist = new List<Account>();

      webservice static Account dopost(){
        acc = [SELECT Name FROM Account Limit 1];
        return acc;
    }

    webservice static List<Contact> createcontact(){
      
      for(Integer i = 1; i <= 10; i++){
        con.add(new Contact(LastName = 'TestContact '+i));
      }
      insert con;
      return con;
  }

  webservice static List<Account> createaccount(){
    for(Integer i = 1; i <= 10; i++){
      acclist.add(new Account(Name = 'TestContact '+i));
    }
    insert acclist;
    return acclist;
}

  webservice static List<Contact> updatecontact(){
    for(Integer i = 1; i <= 10; i++){
      con.add([SELECT Id,LastName,AccountId FROM Contact WHERE LastName =:'TestContact '+i]);
      acclist.add([SELECT Id FROM Account WHERE Name =: 'TestContact '+i]);
    }
    for(Integer i = 0; i<10; i++){
        con[i].AccountId = acclist[i].Id;
    }
    update con;
    return con;
  }
  webservice static void deletecontact(){
    for(Integer i = 1; i <= 10; i++){
      con.add([SELECT Id, FirstName, LastName,AccountId FROM Contact WHERE LastName =:'TestContact '+i]);
      acclist.add([SELECT Id FROM Account WHERE Name =: 'TestContact '+i]);
    }
    delete con;
  }
}