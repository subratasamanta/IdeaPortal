@isTest
private class IdeaControllerTest {
    @isTest static void createIdeaTest(){
        Idea__c ideac= PortalTestDataFactory.createIdeas('Test Idea2','Claim','Test3','Submitted');
        Comment__c comment1= PortalTestDataFactory.createComment('Comment2',ideac.Id,'MyComments1');
        Account genAcc=PortalTestDataFactory.generateAccount();
        Contact createCon=PortalTestDataFactory.createContact(genAcc.id);
        User usrcrt=PortalTestDataFactory.UserCreate('Tavant Customer User',createCon.id);
        NetworkMember membership = [SELECT network.name, networkId, memberID FROM NetworkMember WHERE memberID =: usrcrt.id LIMIT 1];
        EntitySubscription ensubscrptn= PortalTestDataFactory.createSubscription(usrcrt.id,ideac.Id,membership.networkId);
        Vote__c voted=PortalTestDataFactory.createVote(3,ideac.Id,4);
       // IdeaController.WrapIdeasWithComments.setIdea idea=new IdeaController.WrapIdeasWithComments();
        Test.startTest();
        
        IdeaController.getIdeasWithComments();
        IdeaController.getIdeaID(ideac.Id);
        IdeaController.getIdeaID(ideac.CreatedById);
        IdeaController.getSpecificIdeaWithComments(ideac.Id);
        IdeaController.fetchAllRecentIdeas();
        IdeaController.fetchAllPopularIdeas();
        IdeaController.getMyIdeas();
        IdeaController.fetchSubIdeasWithComments(ideac.Id);
        IdeaController.fetchIdeasWithComments(ideac.Id);
        IdeaController.fetchRelatedIdeas(ideac.Id);
        
        Idea__c idea1=new Idea__c();
        IdeaController.createRecord(idea1);
        
        IdeaController.getselectOptions(idea1,'Status__c');
        IdeaController.UserCompany();
        IdeaController.saveComment(ideac.Id,ideac.Id,ideac.Id,ideac.Id);
        IdeaController.sortOldComments(ideac.Id);
        IdeaController.sortNewComments(ideac.Id);
        IdeaController.getIdeaSettings(ideac);
        IdeaController.donotShowComments(ideac);
        
        
        
        
        IdeaController.getDependentMap(idea1,'Claim','Inventory Transfer');
        
        //SObject instance = getSObjectType().newSObject(null, true);
        IdeaController.getDependentMap(ideac,'FirstName__c','LastName__c');
        
        IdeaController.mapIdeasWithCount();
        IdeaController.getData(ideac.Id,usrcrt.Id);
        //Catch Exception Case
        IdeaController.getData('  * ',' %');
        
        IdeaController.getIdea(ideac.Id);
        IdeaController.getIdea(ideac.CreatedById);
        IdeaController.getLoggedInUser();
        IdeaController.updateVote(voted.Id,Integer.valueOf(voted.DownVote__c),Integer.valueOf(voted.Upvote__c));
        IdeaController.insertVote(ideac.Id,3,4,usrcrt.Id);
        
       // List<EntitySubscription> ensub= new List<EntitySubscription>();
        // ensub= [SELECT Id,ParentId FROM EntitySubscription WHERE ParentId =: ideac.Id AND SubscriberId =:usrcrt.Id];
        
        IdeaController.WrapIdeasWithComments wrapper= new IdeaController.WrapIdeasWithComments();
        wrapper.objIdeaRecord=ideac;
        List<Comment__c> comm= [SELECT Id, Name,Idea__c,Idea__r.name,CommentBody__c,UpVotes__c FROM Comment__c];
        wrapper.subscribeString='ABC';
        wrapper.commentsCount=4;
        wrapper.logdUsrProfilename='ABC';
        wrapper.setIdea(ideac);
        
        IdeaController.PicklistEntryWrapper wrapperpcklst=new IdeaController.PicklistEntryWrapper();
        wrapperpcklst.active='true';
        wrapperpcklst.defaultValue='Test';
        wrapperpcklst.label='Test';
        wrapperpcklst.value='Test';
        wrapperpcklst.validFor='Test';
        wrapperpcklst.ideaCount=3;
        wrapperpcklst.showSubIdeas=true;
        //wrapperpcklst.PicklistEntryWrapper();
        
        ideac.Idea_Description__c='hadhsdhshdbhsssssssssssssssssssssssssssfweffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffewf';
        ideac.Idea_Description__c=ideac.Idea_Description__c+'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss';
       // update ideac;
        Test.stopTest();
        
        //System.assert(ensub.size()>0,'Expecting more than one idea');
       // System.assertEquals(4, comm.size());
    }
}