@isTest
public class PortalTestDataFactory {
    //Idea Creation
    public static Idea__c createIdeas(String name,String ideac, String lname,String status) {
        Id ideaId;
        Idea__c idea = new Idea__c(Name = name, Ideas__c =ideac ,LastName__c=lname, 
                                   Status__c=status,Idea_Description__c='ABC',SubIdeas__c='Inventory Transfer');
        Database.insert(idea);
        return idea;
    }
    
    //Comment Creation
    public static Comment__c createComment(String name,Id ideaId, String comment) {
        Comment__c comm = new Comment__c( Name = name, Idea__c=ideaId, CommentBody__c=comment);
        insert comm;
        return comm;
    }
    
    public static Account generateAccount(){
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        Profile profile1 = [SELECT Id FROM Profile WHERE Name =  'System Administrator'];
        User u = new User(
            ProfileId =profile1.Id,
            UserRoleId=portalRole.Id,
            LastName = 'last',
            Email = 'test.idea@ideaportal.com',
            IsActive=true,
            Username = 'test.idea@ideaportal.com',
            CompanyName = 'Testing Co',
            Title = 'Captian',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        System.runAs(new User(Id = UserInfo.getUserId())){
        Database.insert(u);
        }
        //Create Account
        Account portalAccount1 = new Account(
            Name = 'TestAccount',
            OwnerId = u.id,
            Vertical_Practice__c='Aftermarket');
        Database.insert(portalAccount1);
        return portalAccount1;
    }
    
    //Create contact
    public static Contact createContact(Id accid){
    Contact contact1 = new Contact(
        FirstName = 'Test',
        Lastname = 'McTesty',
        AccountId = accid,
        Email = System.now().millisecond() + 'test@test.com'
    );
    Database.insert(contact1);
    return contact1;
    }
    
    //Create User
    public static User UserCreate(String profileName, Id contact1){
    Profile portalProfile = [SELECT Id FROM Profile WHERE Name = :profileName];
    User user1 = new User(
        Username = System.now().millisecond() + 'test12345@test.com',
        ContactId = contact1,
        ProfileId = portalProfile.Id,
        Alias = 'test123',
        Email = 'test12345@test.com',
        EmailEncodingKey = 'UTF-8',
        LastName = 'McTesty',
        CommunityNickname = 'test12345',
        TimeZoneSidKey = 'America/Los_Angeles',
        LocaleSidKey = 'en_US',
        LanguageLocaleKey = 'en_US'
    );
    Database.insert(user1);
    return user1;
    }
    
    //Entity Subscription
    public static EntitySubscription createSubscription(Id subId,Id ideaId,Id ntwrkId) {
        EntitySubscription ensubscrptn= new EntitySubscription(SubscriberId= subId,ParentId=ideaId,NetworkId= ntwrkId);
        Database.insert(ensubscrptn);
        return ensubscrptn;
    }
    
    //Vote Create
    public static Vote__c createVote(Integer DownVote,Id ideaId,Integer Upvote) {
        Vote__c voted= new Vote__c(DownVote__c=DownVote,Idea__c=ideaId,Upvote__c=Upvote);
        insert voted;
        return voted;
    }
    
    //Contact US
    public static Contact_Us__c createContactUS() {
    Contact_Us__c conc= new Contact_Us__c(First_Name__c='TestConc',Last_Name__c='TestLast',
                                          Description__c='Description',Email__c='test@tavant.com');
    insert conc;
    return conc;
    }
    
    //Create Case without insert statement
    public static Case submittedcreateCase() {
    Id recordTypeId=Schema.getGlobalDescribe().get('Case').getDescribe().getRecordTypeInfosByName().get('Customer Portal Case').getRecordTypeId();
        Case cs = new Case();
        cs.RecordTypeId=recordTypeId;
        cs.Origin='Draft';
        cs.Status='Email';
        cs.Salesforce_Org_Id__c='safdafdaf';       
        return cs;
    }
    //Create Case 
    public static Case createCase() {
    Id recordTypeId=Schema.getGlobalDescribe().get('Case').getDescribe().getRecordTypeInfosByName().get('Customer Portal Case').getRecordTypeId();
        Case cs = new Case();
        cs.RecordTypeId=recordTypeId;
        cs.Origin='Draft';
        cs.Status='Email';
        cs.Salesforce_Org_Id__c='safdafdaf';
        insert cs;
        return cs;
    }
    
    //Create CaseLine Item
    public static Case_Line_Item__c createCaseLineitem(Id case1) {
        Case_Line_Item__c cslneitm= new Case_Line_Item__c();
        cslneitm.Licence_Name__c='Warranty Support';
        cslneitm.Case__c= case1;
        insert cslneitm;
        return cslneitm;
    }
     //Create CaseLine Item without DML Statement
    public static Case_Line_Item__c createCSLineitem(Id case1) {
        Case_Line_Item__c cslneitm= new Case_Line_Item__c();
        cslneitm.Licence_Name__c='Warranty Support';
        cslneitm.Case__c= case1;        
        return cslneitm;
    }
    
}