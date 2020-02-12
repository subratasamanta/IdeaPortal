@isTest
private class VoteControllerTest {
        @isTest static void createIdeaTest(){
            Idea__c ideac= PortalTestDataFactory.createIdeas('Test Idea2','Claim','Test3','Submitted');
            Account genAcc=PortalTestDataFactory.generateAccount();
            Contact createCon=PortalTestDataFactory.createContact(genAcc.id);
            User usrcrt=PortalTestDataFactory.UserCreate('Tavant Customer User',createCon.id);
            Vote__c voted=PortalTestDataFactory.createVote(3,ideac.Id,4);
    
    	Test.startTest();
    		VoteController.getData(ideac.id,usrcrt.id);
            VoteController.getData(ideac.CreatedById,usrcrt.CreatedById);
            VoteController.getIdea(ideac.id);
            VoteController.getIdea(ideac.CreatedById);
            VoteController.getIdea(null);
            VoteController.getLoggedInUser();
            VoteController.updateVote(voted.Id,3, 4);
            //Idea__c idea1 = new Idea__c();
            VoteController.insertVote(ideac.id, 3, 5, usrcrt.id);
            VoteController.deleteWithDrawnVote(voted.Id);
            VoteController.deleteWithDrawnVote(voted.CreatedById);
            VoteController.ideaWrapperCLS wrapperTest= new VoteController.ideaWrapperCLS();
            wrapperTest.upvoted=true;
            wrapperTest.downvoted= true;
    	Test.stopTest();
        }
}