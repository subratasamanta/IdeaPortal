trigger createContact on Contact__c (before insert) {
     List<contact > contactList = new List<contact >();
     for(Contact__c  con : trigger.new){
          contact c = new contact();
         c.Accountid =  con.Account__c;
         c.AssistantName =  con.AssistantName__c;
         c.AssistantPhone =  con.AssistantPhone__c;
         c.Birthdate =  con.Birthdate__c;
        // c.Account =  con.Contact__c;
         c.Department =  con.Department__c;
         c.Description =  con.Description__c;
         c.Email =  con.Email__c;
         c.Fax =  con.Fax__c;
         c.firstname=  con.name;
         c.HomePhone =  con.HomePhone__c;
        // c.Account =  con.Languages__c;
         c.lastname=  con.last_Name__c;
        // c.Account =  con.Level__c;
         c.MailingCity =  con.Mailing_City__c;
         c.MailingCountry =  con.Mailing_Country__c;
         c.MailingState =  con.Mailing_State_Province__c;
         c.MailingStreet =  con.Mailing_Street__c;
         c.MailingPostalCode =  con.Mailing_Zip_Postal_Code__c;
         c.MobilePhone =  con.MobilePhone__c;
         c.OtherCity =  con.Other_City__c;
         c.OtherPhone =  con.OtherPhone__c;
         c.OtherState =  con.Other_State_Province__c;
         c.OtherStreet =  con.Other_Street__c;
         c.OtherPostalCode =  con.Other_Zip_Postal_Code__c;
         c.Phone =  con.Phone__c;
         c.ReportsToId =  con.ReportsTo__c;
         c.Title =  con.Title__c;
         contactList.add(c);
     
     }
     insert contactList;
}