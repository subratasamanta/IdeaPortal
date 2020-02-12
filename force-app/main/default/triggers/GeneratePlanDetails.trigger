/**********************************************************************
   To Automatically Generate the plan details on Protect Grow Plan is newly Created.
======================================================
======================================================
Purpose:                                                            
To Calculate Present Year quarter billing details and Previous year total Billing details of every Opportunity of Client
History                                                            
-------                                                            
VERSION  AUTHOR                          DATE            DETAIL                         FEATURES/CSR/TTP
   1.0 -    Pratap Murukutla           30/01/2015      INITIAL DEVELOPMENT                Generate Plan Details 
   
***********************************************************************/


trigger GeneratePlanDetails on Protect_Grow_Plan__c(after insert){
  	Set<String> FinYearSet= new Set<String>(); 
    Set<String> PGPIdSet= new Set<String>();
    Integer PrevFinYear;
    Integer FinYerInt;
    ID pgpId;
    Protect_Grow_Plan__c PGPRecord=new Protect_Grow_Plan__c();
	for(Protect_Grow_Plan__c PGP:Trigger.new){ 
		//Assuming that not multiple Protect Grow Plans are initiated.
        PGPRecord=PGP;
        PrevFinYear = Integer.valueOf(PGP.Financial_Year__c)-1;
        FinYearSet.add(String.valueOf(PGP.Financial_Year__c));
        FinYearSet.add(string.valueOf(PrevFinYear));
    }
    FinYerInt=Integer.valueOf(PGPRecord.Financial_Year__c);
    PrevFinYear=Integer.valueOf(PGPRecord.Financial_Year__c)-1;
    List<Protect_Grow_Plan_Details__c> PGDPDetails=new List<Protect_Grow_Plan_Details__c>();
    String contacts=null;
        List<Contact> contactList=[Select Name from Contact where  AccountId=:PGPRecord.Customer__c];
        List<String> contactNameList=new List<String>();
        for(Contact cont:contactList){
            contactNameList.add(cont.Name);
        }
       contacts=String.join(contactNameList,'/');
    
    
    //PGDPDetailsMap to contain Map of Calculated results of each Opportunity Billing Details.
    Map<String,Protect_Grow_Plan_Details__c> PGDPDetailsMap= New Map<String,Protect_Grow_Plan_Details__c>();
     Set<String> oppStages = new set<String>();
        List<Opportunity_Stage_Names__c> opportunityStages=Opportunity_Stage_Names__c.getAll().values(); 
        for(Opportunity_Stage_Names__c opp:opportunityStages){
            oppStages.add(opp.Name);
        }
    //To query Billing Details of Present and Previous Years
    list<Billing_Details__c> AllBillDetails = [Select Id, Name, Year__c, BILLING_ACTUAL__c, BILLING_EXPECTED__c, BILLING_FORECAST__c, Opportunity_Name__c,Opportunity_Name__r.Name, Month__c From Billing_Details__c Where Year__c=:FinYearSet and Opportunity_Name__r.Account.id=:PGPRecord.Customer__c and Opportunity_Name__r.StageName=:oppStages];
    system.debug('---AllBillDetails----'+AllBillDetails.size());
    for(Billing_Details__c BD : AllBillDetails){
    	system.debug('---BD----'+BD);
        if(PGDPDetailsMap.get(BD.Opportunity_Name__c)!=null){
            // Check the Protect Grow Plan Details exists
            Protect_Grow_Plan_Details__c PGPD =  PGDPDetailsMap.get(BD.Opportunity_Name__c);
			if(PrevFinYear == Integer.valueOf(BD.Year__c) && (BD.BILLING_ACTUAL__c!= null)){
                //Check the Billing Detail is Previous Year and it contains the actual billing
				if(PGPD.Prev_FY_Value_of_Business_A__c != 0){
                  	PGPD.Prev_FY_Value_of_Business_A__c = PGPD.Prev_FY_Value_of_Business_A__c + BD.BILLING_ACTUAL__c;//addition to Previous sum of Opportunity Billing Details
                }else{
                 	 PGPD.Prev_FY_Value_of_Business_A__c = BD.BILLING_ACTUAL__c;
                }                  
            }  
            else if(FinYerInt == Integer.valueOf(BD.Year__c) && (BD.BILLING_ACTUAL__c!= null) && (BD.Month__c!=null)){
                 //Check the Billing Detail is Present and it contains the actual billing
				if(Integer.valueOf(BD.Month__c) == 1 || Integer.valueOf(BD.Month__c) == 2 || Integer.valueOf(BD.Month__c) == 3){ 
                    //Quarter 1 results of Present Year
                	if(PGPD.Q1_Projection_of_A_for_Curr_FY__c != 0){
                    	PGPD.Q1_Projection_of_A_for_Curr_FY__c = PGPD.Q1_Projection_of_A_for_Curr_FY__c + BD.BILLING_ACTUAL__c;//addition to Previous sum of Opportunity Billing Details
    				}else{
                        PGPD.Q1_Projection_of_A_for_Curr_FY__c = BD.BILLING_ACTUAL__c;
                    }                      
                }
                if(Integer.valueOf(BD.Month__c) == 4 || Integer.valueOf(BD.Month__c) == 5 || Integer.valueOf(BD.Month__c) == 6){
                	if(PGPD.Q2_Projection_of_A_for_Curr_FY__c != 0){
                    	PGPD.Q2_Projection_of_A_for_Curr_FY__c = PGPD.Q2_Projection_of_A_for_Curr_FY__c + BD.BILLING_ACTUAL__c;
                    }else{
                        PGPD.Q2_Projection_of_A_for_Curr_FY__c = BD.BILLING_ACTUAL__c;
                    }                      
                }
                if(Integer.valueOf(BD.Month__c) == 7 || Integer.valueOf(BD.Month__c) == 8 || Integer.valueOf(BD.Month__c) == 9){
                    if(PGPD.Q3_Projection_of_A_for_Curr_FY__c != 0){
                       PGPD.Q3_Projection_of_A_for_Curr_FY__c = PGPD.Q3_Projection_of_A_for_Curr_FY__c + BD.BILLING_ACTUAL__c;
                    }else{
                        PGPD.Q3_Projection_of_A_for_Curr_FY__c = BD.BILLING_ACTUAL__c;
                    }                      
                  }
                if(Integer.valueOf(BD.Month__c) == 10 || Integer.valueOf(BD.Month__c) == 11 || Integer.valueOf(BD.Month__c) == 12){ 
                    if(PGPD.Q4_Projection_of_A_for_Curr_FY__c != 0){
                        PGPD.Q4_Projection_of_A_for_Curr_FY__c = PGPD.Q4_Projection_of_A_for_Curr_FY__c + BD.BILLING_ACTUAL__c;
                    }else{
                        PGPD.Q4_Projection_of_A_for_Curr_FY__c = BD.BILLING_ACTUAL__c;
                    }                      
                }
			}                      
		}else{ 
            //To define Map on the Opportunity Name.
			Protect_Grow_Plan_Details__c PGPD = new  Protect_Grow_Plan_Details__c();
            PGPD.Contact_List__c=contacts;
            PGPD.Prev_FY_Value_of_Business_A__c=0;
            PGPD.Q1_Projection_of_A_for_Curr_FY__c=0;
            PGPD.Q2_Projection_of_A_for_Curr_FY__c=0;
            PGPD.Q3_Projection_of_A_for_Curr_FY__c=0;
            PGPD.Q4_Projection_of_A_for_Curr_FY__c=0;
            PGPD.Protect_Grow_Plan__c=PGPRecord.Id;
            PGPD.Opportunity__c=BD.Opportunity_Name__c;
            if(PrevFinYear == Integer.valueOf(BD.Year__c) && (BD.BILLING_ACTUAL__c!= null)){
            	PGPD.Prev_FY_Value_of_Business_A__c = BD.BILLING_ACTUAL__c; 
            }
            else if(FinYerInt == Integer.valueOf(BD.Year__c) && (BD.BILLING_ACTUAL__c!= null) && (BD.Month__c!=null)){
            	if(Integer.valueOf(BD.Month__c) == 1 || Integer.valueOf(BD.Month__c) == 2 || Integer.valueOf(BD.Month__c) == 3){
                	PGPD.Q1_Projection_of_A_for_Curr_FY__c = BD.BILLING_ACTUAL__c;   
                }
                if(Integer.valueOf(BD.Month__c) == 4 || Integer.valueOf(BD.Month__c) == 5 || Integer.valueOf(BD.Month__c) == 6){
                    PGPD.Q2_Projection_of_A_for_Curr_FY__c = BD.BILLING_ACTUAL__c;    
                }
                if(Integer.valueOf(BD.Month__c) == 7 || Integer.valueOf(BD.Month__c) == 8 || Integer.valueOf(BD.Month__c) == 9){
                	PGPD.Q3_Projection_of_A_for_Curr_FY__c = BD.BILLING_ACTUAL__c;
                }
                if(Integer.valueOf(BD.Month__c) == 10 || Integer.valueOf(BD.Month__c) == 11 || Integer.valueOf(BD.Month__c) == 12){
                	PGPD.Q4_Projection_of_A_for_Curr_FY__c = BD.BILLING_ACTUAL__c;                  
                }
            }
            PGDPDetailsMap.put(BD.Opportunity_Name__c, PGPD); 
            PGDPDetails.add(PGPD);
        }      
    } 
    
    insert PGDPDetails;
}