trigger sheep on Contact (after update) {
   
    Contacthandler.sheep(Trigger.oldMap, Trigger.newMap);
    
}