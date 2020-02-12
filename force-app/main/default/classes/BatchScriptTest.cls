@IsTest 
public class BatchScriptTest {
    
    static testMethod void testBatchScriptTest() {

        Batch_Script__c t = new Batch_Script__c();
        t.Last_run__c = system.now();
        t.run__C = true;
        insert t;
        
        update t;
      }
}