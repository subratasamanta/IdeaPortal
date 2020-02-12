public class UploadAttachmentController {

    

    public String selectedType {get;set;}

    public Boolean selectedAwesomeness {get;set;}

    public String description {get;set;}

    private Opportunity Opportunity {get;set;} 

    public String fileName {get;set;}

    public Blob fileBody {get;set;}

    

    public UploadAttachmentController(ApexPages.StandardController controller) { 

        this.opportunity= (Opportunity)controller.getRecord();

    }   

    

    // creates a new Opportunity_Attachment__c record

    private Database.SaveResult saveCustomAttachment() {

        Opportunity_Attachment__c obj = new Opportunity_Attachment__c();

        obj.Opportunity__c = Opportunity.Id; 

        obj.description__c = description;

        obj.type__c = selectedType;


        // fill out cust obj fields

        return Database.insert(obj);

    }

    

    // create an actual Attachment record with the Opportunity_Attachment__c as parent

    private Database.SaveResult saveStandardAttachment(Id parentId) {

        Database.SaveResult result;

        

        Attachment attachment = new Attachment();

        attachment.body = this.fileBody;

        attachment.name = this.fileName;

        attachment.parentId = parentId;

        // inser the attahcment

        result = Database.insert(attachment);

        // reset the file for the view state

        fileBody = Blob.valueOf(' ');

        return result;

    }

    

    /**

    * Upload process is:

    *  1. Insert new Opportunity_Attachment__c record

    *  2. Insert new Attachment with the new Opportunity_Attachment__c record as parent

    *  3. Update the Opportunity_Attachment__c record with the ID of the new Attachment

    **/

    public PageReference processUpload() {

        try {

            Database.SaveResult customAttachmentResult = saveCustomAttachment();

        

            if (customAttachmentResult == null || !customAttachmentResult.isSuccess()) {

                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 

                  'Could not save attachment.'));

                return null;

            }

        

            Database.SaveResult attachmentResult = saveStandardAttachment(customAttachmentResult.getId());

        

            if (attachmentResult == null || !attachmentResult.isSuccess()) {

                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 

                  'Could not save attachment.'));            

                return null;

            } else {

                // update the custom attachment record with some attachment info

                Opportunity_Attachment__c customAttachment = [select id from Opportunity_Attachment__c where id = :customAttachmentResult.getId()];

                customAttachment.name = this.fileName;

                customAttachment.Attachment__c = attachmentResult.getId();

                update customAttachment;

            }

        

        } catch (Exception e) {

            ApexPages.AddMessages(e);

            return null;

        }

        

        return new PageReference('/'+Opportunity.Id);

    }

    

    public PageReference back() {

        return new PageReference('/'+Opportunity.Id);

    }     



}