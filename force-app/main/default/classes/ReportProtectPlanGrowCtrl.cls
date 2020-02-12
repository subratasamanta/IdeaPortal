/**********************************************************************
   To Generate Reports On Protect Grow Plans
======================================================
======================================================
Purpose:                                                            
To Generate the Excel Report on Protect Grow Plans Summary of Client for Previous and Present Financial Years.
History                                                            
-------                                                            
VERSION  AUTHOR                          DATE            DETAIL                         FEATURES/CSR/TTP
   1.0 -    Pratap Murukutla           30/01/2015      INITIAL DEVELOPMENT                Report 
   
***********************************************************************/

public class ReportProtectPlanGrowCtrl{
     public list<PGPDetailsWrapper> PGPDetailsWrpr{get;set;}
	public Protect_Grow_Plan__c PGP{get;set;}
    public String outputList{get;set;}
   	public List<Protect_Grow_Plan_Details__c>  PGDPDetails{get;set;}
    public  ReportProtectPlanGrowCtrl(ApexPages.StandardController stdController){
        this.PGP = (Protect_Grow_Plan__c)stdController.getRecord();
        PGP = [Select Id, Name, Customer__c,Customer__r.Name,Report_Description__c,Financial_Year__c From Protect_Grow_Plan__c  Where Id=:PGP.id];
        // To Retrieve the Existing Protect Plan Details
       	PGDPDetails=[Select 
                    Protect_Grow_Plan__c,Opportunity__r.Name,Prev_FY_Value_of_Business_A__c,
                    Q1_Projection_of_A_for_Curr_FY__c,Q2_Projection_of_A_for_Curr_FY__c,Q3_Projection_of_A_for_Curr_FY__c,
                    Q4_Projection_of_A_for_Curr_FY__c,Total_Projection_of_A_for_Curr_FY__c, 
                    Q1_Potential_for_New_Services__c,Q2_Potential_for_New_Services__c,Q3_Potential_for_New_Services__c,
                    Q4_Potential_for_New_Services__c,Total_Potential_for_New_Services__c, 
                    Q1_Potential_for_Current_FY__c,Q2_Potential_for_Current_FY__c,Q3_Potential_for_Current_FY__c,
                    Q4_Potential_for_Current_FY__c,Total_Potential_for_Current_FY__c,Contact_List__c
                    from  Protect_Grow_Plan_Details__c where Protect_Grow_Plan__c=:PGP.id];
   	   PGPDetailsWrpr = new list<PGPDetailsWrapper>();
       for(Protect_Grow_Plan_Details__c PGPD:PGDPDetails){
             PGPDetailsWrapper PGP = new PGPDetailsWrapper();
           	 PGP.OppName=PGPD.Opportunity__r.Name;
           PGP.contactName=PGPD.Contact_List__c;
            if(PGPD.Prev_FY_Value_of_Business_A__c!=null)
                PGP.PrevFYTotal=PGPD.Prev_FY_Value_of_Business_A__c/1000;
            if(PGPD.Q1_Projection_of_A_for_Curr_FY__c!=null)
                PGP.Q1_Proj_Curr_FY=PGPD.Q1_Projection_of_A_for_Curr_FY__c/1000;
            if(PGPD.Q2_Projection_of_A_for_Curr_FY__c!=null)
                PGP.Q2_Proj_Curr_FY=PGPD.Q2_Projection_of_A_for_Curr_FY__c/1000;
            if(PGPD.Q3_Projection_of_A_for_Curr_FY__c!=null)
                PGP.Q3_Proj_Curr_FY=PGPD.Q3_Projection_of_A_for_Curr_FY__c/1000;
            if(PGPD.Q4_Projection_of_A_for_Curr_FY__c!=null)
                PGP.Q4_Proj_Curr_FY=PGPD.Q4_Projection_of_A_for_Curr_FY__c/1000;
            if(PGPD.Total_Projection_of_A_for_Curr_FY__c!=null)
                PGP.Total_Proj_Curr_FY=PGPD.Total_Projection_of_A_for_Curr_FY__c/1000;
           if(PGPD.Q1_Potential_for_New_Services__c!=null)
                PGP.Q1_Pot_New_Ser=PGPD.Q1_Potential_for_New_Services__c/1000;
            if(PGPD.Q2_Potential_for_New_Services__c!=null)
                PGP.Q2_Pot_New_Ser=PGPD.Q2_Potential_for_New_Services__c/1000;
            if(PGPD.Q3_Potential_for_New_Services__c!=null)
                PGP.Q3_Pot_New_Ser=PGPD.Q3_Potential_for_New_Services__c/1000;
            if(PGPD.Q4_Potential_for_New_Services__c!=null)
                PGP.Q4_Pot_New_Ser=PGPD.Q4_Potential_for_New_Services__c/1000;
            if(PGPD.Total_Potential_for_New_Services__c!=null)
                PGP.Total_Pot_New_Ser=PGPD.Total_Potential_for_New_Services__c/1000;
            if(PGPD.Q1_Potential_for_Current_FY__c!=null)
                PGP.Q1_Pot_Cur_FY=PGPD.Q1_Potential_for_Current_FY__c/1000;
            if(PGPD.Q2_Potential_for_Current_FY__c!=null)
                PGP.Q2_Pot_Cur_FY=PGPD.Q2_Potential_for_Current_FY__c/1000;
            if(PGPD.Q3_Potential_for_Current_FY__c!=null)
                PGP.Q3_Pot_Cur_FY=PGPD.Q3_Potential_for_Current_FY__c/1000;
            if(PGPD.Q4_Potential_for_Current_FY__c!=null)
                PGP.Q4_Pot_Cur_FY=PGPD.Q4_Potential_for_Current_FY__c/1000;
            if(PGPD.Total_Potential_for_Current_FY__c!=null)
                PGP.Total_Pot_Cur_FY=PGPD.Total_Potential_for_Current_FY__c/1000;
            
            PGPDetailsWrpr.add(PGP);
            
        }
    }
    public class PGPDetailsWrapper{
          public Decimal PrevFYTotal{get;set;}
         public String OppName{get;set;}
        public String contactName{get;set;}
        public Decimal Q1_Proj_Curr_FY{get;set;}
        public Decimal Q2_Proj_Curr_FY{get;set;}
        public Decimal Q3_Proj_Curr_FY{get;set;}
        public Decimal Q4_Proj_Curr_FY{get;set;}
        public Decimal Total_Proj_Curr_FY{get;set;}
        public Decimal Q1_Pot_New_Ser{get;set;}
        public Decimal Q2_Pot_New_Ser{get;set;}
        public Decimal Q3_Pot_New_Ser{get;set;}
        public Decimal Q4_Pot_New_Ser{get;set;}
        public Decimal Total_Pot_New_Ser{get;set;}
        public Decimal Q1_Pot_Cur_FY{get;set;}
        public Decimal Q2_Pot_Cur_FY{get;set;}
        public Decimal Q3_Pot_Cur_FY{get;set;}
        public Decimal Q4_Pot_Cur_FY{get;set;}
        public Decimal Total_Pot_Cur_FY{get;set;}
        public PGPDetailsWrapper(){
        }        
    }
    

}