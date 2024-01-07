public with sharing class ft {
    // Insert Trigger for every Transaction
    public static void insertTransaction(List<Transaction__c> trans) {
        for(Transaction__c t : trans){
            if(t.Debit__c == true){
                if(t.Bank__c == true){
                    Person__c person = [SELECT Name,Bank__c from Person__c WHERE Id =: t.Person__c];
                    person.Bank__c -= t.Amount__c;
                    update person;
                }
                else if(t.Cash__c == true){
                    Person__c person = [SELECT Name,Cash__c from Person__c WHERE Id =: t.Person__c];
                    person.Cash__c -= t.Amount__c;
                    update person;
                }
                else if(t.Stock__c == true){
                    Person__c person = [SELECT Name,Stock__c from Person__c WHERE Id =: t.Person__c];
                    person.Stock__c -= t.Amount__c;
                    update person;
                }
            }
            else if(t.Credit__c == true){
                if(t.Bank__c == true){
                    Person__c person = [SELECT Name,Bank__c from Person__c WHERE Id =: t.Person__c];
                    person.Bank__c += t.Amount__c;
                    update person;
                }
                else if(t.Cash__c == true){
                    Person__c person = [SELECT Name,Cash__c from Person__c WHERE Id =: t.Person__c];
                    person.Cash__c += t.Amount__c;
                    update person;
                }
                else if(t.Stock__c == true){
                    Person__c person = [SELECT Name,Stock__c from Person__c WHERE Id =: t.Person__c];
                    person.Stock__c += t.Amount__c;
                    update person;
                }
            }
        }
    }
    // Deleting Trigger for every Transaction 
    public static void deleteTransaction(List<Transaction__c> trans){
        for(Transaction__c t : trans){
            if(t.Debit__c == true){
                if(t.Bank__c == true){
                    Person__c person = [SELECT Name,Bank__c from Person__c WHERE Id =: t.Person__c];
                    person.Bank__c += t.Amount__c;
                    update person;
                }
                else if(t.Cash__c == true){
                    Person__c person = [SELECT Name,Cash__c from Person__c WHERE Id =: t.Person__c];
                    person.Cash__c += t.Amount__c;
                    update person;
                }
                else if(t.Stock__c == true){
                    Person__c person = [SELECT Name,Stock__c from Person__c WHERE Id =: t.Person__c];
                    person.Stock__c += t.Amount__c;
                    update person;
                }
            }
            else if(t.Credit__c == true){
                if(t.Bank__c == true){
                    Person__c person = [SELECT Name,Bank__c from Person__c WHERE Id =: t.Person__c];
                    person.Bank__c -= t.Amount__c;
                    update person;
                }
                else if(t.Cash__c == true){
                    Person__c person = [SELECT Name,Cash__c from Person__c WHERE Id =: t.Person__c];
                    person.Cash__c -= t.Amount__c;
                    update person;
                }
                else if(t.Stock__c == true){
                    Person__c person = [SELECT Name,Stock__c from Person__c WHERE Id =: t.Person__c];
                    person.Stock__c -= t.Amount__c;
                    update person;
                }
            }
        }
    }

    // For ft1 Component
    // Show Cash,Bank,Stock And Credit,Debit Of all three
    @AuraEnabled
    public static List<Decimal> component1(Id RecordId){
        try {
            Decimal creditcash = 0;
            Decimal creditbank = 0;
            Decimal creditstock = 0;
            Decimal debitcash = 0;
            Decimal debitbank = 0;
            Decimal debitstock = 0;

            List<Decimal> response = new List<Decimal>();
            Person__c person = [SELECT Name,Bank__c, Stock__c, Cash__c FROM Person__c WHERE Id =: RecordId];
            response.add(person.Cash__c);
            response.add(person.Bank__c);
            response.add(person.Stock__c);

            List<Transaction__c> trans = [SELECT Credit__c,Debit__c,Cash__c,Bank__c,Stock__c,Amount__c FROM Transaction__c WHERE Person__c =: RecordId];
            
            for(Transaction__c t : trans){
                if(t.Credit__c == true){
                    if(t.Cash__c == true){
                        creditcash += t.Amount__c;
                    }
                    else if (t.Bank__c == true){
                        creditbank += t.Amount__c;
                    }
                    else if (t.Stock__c == true){
                        creditstock += t.Amount__c;
                    }
                }
                else if(t.Debit__c == true){
                    if(t.Cash__c == true){
                        debitcash += t.Amount__c;
                    }
                    else if (t.Bank__c == true){
                        debitbank += t.Amount__c;
                    }
                    else if (t.Stock__c == true){
                        debitstock += t.Amount__c;
                    }
                }
            } 

            response.add(creditcash);
            response.add(creditbank);
            response.add(creditstock);
            response.add(debitcash);
            response.add(debitbank);
            response.add(debitstock);

            return response;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

// For ft2 Component 
// Show Total Amount, Total Stock, Total Credit, Total Debit
    @AuraEnabled
    public static List<Decimal> component2(Id RecordId){
        try {
            Decimal credit = 0;
            Decimal debit = 0;
            List<Decimal> response = new List<Decimal>();
            Person__c person = [SELECT Name,Stock__c,Cash__c,Bank__c FROM Person__c WHERE Id =: RecordId];
            response.add(person.Cash__c + person.Bank__c);
            response.add(person.Stock__c);

            List<Transaction__c> trans = [SELECT Credit__c,Debit__c,Amount__c FROM Transaction__c WHERE Person__c =:RecordId AND Stock__c =: false]; 

            for(Transaction__c t : trans){
                if(t.Credit__c == true){
                    credit += t.Amount__c;
                }
                else if(t.Debit__c == true){
                    debit += t.Amount__c;
                }
            }
            response.add(credit);
            response.add(debit);
            return response;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    // For ft3 Component
    // Show Transaction
    @AuraEnabled
    public static List<Transaction__c> allTransaction(Id RecordId){
        try {
            List<Transaction__c> response = [SELECT Name,Amount__c,Date__c,Credit__c,Debit__c,Transaction_method__c FROM Transaction__c WHERE Person__c =: RecordId];
            return response;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string Transfer(Decimal amount, Id p1, Id p2, String check, String credit, Id fromacc, Id toacc ){
        try {
            if(credit == 'Credit'){
                if(check == 'Cash'){
                    Transfer__c t1 = new Transfer__c (From__c = p1, To__c = p2, Date__c = System.Today(), Credit__c = true, Amount__c = amount, Cash__c = true, Transaction_method__c = 'Cash Transfer');
                    insert t1;
                }
                else if(check == 'Bank'){
                    Transfer__c t1 = new Transfer__c (From__c = p1, To__c = p2, Date__c = System.Today(), Credit__c = true, Amount__c = amount, Bank__c = true, FromAccount__c = fromacc, ToAccount__c = toacc, Transaction_method__c = 'UPI');
                    insert t1;
                }
                else if(check == 'Stock'){
                    Transfer__c t1 = new Transfer__c (From__c = p1, To__c = p2, Date__c = System.Today(), Credit__c = true, Amount__c = amount, Stock__c = true, FromAccount__c = fromacc, ToAccount__c = toacc, Transaction_method__c = 'Stock Transfer');
                    insert t1;
                }
            }

            else if(credit == 'Debit'){if(check == 'Cash'){
                Transfer__c t1 = new Transfer__c (From__c = p1, To__c = p2, Date__c = System.Today(), Debit__c = true, Amount__c = amount, Cash__c = true, Transaction_method__c = 'Cash Transfer');
                insert t1;
            }
            else if(check == 'Bank'){
                Transfer__c t1 = new Transfer__c (From__c = p1, To__c = p2, Date__c = System.Today(), Debit__c = true, Amount__c = amount, Bank__c = true, FromAccount__c = fromacc, ToAccount__c = toacc, Transaction_method__c = 'UPI');
                insert t1;
            }
            else if(check == 'Stock'){
                Transfer__c t1 = new Transfer__c (From__c = p1, To__c = p2, Date__c = System.Today(), Debit__c = true, Amount__c = amount, Stock__c = true, FromAccount__c = fromacc, ToAccount__c = toacc, Transaction_method__c = 'Stock Transfer');
                insert t1;
            }}

            else{
                if(check == 'Cash'){
                    Transfer__c t1 = new Transfer__c (From__c = p1, To__c = p2, Date__c = System.Today(), Amount__c = amount, Cash__c = true, Transaction_method__c = 'Cash Transfer');
                    insert t1;
                }
                else if(check == 'Bank'){
                    Transfer__c t1 = new Transfer__c (From__c = p1, To__c = p2, Date__c = System.Today(), Amount__c = amount, Bank__c = true, FromAccount__c = fromacc, ToAccount__c = toacc, Transaction_method__c = 'UPI');
                    insert t1;
                }
                else if(check == 'Stock'){
                    Transfer__c t1 = new Transfer__c (From__c = p1, To__c = p2, Date__c = System.Today(), Amount__c = amount, Stock__c = true, FromAccount__c = fromacc, ToAccount__c = toacc, Transaction_method__c = 'Stock Transfer');
                    insert t1;
                }
            }

            return null;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    public static void transfertrigger(List<Transfer__c> trans){
       
        for(Transfer__c t : trans){

            if(t.bank__c == true){

                Person__c person1 = [SELECT Bank__c FROM Person__c WHERE Id =: t.From__c];
                person1.Bank__c -= t.Amount__c;
                update person1;
                Person__c person2 = [SELECT Bank__c FROM Person__c WHERE Id =: t.To__c];
                person2.Bank__c += t.Amount__c;
                update person2;

                // Mummy
                if(t.From__c == 'a0A5g000003FIdlEAG'){
                    if(t.To__c == 'a0A5g000003FIdlEAG'){
                        B_D_Account__c bank1 = [SELECT Shlesha__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Shlesha__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Shlesha__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Shlesha__c += t.Amount__c;
                        update bank2;
                    }
                    else if(t.To__c == 'a0A5g000003FIdqEAG'){
                        B_D_Account__c bank1 = [SELECT Shlesha__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Shlesha__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Nimit__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Nimit__c += t.Amount__c;
                        update bank2;
                    }
                    else if(t.To__c == 'a0A5g000003FIdmEAG'){
                        B_D_Account__c bank1 = [SELECT Shlesha__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Shlesha__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Nisarg__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Nisarg__c += t.Amount__c;
                        update bank2;
                    }
                }

                //    Nimit
                else if(t.From__c == 'a0A5g000003FIdqEAG'){
                    if(t.To__c == 'a0A5g000003FIdlEAG'){
                        B_D_Account__c bank1 = [SELECT Nimit__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Nimit__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Shlesha__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Shlesha__c += t.Amount__c;
                        update bank2;
                    }
                    else if(t.To__c == 'a0A5g000003FIdqEAG'){
                        B_D_Account__c bank1 = [SELECT Nimit__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Nimit__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Nimit__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Nimit__c += t.Amount__c;
                        update bank2;
                    }
                    else if(t.To__c == 'a0A5g000003FIdmEAG'){
                        B_D_Account__c bank1 = [SELECT Nimit__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Nimit__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Nisarg__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Nisarg__c += t.Amount__c;
                        update bank2;
                    }
                }

                //   Nisarg 
                else if(t.From__c == 'a0A5g000003FIdmEAG'){
                    if(t.To__c == 'a0A5g000003FIdlEAG'){
                        B_D_Account__c bank1 = [SELECT Nisarg__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Nisarg__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Shlesha__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Shlesha__c += t.Amount__c;
                        update bank2;
                    }
                    else if(t.To__c == 'a0A5g000003FIdqEAG'){
                        B_D_Account__c bank1 = [SELECT Nisarg__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Nisarg__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Nimit__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Nimit__c += t.Amount__c;
                        update bank2;
                    }
                    else if(t.To__c == 'a0A5g000003FIdmEAG'){
                        B_D_Account__c bank1 = [SELECT Nisarg__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Nisarg__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Nisarg__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Nisarg__c += t.Amount__c;
                        update bank2;
                    }
                }

                if(t.Credit__c == true){
                    Person__c person = [SELECT Cash__c FROM Person__c WHERE Id =: t.From__c];
                    person.Cash__c -= t.Amount__c;
                    update person;

                    Person__c person3 = [SELECT Bank__c FROM Person__c WHERE Id =: t.To__c];
                    person3.Bank__c += t.Amount__c;
                    update person3;

                    if(t.To__c == 'a0A5g000003FIdlEAG'){
                        B_D_Account__c bank2 = [SELECT Shlesha__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Shlesha__c += t.Amount__c;
                        update bank2;
                    }
                    else if(t.To__c == 'a0A5g000003FIdqEAG'){
                        B_D_Account__c bank2 = [SELECT Nimit__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Nimit__c += t.Amount__c;
                        update bank2;
                    }
                    else if(t.To__c == 'a0A5g000003FIdmEAG'){
                        B_D_Account__c bank2 = [SELECT Nisarg__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Nisarg__c += t.Amount__c;
                        update bank2;
                    }
                }
                else if(t.Debit__c == true){
                    Person__c person = [SELECT Cash__c FROM Person__c WHERE Id =: t.To__c];
                    person.Cash__c += t.Amount__c;
                    update person;

                    Person__c person3 = [SELECT Bank__c FROM Person__c WHERE Id =: t.From__c];
                    person3.Bank__c -= t.Amount__c;
                    update person3;

                    if(t.From__c == 'a0A5g000003FIdlEAG'){
                        B_D_Account__c bank2 = [SELECT Shlesha__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank2.Shlesha__c -= t.Amount__c;
                        update bank2;
                    }
                    else if(t.From__c == 'a0A5g000003FIdqEAG'){
                        B_D_Account__c bank2 = [SELECT Nimit__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank2.Nimit__c -= t.Amount__c;
                        update bank2;
                    }
                    else if(t.From__c == 'a0A5g000003FIdmEAG'){
                        B_D_Account__c bank2 = [SELECT Nisarg__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank2.Nisarg__c -= t.Amount__c;
                        update bank2;
                    }
                }
            }

            else if(t.Cash__c == true){
                Person__c person1 = [SELECT Cash__c FROM Person__c WHERE Id =: t.From__c];
                person1.Cash__c -= t.Amount__c;
                update person1;
                Person__c person2 = [SELECT Cash__c FROM Person__c WHERE Id =: t.To__c];
                person2.Cash__c += t.Amount__c;
                update person2;
            }

            else if(t.Stock__c == true){

                if(t.Credit__c == true){
                    Person__c person1 = [SELECT Bank__c FROM Person__c WHERE Id =: t.From__c];
                    person1.Bank__c -= t.Amount__c;
                    update person1; 

                    Person__c person2 = [SELECT Stock__c FROM Person__c WHERE Id =: t.To__c];
                    person2.Stock__c += t.Amount__c;
                    update person2; 
                }
                else if( t.Debit__c == true){
                    Person__c person1 = [SELECT Stock__c FROM Person__c WHERE Id =: t.From__c];
                    person1.Stock__c -= t.Amount__c;
                    update person1; 

                    Person__c person2 = [SELECT Bank__c FROM Person__c WHERE Id =: t.To__c];
                    person2.Bank__c += t.Amount__c;
                    update person2; 
                }

                // Shlesha
                if(t.From__c == 'a0A5g000003FIdlEAG'){
                    if(t.To__c == 'a0A5g000003FIdlEAG'){
                        B_D_Account__c bank1 = [SELECT Shlesha__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Shlesha__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Shlesha__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Shlesha__c += t.Amount__c;
                        update bank2;
                    }
                    else if(t.To__c == 'a0A5g000003FIdqEAG'){
                        B_D_Account__c bank1 = [SELECT Shlesha__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Shlesha__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Nimit__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Nimit__c += t.Amount__c;
                        update bank2;
                    }
                    else if(t.To__c == 'a0A5g000003FIdmEAG'){
                        B_D_Account__c bank1 = [SELECT Shlesha__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Shlesha__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Nisarg__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Nisarg__c += t.Amount__c;
                        update bank2;
                    }
                }
                    //    Nimit
                else if(t.From__c == 'a0A5g000003FIdqEAG'){
                    if(t.To__c == 'a0A5g000003FIdlEAG'){
                        B_D_Account__c bank1 = [SELECT Nimit__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Nimit__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Shlesha__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Shlesha__c += t.Amount__c;
                        update bank2;
                    }
                    else if(t.To__c == 'a0A5g000003FIdqEAG'){
                        B_D_Account__c bank1 = [SELECT Nimit__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Nimit__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Nimit__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Nimit__c += t.Amount__c;
                        update bank2;
                    }
                    else if(t.To__c == 'a0A5g000003FIdmEAG'){
                        B_D_Account__c bank1 = [SELECT Nimit__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Nimit__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Nisarg__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Nisarg__c += t.Amount__c;
                        update bank2;
                    }
                }

                    //   Nisarg 
                else if(t.From__c == 'a0A5g000003FIdmEAG'){
                    if(t.To__c == 'a0A5g000003FIdlEAG'){
                        B_D_Account__c bank1 = [SELECT Nisarg__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Nisarg__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Shlesha__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Shlesha__c += t.Amount__c;
                        update bank2;
                    }
                    else if(t.To__c == 'a0A5g000003FIdqEAG'){
                        B_D_Account__c bank1 = [SELECT Nisarg__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Nisarg__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Nimit__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Nimit__c += t.Amount__c;
                        update bank2;
                    }
                    else if(t.To__c == 'a0A5g000003FIdmEAG'){
                        B_D_Account__c bank1 = [SELECT Nisarg__c FROM B_D_Account__c WHERE Id =: t.FromAccount__c];
                        bank1.Nisarg__c -= t.Amount__c;
                        update bank1;
                        B_D_Account__c bank2 = [SELECT Nisarg__c FROM B_D_Account__c WHERE Id =: t.ToAccount__c];
                        bank2.Nisarg__c += t.Amount__c;
                        update bank2;
                    }
                }
            }

            
        }
    }
}