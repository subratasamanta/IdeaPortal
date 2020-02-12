public class FormConroller{
    public Scorecard__c scoreform{
    get{
    if (scoreform == null)
      scoreform   = new Scorecard__c();
      return scoreform;
    }
    set;
    }
    public PageReference save(){
    try{
     upsert(scoreform);
   }catch(System.DMLException e){
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error creating new scorecard.'));
      return null;
    }
    return (new ApexPages.StandardController(scoreform)).view();
    //return null;
  }
  public PageReference SaveAndNew() {
    save();
    PageReference pageRef = new PageReference('https://c.ap1.visual.force.com/apex/Scorecard_Definition?sfdc.tabName=01r90000000R2Of');
    return pageRef;
}
  public PageReference cancel(){
   return null;
    } 
  public List<Scorecard__c> searchResults {get;set;}
  public string searchText {get;set;}
  public PageReference search() {
   try{
    String qry = 'select Id, Name, Department__c,Sub_Department__c,To__c,From__c,Year__c from Scorecard__c where name LIKE \'%'+searchText+'%\' order by name';
    searchResults = Database.query(qry);
    return null;
   }
   catch(System.DMLException e){
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error Searching scorecards.'));
      return null;
    }
   }
}