/**********************************************************************
   To Automatically Generate the plan details on Click Generate Plan Details in Protect & Grow Plan Page.
======================================================
======================================================
Purpose:                                                            
To Calculate Present Year quarter billing details and Previous year total Billing details of every Opportunity of Client
History                                                            
-------                                                            
VERSION  AUTHOR                          DATE            DETAIL                         FEATURES/CSR/TTP
   1.0 -    Pratap Murukutla           30/01/2015      INITIAL DEVELOPMENT                Generate Plan Details 
   
***********************************************************************/
public class ProtectGrowPlanExtCtrl{
    public Protect_Grow_Plan__c PGP{get;set;}
    public list<PGPDetailsWrapper> PGPDetailsWrpr{get;set;}
    //Constructor
    public ProtectGrowPlanExtCtrl(ApexPages.StandardController stdController){
        this.PGP = (Protect_Grow_Plan__c)stdController.getRecord();
        PGP = [Select Id, Name, Customer__r.Name,Customer__c,Financial_Year__c From Protect_Grow_Plan__c  Where Id=:PGP.id];
        PGPDetailsWrpr = new list<PGPDetailsWrapper>();
        //List of Wrappers to show the results Of Protect Plan details 
        PGPDetailsWrpr = getBillingDetails(PGP.Customer__r.Name, string.valueOf(PGP.Financial_Year__c)); 
      
    }
    
    private list<PGPDetailsWrapper> getBillingDetails(String AccountId, String FinYear){
        Integer PrevFinYear = Integer.valueOf(FinYear)-1;
        Set<String> FinYearSet = new set<String>();
        FinYearSet.add(FinYear);
        FinYearSet.add(string.valueOf(PrevFinYear));
        Integer FinYerInt = Integer.valueOf(FinYear);
        Set<String> oppStages = new set<String>();
        List<Opportunity_Stage_Names__c> opportunityStages=Opportunity_Stage_Names__c.getAll().values(); 
        for(Opportunity_Stage_Names__c opp:opportunityStages){
            oppStages.add(opp.Name);
        }
        
        //To query Billing Details of Present and Previous Years
        list<Billing_Details__c> AllBillDetails = [Select Id, Name, Year__c, BILLING_ACTUAL__c, BILLING_EXPECTED__c, BILLING_FORECAST__c,Opportunity_Name__c,Opportunity_Name__r.Name,Month__c From Billing_Details__c Where Year__c=:FinYearSet and Account_Name__c=:AccountId and Opportunity_Name__r.StageName=:oppStages]; 
        //ReportMap to contain Map of Calculated results of each Opportunity Billing Details.
        Map<String, OppBillingWrapper> ReportMap = new Map<String,OppBillingWrapper>();  
        for(Billing_Details__c BD : AllBillDetails){
            if(ReportMap.get(BD.Opportunity_Name__c) !=null){
                // Check the OppBillingWrapper exists
                OppBillingWrapper OBW = ReportMap.get(BD.Opportunity_Name__c);
                if(PrevFinYear == Integer.valueOf(BD.Year__c) && (BD.BILLING_ACTUAL__c!= null)){
                    //Check the Billing Detail is Previous Year and it contains the actual billing
                    if(OBW.PrevFYTotal != 0){
                        OBW.PrevFYTotal = OBW.PrevFYTotal + BD.BILLING_ACTUAL__c; //addition to Previous sum of Opportunity Billing Details
                     }else{
                         OBW.PrevFYTotal = BD.BILLING_ACTUAL__c; 
                     }                  
                 }
                else if(FinYerInt == Integer.valueOf(BD.Year__c) && (BD.BILLING_ACTUAL__c!= null) && (BD.Month__c!=null)){
                    //Check the Billing Detail is Previous Year and it contains the actual billing
                    if(Integer.valueOf(BD.Month__c) == 1 || Integer.valueOf(BD.Month__c) == 2 || Integer.valueOf(BD.Month__c) == 3){
                        //Quarter 1 results of Present Year
                        if(OBW.Q1 != 0){
                             OBW.Q1 = OBW.Q1 + BD.BILLING_ACTUAL__c;//addition to Previous sum of Opportunity Billing Details
                        }else{
                              OBW.Q1 = BD.BILLING_ACTUAL__c;
                            
                        }                      
                    }
                    if(Integer.valueOf(BD.Month__c) == 4 || Integer.valueOf(BD.Month__c) == 5 || Integer.valueOf(BD.Month__c) == 6){
                        if(OBW.Q2 != 0){
                             OBW.Q2 = OBW.Q2 + BD.BILLING_ACTUAL__c;
                         }else{
                             OBW.Q2 = BD.BILLING_ACTUAL__c;
                        }                      
                    }
                    if(Integer.valueOf(BD.Month__c) == 7 || Integer.valueOf(BD.Month__c) == 8 || Integer.valueOf(BD.Month__c) == 9){
                         if(OBW.Q3 != 0){
                              OBW.Q3 = OBW.Q3 + BD.BILLING_ACTUAL__c;
                         }else{
                             OBW.Q3 = BD.BILLING_ACTUAL__c;
                        }                      
                    }
                    if(Integer.valueOf(BD.Month__c) == 10 || Integer.valueOf(BD.Month__c) == 11 || Integer.valueOf(BD.Month__c) == 12){ 
                        if(OBW.Q4 != 0){
                             OBW.Q4 = OBW.Q4 + BD.BILLING_ACTUAL__c;
                        }else{
                             OBW.Q4 = BD.BILLING_ACTUAL__c;
                        }                      
                    }
                 }              
                 ReportMap.put(BD.Opportunity_Name__c, OBW);              
             }else{
                 //To define Map on the Opportunity Name.
                 OppBillingWrapper OBW = new OppBillingWrapper();
                 OBW.PrevFYTotal=0; OBW.Q1=0; 
                 OBW.Q2=0;
                 OBW.Q3=0;
                 OBW.Q4=0;
                 if(PrevFinYear == Integer.valueOf(BD.Year__c) && (BD.BILLING_ACTUAL__c!= null)){
                     OBW.PrevFYTotal = BD.BILLING_ACTUAL__c; 
                 }
                else if(FinYerInt == Integer.valueOf(BD.Year__c) && (BD.BILLING_ACTUAL__c!= null) && (BD.Month__c!=null)){
                    if(Integer.valueOf(BD.Month__c) == 1 || Integer.valueOf(BD.Month__c) == 2 || Integer.valueOf(BD.Month__c) == 3){
                        OBW.Q1 = BD.BILLING_ACTUAL__c;   
                    }
                    if(Integer.valueOf(BD.Month__c) == 4 || Integer.valueOf(BD.Month__c) == 5 || Integer.valueOf(BD.Month__c) == 6){
                        OBW.Q2 = BD.BILLING_ACTUAL__c;   
                    }
                    if(Integer.valueOf(BD.Month__c) == 7 || Integer.valueOf(BD.Month__c) == 8 || Integer.valueOf(BD.Month__c) == 9){
                        OBW.Q3 = BD.BILLING_ACTUAL__c;
                    }
                    if(Integer.valueOf(BD.Month__c) == 10 || Integer.valueOf(BD.Month__c) == 11 || Integer.valueOf(BD.Month__c) == 12){
                        OBW.Q4 = BD.BILLING_ACTUAL__c;                  
                    }
                }
                OBW.OppName=BD.Opportunity_Name__r.Name;
                ReportMap.put(BD.Opportunity_Name__c, OBW); 
             }      
        } 
        list<PGPDetailsWrapper> PGDWrprList = new list<PGPDetailsWrapper>(); 
        for(string OppId : ReportMap.keySet()){
            //Mapping of OppBillingWrapper to PGPDetailsWrapper
            PGPDetailsWrapper PGP = new PGPDetailsWrapper();
            PGP.OppId = OppId;
            PGP.OppBillWrpr=ReportMap.get(OppId);
            PGDWrprList.add(PGP);
        }
        return PGDWrprList;
    }
    //To Save the Wrapper Details to Protect Grow Plan Details.
    public pageReference savePGPDDetails(){
        List<Protect_Grow_Plan_Details__c> PGDPDetails=new List<Protect_Grow_Plan_Details__c>();
        PGDPDetails=[Select Protect_Grow_Plan__c,Opportunity__c from  Protect_Grow_Plan_Details__c where Protect_Grow_Plan__c=:PGP.id];
       	String contacts=null;
        List<Contact> contactList=[Select Name from Contact where  AccountId=:PGP.Customer__c];
        List<String> contactNameList=new List<String>();
        for(Contact cont:contactList){
            contactNameList.add(cont.Name);
        }
       contacts=String.join(contactNameList,'/');
        
        Map<String,Protect_Grow_Plan_Details__c> PGDPDetailsMap= New Map<String,Protect_Grow_Plan_Details__c>();
        for(Protect_Grow_Plan_Details__c PGDPDetail:PGDPDetails){
            PGDPDetailsMap.put(PGDPDetail.Opportunity__c,PGDPDetail);
         }
        List<Protect_Grow_Plan_Details__c> PGDPDetailsUpdate=new List<Protect_Grow_Plan_Details__c>();
        for(PGPDetailsWrapper PGDP:PGPDetailsWrpr){
            Protect_Grow_Plan_Details__c PGDPDetail;
            if(PGDPDetailsMap.get(PGDP.OppId)!=null){
                 //To Update the Existing Protect Grow Plan Detail with latest values of its Wrapper Details
                 PGDPDetail=PGDPDetailsMap.get(PGDP.OppId);
                 PGDPDetail.Prev_FY_Value_of_Business_A__c =PGDP.OppBillWrpr.PrevFYTotal;  
                 PGDPDetail.Q1_Projection_of_A_for_Curr_FY__c=PGDP.OppBillWrpr.Q1;
                 PGDPDetail.Q2_Projection_of_A_for_Curr_FY__c=PGDP.OppBillWrpr.Q2; 
                 PGDPDetail.Q3_Projection_of_A_for_Curr_FY__c=PGDP.OppBillWrpr.Q3; 
                 PGDPDetail.Q4_Projection_of_A_for_Curr_FY__c=PGDP.OppBillWrpr.Q4;  
                 PGDPDetail.Contact_List__c=contacts;
                 PGDPDetailsUpdate.add(PGDPDetail);
            } 
            else{
                //To Create Protect Grow Plan Detail with of its Wrapper Details
                PGDPDetail=new Protect_Grow_Plan_Details__c();
                PGDPDetail.Protect_Grow_Plan__c =PGP.id;
                PGDPDetail.Opportunity__c=PGDP.OppId;
                PGDPDetail.Prev_FY_Value_of_Business_A__c =PGDP.OppBillWrpr.PrevFYTotal;  
                PGDPDetail.Q1_Projection_of_A_for_Curr_FY__c=PGDP.OppBillWrpr.Q1;
                PGDPDetail.Q2_Projection_of_A_for_Curr_FY__c=PGDP.OppBillWrpr.Q2; 
                PGDPDetail.Q3_Projection_of_A_for_Curr_FY__c=PGDP.OppBillWrpr.Q3; 
                PGDPDetail.Q4_Projection_of_A_for_Curr_FY__c=PGDP.OppBillWrpr.Q4; 
                PGDPDetail.Contact_List__c=contacts;
                PGDPDetailsUpdate.add(PGDPDetail);   
            }   
        }
        upsert PGDPDetailsUpdate;
        //To return to Protect Grow Plan Page after the save operation.
        PageReference pageRef =  new PageReference('/'+PGP.Id);
        pageRef.setRedirect(true);
        return pageRef;         
 }

    public class PGPDetailsWrapper{
        public Protect_Grow_Plan_Details__c PDPD{get;set;}
        public String OppId{get;set;}
        public OppBillingWrapper OppBillWrpr{get;set;}
        public PGPDetailsWrapper(){
        }        
    }
    
    public class OppBillingWrapper{
        public Decimal PrevFYTotal{get;set;}
         public String OppName{get;set;}
        public Decimal Q1{get;set;}
        public Decimal Q2{get;set;}
        public Decimal Q3{get;set;}
        public Decimal Q4{get;set;}    
        public OppBillingWrapper(){
        } 
    }

}