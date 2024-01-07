// public with sharing class obj {

//     @AuraEnabled
//     public static List<String> obj() {
//         List < Schema.SObjectType > gd = Schema.getGlobalDescribe().Values();      
//         Map<String , Schema.SObjectType > globalDescription = Schema.getGlobalDescribe(); 
//         List<String> listName = new List<String>();  
                
//         for ( Schema.SObjectType f : gd ) 
//         {  
//             // if(f.getDescribe().isUpdateable() && f.getDescribe().isAccessible()){
//                 if(f.getDescribe().isCreateable() == true && f.getDescribe().isUpdateable() == true && f.getDescribe().isDeletable() == true ){

//             Schema.sObjectType objType = globalDescription.get(f.getDescribe().getName() );  

//             listName.add(String.valueOf(objType));
//             }
//             else {
//                 continue;
//             }
//         }
//         return listName;
//     }
//     @AuraEnabled
//     public static List<String> fields(String oobject){
//         Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
//         Map <String, Schema.SObjectField> MapofdesiredObject = schemaMap.get(oobject).getDescribe().fields.getMap();
//         List<String> field = new List<String>();
//         for(Schema.SObjectField sObjectfield : MapofdesiredObject.Values())
//         {           
//             if(sObjectfield.getDescribe().isUpdateable()){
//                 schema.describefieldresult dfield = sObjectfield.getDescribe();
//                 field.add(String.valueOf(dfield.getName()));
//             }
//         }
        
//         return field;
//     }

//     @AuraEnabled
//     public static string save(String oobject, String field1){
//         try {
//             // oobject acc = new oobject();
//             // acc.field1 = 'Nimit';
//             // acc.Phone = '11233';
//             // acc.Active__c = 'true';
            
//             // insert acc;
//             return null;
            
//         } catch (Exception e) {
//             throw new AuraHandledException(e.getMessage());
//         }
//     }
// }



public with sharing class obj {

    @AuraEnabled
        public static List<String> obj() {
            List < Schema.SObjectType > gd = Schema.getGlobalDescribe().Values();      
            Map<String , Schema.SObjectType > globalDescription = Schema.getGlobalDescribe(); 
            List<String> listName = new List<String>();  
                    
            for ( Schema.SObjectType f : gd ) 
            {  
                if(f.getDescribe().isCreateable() == true && f.getDescribe().isUpdateable() == true && f.getDescribe().isDeletable() == true ){
                Schema.sObjectType objType = globalDescription.get(f.getDescribe().getName() );  
                listName.add(String.valueOf(objType));
                }
                else {continue;}
            }
            return listName;
        }

    @AuraEnabled
    public static FieldSetForm getForm(Id recordId, String objectName, String fieldSetName) {

        Schema.SObjectType objectType = Schema.getGlobalDescribe().get(objectName);
        Schema.DescribeSObjectResult objectDescribe = objectType.getDescribe();
        Map<String, Schema.FieldSet> fieldSetMap = objectDescribe.fieldSets.getMap();
        
        FieldSetForm form = new FieldSetForm();        
        form.Fields = getFields(recordId, objectName, fieldSetName);
        
        return form;
    }
    
    private static List<FormField> getFields(Id recordId, String objectName, String fieldSetName) {
        Schema.SObjectType objectType = null;
        
        if (recordId != null) {
            objectType = recordId.getSobjectType();
        }
        else if (String.isNotBlank(objectName)) {
            objectType = Schema.getGlobalDescribe().get(objectName);
        }
        
        Schema.DescribeSObjectResult objectDescribe = objectType.getDescribe();
        Map<String, Schema.FieldSet> fieldSetMap = objectDescribe.fieldSets.getMap();
        Schema.FieldSet fieldSet = fieldSetMap.get(fieldSetName);
        List<Schema.FieldSetMember> fieldSetMembers = fieldSet.getFields();
        
        List<FormField> fields = new List<FormField>();
        for (Schema.FieldSetMember fsm : fieldSetMembers) {
            FormField f = new FormField(fsm);
            fields.add(f);
        }
        
        return fields;
    }
    
    public class FieldSetForm {
        @AuraEnabled
        public List<FormField> Fields { get; set; }
        
        public FieldSetForm() {
            Fields = new List<FormField>();
        }
    }
}