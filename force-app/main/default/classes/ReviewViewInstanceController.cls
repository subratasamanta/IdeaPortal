public class ReviewViewInstanceController{
  public List<Financial__c> finances{get; set;}
  public List<Customer__c> customers{get; set;}
  public List<Internal_process__c> internals{get; set;}
  public List<Learning_and_Growth__c> learnings{get; set;}
  public Scorecard_Instances__c scorecardinstancedetails;
  public Scorecard__c scorecarddetails;
  public Scorecard__c getscorecarddetails() {
     return scorecarddetails;
  }
  public List<Scorecard_Instances__c> detailsReviewpage{get; set;}
  public string refresh =  Apexpages.currentPage().getParameters().get('refresh');
  public  ReviewViewInstanceController(){

    scorecarddetails = [SELECT 
                         Weighted_Score_1_Owner__c,
                         Weighted_Score_2_Owner__c 
    FROM Scorecard__c 
    WHERE Id = :Apexpages.currentPage().getParameters().get('selectedScorecard')];
    scorecardinstancedetails= [SELECT 
    Name,
    Year__c,
    Month__c,
    Status__c,Weighted__c,Weighted_2__c,
    Scorecard__c FROM Scorecard_Instances__c
    WHERE Id=:Apexpages.currentPage().getParameters().get('selectedInstanceScorecard')];
    
    finances = [SELECT 
                Name,
                Current_Value_Grade__c,
                Grade__c,
                Current_Value__c,
                Initiatives__c,
                Future_Initiatives__c,Previous_Value__c,
                Metrics__c,
                Objectives__c,
                Targets__c,
                Target_Grade_Value__c,
                Review_Comments__c,Score__c,Weighted_1__c,Weighted_2__c
    FROM Financial__c 
    WHERE LinkID__c=:Apexpages.currentPage().getParameters().get('selectedInstanceScorecard')];
    customers =[SELECT 
                Name,
                Current_Value_Grade__c,
                Grade__c,
                Current_Value__c,
                Initiatives__c,
                Future_Initiatives__c,Previous_Value__c,
                Metrics__c,
                Objectives__c,
                Targets__c,
                Target_Grade_Value__c,
                Review_Comments__c,Score__c,Weighted_1__c,Weighted_2__c 
    FROM Customer__c 
    WHERE LinkID__c=:Apexpages.currentPage().getParameters().get('selectedInstanceScorecard')];
    learnings =[SELECT 
                Name,
                Current_Value_Grade__c,
                Grade__c,
                Current_Value__c,
                Initiatives__c,
                Future_Initiatives__c,Previous_Value__c,
                Metrics__c,
                Objectives__c,
                Targets__c,
                Target_Grade_Value__c,
                Review_Comments__c,Score__c,Weighted_1__c,Weighted_2__c 
    FROM Learning_and_Growth__c 
    WHERE LinkID__c=:Apexpages.currentPage().getParameters().get('selectedInstanceScorecard')];
    internals =[SELECT 
                Name,
                Current_Value_Grade__c,
                Grade__c,
                Current_Value__c,
                Initiatives__c,
                Future_Initiatives__c,Previous_Value__c,
                Metrics__c,
                Objectives__c,
                Targets__c,
                Target_Grade_Value__c,
                Review_Comments__c,Score__c,Weighted_1__c,Weighted_2__c 
    FROM Internal_process__c 
    WHERE LinkID__c=:Apexpages.currentPage().getParameters().get('selectedInstanceScorecard')];
    }
    public Scorecard_Instances__c getscorecardinstancedetails() {
        return scorecardinstancedetails;
       }   
  public PageReference save(){
     try{
       scorecardinstancedetails.Status__c = 'Final Submitted';
       update scorecardinstancedetails;
       update(finances);
       update(customers);   
       update(internals);
       update(learnings);
     }
     catch(System.DMLException e){
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error creating new scorecard.'));
      return null;
     }
    PageReference redirect = new PageReference(refresh);
    redirect.setRedirect(true); 
    return redirect;
  }
 public PageReference reject(){
     try{
         scorecardinstancedetails.Status__c = 'Open';
         update scorecardinstancedetails;
         update(finances);
         update(customers);   
         update(internals);
         update(learnings);
     }
     catch(System.DMLException e){
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error creating new scorecard.'));
      return null;
     }
    PageReference redirect = new PageReference(refresh);
    redirect.setRedirect(true); 
    return redirect;
  }
}