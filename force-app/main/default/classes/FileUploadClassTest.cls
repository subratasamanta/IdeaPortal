@isTest
private class FileUploadClassTest {
    @isTest static void FileUploadTest(){
        Idea__c ideac= PortalTestDataFactory.createIdeas('Test Idea2','Claim','Test3','Submitted');
        Test.startTest();
        	FileUploadClass.WrapperFileInfo filewrap= new FileUploadClass.WrapperFileInfo();
        	filewrap.title = 'Test';
        	filewrap.ownerName = 'Test';
        	//filewrap.lastModDate;
        	filewrap.ContentDocumentId='a1b2g0000000E2zAAE';
        	FileUploadClass.releatedFiles(ideac.Id);
        Test.stopTest();
    }
}