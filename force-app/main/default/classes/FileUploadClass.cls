public with sharing class FileUploadClass {
    
    @AuraEnabled
    public static list<WrapperFileInfo> releatedFiles(Id idParent){
        set<id> lstConDocs = new set<id>();
        list<WrapperFileInfo> fileInfoList = new list<WrapperFileInfo>();
        list<ContentDocument> cdList = new list<ContentDocument>();
        for(ContentDocumentLink cntLink : [Select Id, ContentDocumentId From ContentDocumentLink Where LinkedEntityId =:idParent]) {
            lstConDocs.add(cntLink.ContentDocumentId);
        }
        if(!lstConDocs.isEmpty()) {
            cdList = [SELECT Id,LastModifiedDate,OwnerId,Owner.Name,Title FROM ContentDocument
                    WHERE Id IN :lstConDocs];
            for(ContentDocument cd : cdList){
                WrapperFileInfo fileInfo = new WrapperFileInfo();
                fileInfo.title = cd.Title;
                fileInfo.ownerName = cd.Owner.Name;
                fileInfo.lastModDate =  cd.LastModifiedDate;
                fileInfo.ContentDocumentId = cd.Id;
                fileInfoList.add(fileInfo);
            }
            return fileInfoList;
        }
        else {
            return fileInfoList;
        }
    }
	

    @AuraEnabled
    public static String getDownloadURL(String contentDocId) {
        String fullFileURL= URL.getSalesforceBaseUrl().toExternalForm()+'/tavantcustomerportal/sfc/servlet.shepherd/document/download/';
        
        //String fullFileURL = 'https://testingbox-mytavant.cs35.force.com/tavantcustomerportal/sfc/servlet.shepherd/document/download/';
        fullFileURL += contentDocId;
        System.debug('fullFileURL :' + fullFileURL);
        return fullFileURL;
    }

     @AuraEnabled
    public static Boolean deleteAttachment(String atchId){
        Boolean isDeleted = false;
        ContentDocument condoc=[SELECT Id FROM ContentDocument WHERE Id =: atchId];
        try{
            delete condoc;
            isDeleted=true;
        }
        catch(Exception e){
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        return isDeleted;
    }

public without sharing class WrapperFileInfo {
    @AuraEnabled public String title;
    @AuraEnabled public String ownerName;
    @AuraEnabled public DateTime lastModDate;
    @AuraEnabled public Id ContentDocumentId;
}
    
}