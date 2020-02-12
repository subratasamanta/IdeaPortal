public with sharing  class UserDetails {
    
    public static void getUserDetails(List<Idea__c> lstIdeaIds){
        system.debug('method calling');
        Idea__c oldIdea = [Select Id, Name from Idea__c where Id=:lstIdeaIds]; 
        List<Idea__c> newIdea = new List<Idea__c>();
        
        for(User usr : [SELECT ID,Name,Contact.Name,ContactID,Contact.AccountId,Contact.Account.Name FROM User 
                        Where Id = : userInfo.getUserId() 
                        LIMIT 50000]){
                            
                            Idea__c objIdea = new Idea__c();
                            objIdea.id=oldIdea.Id;
                            objIdea.Contact__c =usr.ContactId;
                            objIdea.Customer__c =usr.Contact.AccountId;
                            newIdea.add(objIdea);
                            
                        }
        system.debug('newIdea++:::'+newIdea );
        if(!newIdea.isEmpty()){
            update newIdea;
        }
    }
    
}