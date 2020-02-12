public class SubscribeEmailCls {
    @InvocableMethod
    public static void SubscriptionEmail(List<Idea__c> ideaList){
       List<Idea__c> allIdeaLst= new List<Idea__c>();
       Set<Id> ideaCreatedID= new Set<Id>();
       Set<Id> allIdeaId= new Set<Id>();
       Set<Id> subscriberId= new Set<Id>();
       List<EntitySubscription> subscriptionLst= new List<EntitySubscription>();
        //UserID of created Idea
       List<Id> subscriberIdlst= new List<Id>();
        for(Idea__c idea : ideaList){
            ideaCreatedID.add(idea.CreatedById);
        }
        //List of Ideas
        allIdeaLst=[SELECT CreatedById,Id,Name FROM Idea__c WHERE CreatedById IN:ideaCreatedID];
        System.debug('allIdeaLst.size() : '+allIdeaLst.size());
        for(Idea__c allIdea : allIdeaLst){
            allIdeaId.add(allIdea.Id);
        }
        //Subscriber Id List
        subscriptionLst=[SELECT Id,ParentId,SubscriberId FROM EntitySubscription WHERE ParentId IN:allIdeaId];
        for(EntitySubscription subscription : subscriptionLst){
            subscriberId.add(subscription.SubscriberId);
        }
        subscriberIdlst.addAll(subscriberId);
        //To notify subscriber about new idea post
        try{ 
        Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
        semail.setToAddresses(subscriberIdlst);
        semail.setSenderDisplayName('Tavant System Admin');
        String messageBody = '<html><body>Hi,<br/> New Idea is being posted.</body></html>';
        semail.setHtmlBody(messageBody);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail});
        System.debug('Mail sent successfully '+semail);
        }
        catch(Exception e){
            System.debug('~~~~Exception Line number '+e.getLineNumber()+' ~~~ Message is -> '+e.getMessage());
        }
    }
}