/**********************************************************************
 Name:  ExpectedChangeSendEmail Trigger
 Copyright © 2013  TAVANT Technologies
======================================================
======================================================
Purpose:                                                            
-------     
Send email to user while change in Expected value                                                       
======================================================
======================================================
History                                                            
-------                                                            
VERSION     AUTHOR            DATE            DETAIL                          
1.0         Praveen KH        02/04/2013      INITIAL DEVELOPMENT             
***********************************************************************/
trigger ExpectedChangeSendEmail on Billing_Details__c (after update) {
    
    System.debug('-># ExpectedChangeSendEmail');

    Set<ID> OppIDs = new Set<ID>();
    for(Billing_Details__c bd : Trigger.new){
        OppIDs.add(bd.Opportunity_Name__c);
    }
    
    Map<ID,Opportunity> OppsMap = new Map<ID,Opportunity>([Select Id, Probability, PBD__c, GDM__c, Owner.Email From Opportunity Where ID IN: OppIDs]);
    Map<String, PBD_GDM_Emails__c>  PGEmailsMap= PBD_GDM_Emails__c.getAll();
    String templateName = 'Billing Expected Change Template';
    EmailTemplate e = [select Id,Name,Subject,body from EmailTemplate where name like :templateName+'%'];
    Map<Id,Billing_Details__c > oldBDMap = Trigger.oldMap;
    String commonGroupEmailId  = 'sf-notifications@tavant.com';
    
    for(Billing_Details__c bd : Trigger.new){
        Billing_Details__c OldBD = oldBDMap .get(bd.Id);
        if(bd.BILLING_EXPECTED__c <> OldBD .BILLING_EXPECTED__c){
            Opportunity Opp = OppsMap.get(bd.Opportunity_Name__c);
            if(Opp != null){
                System.debug('# Opp.Probability = '+Opp.Probability);
                if(100 == Opp.Probability){
                List<String> EmailIds = new List<String>();
                if(opp.Owner.Email != null){
                    EmailIds.add(opp.Owner.Email);
                }
                    if(opp.PBD__c != null){
                        PBD_GDM_Emails__c PBDEmail = PGEmailsMap.get(opp.PBD__c);
                        if(null != PBDEmail){
                            EmailIds.add(PBDEmail.Email_ID__c);
                        }
                    }
                    if(opp.GDM__c != null){
                        PBD_GDM_Emails__c GDMEmail = PGEmailsMap.get(opp.GDM__c);
                        if(null != GDMEmail){
                            EmailIds.add(GDMEmail.Email_ID__c);                    
                        }
                    }
                   System.debug('# EmailIds' + EmailIds); 
                   Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                   message.saveAsActivity=false; 
                   message.setTemplateId(e.id);
                   Contact tempContact = new Contact(email = UserInfo.getUserEmail(), firstName = UserInfo.getUserName(), lastName = UserInfo.getLastName());
                   insert tempContact;
                   message.setTargetObjectId(tempContact.Id);
                   emailIds.add(commonGroupEmailId);  
                   message.setToAddresses(emailIds);  
                   message.setWhatId(bd.Id);
                   Messaging.sendEmail(new Messaging.Email[] {message});    
                   Delete  tempContact; 
                }
            }
        }
    }
    System.debug('<-# ExpectedChangeSendEmail');
}