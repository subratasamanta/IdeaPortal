public with sharing class DownloadRestClass {
    public static List<String> getDownloadURL(Set<String> contentDocIdSet) {
        
        List<ContentVersion> contentVerList =  [SELECT ContentDocumentId,Id FROM ContentVersion
                                                WHERE ContentDocumentId in: contentDocIdSet];
        List<String> urlDownloadList = new List<String>();
        String fullFileURL= URL.getSalesforceBaseUrl().toExternalForm();
        fullFileURL += '/sfc/servlet.shepherd/version/download/';
        for(ContentVersion cv : contentVerList){
            String urlDownload= fullFileURL+cv.Id; 
            System.debug('URL :'+urlDownload);
            urlDownloadList.add(urlDownload);
        }
        System.debug('urlDownloadList.size() :'+urlDownloadList.size());
        return urlDownloadList;
    }
}