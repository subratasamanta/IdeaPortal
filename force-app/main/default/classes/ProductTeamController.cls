public class ProductTeamController {
    
    @AuraEnabled
    public static list<Contact> fetchContactDetailList() {
        return   [Select Id,Name,Phone,Account.Name,Title,NumberOfCertifications__c,Introduction__c ,Picture__c    
                  From Contact ];
    }
    
    @AuraEnabled
	public static Contact_Us__c createRecord(Contact_Us__c objContact) {
        Contact_Us__c conUs = new Contact_Us__c();
        conUs.First_Name__c = objContact.First_Name__c;
        conUs.Last_Name__c = objContact.Last_Name__c;
        conUs.Email__c = objContact.Email__c;
        conUs.Phone__c = objContact.Phone__c;
        conUs.Enquiry_Type__c = objContact.Enquiry_Type__c;
        conUs.Description__c = objContact.Description__c;
        conUs.Company__c = objContact.Company__c;
        insert conUs;
        return conUs;
    }
    @AuraEnabled 
    public static void sendMailMethod(String mMail ,String mSubject ,String mbody, String fstName, String mphn, String mcmpny){
        
        List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();     
        
        // Step 1: Create a new Email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        // Step 2: Set list of people who should get the email
        List<String> sendTo = new List<String>();
        sendTo.add(mMail);
        mail.setToAddresses(sendTo);
        
        // Step 3: Set who the email is sent from
        mail.setReplyTo('noreply@gmail.com'); // change it with your mail address.
        mail.setSenderDisplayName(fstName); 
        
        // Step 4. Set email contents - you can use variables!
        mail.setSubject(mSubject);
        mail.setHtmlBody(mMail+mphn+mcmpny+mbody);
        system.debug('called in '+mail);
            
        // Step 5. Add your email to the master list
        mails.add(mail);
        
        // Step 6: Send all emails in the master list
        Messaging.sendEmail(mails);
    }   
}