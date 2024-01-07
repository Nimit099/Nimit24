public class CSVMaker {

    @AuraEnabled(cacheable=true)
    public static List<String> Objectname(){
        try{
            Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        
                Set<String> objects = new Set<String>();
                for (Schema.SObjectType d : gd.values()){
                    Schema.DescribeSObjectResult ds = d.getDescribe();
                    if (ds.isAccessible() && ds.isCreateable() && ds.isUpdateable()){
                        objects.add(ds.getName());
                    }
                }
            List<String> parentObjs = new List<String>(objects);
            parentObjs.sort ();
            return parentObjs;
        } catch (Exception e){
            return null;
        }
    }

    @AuraEnabled
    public static Map<String, String> fieldList(String objectname){
        try{
            Map<String, String> fields = new Map<String, String>();
            List<List<String>> allReqiredFields = new List<List<String>>(); 
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            Schema.SObjectType leadSchema = schemaMap.get(objectname) ;
            Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
            for (String fieldName : fieldMap.keySet()){ 
                if ( fieldMap.get(fieldName).getDescribe().isAccessible()){
                    fields.put(fieldMap.get(fieldName).getDescribe().getName(), String.valueOf(fieldMap.get(fieldName).getDescribe().getType()));
                }
            }
            return fields;
        } catch(Exception e){
            System.debug(e);
            return null;
        }
    }

    @AuraEnabled
    public static ContentVersion generateCSV(String objectname, List<String> fields){
        try{
            List<String> csvRowValues = new List<String>();
            String query = 'SELECT ';
            for (String field : fields) {
                query += field + ', ';
            }
            query = query.removeEnd(', ');
            csvRowValues.add(query.removeStart('SELECT'));
            query += ' FROM '+ objectname;
            List<sObject> objectRecords = Database.query(query);            
            for (sObject record : objectRecords) {
                String csvRowVal = '';
                for (String field : fields) {
                    if(record.get(field) != null){
                        csvRowVal = csvRowVal + ','+ record.get(field);
                    } else{
                        csvRowVal = csvRowVal + ','+ ' - ';
                    }
                }
                csvRowVal = csvRowVal.replaceFirst(',','');
                csvRowValues.add(csvRowVal); // To add rows
            }

            ContentVersion newCSVFile = new ContentVersion();
            newCSVFile.title = objectname +'_'+System.now();
            newCSVFile.VersionData = Blob.valueOf(String.join(csvRowValues, '\n'));
            newCSVFile.PathOnClient = newCSVFile.title +'.csv';
            insert newCSVFile;
            return [SELECT Id, ContentUrl FROM ContentVersion WHERE Id =: newCSVFile.Id];
        } catch(Exception e){
            System.debug(e);
            return null;
        }
    }

}