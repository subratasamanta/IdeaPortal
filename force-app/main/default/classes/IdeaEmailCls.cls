public without sharing class IdeaEmailCls {
    @InvocableMethod
    	public static void getMap(List<Comment__c> id1){
        System.debug('List of Comment '+id1.size());
        List<ID> ideaId= new List<ID>();
        Set<String> usrId = new Set<String>();
        List<String> usrListId = new List<String>();
        for(Comment__c c: id1)
        {
            ideaId.add(c.Idea__c);
        }
        System.debug('id2.size() '+ideaId.size());
       // Comment__c[] c =[Select Id,CommentBody__c FROM Comment__c where Id=: ideaId];
       // System.debug('Comment Body'+c[0].CommentBody__c);
        List<Comment__c> commentDetails=[Select Id,CreatedById,CreatedBy.Email,Idea__c,Idea__r.CreatedById,
                         Idea__r.CreatedBy.Email from Comment__c where Idea__c in: ideaId];
        for(Comment__c comm: commentDetails){
            {
                usrId.add(comm.CreatedBy.Email);
                usrId.add(comm.Idea__r.CreatedBy.Email);
            }
        }      
        System.debug('usrId.size() '+usrId.size());
        usrListId.addAll(usrId);
        
        EmailTemplate et=[Select Id from EmailTemplate where name = 'Comment Notification' limit 1];
        try{            
        Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
        String[] sendingTo = new String[]{};
        for(String s1 : usrListId)
        {
            sendingTo.add(s1);
        }
        System.debug('sendingTo'+sendingTo);
        semail.setToAddresses(sendingTo);
        semail.setSenderDisplayName('Tavant System Admin');
       // semail.setPlainTextBody('New Comment is being added');
        String messageBody = '<html><body>Hi,<br/> New Comment is being added.</body></html>';
        semail.setHtmlBody(messageBody);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail});
        System.debug('Mail sent successfully '+semail);  
        }
        catch(Exception e){
            System.debug('~~~~Exception Line number '+e.getLineNumber()+' ~~~ Message is -> '+e.getMessage());
        }
    }
}