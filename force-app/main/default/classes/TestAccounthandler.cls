@isTest
public with sharing class TestAccounthandler {
    
    @TestSetup
    static void makeData(){
        List<Account> acclist = new List<Account>();
        for(Integer i = 0 ; i<20; i++){
            acclist.add(new Account(Name = 'Nimit'));
        }
        insert acclist;
    }

    @isTest static void testcreatecon(){
        List<Account> acclist = new List<Account>([SELECT ID FROM Account]);
        Accounthandler.createcon(acclist);
        List<Contact> con = new List<Contact>([SELECT LastName FROM Contact]);
        for(Contact c :con){
        System.assertEquals('Nimit', c.LastName);
        }
    }
    @isTest static void testcreateac(){

        Account acc = new Account (Name = 'Nimit');
        insert acc;
        List<Account> ac = new List<Account>();
        ac.add(acc);
        Accounthandler.createac(ac);

        Integer accno = [SELECT Count() FROM Account];
        System.assertEquals( 23 , accno, 'Total account created is '+accno );
    }

    @isTest static void Testdeleteac(){
        Accounthandler.deleteac(new List<Account>([SELECT ID FROM Account]));
        Integer accno = [SELECT Count() FROM Account];
        System.assertNotEquals(1, accno);

    }

    // @isTest static void testrating(){
    //     List<Account> acclist = new List<Account>([SELECT ID,Rating FROM Account]);
    //     List<Account> acclist1 = new List<Account>([SELECT ID,Rating FROM Account]);
    //     for(Account acc : acclist1){
    //         acc.Rating = 'Hot';
    //     }
    //     update acclist1;

    //     Accounthandler.Ratings(acclist, acclist1);
    // }

    @isTest static void testchange(){
        Account acc1 = new Account(Name = 'Nimit');
        Account acc2 = new Account(Name = 'Nimit1');
        insert acc1;
        insert acc2;
        Contact con = new Contact(LastName ='Shah', email = 'nimitshah240@gmail.com', AccountId = acc1.Id);
        insert con;
        Accounthandler.change(acc1,acc2);
    }


    @isTest static void testapproval(){
        List<Account> acclist = new List<Account>([SELECT ID FROM Account]);
        // List<Approval> approved = new List<Approval>();
        Integer count;
        Accounthandler.approval(acclist[0]);
        System.assertEquals(1,[SELECT Count() FROM ProcessInstance]);
    }

    @isTest static void testprefix(){
        List<Account> acclist = new List<Account>([SELECT ID,Name FROM Account]);
        Accounthandler.prefix(acclist);
        List<Account> acclist1 = new List<Account>([SELECT ID,Name FROM Account WHERE Name Like: '%N%']);
        System.assertEquals(20,acclist1.size());
    }
    @isTest static void testpublics(){
        List<Account> acclist = new List<Account>([SELECT ID,Name,LastModifiedById FROM Account]);
        Accounthandler.publics(acclist);
        List<Account> acclist1 = new List<Account>([SELECT ID,Name FROM Account WHERE OwnerId =: acclist[0].OwnerID]);
        
        System.assertEquals(20, acclist1.size());
    } 
}