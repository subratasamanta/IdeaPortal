public class ChatterActivityCtrl {

    public Date SToDate { get; set; }
    public Date SFromDate { get; set; }
    public boolean errorFound{get;set;}
    public boolean CountComments{get;set;}    
    public list<ReportWrapper> ReportWrprList{get;set;}
  
    public ChatterActivityCtrl(){
        ReportWrprList = new list<ReportWrapper>();
        errorFound = false;
        CountComments = false;
    }
  
  
  public void runReport(){
    errorFound = false;  
    ReportWrprList = new list<ReportWrapper>();
    try{
        Date FromDate = SFromDate;
        Date ToDate = SToDate;
        
        if(FromDate > Todate){
            AddError('To Date should not be greater than From Date');
        }
        Integer numberDaysDue = FromDate.daysBetween(ToDate);
        if(numberDaysDue > 10){
            AddError('We can not process data for more than 10 days');
        }
        
        boolean isGDM = true;        
        list<User> GDMUserList = [Select Id from User Where Is_GDM__c=:isGDM];
        if(GDMUserList.isEmpty()){
            AddError('NO GDM User Found');           
        }        
        if(!errorFound){ 
            QueryFeed(GDMUserList, FromDate, ToDate);
        }
      
    }catch(Exception e){
        AddError('Un Expected Error. Please Contact Your Administrator');        
        system.debug('# Exception'+e);
    }    
    
  }
  
  
  public void QueryFeed(list<user> LGDMUserList, Date LFromDate, Date LToDate){ 
        ReportWrprList = new list<ReportWrapper>();  
        Map<String,Integer> FeedCount = new Map<String,Integer>();

        list<FeedItem> FeedItemList = [Select CreatedBy.Name, InsertedById,(Select CreatedBy.Name, CreatedById From FeedComments Where CreatedById IN: LGDMUserList ) From FeedItem Where CreatedById IN: LGDMUserList AND CreatedDate >: LFromDate and CreatedDate <: LToDate];
        for(FeedItem fi : FeedItemList){
            if(FeedCount.get(fi.CreatedBy.Name) != null){
                Integer PostCount = FeedCount.get(fi.CreatedBy.Name) + 1; 
                FeedCount.put(fi.CreatedBy.Name,PostCount);
            }else{
                FeedCount.put(fi.CreatedBy.Name,1);
            }
            if(CountComments){
             for(FeedComment fc : fi.FeedComments){
                 if(FeedCount.get(fc.CreatedBy.Name) != null){
                     Integer ComentCount = FeedCount.get(fc.CreatedBy.Name) + 1; 
                     FeedCount.put(fc.CreatedBy.Name,ComentCount );
                 }else{
                     FeedCount.put(fc.CreatedBy.Name,1);
                 }                
             }
            }
        }
      
        for(String s:FeedCount.keySet()){
            ReportWrprList.add(new ReportWrapper(s,FeedCount.get(s)));
        }
      //return  FeedCount;
  }
  
  
  public void AddError(string errorMsg){
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,errorMsg);
        ApexPages.addMessage(myMsg); 
        errorFound = true;
  }
  
  
  public class ReportWrapper{
    public string UserName{get;set;}
    public Integer PostCount{get;set;}
    public Integer CommentCount{get;set;}
    
    public ReportWrapper(string s, Integer pc){
        this.UserName = s;
        this.PostCount = pc;     
    }
  }
  
  
}