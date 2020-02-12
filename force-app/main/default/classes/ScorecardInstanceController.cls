public class ScorecardInstanceController{
    public List<Financial__c> finances{get; set;}
    public String monthunii{get; set;}
    public List<Customer__c> customers{get; set;}
    public List<Internal_process__c> internals{get; set;}
    public List<Learning_and_Growth__c> learnings{get; set;}  
    public Scorecard__c scorecarddetails;
    public Scorecard_Instances__c scorecardinstancedetails;
    public List<Metrics__c> allmetrics;
    public List<Metrics__c> financemetrics;
    public List<Metrics__c> customermetrics;
    public List<Metrics__c> learningmetrics;
    public List<Metrics__c> internalmetrics;
    public string refresh =  Apexpages.currentPage().getParameters().get('refresh');
    public Finance_Data_form__c FinanceFields;
    public Sales_Marketing_Data_Form__c SalesFields;
    public Marketing_Data_Form__c MarketingFields;
    public RMG_Data_Form__c RMGFields;
    public SEPG_Data_Form__c SEPGFields;
    public PMO_Data_Form__c PMOFields;
    public HR_Data_form__c HRFields;
    public List<Financial__c> financialData{get; set;}
    public ScorecardInstanceController(){ 
//Master Scorecard details
    scorecarddetails = [SELECT 
                         Name,Id,Department__c,Frequency__c,Sub_Department__c,
                         Weighted_Score_1_Owner__c,
                         Weighted_Score_2_Owner__c 
     FROM Scorecard__c 
     WHERE Id = :Apexpages.currentPage().getParameters().get('selectedScorecard')];
//render scorecard instance from database or create new       
    if(Apexpages.currentPage().getParameters().get('selectedInstanceScorecard') != null){
       scorecardinstancedetails = [SELECT Name, Year__c, Frequency__c,Month__c, Status__c,Weighted__c, Weighted_2__c, Scorecard__c 
       FROM Scorecard_Instances__c 
       WHERE Id = :Apexpages.currentPage().getParameters().get('selectedInstanceScorecard')];                           
           }else{
            scorecardinstancedetails = new Scorecard_Instances__c();
      }
       financemetrics=[SELECT 
       Name,Id,Objective__c,Grade__c,Yearly_Target__c,Yearly_Target2__c,Metric_Type__c,Weightage_1__c,Weightage_2__c
       FROM Metrics__c
       WHERE Scorecard__c=:Apexpages.currentPage().getParameters().get('selectedScorecard') and Category__c='Financial'
       ORDER BY Name];
       customermetrics = [SELECT 
       Name,Id,Grade__c,Yearly_Target__c,Yearly_Target2__c,Metric_Type__c,Weightage_1__c,Weightage_2__c 
       FROM Metrics__c
       WHERE Scorecard__c=:Apexpages.currentPage().getParameters().get('selectedScorecard') and Category__c='Customer'
       ORDER BY Name];
       learningmetrics = [SELECT 
       Name,Grade__c,Id,Objective__c,Yearly_Target__c,Yearly_Target2__c,Metric_Type__c,Weightage_1__c,Weightage_2__c 
       FROM Metrics__c
       WHERE Scorecard__c=:Apexpages.currentPage().getParameters().get('selectedScorecard') and Category__c='Learning & Growth' 
       ORDER BY Name];
       internalmetrics = [SELECT 
       Name,Grade__c,Id,Objective__c,Yearly_Target__c,Yearly_Target2__c,Metric_Type__c,Weightage_1__c,Weightage_2__c 
       FROM Metrics__c
       WHERE Scorecard__c=:Apexpages.currentPage().getParameters().get('selectedScorecard') and Category__c='Internal Process'
       ORDER BY Name];       
     finances();
     customers();   
     learnings();
     internals();
       allmetrics = [SELECT Metric_Type__c FROM Metrics__c
       WHERE Scorecard__c=:Apexpages.currentPage().getParameters().get('selectedScorecard')];
    }
    public void finances(){
       finances = [SELECT 
                   Name,
                   Current_Value__c,
                   Current_Value_Grade__c,
                   Initiatives__c,
                   Future_Initiatives__c,Previous_Value__c,
                   Metrics__c,
                   Grade__c,
                   Objectives__c,
                   Targets__c,
                   Target_Grade_Value__c,
                   Review_Comments__c,Score__c,Weighted_1__c,Weighted_2__c
       FROM Financial__c 
       WHERE LinkID__c=:Apexpages.currentPage().getParameters().get('selectedInstanceScorecard')];       
       if(Apexpages.currentPage().getParameters().get('selectedInstanceScorecard')==null){
         for(integer i=0;i<financemetrics.size();i++){
            finances.add(new Financial__c());
            finances[i].Grade__c = financemetrics[i].Grade__c;
            finances[i].Metrics__c = financemetrics[i].Id;
            finances[i].Objectives__c = financemetrics[i].Objective__c;
            finances[i].Weighted_1__c = financemetrics[i].Weightage_1__c;
            finances[i].Weighted_2__c = financemetrics[i].Weightage_2__c;
            if(financemetrics[i].Grade__c == true){
                finances[i].Previous_Value__c = financemetrics[i].Yearly_Target__c;
            }else{
                finances[i].Previous_Value__c = string.valueof(financemetrics[i].Yearly_Target2__c);
            }
         }
       }
    }
    public void customers(){
      customers =[SELECT 
                  Name,
                  Current_Value__c,
                  Current_Value_Grade__c,
                  Initiatives__c,
                  Future_Initiatives__c,Previous_Value__c,
                  Grade__c,
                  Metrics__c,
                  Targets__c,
                  Target_Grade_Value__c,
                  Review_Comments__c,Score__c,Weighted_1__c,Weighted_2__c
      FROM Customer__c 
      WHERE LinkID__c=:Apexpages.currentPage().getParameters().get('selectedInstanceScorecard')];      
      if(Apexpages.currentPage().getParameters().get('selectedInstanceScorecard')==null){
       for(integer i=0;i<customermetrics.size();i++){
           customers.add(new Customer__c());
           customers[i].Grade__c = customermetrics[i].Grade__c;
           customers[i].Metrics__c = customermetrics[i].Id;
           customers[i].Weighted_1__c = customermetrics[i].Weightage_1__c;
           customers[i].Weighted_2__c = customermetrics[i].Weightage_2__c;           
           if(customermetrics[i].Grade__c == true){
               customers[i].Previous_Value__c = customermetrics[i].Yearly_Target__c;
           }else{
               customers[i].Previous_Value__c = string.valueof(customermetrics[i].Yearly_Target2__c);
           }           
        }
      }
    }
    public void learnings(){
      learnings =[SELECT 
                  Name,
                  Current_Value__c,
                  Current_Value_Grade__c,
                  Initiatives__c,
                  Future_Initiatives__c,Previous_Value__c,
                  Grade__c,
                  Metrics__c,
                  Objectives__c,
                  Targets__c,
                  Target_Grade_Value__c,
                  Review_Comments__c,Score__c,Weighted_1__c,Weighted_2__c 
      FROM Learning_and_Growth__c 
      WHERE LinkID__c=:Apexpages.currentPage().getParameters().get('selectedInstanceScorecard')];      
      if(Apexpages.currentPage().getParameters().get('selectedInstanceScorecard')==null){
         for(integer i=0;i<learningmetrics.size();i++){
            learnings.add(new Learning_and_Growth__c());
            learnings[i].Metrics__c = learningmetrics[i].Id;
            learnings[i].Grade__c = learningmetrics[i].Grade__c;
            learnings[i].Objectives__c = learningmetrics[i].Objective__c;
            learnings[i].Weighted_1__c = learningmetrics[i].Weightage_1__c;
            learnings[i].Weighted_2__c = learningmetrics[i].Weightage_2__c;            
            if(learningmetrics[i].Grade__c == true){
                learnings[i].Previous_Value__c = learningmetrics[i].Yearly_Target__c;
            }else{
                learnings[i].Previous_Value__c = string.valueof(learningmetrics[i].Yearly_Target2__c);
            }              
         }
      }
    }
    public void internals(){
       internals =[SELECT 
                   Name,
                   Current_Value__c,
                   Current_Value_Grade__c,
                   Initiatives__c,
                   Future_Initiatives__c,Previous_Value__c,
                   Metrics__c,
                   Grade__c,
                   Objectives__c,
                   Targets__c,
                   Target_Grade_Value__c,
                   Review_Comments__c,Score__c,Weighted_1__c,Weighted_2__c 
       FROM Internal_process__c 
       WHERE LinkID__c=:Apexpages.currentPage().getParameters().get('selectedInstanceScorecard')];      
       if(Apexpages.currentPage().getParameters().get('selectedInstanceScorecard')==null){
           for(integer i=0;i<internalmetrics.size();i++){
              internals.add(new Internal_process__c());
              internals[i].Metrics__c = internalmetrics[i].Id;
              internals[i].Grade__c = internalmetrics[i].Grade__c;
              internals[i].Objectives__c = internalmetrics[i].Objective__c;
              internals[i].Weighted_1__c = internalmetrics[i].Weightage_1__c;
              internals[i].Weighted_2__c = internalmetrics[i].Weightage_2__c;               
              if(internalmetrics[i].Grade__c == true){
                internals[i].Previous_Value__c = internalmetrics[i].Yearly_Target__c;
              }else{
                internals[i].Previous_Value__c = string.valueof(internalmetrics[i].Yearly_Target2__c);
              }                                     
           }
       }   
    }
    public String getMonth(){
        //DateTime d = datetime.now();
        //String monthName = d.format('MMMMM');
        //monthunii= Apexpages.currentPage().getParameters().get('getCurrentMonthName');
        //return scorecardinstancedetails.Month__c;
        return scorecardinstancedetails.Month__c;
    }
    public String getYear(){
        DateTime d = datetime.now();
        String yearName = d.format('yyyy');
        return yearName;
    }

    public void echoVal(){
     Integer checkRecord1  = [Select count()from Finance_Data_form__c where Month__c=:getMonth()and Year__c=:getYear()];
     Integer checkRecord2  = [Select count()from Sales_Marketing_Data_Form__c where Month__c=:getMonth()and Year__c=:getYear()];
     Integer checkRecord3  = [Select count()from Marketing_Data_Form__c where Month__c=:getMonth()and Year__c=:getYear()];
     Integer checkRecord4  = [Select count()from RMG_Data_Form__c where Month__c=:getMonth()and Year__c=:getYear()];
     Integer checkRecord5  = [Select count()from SEPG_Data_Form__c where Month__c=:getMonth()and Year__c=:getYear()];
     Integer checkRecord6  = [Select count()from PMO_Data_Form__c where Month__c=:getMonth()and Year__c=:getYear()];
     Integer checkRecord7  = [Select count()from HR_Data_form__c where Month__c=:getMonth()and Year__c=:getYear()];          
     if(checkRecord1>0 && checkRecord2>0 && checkRecord3>0 && checkRecord4>0 && checkRecord5>0 && checkRecord6>0 && checkRecord7>0){
     FinanceFields= [SELECT 
     Total_billing_in_E_business__c,Total_billing_in_E_media__c,
     Total_billing_in_Capital_Markets__c,Total_biiling_in_Consumer_Lending__c,Total_billing_in_SOPS__c,
     Dealsheet_GM_key_Accs_AD__c,Execution_GM_key_Accs_AD__c,
     Dealsheet_GM_key_Accs_RP__c,Execution_GM_key_Accs_RP__c,
     Dealsheet_GM_key_Accs_KK__c,Execution_GM_key_Accs_KK__c,
     Dealsheet_GM_key_Accs_PS__c,Execution_GM_key_Accs_PS__c,
     Dealsheet_GM_Capital_Markets_projects__c,Execution_GM_Capital_Markets_projects__c,
     Dealsheet_GM_CL_projects__c,Execution_GM_CL_projects__c,
     Dealsheet_GM_E_business_projects__c,Execution_GM_E_business_projects__c,
     Dealsheet_GM_E_media_projects__c,Execution_GM_E_media_projects__c,
     Dealsheet_GM_SOPS_projects__c,Execution_GM_SOPS_projects__c,
     Dealsheet_GM_sales_DIT__c,Execution_GM_sales_DIT__c,
     Dealsheet_GM_sales_Mani__c,Execution_GM_sales_Mani__c,
     Dealsheet_GM_sales_Satya__c,Execution_GM_sales_Satya__c,
     Dealsheet_GM_sales_VK__c,Execution_GM_sales_VK__c,
     Overall_deal_sheet_GM__c,Overall_execution_GM__c,
     existing_client_sales_billing_CM__c,New_sales_billings_CM__c,Total_bookings_CM__c,
     existing_client_sales_billing_CL__c,New_sales_billings_CL__c,Total_bookings_CL__c,
     existing_client_sales_billing_E_biz__c,New_sales_billings_E_biz__c,Total_bookings_E_biz__c,
     existing_client_sales_billing_emedia__c,New_sales_billings_E_Media__c,Total_bookings_E_Media__c,
     existing_client_sales_billing_SOps__c,New_sales_billings_SOps__c,Total_bookings_SOps__c,
     Key_Account_CP_AD_existing_c_billing__c,Key_Account_CP_AD_booking__c,Key_Account_CP_AD_existing_client__c,
     Key_Account_CP_KK_existing_c_billing__c,Key_Account_CP_KK_bookings__c,Key_Account_CP_KK_existing_client__c,
     Key_Account_CP_PS_existing_c_billing__c,Key_Account_CP_PS_bookings__c,Key_Account_CP_PS_existing_client__c,
     Key_Account_CP_RP_existing_c_billing__c,Key_Account_CP_RP_bookings__c,Key_Account_CP_RP_existing_client__c,
     Sales_DIT_cpns__c,Sales_DIT_customer__c,Sales_DIT_new_sales_booking__c,Sales_DIT_new_sales_billing__c,
     Sales_Mani_cpns__c,Sales_Mani_new_sales_booking__c,Sales_Mani_new_sales_billing__c,Sales_Mani_customer__c,
     Sales_Overall_customer__c,Sales_Overall_new_sales_booking__c,Sales_Overall_new_sales_billing__c,Sales_Overall_cpns__c,
     Sales_Satya_customer__c,Sales_Satya_new_sales_booking__c,Sales_Satya_new_sales_billing__c,Sales_Satya_cpns__c,
     Sales_VK_cpns__c,Sales_VK_customer__c,Sales_VK_new_sales_booking__c,Sales_VK_new_sales_billing__c,
     Marketing_cost_per_client__c,Total_cost_of_marketing__c,Total_new_sales__c,     
     Bookings_for_the_organization__c,EBITDA__c,Total_Billing__c,Overall_Org_GM__c,
     GM_of_Hosting_Business__c
     FROM Finance_Data_form__c 
     WHERE Month__c =:getMonth()and Year__c=:getYear() LIMIT 1];
     
     SalesFields= [SELECT 
     Total_IT_budget_of_all_clients_SOps__c,Total_IT_budget_of_all_clients_E_biz__c,Total_IT_budget_of_all_clients_CM__c,
     Total_IT_budget_of_clients_in_E_media__c,Total_IT_budget_of_all_clients_CL__c,
     Sales_effectiveness_for_the_Org__c,Customer_perception_of_Tavant__c,of_client_visits_by_GDMs_SPMs__c,
     Number_of_new_customers_CM__c,Number_of_new_clients_CM__c,Number_of_qualified_leads_CM__c,Sales_process_compliance_CM__c,
     Number_of_new_customers_CL__c,Number_of_new_clients_CL__c,Number_of_qualified_leads_CL__c,Achieve_sales_process_compliance_CL__c,
     Number_of_new_clients_E_biz__c,Number_of_new_customers_E_biz__c,Number_of_qualified_leads_E_biz__c,Achieve_sales_process_compliance_E_biz__c,
     Achieve_sales_process_compliance_E_Med__c,Number_of_new_clients_E_Media__c,Number_of_new_customers_E_Media__c,Number_of_qualified_leads_E_Media__c,
     Achieve_sales_process_compliance_SOps__c,Number_of_new_clients_SOps__c,Number_of_new_customers_SOps__c,Number_of_qualified_leads_SOps__c,
     CP_AD__c,CP_KK__c,CP_ps__c,CP_RP__c,
     Sales_DIT__c,Sales_Satya__c,Sales_Mani__c,Sales_VK__c,Sales_Overall__c
     FROM Sales_Marketing_Data_Form__c
     WHERE Month__c =:getMonth()and Year__c=:getYear() LIMIT 1];
     
     MarketingFields = [SELECT 
     of_artifacts_published__c,
     CSAT_score__c,Service_Operations_CSAT__c,
     Capital_Markets__c,Consumer_Lending__c,E_Business__c,E_Media__c,Service_operations__c,
     Key_Accounts_CP_PS__c,Key_Accounts_CP_PS_MA__c,
     Key_Accounts_CP_RP__c,Key_Accounts_CP_RP_MA__c,
     Key_Accounts_CP_AD__c,Key_Accounts_CP_AD_MA__c,
     Key_Accounts_CP_kk__c,Key_Accounts_CP_KK_MA__c
     FROM Marketing_Data_Form__c 
     WHERE Month__c =:getMonth()and Year__c=:getYear() LIMIT 1];
     
     RMGFields = [SELECT 
     Utilization_rate__c,
     Resource_forecast_planning_Sales_VK__c,
     Resource_forecast_planning_Sales_Satya__c,
     Resource_forecast_planning_Sales_Mani__c,
     Resource_forecast_planning_Sales_DIT__c,
     Resource_forecast_planning_CP_RP__c,
     Resource_forecast_planning_CP_PS__c,
     Resource_forecast_planning_CP_KK__c,
     Resource_forecast_planning_CP_AD__c,
     Resource_forecast_planning_Sales_Overall__c,
     Readiness_to_staff_new_projects__c,
     Attain_desired_role_ratios__c 
     FROM RMG_Data_Form__c 
     WHERE Month__c =:getMonth()and Year__c=:getYear() LIMIT 1];     

     SEPGFields = [SELECT 
     of_Projects_at_or_above_CMMi_level_4__c,
     Timeliness_in_projects_delivery__c,
     Significant_audit_findings_for_Ops_Team__c 
     FROM SEPG_Data_Form__c 
     WHERE Month__c =:getMonth()and Year__c=:getYear() LIMIT 1]; 
     
     PMOFields = [SELECT 
     Degree_of_reusability_for_the_Org__c,
     reuse_for_SOPS_Practice__c,
     reuse_for_Emedia_Practice__c,
     reuse_for_Ebusiness_practice__c,
     reuse_for_Consumer_Lending_Practice__c,
     reuse_for_Capital_Markets_Practice__c 
     FROM PMO_Data_Form__c 
     WHERE Month__c =:getMonth()and Year__c=:getYear() LIMIT 1];      

     HRFields = [SELECT 
     attending_min_hrs_Overall__c,
     attending_min_hrs_Capital_Markets__c,attending_min_hrs_CL__c,
     attending_min_hrs_E_business__c,attending_min_hrs_E_media__c,
     attending_min_hrs_SOPS__c,attending_min_hrs_IS__c,
     attending_min_hrs_Sales_DIT__c,attending_min_hrs_Sales_Mani__c,
     attending_min_hrs_Sales_Overall__c,attending_min_hrs_Sales_Satya__c,
     attending_min_hrs_Sales_VK__c,attending_min_hrs_Inside_Sales__c,
     attending_min_hrs_Marketing__c,attending_min_hrs_Operations__c,
     attending_min_hrs_Facilities__c,attending_min_hrs_Finance__c,
     ESAT_score_for_IS_Team__c,ESAT_score_for_Facilities_Deptt__c,ESAT_score_for_Finance_Deptt__c,ESAT_score__c,
     Attrition_rate__c,     
     Attrition_rate_for_CP_Plan_2012_AD__c,
     Attrition_rate_for_CP_Plan_2012_KK__c,
     Attrition_rate_for_CP_Plan_2012_PS__c,
     Attrition_rate_for_CP_Plan_2012_RP__c
     FROM HR_Data_form__c 
     WHERE Month__c =:getMonth()and Year__c=:getYear() LIMIT 1];
    if(scorecarddetails.Name == 'E-Media Plan'){
        fetchEmediaFormulasData();
    }
    else if(scorecarddetails.Name == 'E-Business Plan'){
        fetchEbusinessFormulasData();
    }
    else if(scorecarddetails.Name == 'Consumer Lending Plan'){
        fetchCLFormulasData();
    }
    else if(scorecarddetails.Name == 'Capital Markets Plan'){
        fetchCMFormulasData();
    }
    else if(scorecarddetails.Name == 'SOPS Plan'){
        fetchSOPSFormulasData();
    }    
    else if(scorecarddetails.Name == 'Corporate Plan'){   
        fetchCorporateFormulasData();
    }
    else if(scorecarddetails.Name == 'Delivery_Plan'){
        fetchDeliveryFormulasData();
    }
    else if(scorecarddetails.Name == 'CP Plan AD'){
        fetchADFormulasData();
    }
    else if(scorecarddetails.Name == 'CP Plan RP'){
        fetchRPFormulasData();
    }
    else if(scorecarddetails.Name == 'CP_Plan_SG'){
        fetchKKFormulasData();
    }
    else if(scorecarddetails.Name == 'CP Plan PS'){
        fetchPSFormulasData();
    }
    else if(scorecarddetails.Name == 'Sales Plan DIT'){
        fetchDITFormulasData();
    }
    else if(scorecarddetails.Name == 'Sales Plan Mani'){
        fetchManiFormulasData();
    }
    else if(scorecarddetails.Name == 'Sales Plan Satya'){
        fetchSatyaFormulasData();
    }     
    else if(scorecarddetails.Name == 'Sales Plan VK'){
        fetchVKFormulasData();
    }
    else if(scorecarddetails.Name == 'HR Plan'){
        fetchHRFormulasData();
    } 
    else if(scorecarddetails.Name == 'Marketing Plan'){
        fetchMarketingFormulasData();
    }
    else if(scorecarddetails.Name == 'Operations Plan'){
        fetchOperationsFormulasData();
    }
    else if(scorecarddetails.Name == 'Facilities Plan'){
        fetchFacilitiesFormulasData();
    }
    else if(scorecarddetails.Name == 'Finance Plan'){
        fetchFinanceFormulasData();
    }
    else if(scorecarddetails.Name == 'IS Plan'){
        fetchISFormulasData();
    }
    else if(scorecarddetails.Name == 'Inside Sales Plan'){
        fetchISPFormulasData();
    }      
    else if(scorecarddetails.Name == 'Sales Plan Overall'){
       fetchSalesOverallFormulasData();
    }
  }
    else{
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Data froms not available'));
    }
  }
    public Scorecard__c getscorecarddetails() {
        return scorecarddetails;
       }
    public Scorecard_Instances__c getscorecardinstancedetails(){
        return scorecardinstancedetails;
       }    
    public List<Metrics__c> getfinancemetrics(){
        return financemetrics;
       }
    public List<Metrics__c> getallmetrics(){
        return allmetrics;
       }           
    public List<Metrics__c> getcustomermetrics(){
        return customermetrics;
       }
    public List<Metrics__c> getlearningmetrics(){
        return learningmetrics;
       }
    public List<Metrics__c> getinternalmetrics(){
        return internalmetrics;
       }
    public PageReference save(){
    try{
     if(scorecardinstancedetails.Scorecard__c == null){
     scorecardinstancedetails.Name = scorecarddetails.Name+'-'+scorecardinstancedetails.Month__c+'-'+scorecardinstancedetails.Year__c;
     scorecardinstancedetails.Scorecard__c = scorecarddetails.Id;
     }
     upsert(scorecardinstancedetails);
     for(Integer i = 0;i<finances.size();i++){
     if(finances[i].Id == null){
         finances[i].LinkID__c = scorecardinstancedetails.Id;
      }   
     }
     upsert(finances);
     
     //insert customer list
     for(Integer i = 0;i<customers.size();i++){
     if(customers[i].Id == null){
     customers[i].LinkID__c = scorecardinstancedetails.Id;
     }}
     upsert(customers);
     
     //insert internal list
     for(Integer i = 0;i<internals.size();i++){
     if(internals[i].Id == null){
     internals[i].LinkID__c = scorecardinstancedetails.Id;
     }}
     upsert(internals);
     
     //insert learning list
     for(Integer i = 0;i<learnings.size();i++){
     if(learnings[i].Id == null){
     learnings[i].LinkID__c = scorecardinstancedetails.Id;
     }}
     upsert(learnings);
    }catch(System.DMLException e){
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error creating new scorecard.'));
      return null;
    }
    scorecardinstancedetails.Status__c = 'Open';
    update scorecardinstancedetails;
    PageReference redirect = new PageReference(refresh);
    redirect.setRedirect(true); 
    return redirect;
   }
  public PageReference submit(){   
    save();
    scorecardinstancedetails.Status__c = 'Submitted For Review';
    update scorecardinstancedetails;
    PageReference redirect = new PageReference(refresh);
    redirect.setRedirect(true); 
    return redirect;
  }
  public void calculateweightage(){
      calculatescores();
    Decimal fin = 0;Decimal fin2 = 0;
    for(Integer i=0;i<financemetrics.size();i++){
      if(finances[i].Score__c == null || finances[i].Score__c == 'NA' || financemetrics[i].Weightage_1__c==null){
        fin += 0;
      }else{
        fin += financemetrics[i].Weightage_1__c*decimal.valueOf(finances[i].Score__c);
      }
    }
    for(Integer i=0;i<customermetrics.size();i++){
      if(customers[i].Score__c == null || customers[i].Score__c == 'NA' || customermetrics[i].Weightage_1__c==null){
        fin += 0;
      }else{
        fin += customermetrics[i].Weightage_1__c*decimal.valueof(customers[i].Score__c);
      }
    }    
    for(Integer i=0;i<internalmetrics.size();i++){
      if(internals[i].Score__c == null || internals[i].Score__c == 'NA' || internalmetrics[i].Weightage_1__c==null){
        fin += 0;
      }else{
        fin +=  internalmetrics[i].Weightage_1__c*decimal.valueof(internals[i].Score__c);
      }        
    }
    for(Integer i=0;i<learningmetrics.size();i++){
      if(learnings[i].Score__c == null || learnings[i].Score__c == 'NA' || learningmetrics[i].Weightage_1__c==null){
        fin += 0;
      }else{
        fin +=  learningmetrics[i].Weightage_1__c*decimal.valueof(learnings[i].Score__c);
      }         
    }            
    scorecardinstancedetails.Weighted__c = fin/100;
    for(Integer i=0;i<financemetrics.size();i++){
      if(finances[i].Score__c == null || finances[i].Score__c == 'NA' || financemetrics[i].Weightage_2__c==null){
        fin2 += 0;
      }else{
        fin2 += financemetrics[i].Weightage_2__c*decimal.valueof(finances[i].Score__c);
      }
    }
    for(Integer i=0;i<customermetrics.size();i++){
      if(customers[i].Score__c == null || customers[i].Score__c == 'NA' || customermetrics[i].Weightage_2__c==null){
        fin2 += 0;
      }else{
        fin2 += customermetrics[i].Weightage_2__c*decimal.valueof(customers[i].Score__c);
      }
    }    
    for(Integer i=0;i<internalmetrics.size();i++){
      if(internals[i].Score__c == null || internals[i].Score__c == 'NA' || internalmetrics[i].Weightage_2__c==null){
        fin2 += 0;
      }else{
        fin2 +=  internalmetrics[i].Weightage_2__c*decimal.valueof(internals[i].Score__c);
      }        
    }
    for(Integer i=0;i<learningmetrics.size();i++){
      if(learnings[i].Score__c == null || learnings[i].Score__c == 'NA' || learningmetrics[i].Weightage_2__c==null){
        fin2 += 0;
      }else{
        fin2 +=  learningmetrics[i].Weightage_2__c*decimal.valueof(learnings[i].Score__c);
      }         
    }    
    scorecardinstancedetails.Weighted_2__c = fin2/100;
  }
  public void calculatescores(){
     for(Integer i=0;i<financemetrics.size();i++){
       if(financemetrics[i].Metric_Type__c == 'Revenue %'){          
          if(finances[i].Current_Value__c == null || finances[i].Targets__c == null){  
             finances[i].Score__c = 'NA';
          }
          else if((finances[i].Current_Value__c/finances[i].Targets__c) >= 1.00){  
             finances[i].Score__c = string.valueof((1.00 + 3*(finances[i].Current_Value__c/finances[i].Targets__c - 1.00))*100);
          }
          else if((finances[i].Current_Value__c/finances[i].Targets__c) >= .75){  
             finances[i].Score__c = string.valueof((0.50 + 2*(finances[i].Current_Value__c/finances[i].Targets__c - 0.75))*100);
          }
          else if((finances[i].Current_Value__c/finances[i].Targets__c) >= .50){  
             finances[i].Score__c = string.valueof((0.25 +(finances[i].Current_Value__c/finances[i].Targets__c - 0.50))*100);}
          else{  
             finances[i].Score__c = string.valueof(0);}           
       }
       if(financemetrics[i].Metric_Type__c == 'No of customers'){
          if(finances[i].Current_Value__c == null || finances[i].Targets__c == null){  
             finances[i].Score__c = 'NA';
          }                 
          else if((finances[i].Current_Value__c/finances[i].Targets__c) >= 1.25){  
             finances[i].Score__c = string.valueof((1.25*(1+2*(finances[i].Current_Value__c/finances[i].Current_Value__c-1)))*100);}
          else if((finances[i].Current_Value__c/finances[i].Targets__c) >= 1.00){  
             finances[i].Score__c = string.valueof((1+2*(finances[i].Current_Value__c/finances[i].Current_Value__c-1))*100);}
          else if((finances[i].Current_Value__c/finances[i].Targets__c) >= .66){  
             finances[i].Score__c = string.valueof((finances[i].Current_Value__c/finances[i].Targets__c)*100);}
          else{  
             finances[i].Score__c = string.valueof(0);}           
       } 
       if(financemetrics[i].Metric_Type__c == 'Percentage Value'){
          if(finances[i].Current_Value__c == null || finances[i].Targets__c == null){  
             finances[i].Score__c = 'NA';
          }                 
          else if(finances[i].Current_Value__c/finances[i].Targets__c >= 1.25){  
             finances[i].Score__c = string.valueof(125);}
          else if(finances[i].Current_Value__c/finances[i].Targets__c >= .66){  
             finances[i].Score__c = string.valueof((finances[i].Current_Value__c/finances[i].Targets__c)*100);}
          else{  
             finances[i].Score__c = string.valueof(0);}           
       }
           if(financemetrics[i].Metric_Type__c == 'Lost Assets'){
          if(finances[i].Current_Value__c == null || finances[i].Targets__c == null){  
             finances[i].Score__c = 'NA';            
          }   else {
                    finances[i].Score__c = string.valueof((2-(finances[i].Current_Value__c/finances[i].Targets__c))*100);}
          
             }
      
       if(financemetrics[i].Metric_Type__c == 'Utilization'){
          if(finances[i].Current_Value__c == null || finances[i].Targets__c == null){  
             finances[i].Score__c = 'NA';
          }          
          else if(finances[i].Current_Value__c-finances[i].Targets__c >= 5){  
             finances[i].Score__c = string.valueof((finances[i].Current_Value__c/finances[i].Targets__c )*100);}
          else if((finances[i].Current_Value__c-finances[i].Targets__c<5)&&(finances[i].Current_Value__c-finances[i].Targets__c>0)){  
             finances[i].Score__c = string.valueof(125);}
             else if(finances[i].Current_Value__c <= finances[i].Targets__c){  
             finances[i].Score__c = string.valueof(0);}           
       }  
       if(financemetrics[i].Metric_Type__c == 'Grades'){
          if(finances[i].Current_Value_Grade__c == null){  
             finances[i].Score__c = 'NA';}           
          else if(finances[i].Current_Value_Grade__c=='A'){  
             finances[i].Score__c = string.valueof(100);}
          else if(finances[i].Current_Value_Grade__c=='B'){  
             finances[i].Score__c = string.valueof(80);}
          else if(finances[i].Current_Value_Grade__c=='C'){  
             finances[i].Score__c = string.valueof(60);}
          else if(finances[i].Current_Value_Grade__c=='D'){  
             finances[i].Score__c = string.valueof(40);}
          else if(finances[i].Current_Value_Grade__c=='E'){  
             finances[i].Score__c = string.valueof(0);}                                                                  
       }
       if(financemetrics[i].Metric_Type__c == 'Actual GM% Factor'){
       if(finances[i].Current_Value__c == null || finances[i].Targets__c == null){  
             finances[i].Score__c = 'NA';
          }
          else {
             finances[i].Score__c = string.valueof((1+4*((finances[i].Current_Value__c/100)-(finances[i].Targets__c/100)))*100);}
       }                                             
       if(financemetrics[i].Metric_Type__c == 'Dealsheet GM% Factor'){
        if(finances[i].Current_Value__c == null || finances[i].Targets__c == null){  
             finances[i].Score__c = 'NA';
          }
          else {
             finances[i].Score__c = string.valueof((0.6+4*(finances[i].Current_Value__c/100-0.2))*100); }                                                  
       }                                          
     }
     for(Integer i=0;i<customermetrics.size();i++){
       if(customermetrics[i].Metric_Type__c == 'Grades'){          
          if(customers[i].Current_Value_Grade__c == null){  
             customers[i].Score__c = 'NA';}            
          else if(customers[i].Current_Value_Grade__c=='A'){  
             customers[i].Score__c = string.valueof(100);}
          else if(customers[i].Current_Value_Grade__c=='B'){  
             customers[i].Score__c = string.valueof(80);}
          else if(customers[i].Current_Value_Grade__c=='C'){  
             customers[i].Score__c = string.valueof(60);}
          else if(customers[i].Current_Value_Grade__c=='D'){  
             customers[i].Score__c = string.valueof(40);}
          else if(customers[i].Current_Value_Grade__c=='E'){  
             customers[i].Score__c = string.valueof(0);}            
       }
       if(customermetrics[i].Metric_Type__c == 'Percentage Value'){
          if(customers[i].Current_Value__c == null || customers[i].Targets__c == null){  
             customers[i].Score__c = 'NA';
          }                 
          else if(customers[i].Current_Value__c/customers[i].Targets__c>= 1.25){  
             customers[i].Score__c = string.valueof(125);}
          else if(customers[i].Current_Value__c/customers[i].Targets__c >= .66){  
             customers[i].Score__c = string.valueof((customers[i].Current_Value__c/customers[i].Targets__c)*100);}
          else{  
             customers[i].Score__c = string.valueof(0);}           
       }
       if(customermetrics[i].Metric_Type__c == 'No of customers'){
          if(customers[i].Current_Value__c == null || customers[i].Targets__c == null){  
             customers[i].Score__c = 'NA';
          }                 
          else if((customers[i].Current_Value__c/customers[i].Targets__c) >= 1.25){  
             customers[i].Score__c = string.valueof((1.25*(1+2*(customers[i].Current_Value__c/customers[i].Current_Value__c-1)))*100);}
          else if((customers[i].Current_Value__c/customers[i].Targets__c) >= 1.00){  
             customers[i].Score__c = string.valueof((1+2*(customers[i].Current_Value__c/customers[i].Current_Value__c-1))*100);}
          else if((customers[i].Current_Value__c/customers[i].Targets__c) >= .66){  
             customers[i].Score__c = string.valueof((customers[i].Current_Value__c/customers[i].Targets__c)*100);}
          else{  
             customers[i].Score__c = string.valueof(0);}           
       }  
          if(customermetrics[i].Metric_Type__c == 'Lost Assets'){
          if(customers[i].Current_Value__c == null || customers[i].Targets__c == null){  
             customers[i].Score__c = 'NA';            
          }   else {
                    customers[i].Score__c = string.valueof((2-(customers[i].Current_Value__c/customers[i].Targets__c))*100);}
          
             }                
     } 
     for(Integer i=0;i<internalmetrics.size();i++){
       if(internalmetrics[i].Metric_Type__c == 'Grades'){
          if(internals[i].Current_Value_Grade__c == null){  
             internals[i].Score__c = 'NA';}            
          else if(internals[i].Current_Value_Grade__c=='A'){  
             internals[i].Score__c = string.valueof(100);}
          else if(internals[i].Current_Value_Grade__c=='B'){  
             internals[i].Score__c = string.valueof(80);}
          else if(internals[i].Current_Value_Grade__c=='C'){  
             internals[i].Score__c = string.valueof(60);}
          else if(internals[i].Current_Value_Grade__c=='D'){  
             internals[i].Score__c = string.valueof(40);}
          else if(internals[i].Current_Value_Grade__c=='E'){  
             internals[i].Score__c = string.valueof(0);}          
       }
       if(internalmetrics[i].Metric_Type__c == 'Revenue %'){          
          if(internals[i].Current_Value__c == null || internals[i].Targets__c == null){  
             internals[i].Score__c = 'NA';
          }
          else if((internals[i].Current_Value__c/internals[i].Targets__c) >= 1.00){  
             internals[i].Score__c = string.valueof((1.00 + 3*(internals[i].Current_Value__c/internals[i].Targets__c - 1.00))*100);
          }
          else if((internals[i].Current_Value__c/internals[i].Targets__c) >= .75){  
             internals[i].Score__c = string.valueof((0.50 + 2*(internals[i].Current_Value__c/internals[i].Targets__c - 0.75))*100);
          }
          else if((internals[i].Current_Value__c/internals[i].Targets__c) >= .50){  
             internals[i].Score__c = string.valueof((0.25 +(internals[i].Current_Value__c/internals[i].Targets__c - 0.50))*100);}
          else{  
             internals[i].Score__c = string.valueof(0);}           
       }    
       if(internalmetrics[i].Metric_Type__c == 'Percentage Value'){
          if(internals[i].Current_Value__c == null || internals[i].Targets__c == null){  
             internals[i].Score__c = 'NA';
          }                 
          else if(internals[i].Current_Value__c/internals[i].Targets__c >= 1.25){  
             internals[i].Score__c = string.valueof(125);}
          else if(internals[i].Current_Value__c/internals[i].Targets__c >= .66){  
             internals[i].Score__c = string.valueof((internals[i].Current_Value__c/internals[i].Targets__c)*100);}
          else{  
             internals[i].Score__c = string.valueof(0);}           
       }
      if(internalmetrics[i].Metric_Type__c == 'Lost Assets'){
          if(internals[i].Current_Value__c == null || internals[i].Targets__c == null){  
             internals[i].Score__c = 'NA';            
          }   else {
                    internals[i].Score__c = string.valueof((2-(internals[i].Current_Value__c/internals[i].Targets__c))*100);}
          
             }                                                                   
     }
     for(Integer i=0;i<learningmetrics.size();i++){
       if(learningmetrics[i].Metric_Type__c == 'Grades'){
          if(learnings[i].Current_Value_Grade__c == null){  
             learnings[i].Score__c = 'NA';}           
          else if(learnings[i].Current_Value_Grade__c=='A'){  
             learnings[i].Score__c = string.valueof(100);}
          else if(learnings[i].Current_Value_Grade__c=='B'){  
             learnings[i].Score__c = string.valueof(80);}
          else if(learnings[i].Current_Value_Grade__c=='C'){  
             learnings[i].Score__c = string.valueof(60);}
          else if(learnings[i].Current_Value_Grade__c=='D'){  
             learnings[i].Score__c = string.valueof(40);}
          else if(learnings[i].Current_Value_Grade__c=='E'){  
             learnings[i].Score__c = string.valueof(0);}                                                                  
       }
       if(learningmetrics[i].Metric_Type__c == 'Percentage Value'){
          if(learnings[i].Current_Value__c == null || learnings[i].Targets__c == null){  
             learnings[i].Score__c = 'NA';
          }                 
          else if(learnings[i].Current_Value__c/learnings[i].Targets__c >= 1.25){  
             learnings[i].Score__c = string.valueof(125);}
          else if(learnings[i].Current_Value__c/learnings[i].Targets__c >= .66){  
             learnings[i].Score__c = string.valueof((learnings[i].Current_Value__c/learnings[i].Targets__c)*100);}
          else{  
             learnings[i].Score__c = string.valueof(0);}           
       }
      if(learningmetrics[i].Metric_Type__c == 'Lost Assets'){
          if(learnings[i].Current_Value__c == null || learnings[i].Targets__c == null){  
             learnings[i].Score__c = 'NA';            
          }   else {
                    learnings[i].Score__c = string.valueof((2-(learnings[i].Current_Value__c/learnings[i].Targets__c))*100);}
          
             }                      
     }                
  }
      public void fetchEmediaFormulasData(){
       for(Integer i=0;i<financemetrics.size();i++){
          if(financemetrics[i].Name == 'Average share of IT budgets (%)'){
             if(FinanceFields.Total_billing_in_E_media__c!=null && SalesFields.Total_IT_budget_of_clients_in_E_media__c!=null){
              finances[i].Current_Value__c = FinanceFields.Total_billing_in_E_media__c/SalesFields.Total_IT_budget_of_clients_in_E_media__c;}
             else{
              finances[i].Current_Value__c = 0;
             }
          }
          if(financemetrics[i].Name == '50%*(Dealsheet GM%)') {
             if(FinanceFields.Dealsheet_GM_E_media_projects__c!=null){
              finances[i].Current_Value__c = FinanceFields.Dealsheet_GM_E_media_projects__c;
             }
             else{
              finances[i].Current_Value__c = 0;
             }
          } 
          if(financemetrics[i].Name == '50%*(Execution GM%)') {
             if(FinanceFields.Execution_GM_E_media_projects__c!=null){
              finances[i].Current_Value__c = FinanceFields.Execution_GM_E_media_projects__c;
             }
             else{
              finances[i].Current_Value__c = 0;
             }
          }                     
           if(financemetrics[i].Name == 'Existing client sales billings ($mn)') {
              if(FinanceFields.existing_client_sales_billing_emedia__c!=null){
               finances[i].Current_Value__c = FinanceFields.existing_client_sales_billing_emedia__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           } 
           if(financemetrics[i].Name == 'New sales billings ($mn)') {
              if(FinanceFields.New_sales_billings_E_Media__c!=null){
               finances[i].Current_Value__c = FinanceFields.New_sales_billings_E_Media__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == 'Total bookings ($mn)') {
              if(FinanceFields.Total_bookings_E_Media__c!=null){
               finances[i].Current_Value__c = FinanceFields.Total_bookings_E_Media__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           } 
           if(financemetrics[i].Name == 'Number of new customers') {
              if(SalesFields.Number_of_new_customers_E_Media__c!=null){
               finances[i].Current_Value__c = SalesFields.Number_of_new_customers_E_Media__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == 'Number of new clients') {
              if(SalesFields.Number_of_new_clients_E_Media__c!=null){
               finances[i].Current_Value__c = SalesFields.Number_of_new_clients_E_Media__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           }                    
       }
        for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name == 'Achieving intended positioning (Grade)'){
              if(MarketingFields.E_Media__c!=null){
                customers[i].Current_Value_Grade__c = MarketingFields.E_Media__c;
              }else{
                customers[i].Current_Value_Grade__c = 'None';
              }
           }
           if(customermetrics[i].Name == 'Number of qualified leads'){
              if(SalesFields.Number_of_qualified_leads_E_Media__c!=null){
                customers[i].Current_Value__c = SalesFields.Number_of_qualified_leads_E_Media__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }        
        }        
        for(Integer i=0;i<internalmetrics.size();i++){
           if(internalmetrics[i].Name == '% reuse (grade)'){
              if(PMOFields.reuse_for_Emedia_Practice__c!=null){
                internals[i].Current_Value_Grade__c = PMOFields.reuse_for_Emedia_Practice__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }
           /*if(internalmetrics[i].Name == '% of revenue from new services'){
              if(SalesFields.Sales_effectiveness_for_the_Org__c!=null){
                internals[i].Current_Value_Grade__c = SalesFields.Sales_effectiveness_for_the_Org__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }*/
           if(internalmetrics[i].Name == 'Achieving sales process compliance (Grade)'){
              if(SalesFields.Achieve_sales_process_compliance_E_Med__c!=null){
                internals[i].Current_Value_Grade__c = SalesFields.Achieve_sales_process_compliance_E_Med__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }                      
        }          
        for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == '% of personnel attending at least 20 hours of training'){
              if(HRFields.attending_min_hrs_E_media__c!=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_E_media__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }                   
        }             
    }
    public void fetchEbusinessFormulasData(){
        for(Integer i=0;i<finances.size();i++){
           if(financemetrics[i].Name == 'Average share of IT budgets (%)'){
              if(FinanceFields.Total_billing_in_E_business__c!=null && SalesFields.Total_IT_budget_of_all_clients_E_biz__c!=null){
                finances[i].Current_Value__c = FinanceFields.Total_billing_in_E_business__c/SalesFields.Total_IT_budget_of_all_clients_E_biz__c;}
              else{
                finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == '50%*(Dealsheet GM%)') {
              if(FinanceFields.Dealsheet_GM_E_business_projects__c!=null){
               finances[i].Current_Value__c = FinanceFields.Dealsheet_GM_E_business_projects__c;
              }
              else{
               finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == '50%*( Execution GM%)') {
              if(FinanceFields.Execution_GM_E_business_projects__c!=null){
               finances[i].Current_Value__c = FinanceFields.Execution_GM_E_business_projects__c;
              }
              else{
               finances[i].Current_Value__c = 0;
              }
           }                     
           if(financemetrics[i].Name == 'Existing client sales billings ($mn)') {
              if(FinanceFields.existing_client_sales_billing_E_biz__c!=null){
               finances[i].Current_Value__c = FinanceFields.existing_client_sales_billing_E_biz__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           } 
           if(financemetrics[i].Name == 'New sales billings ($mn)') {
              if(FinanceFields.New_sales_billings_E_biz__c!=null){
               finances[i].Current_Value__c = FinanceFields.New_sales_billings_E_biz__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == 'Total bookings ($mn)') {
              if(FinanceFields.Total_bookings_E_biz__c!=null){
               finances[i].Current_Value__c = FinanceFields.Total_bookings_E_biz__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           } 
           if(financemetrics[i].Name == 'Number of new customers') {
              if(SalesFields.Number_of_new_customers_E_biz__c!=null){
               finances[i].Current_Value__c = SalesFields.Number_of_new_customers_E_biz__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == 'Number of new clients') {
              if(SalesFields.Number_of_new_clients_E_biz__c!=null){
               finances[i].Current_Value__c = SalesFields.Number_of_new_clients_E_biz__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           }                 
        }
        for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name == 'Achieving intended positioning (Grade)'){
              if(MarketingFields.E_Business__c!=null){
                customers[i].Current_Value_Grade__c = MarketingFields.E_Business__c;
              }else{
                customers[i].Current_Value_Grade__c = 'None';
              }
           }
           if(customermetrics[i].Name == 'Number of qualified leads'){
              if(SalesFields.Number_of_qualified_leads_E_biz__c!=null){
                customers[i].Current_Value__c = SalesFields.Number_of_qualified_leads_E_biz__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }        
        }            
        for(Integer i=0;i<internalmetrics.size();i++){
           if(internalmetrics[i].Name == '% reuse (grade)'){
              if(PMOFields.reuse_for_Ebusiness_practice__c!=null){
                internals[i].Current_Value_Grade__c = PMOFields.reuse_for_Ebusiness_practice__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }
           /*if(internalmetrics[i].Name == '% of revenue from new services'){
              if(SalesFields.Sales_effectiveness_for_the_Org__c!=null){
                internals[i].Current_Value_Grade__c = SalesFields.Sales_effectiveness_for_the_Org__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }*/
           if(internalmetrics[i].Name == 'Achieving sales process compliance (Grade)'){
              if(SalesFields.Achieve_sales_process_compliance_E_biz__c!=null){
                internals[i].Current_Value_Grade__c = SalesFields.Achieve_sales_process_compliance_E_biz__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }                      
        }            
        for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == '% of personnel attending at least 20 hours of training'){
              if(HRFields.attending_min_hrs_E_business__c!=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_E_business__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }                   
        }             
    }
    public void fetchCLFormulasData(){
        for(Integer i=0;i<finances.size();i++){
           if(financemetrics[i].Name == 'Average share of IT budgets (%)'){
              if(FinanceFields.Total_biiling_in_Consumer_Lending__c!=null && SalesFields.Total_IT_budget_of_all_clients_CL__c!=null){
                finances[i].Current_Value__c = FinanceFields.Total_biiling_in_Consumer_Lending__c/SalesFields.Total_IT_budget_of_all_clients_CL__c;}
              else{
                finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == '50%*(Dealsheet GM%)') {
              if(FinanceFields.Dealsheet_GM_CL_projects__c!=null){
               finances[i].Current_Value__c = FinanceFields.Dealsheet_GM_CL_projects__c;
              }
              else{
               finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == '50%*(Execution GM%)') {
              if(FinanceFields.Execution_GM_CL_projects__c!=null){
               finances[i].Current_Value__c = FinanceFields.Execution_GM_CL_projects__c;
              }
              else{
               finances[i].Current_Value__c = 0;
              }
           }                      
           if(financemetrics[i].Name == 'Existing client sales billings ($mn)') {
              if(FinanceFields.existing_client_sales_billing_CL__c!=null){
               finances[i].Current_Value__c = FinanceFields.existing_client_sales_billing_CL__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           } 
           if(financemetrics[i].Name == 'New sales billings ($mn)') {
              if(FinanceFields.New_sales_billings_CL__c!=null){
               finances[i].Current_Value__c = FinanceFields.New_sales_billings_CL__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           }
           /*if(financemetrics[i].Name == 'Total bookings ($mn)') {
              if(FinanceFields.Total_bookings_CL__c!=null){
               finances[i].Current_Value__c = FinanceFields.Total_bookings_CL__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           } */
           if(financemetrics[i].Name == 'Number of new customers') {
              if(SalesFields.Number_of_new_customers_CL__c!=null){
               finances[i].Current_Value__c = SalesFields.Number_of_new_customers_CL__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == 'Number of new clients') {
              if(SalesFields.Number_of_new_clients_CL__c!=null){
               finances[i].Current_Value__c = SalesFields.Number_of_new_clients_CL__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           }                              
        }
        for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name == 'Achieving intended positioning (Grade)'){
              if(MarketingFields.Consumer_Lending__c!=null){
                customers[i].Current_Value_Grade__c = MarketingFields.Consumer_Lending__c;
              }else{
                customers[i].Current_Value_Grade__c = 'None';
              }
           }
           if(customermetrics[i].Name == 'Number of qualified leads'){
              if(SalesFields.Number_of_qualified_leads_CL__c!=null){
                customers[i].Current_Value__c = SalesFields.Number_of_qualified_leads_CL__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }        
        }        
        for(Integer i=0;i<internalmetrics.size();i++){
           if(internalmetrics[i].Name == '% reuse (Grade)'){
              if(PMOFields.reuse_for_Consumer_Lending_Practice__c!=null){
                internals[i].Current_Value_Grade__c = PMOFields.reuse_for_Consumer_Lending_Practice__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }
           /*if(internalmetrics[i].Name == '% of revenue from new services'){
              if(SalesFields.Sales_effectiveness_for_the_Org__c!=null){
                internals[i].Current_Value_Grade__c = SalesFields.Sales_effectiveness_for_the_Org__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }*/
           if(internalmetrics[i].Name == 'Achieving sales process compliance (Grade)'){
              if(SalesFields.Achieve_sales_process_compliance_CL__c!=null){
                internals[i].Current_Value_Grade__c = SalesFields.Achieve_sales_process_compliance_CL__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }                      
        }        
        for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == '% of personnel attending at least 20 hours of training'){
              if(HRFields.attending_min_hrs_CL__c!=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_CL__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }                   
        }            
    }
    public void fetchCMFormulasData(){
    for(Integer i=0;i<finances.size();i++){
           if(financemetrics[i].Name == 'Average share of IT budgets(%)'){
              if(FinanceFields.Total_billing_in_Capital_Markets__c!=null && SalesFields.Total_IT_budget_of_all_clients_CM__c!=null){
                finances[i].Current_Value__c = FinanceFields.Total_billing_in_Capital_Markets__c/SalesFields.Total_IT_budget_of_all_clients_CM__c;}
              else{
               finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == '50%*(Dealsheet GM%)') {
              if(FinanceFields.Dealsheet_GM_Capital_Markets_projects__c!=null){
               finances[i].Current_Value__c = FinanceFields.Dealsheet_GM_Capital_Markets_projects__c;
              }else{
              finances[i].Current_Value__c = 0;
              }
           }  
           if(financemetrics[i].Name == '50%*(Execution GM%)') {
              if(FinanceFields.Dealsheet_GM_Capital_Markets_projects__c!=null){
               finances[i].Current_Value__c = FinanceFields.Dealsheet_GM_Capital_Markets_projects__c;
              }else{
              finances[i].Current_Value__c = 0;
              }
           }                        
           if(financemetrics[i].Name == 'Existing client sales billings ($mn)') {
              if(FinanceFields.existing_client_sales_billing_CM__c!=null){
               finances[i].Current_Value__c = FinanceFields.existing_client_sales_billing_CM__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           } 
           if(financemetrics[i].Name == 'New sales billings ($mn)') {
              if(FinanceFields.New_sales_billings_CM__c!=null){
               finances[i].Current_Value__c = FinanceFields.New_sales_billings_CM__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == 'Total bookings ($mn)') {
              if(FinanceFields.Total_bookings_CM__c!=null){
               finances[i].Current_Value__c = FinanceFields.Total_bookings_CM__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           } 
           if(financemetrics[i].Name == 'Number of new customers') {
              if(SalesFields.Number_of_new_customers_CM__c!=null){
               finances[i].Current_Value__c = SalesFields.Number_of_new_customers_CM__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == 'Number of new clients') {
              if(SalesFields.Number_of_new_clients_CM__c!=null){
               finances[i].Current_Value__c = SalesFields.Number_of_new_clients_CM__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           }                                           
        }
        for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name == 'Achieving intended positioning (Grade)'){
              if(MarketingFields.Capital_Markets__c!=null){
                customers[i].Current_Value_Grade__c = MarketingFields.Capital_Markets__c;
              }else{
                customers[i].Current_Value_Grade__c = 'None';
              }
           }
           if(customermetrics[i].Name == 'Number of qualified leads'){
              if(SalesFields.Number_of_qualified_leads_CM__c!=null){
                customers[i].Current_Value__c = SalesFields.Number_of_qualified_leads_CM__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }        
        }
        for(Integer i=0;i<internalmetrics.size();i++){
           if(internalmetrics[i].Name == '% reuse (Grade)'){
              if(PMOFields.reuse_for_Capital_Markets_Practice__c !=null){
                internals[i].Current_Value_Grade__c = PMOFields.reuse_for_Capital_Markets_Practice__c ;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }
           /*if(internalmetrics[i].Name == '% of revenue from new services'){
              if(SalesFields.Sales_effectiveness_for_the_Org__c!=null){
                internals[i].Current_Value_Grade__c = SalesFields.Sales_effectiveness_for_the_Org__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }*/
           if(internalmetrics[i].Name == 'Achieving sales process compliance (Grade)'){
              if(SalesFields.Sales_process_compliance_CM__c!=null){
                internals[i].Current_Value_Grade__c = SalesFields.Sales_process_compliance_CM__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }                      
        }
        for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == '% of personnel attending at least 20 hours of training'){
              if(HRFields.attending_min_hrs_Capital_Markets__c!=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_Capital_Markets__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }                   
        }           
    }
    public void fetchSOPSFormulasData(){
    for(Integer i=0;i<finances.size();i++){
           if(financemetrics[i].Name == 'Average share of IT budgets (%)'){
              if(FinanceFields.Total_billing_in_SOPS__c!=null && SalesFields.Total_IT_budget_of_all_clients_SOps__c !=null){
                finances[i].Current_Value__c = FinanceFields.Total_billing_in_SOPS__c/SalesFields.Total_IT_budget_of_all_clients_SOps__c;}
              else{
                finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == '50%*(Dealsheet GM%)') {
              if(FinanceFields.Dealsheet_GM_SOPS_projects__c!=null){
              finances[i].Current_Value__c = FinanceFields.Dealsheet_GM_SOPS_projects__c;
              }else{
              finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == '50%*(Execution GM%)') {
              if(FinanceFields.Execution_GM_SOPS_projects__c!=null){
              finances[i].Current_Value__c = FinanceFields.Execution_GM_SOPS_projects__c;
              }else{
              finances[i].Current_Value__c = 0;
              }
           }                        
           if(financemetrics[i].Name == 'Existing client sales billings ($mn)') {
              if(FinanceFields.existing_client_sales_billing_SOps__c!=null){
               finances[i].Current_Value__c = FinanceFields.existing_client_sales_billing_SOps__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           } 
           if(financemetrics[i].Name == 'New sales billings ($mn)') {
              if(FinanceFields.New_sales_billings_SOps__c!=null){
               finances[i].Current_Value__c = FinanceFields.New_sales_billings_SOps__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == 'Total bookings ($mn)') {
              if(FinanceFields.Total_bookings_SOps__c!=null){
               finances[i].Current_Value__c = FinanceFields.Total_bookings_SOps__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           } 
           if(financemetrics[i].Name == 'Number of new customers') {
              if(SalesFields.Number_of_new_customers_CM__c!=null){
               finances[i].Current_Value__c = SalesFields.Number_of_new_customers_CM__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == 'Number of new clients') {
              if(SalesFields.Number_of_new_clients_CM__c!=null){
               finances[i].Current_Value__c = SalesFields.Number_of_new_clients_CM__c;
              }
              else{
              finances[i].Current_Value__c = 0;
              }
           }                     
        }
        for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name == 'Achieving intended positioning (Grade)'){
              if(MarketingFields.Service_operations__c!=null){
                customers[i].Current_Value_Grade__c = MarketingFields.Service_operations__c;
              }else{
                customers[i].Current_Value_Grade__c = 'None';
              }
           }
           if(customermetrics[i].Name == 'Number of qualified leads'){
              if(SalesFields.Number_of_qualified_leads_SOps__c!=null){
                customers[i].Current_Value__c = SalesFields.Number_of_qualified_leads_SOps__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }        
        }
        for(Integer i=0;i<internalmetrics.size();i++){
           if(internalmetrics[i].Name == '% reuse (grade)'){
              if(PMOFields.reuse_for_SOPS_Practice__c!=null){
                internals[i].Current_Value_Grade__c = PMOFields.reuse_for_SOPS_Practice__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }
           /*if(internalmetrics[i].Name == '% of revenue from new services'){
              if(SalesFields.Sales_effectiveness_for_the_Org__c!=null){
                internals[i].Current_Value_Grade__c = SalesFields.Sales_effectiveness_for_the_Org__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }*/
           if(internalmetrics[i].Name == 'Achieving sales process compliance (Grade)'){
              if(SalesFields.Achieve_sales_process_compliance_SOps__c!=null){
                internals[i].Current_Value_Grade__c = SalesFields.Achieve_sales_process_compliance_SOps__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }                      
        }
        for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == '% of personnel attending at least 20 hours of training'){
              if(HRFields.attending_min_hrs_SOPS__c !=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_SOPS__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }                   
        }                      
    }
    public void fetchCorporateFormulasData(){
           for(Integer i=0;i<financemetrics.size();i++){
           if(financemetrics[i].Name == 'Bookings ($mn)'){
              if(FinanceFields.Bookings_for_the_organization__c!=null){
                finances[i].Current_Value__c = FinanceFields.Bookings_for_the_organization__c;
              }else{
                finances[i].Current_Value__c = 0;
              }
           }   
           if(financemetrics[i].Name == 'Revenue – Billings ($mn)'){
              if(FinanceFields.Total_Billing__c!=null){
                finances[i].Current_Value__c = FinanceFields.Total_Billing__c;
              }else{
                finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == 'Utilization rate (%)'){
              if(RMGFields.Utilization_rate__c!=null){
                finances[i].Current_Value__c = RMGFields.Utilization_rate__c;
              }else{
                finances[i].Current_Value__c = 0;
              }
           }
           if(financemetrics[i].Name == 'EBITDA ($mn)'){
              if(FinanceFields.EBITDA__c!=null){
                finances[i].Current_Value__c = FinanceFields.EBITDA__c;
              }else{
                finances[i].Current_Value__c = 0;
              }
           }                 
        }
        for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name == 'CSAT Score'){
              if(MarketingFields.CSAT_score__c!=null){
                customers[i].Current_Value__c = MarketingFields.CSAT_score__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }
           if(customermetrics[i].Name == 'ESAT score'){
              if(HRFields.ESAT_score__c!=null){
                customers[i].Current_Value__c = HRFields.ESAT_score__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }        
        }
        for(Integer i=0;i<internalmetrics.size();i++){
           if(internalmetrics[i].Name == 'Sales effectiveness (Grade)'){
              if(SalesFields.Sales_effectiveness_for_the_Org__c!=null){
                internals[i].Current_Value_Grade__c = SalesFields.Sales_effectiveness_for_the_Org__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }
        }                 
        for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == '# of whitepapers/ case studies/ marketing artifacts'){
              if(MarketingFields.of_artifacts_published__c!=null){
                learnings[i].Current_Value__c = MarketingFields.of_artifacts_published__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }
           if(learningmetrics[i].Name == 'Customer perception of Tavant (Grade)'){
              if(SalesFields.Customer_perception_of_Tavant__c!=null){
                learnings[i].Current_Value__c = SalesFields.Customer_perception_of_Tavant__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }           
           if(learningmetrics[i].Name == 'Training (%)'){
              if(HRFields.attending_min_hrs_Overall__c!=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_Overall__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }            
        }        
    }
   public void fetchDeliveryFormulasData(){ 
    for(Integer i=0;i<financemetrics.size();i++){
           if(financemetrics[i].Name == 'Billings ($mn)'){
              if(FinanceFields.Total_Billing__c!=null){
                finances[i].Current_Value__c= FinanceFields.Total_Billing__c;
              }else{
                finances[i].Current_Value__c= 0;
              }
           }   
           if(financemetrics[i].Name == '%GM'){
              if(FinanceFields.Overall_Org_GM__c!=null){
                finances[i].Current_Value__c= FinanceFields.Overall_Org_GM__c;
              }else{
                finances[i].Current_Value__c= 0;
              }
           }
           if(financemetrics[i].Name == 'Utilization rate (%)'){
              if(RMGFields.Utilization_rate__c!=null){
                finances[i].Current_Value__c= RMGFields.Utilization_rate__c;
              }else{
                finances[i].Current_Value__c= 0;
              }
           }
           if(financemetrics[i].Name == 'Improving readiness to staff new projects (Grade)'){
              if(RMGFields.Readiness_to_staff_new_projects__c!=null){
                finances[i].Current_Value_Grade__c = RMGFields.Readiness_to_staff_new_projects__c;
              }else{
                finances[i].Current_Value_Grade__c = 'None';
              }
           }                          
        } 
        for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name == 'CSAT score'){
              if(MarketingFields.CSAT_score__c!=null){
                customers[i].Current_Value__c = MarketingFields.CSAT_score__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }
           if(customermetrics[i].Name == '# of client visits by GDMs/ SPMs'){
              if(SalesFields.of_client_visits_by_GDMs_SPMs__c!=null){
                customers[i].Current_Value__c = SalesFields.of_client_visits_by_GDMs_SPMs__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }
           if(customermetrics[i].Name == 'Attrition rate (%)'){
              if(HRFields.Attrition_rate__c!=null){
                customers[i].Current_Value__c = HRFields.Attrition_rate__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }                   
        }
        for(Integer i=0;i<internalmetrics.size();i++){
           if(internalmetrics[i].Name == 'Projects at or above CMMi level 4 (%)'){
              if(SEPGFields.of_Projects_at_or_above_CMMi_level_4__c!=null){
                internals[i].Current_Value__c = SEPGFields.of_Projects_at_or_above_CMMi_level_4__c;
              }else{
                internals[i].Current_Value__c = 0;
              }
           }
           if(internalmetrics[i].Name == 'Timeliness in implementation of Tavant OK (Qtr)'){
              if(SEPGFields.Timeliness_in_projects_delivery__c!=null){
                internals[i].Current_Value__c = SEPGFields.Timeliness_in_projects_delivery__c;
              }else{
                internals[i].Current_Value__c = 0;
              }
           }
           if(internalmetrics[i].Name == 'Building frameworks, templates and reusable components (Grade)'){
              if(PMOFields.Degree_of_reusability_for_the_Org__c!=null){
                internals[i].Current_Value_Grade__c = PMOFields.Degree_of_reusability_for_the_Org__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }
           if(internalmetrics[i].Name == 'Attaining desired role ratios across the organization (Grade)'){
              if(RMGFields.Attain_desired_role_ratios__c!=null){
                internals[i].Current_Value_Grade__c = RMGFields.Attain_desired_role_ratios__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }                                 
        }                 
        for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == '% of personnel attending at least 20 hours of training'){
              if(HRFields.attending_min_hrs_Overall__c!=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_Overall__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }
           if(learningmetrics[i].Name == '# of whitepapers/ case studies/ marketing artifacts'){
              if(MarketingFields.of_artifacts_published__c!=null){
                learnings[i].Current_Value__c = MarketingFields.of_artifacts_published__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }                    
    }
    }
    public void fetchMarketingFormulasData(){
           for(Integer i=0;i<finances.size();i++){
           if(financemetrics[i].Name == 'Cost Per New Sale $ ($)'){
             if(FinanceFields.Total_cost_of_marketing__c!= null && FinanceFields.Total_new_sales__c!=null){
               finances[i].Current_Value__c = FinanceFields.Total_cost_of_marketing__c/FinanceFields.Total_new_sales__c;}
             else{
             finances[i].Current_Value__c = 0;
             }
           }
           if(financemetrics[i].Name == 'Cost Per Client ($)'){
             if(FinanceFields.Marketing_cost_per_client__c!= null){
               finances[i].Current_Value__c = FinanceFields.Marketing_cost_per_client__c;}
             else{
             finances[i].Current_Value__c = 0;
             }
           }        
       }
      for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name == 'CSAT score'){
              if(MarketingFields.CSAT_score__c!=null){
                customers[i].Current_Value__c = MarketingFields.CSAT_score__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }
        }       
       for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == '% of personnel attending at least 20 hours of training'){
              if(HRFields.attending_min_hrs_Marketing__c!=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_Marketing__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }
       }
    }
    public void fetchOperationsFormulasData(){
           for(Integer i=0;i<finances.size();i++){
           if(financemetrics[i].Name == '%GM'){
             if(FinanceFields.GM_of_Hosting_Business__c!= null){
               finances[i].Current_Value__c = FinanceFields.GM_of_Hosting_Business__c;}
             else{
             finances[i].Current_Value__c = 0;
             }
           }       
       }
       for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name == 'CSAT Score'){
              if(MarketingFields.Service_Operations_CSAT__c!=null){
                customers[i].Current_Value__c = MarketingFields.Service_Operations_CSAT__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }                
        }       
       for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == '% of personnel attending at least 20 hours of training'){
              if(HRFields.attending_min_hrs_Operations__c!=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_Operations__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }
       }
    }
    public void fetchFacilitiesFormulasData(){
           for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name== 'ESAT score'){
              if(HRFields.ESAT_score_for_Facilities_Deptt__c!=null){
                customers[i].Current_Value__c = HRFields.ESAT_score_for_Facilities_Deptt__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }                
        }       
       for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == '% of personnel attending at least 20 hours of training'){
              if(HRFields.attending_min_hrs_Facilities__c!=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_Facilities__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }
       }
    }
    public void fetchFinanceFormulasData(){
       /*for(Integer i=0;i<financemetrics.size();i++){
            if(financemetrics[i].Id== 'a0BW0000002zGtJ'){
               if(FinanceFields.Dealsheet_GM_key_Accs_AD__c!=null && FinanceFields.Execution_GM_key_Accs_AD__c!=null){
                finances[i].Current_Value__c = (FinanceFields.Dealsheet_GM_key_Accs_AD__c+FinanceFields.Execution_GM_key_Accs_AD__c)/2;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }
       }*/            
       for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name== 'ESAT score'){
              if(HRFields.ESAT_score_for_Finance_Deptt__c!=null){
                customers[i].Current_Value__c = HRFields.ESAT_score_for_Finance_Deptt__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }                
        }       
       for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == '% of personnel attending at least 20 hours of training'){
              if(HRFields.attending_min_hrs_Finance__c!=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_Finance__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }
       }
    }
    public void fetchISFormulasData(){
       for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name== 'ESAT score'){
              if(HRFields.ESAT_score_for_IS_Team__c!=null){
                customers[i].Current_Value__c = HRFields.ESAT_score_for_IS_Team__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }                
       }       
       for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == '% of personnel attending at least 20 hours of training'){
              if(HRFields.attending_min_hrs_IS__c!=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_IS__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }
       }
    }
    public void fetchHRFormulasData(){
       for(Integer i=0;i<internalmetrics.size();i++){
          if(internalmetrics[i].Name == 'ESAT score'){
             if(HRFields.ESAT_score__c!=null){
              internals[i].Current_Value__c = HRFields.ESAT_score__c;
              }else{
              internals[i].Current_Value__c = 0;
             }
          }
       }
    }
    public void fetchADFormulasData(){
            for(Integer i=0;i<financemetrics.size();i++){
            if(financemetrics[i].Name == '50%*(Dealsheet GM%)'){
               if(FinanceFields.Dealsheet_GM_key_Accs_AD__c!=null){
                finances[i].Current_Value__c = FinanceFields.Dealsheet_GM_key_Accs_AD__c;
            }else{
                finances[i].Current_Value__c = 0;
               }
            }
            if(financemetrics[i].Name == '50%*(Execution GM%)'){
               if(FinanceFields.Execution_GM_key_Accs_AD__c!=null){
                finances[i].Current_Value__c = FinanceFields.Execution_GM_key_Accs_AD__c;
            }else{
                finances[i].Current_Value__c = 0;
               }
            }                         
            /* if(financemetrics[i].Name == 'Average share of IT budgets (%)'){
               if(FinanceFields.Dealsheet_GM_key_Accs_AD__c!=null && FinanceFields.Execution_GM_key_Accs_AD__c!=null){
                finances[i].Current_Value__c = (FinanceFields.Dealsheet_GM_key_Accs_AD__c+FinanceFields.Execution_GM_key_Accs_AD__c)/2;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }     */        
            if(financemetrics[i].Name == 'Bookings for next year ($mn)'){
               if(FinanceFields.Key_Account_CP_AD_booking__c!=null){
                finances[i].Current_Value__c = FinanceFields.Key_Account_CP_AD_booking__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }            
            if(financemetrics[i].Name == 'Existing Client Billings ($mn)'){
               if(FinanceFields.Key_Account_CP_AD_existing_c_billing__c!=null){
                finances[i].Current_Value__c = FinanceFields.Key_Account_CP_AD_existing_c_billing__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }
            if(financemetrics[i].Name == 'Existing Client Bookings (Total) ($mn)'){
               if(FinanceFields.Key_Account_CP_AD_existing_client__c!=null){
                finances[i].Current_Value__c = FinanceFields.Key_Account_CP_AD_existing_client__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            } 
            if(financemetrics[i].Name == 'DSO (Days)'){
               if(SalesFields.CP_AD__c!=null){
                finances[i].Current_Value__c = SalesFields.CP_AD__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }                                       
        }
        for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name == 'CSAT score'){
              if(MarketingFields.Key_Accounts_CP_AD__c!=null){
                customers[i].Current_Value__c = MarketingFields.Key_Accounts_CP_AD__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }
           if(customermetrics[i].Name == 'Attrition rate among onsite employees (%)'){
              if(HRFields.Attrition_rate_for_CP_Plan_2012_AD__c!=null){
                customers[i].Current_Value__c = HRFields.Attrition_rate_for_CP_Plan_2012_AD__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }                   
        }
        for(Integer i=0;i<internalmetrics.size();i++){
           if(internalmetrics[i].Name == 'Improving forecast accuracy and resource planning (Grade)'){//forcast
              if(RMGFields.Resource_forecast_planning_CP_AD__c!=null){
                internals[i].Current_Value_Grade__c = RMGFields.Resource_forecast_planning_CP_AD__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }/*
           if(internalmetrics[i].Name == '% of revenue from new services'){
              if(SEPGFields.Timeliness_in_projects_delivery__c!=null){
                internals[i].Current_Value__c = SEPGFields.Timeliness_in_projects_delivery__c;
              }else{
                internals[i].Current_Value__c = 0;
              }
           }*/                               
        }                   
    }
    public void fetchRPFormulasData(){
           for(Integer i=0;i<finances.size();i++){
            if(financemetrics[i].Name == '50%*(Dealsheet GM%)'){
              if(FinanceFields.Dealsheet_GM_key_Accs_RP__c!=null){
                finances[i].Current_Value__c = FinanceFields.Dealsheet_GM_key_Accs_RP__c;
              }else{
                finances[i].Current_Value__c = 0;
              }
            }
            if(financemetrics[i].Name == '50%*(Execution GM%)'){
              if(FinanceFields.Execution_GM_key_Accs_RP__c!=null){
                finances[i].Current_Value__c = FinanceFields.Execution_GM_key_Accs_RP__c;
              }else{
                finances[i].Current_Value__c = 0;
              }
            }                       
            /*  if(financemetrics[i].Name == 'Average share of IT budgets (%)'){
               if(FinanceFields.Dealsheet_GM_key_Accs_AD__c!=null && FinanceFields.Execution_GM_key_Accs_AD__c!=null){
                finances[i].Current_Value__c = (FinanceFields.Dealsheet_GM_key_Accs_AD__c/FinanceFields.Execution_GM_key_Accs_AD__c);}
               else{
                finances[i].Current_Value__c = 0;
               }
            }         */    
            if(financemetrics[i].Name == 'Bookings for next year ($mn)'){
               if(FinanceFields.Key_Account_CP_RP_bookings__c!=null){
                finances[i].Current_Value__c = FinanceFields.Key_Account_CP_RP_bookings__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }            
            if(financemetrics[i].Name == 'Existing Client Billings ($mn)'){
               if(FinanceFields.Key_Account_CP_RP_existing_c_billing__c!=null){
                finances[i].Current_Value__c = FinanceFields.Key_Account_CP_RP_existing_c_billing__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }
            if(financemetrics[i].Name == 'Existing Client Bookings (Total) ($mn)'){
               if(FinanceFields.Key_Account_CP_RP_existing_client__c!=null){
                finances[i].Current_Value__c = FinanceFields.Key_Account_CP_RP_existing_client__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            } 
            if(financemetrics[i].Name == 'DSO (days)'){
               if(SalesFields.CP_RP__c!=null){
                finances[i].Current_Value__c = SalesFields.CP_RP__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }                                       
        }
        for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name == 'CSAT score'){
              if(MarketingFields.Key_Accounts_CP_RP__c!=null){
                customers[i].Current_Value__c = MarketingFields.Key_Accounts_CP_RP__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }
           if(customermetrics[i].Name == 'Attrition rate among onsite employees (%)'){
              if(HRFields.Attrition_rate_for_CP_Plan_2012_RP__c!=null){
                customers[i].Current_Value__c = HRFields.Attrition_rate_for_CP_Plan_2012_RP__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }                   
        }
        for(Integer i=0;i<internalmetrics.size();i++){
           if(internalmetrics[i].Name == 'Improving forecast accuracy and resource planning (Grade)'){//forcast
              if(RMGFields.Resource_forecast_planning_CP_RP__c!=null){
                internals[i].Current_Value_Grade__c = RMGFields.Resource_forecast_planning_CP_RP__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }/*
           if(internalmetrics[i].Name == '% of revenue from new services'){
              if(SEPGFields.Timeliness_in_projects_delivery__c!=null){
                internals[i].Current_Value__c = SEPGFields.Timeliness_in_projects_delivery__c;
              }else{
                internals[i].Current_Value__c = 0;
              }
           }*/                               
        }       
    }
    public void fetchPSFormulasData(){
     for(Integer i=0;i<finances.size();i++){
            if(financemetrics[i].Name == '50%*(Dealsheet GM%)'){
              if(FinanceFields.Dealsheet_GM_key_Accs_PS__c!=null){
                finances[i].Current_Value__c = FinanceFields.Dealsheet_GM_key_Accs_PS__c;
              }else{
              finances[i].Current_Value__c = 0;
              }
            }
            if(financemetrics[i].Name == '50%*(Execution GM%)'){
              if(FinanceFields.Execution_GM_key_Accs_PS__c!=null){
                finances[i].Current_Value__c = FinanceFields.Execution_GM_key_Accs_PS__c;
              }else{
              finances[i].Current_Value__c = 0;
              }
            }                        
            /*if(financemetrics[i].Name == 'Average share of IT budgets (%)'){
               if(FinanceFields.Dealsheet_GM_key_Accs_AD__c!=null && FinanceFields.Execution_GM_key_Accs_AD__c!=null){
                finances[i].Current_Value__c = (FinanceFields.Dealsheet_GM_key_Accs_AD__c/FinanceFields.Execution_GM_key_Accs_AD__c);}
               else{
                finances[i].Current_Value__c = 0;
               }
            }*/
            if(financemetrics[i].Name == 'Bookings for next year ($mn)'){
               if(FinanceFields.Key_Account_CP_PS_bookings__c!=null){
                finances[i].Current_Value__c = FinanceFields.Key_Account_CP_PS_bookings__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }            
            if(financemetrics[i].Name == 'Existing Client Billings ($mn)'){
               if(FinanceFields.Key_Account_CP_PS_existing_c_billing__c!=null){
                finances[i].Current_Value__c = FinanceFields.Key_Account_CP_PS_existing_c_billing__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }
            if(financemetrics[i].Name == 'Existing Client Bookings (Total) ($mn)'){
               if(FinanceFields.Key_Account_CP_PS_existing_client__c!=null){
                finances[i].Current_Value__c = FinanceFields.Key_Account_CP_PS_existing_client__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            } 
            if(financemetrics[i].Name == 'DSO (days)'){
               if(SalesFields.CP_ps__c!=null){
                finances[i].Current_Value__c = SalesFields.CP_ps__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }                                       
        }
        for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name == 'CSAT score'){
              if(MarketingFields.Key_Accounts_CP_PS__c!=null){
                customers[i].Current_Value__c = MarketingFields.Key_Accounts_CP_PS__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }
           if(customermetrics[i].Name == 'Attrition rate among onsite employees (%)'){
              if(HRFields.Attrition_rate_for_CP_Plan_2012_PS__c!=null){
                customers[i].Current_Value__c = HRFields.Attrition_rate_for_CP_Plan_2012_PS__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }                   
        }
        for(Integer i=0;i<internalmetrics.size();i++){
           if(internalmetrics[i].Name == 'Improving forecast accuracy and resource planning (Grade)'){//forcast
              if(RMGFields.Resource_forecast_planning_CP_PS__c!=null){
                internals[i].Current_Value_Grade__c = RMGFields.Resource_forecast_planning_CP_PS__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }/*
           if(internalmetrics[i].Name == '% of revenue from new services'){
              if(SEPGFields.Timeliness_in_projects_delivery__c!=null){
                internals[i].Current_Value__c = SEPGFields.Timeliness_in_projects_delivery__c;
              }else{
                internals[i].Current_Value__c = 0;
              }
           }*/                               
        }  
    }
    public void fetchKKFormulasData(){
           for(Integer i=0;i<finances.size();i++){
            if(financemetrics[i].Name == '50%*(Dealsheet GM%)'){
              if(FinanceFields.Dealsheet_GM_key_Accs_KK__c!=null){
                finances[i].Current_Value__c = FinanceFields.Dealsheet_GM_key_Accs_KK__c;
              }else{
                finances[i].Current_Value__c = 0;
              }
            }  
            if(financemetrics[i].Name == '50%*(Execution GM%)'){
              if(FinanceFields.Execution_GM_key_Accs_KK__c!=null){
                finances[i].Current_Value__c = FinanceFields.Execution_GM_key_Accs_KK__c;
              }else{
                finances[i].Current_Value__c = 0;
              }
            }                           
            /*if(financemetrics[i].Name == 'Average share of IT budgets (%)'){
               if(FinanceFields.Dealsheet_GM_key_Accs_AD__c!=null && FinanceFields.Execution_GM_key_Accs_AD__c!=null){
                finances[i].Current_Value__c = (FinanceFields.Dealsheet_GM_key_Accs_AD__c/FinanceFields.Execution_GM_key_Accs_AD__c);}
               else{
                finances[i].Current_Value__c = 0;
               }
            }*/
            if(financemetrics[i].Name == 'Bookings for next year ($mn)'){
               if(FinanceFields.Key_Account_CP_KK_bookings__c!=null){
                finances[i].Current_Value__c = FinanceFields.Key_Account_CP_KK_bookings__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }            
            if(financemetrics[i].Name == 'Existing Client Billings ($mn)'){
               if(FinanceFields.Key_Account_CP_KK_existing_c_billing__c!=null){
                finances[i].Current_Value__c = FinanceFields.Key_Account_CP_KK_existing_c_billing__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }
            if(financemetrics[i].Name == 'Existing Client Bookings (Total) ($mn)'){
               if(FinanceFields.Key_Account_CP_KK_existing_client__c!=null){
                finances[i].Current_Value__c = FinanceFields.Key_Account_CP_KK_existing_client__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            } 
            if(financemetrics[i].Name == 'DSO (days)'){
               if(SalesFields.CP_KK__c!=null){
                finances[i].Current_Value__c = SalesFields.CP_KK__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }                                       
        }
        for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name == 'CSAT score'){
              if(MarketingFields.Key_Accounts_CP_kk__c!=null){
                customers[i].Current_Value__c = MarketingFields.Key_Accounts_CP_kk__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }
           if(customermetrics[i].Name == 'Attrition rate among onsite employees (%)'){
              if(HRFields.Attrition_rate_for_CP_Plan_2012_KK__c!=null){
                customers[i].Current_Value__c = HRFields.Attrition_rate_for_CP_Plan_2012_KK__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }                   
        }
        for(Integer i=0;i<internalmetrics.size();i++){
           if(internalmetrics[i].Name == 'Improving forecast accuracy and resource planning (Grade)'){//forcast
              if(RMGFields.Resource_forecast_planning_CP_KK__c!=null){
                internals[i].Current_Value_Grade__c = RMGFields.Resource_forecast_planning_CP_KK__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }/*
           if(internalmetrics[i].Name == '% of revenue from new services'){
              if(SEPGFields.Timeliness_in_projects_delivery__c!=null){
                internals[i].Current_Value__c = SEPGFields.Timeliness_in_projects_delivery__c;
              }else{
                internals[i].Current_Value__c = 0;
              }
           }*/                               
        }                
    }
    public void fetchManiFormulasData(){
           for(Integer i=0;i<finances.size();i++){
            if(financemetrics[i].Name == '25% * Execution GM (%)'){
              if(FinanceFields.Execution_GM_sales_Mani__c!=null){
                finances[i].Current_Value__c = FinanceFields.Execution_GM_sales_Mani__c;
              }else{
              finances[i].Current_Value__c = 0;
              }
            }
            if(financemetrics[i].Name == '75% * Dealsheet GM (%)'){
              if(FinanceFields.Dealsheet_GM_sales_Mani__c!=null){
                finances[i].Current_Value__c = FinanceFields.Dealsheet_GM_sales_Mani__c;
              }else{
              finances[i].Current_Value__c = 0;
              }
            }            
            if(financemetrics[i].Name == 'DSO (days)'){
               if(SalesFields.Sales_Mani__c!=null){
                finances[i].Current_Value__c = SalesFields.Sales_Mani__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }
            if(financemetrics[i].Name == 'New Sales Billings ($mn)'){
               if(FinanceFields.Sales_Mani_new_sales_billing__c!=null){
                finances[i].Current_Value__c = FinanceFields.Sales_Mani_new_sales_billing__c;
               }else{
                finances[i].Current_Value__c = 0;
               }
            }                  
            if(financemetrics[i].Name == 'New Sales Bookings (Total) ($mn)'){
               if(FinanceFields.Sales_Mani_new_sales_booking__c!=null){
                finances[i].Current_Value__c = FinanceFields.Sales_Mani_new_sales_booking__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }                                       
        }
        /*for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name == 'CSAT score'){
              if(MarketingFields.Key_Accounts_CP_PS__c!=null){
                customers[i].Current_Value__c = MarketingFields.Key_Accounts_CP_PS__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }                
        }*/
        for(Integer i=0;i<internalmetrics.size();i++){
           if(internalmetrics[i].Name == 'Improving forecast accuracy and resource planning (Grade)'){//forcast
              if(RMGFields.Resource_forecast_planning_Sales_Mani__c!=null){
                internals[i].Current_Value_Grade__c = RMGFields.Resource_forecast_planning_Sales_Mani__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }/*
           if(internalmetrics[i].Name == '% of revenue from new services'){
              if(SEPGFields.Timeliness_in_projects_delivery__c!=null){
                internals[i].Current_Value__c = SEPGFields.Timeliness_in_projects_delivery__c;
              }else{
                internals[i].Current_Value__c = 0;
              }
           }*/                               
        }  
        for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == '% of personnel attending at least 20 hours of training'){//training
              if(HRFields.attending_min_hrs_Sales_Mani__c!=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_Sales_Mani__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }/*
           if(learningmetrics[i].Name == 'Cost Per Qualified Lead ($)'){
              if(MarketingFields.of_artifacts_published__c!=null){
                learnings[i].Current_Value__c = MarketingFields.of_artifacts_published__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }  */                  
           if(learningmetrics[i].Name == 'Cost Per Customer ($)'){
              if(FinanceFields.Sales_Mani_customer__c!=null){
                learnings[i].Current_Value__c = FinanceFields.Sales_Mani_customer__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }
           if(learningmetrics[i].Name == 'Cost Per New Sale $ ($)'){
              if(FinanceFields.Sales_Mani_cpns__c!=null){
                learnings[i].Current_Value__c = FinanceFields.Sales_Mani_cpns__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }                               
        }        
    }
    public void fetchDITFormulasData(){
           for(Integer i=0;i<finances.size();i++){
            if(financemetrics[i].Name == '75% * Dealsheet GM (%)'){
              if(FinanceFields.Dealsheet_GM_sales_DIT__c!=null){
                finances[i].Current_Value__c = FinanceFields.Dealsheet_GM_sales_DIT__c;
              }else{
              finances[i].Current_Value__c = 0;
              }
            }
            if(financemetrics[i].Name == '25% * Execution GM (%)'){
              if(FinanceFields.Execution_GM_sales_DIT__c!=null){
                finances[i].Current_Value__c = FinanceFields.Execution_GM_sales_DIT__c;
              }else{
              finances[i].Current_Value__c = 0;
              }
            }            
            if(financemetrics[i].Name == 'DSO (days)'){
               if(SalesFields.Sales_DIT__c!=null){
                finances[i].Current_Value__c = SalesFields.Sales_DIT__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }/*
            if(financemetrics[i].Name == 'New Sales Billings ($mn)'){
               if(FinanceFields.Sales_DIT_new_sales_billing__c!=null){
                finances[i].Current_Value__c = FinanceFields.Sales_DIT_new_sales_billing__c;
               }else{
                finances[i].Current_Value__c = 0;
               }
            }  */                 
            if(financemetrics[i].Name == 'New Sales Bookings (Total) ($)'){
               if(FinanceFields.Sales_DIT_new_sales_booking__c!=null){
                finances[i].Current_Value__c = FinanceFields.Sales_DIT_new_sales_booking__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }                                       
        }
        /*for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name == 'CSAT score'){
              if(MarketingFields.Key_Accounts_CP_PS__c!=null){
                customers[i].Current_Value__c = MarketingFields.Key_Accounts_CP_PS__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }                
        }*/
        for(Integer i=0;i<internalmetrics.size();i++){
           if(internalmetrics[i].Name == 'Improving forecast accuracy and resource planning (Grade)'){//forcast
              if(RMGFields.Resource_forecast_planning_Sales_DIT__c!=null){
                internals[i].Current_Value_Grade__c = RMGFields.Resource_forecast_planning_Sales_DIT__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }/*
           if(internalmetrics[i].Name == '% of revenue from new services'){
              if(SEPGFields.Timeliness_in_projects_delivery__c!=null){
                internals[i].Current_Value__c = SEPGFields.Timeliness_in_projects_delivery__c;
              }else{
                internals[i].Current_Value__c = 0;
              }
           }*/                               
        }  
        for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == '% of personnel attending at least 20 hours of training'){
              if(HRFields.attending_min_hrs_Sales_DIT__c!=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_Sales_DIT__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }/*
           if(learningmetrics[i].Name == 'Cost Per Qualified Lead ($)'){
              if(MarketingFields.of_artifacts_published__c!=null){
                learnings[i].Current_Value__c = MarketingFields.of_artifacts_published__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }  */                  
           if(learningmetrics[i].Name == 'Cost Per Customer ($)'){
              if(FinanceFields.Sales_DIT_customer__c!=null){
                learnings[i].Current_Value__c = FinanceFields.Sales_DIT_customer__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }
           if(learningmetrics[i].Name == 'Cost Per New Sale $ ($)'){
              if(FinanceFields.Sales_DIT_cpns__c!=null){
                learnings[i].Current_Value__c = FinanceFields.Sales_DIT_cpns__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }                               
        }       
    }
    public void fetchSatyaFormulasData(){
      for(Integer i=0;i<finances.size();i++){
            if(financemetrics[i].Name == '75% * Dealsheet GM (%)'){
              if(FinanceFields.Dealsheet_GM_sales_Satya__c!=null){
                finances[i].Current_Value__c = FinanceFields.Dealsheet_GM_sales_Satya__c;
              }else{
              finances[i].Current_Value__c = 0;
              }
            }
            if(financemetrics[i].Name == '25% * Execution GM (%)'){
              if(FinanceFields.Execution_GM_sales_Satya__c!=null){
                finances[i].Current_Value__c = FinanceFields.Execution_GM_sales_Satya__c;
              }else{
              finances[i].Current_Value__c = 0;
              }
            }            
            if(financemetrics[i].Name == 'DSO (days)'){
               if(SalesFields.Sales_Satya__c!=null){
                finances[i].Current_Value__c = SalesFields.Sales_Satya__c;
               }else{
                finances[i].Current_Value__c = 0;
               }
            }
            if(financemetrics[i].Name == 'New Sales Billings ($mn)'){
               if(FinanceFields.Sales_Satya_new_sales_billing__c!=null){
                finances[i].Current_Value__c = FinanceFields.Sales_Satya_new_sales_billing__c;
               }else{
                finances[i].Current_Value__c = 0;
               }
            }              
            if(financemetrics[i].Name == 'New Sales Bookings (Total) ($mn)'){
               if(FinanceFields.Sales_Satya_new_sales_billing__c!=null){
                finances[i].Current_Value__c = FinanceFields.Sales_Satya_new_sales_billing__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }                                       
        }
        /*for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name == 'CSAT score'){
              if(MarketingFields.Key_Accounts_CP_PS__c!=null){
                customers[i].Current_Value__c = MarketingFields.Key_Accounts_CP_PS__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }                
        }*/
        for(Integer i=0;i<internalmetrics.size();i++){
           if(internalmetrics[i].Name == 'Improving forecast accuracy and resource planning (Grade)'){//forcast
              if(RMGFields.Resource_forecast_planning_Sales_Satya__c!=null){
                internals[i].Current_Value_Grade__c = RMGFields.Resource_forecast_planning_Sales_Satya__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }/*
           if(internalmetrics[i].Name == '% of revenue from new services'){
              if(SEPGFields.Timeliness_in_projects_delivery__c!=null){
                internals[i].Current_Value__c = SEPGFields.Timeliness_in_projects_delivery__c;
              }else{
                internals[i].Current_Value__c = 0;
              }
           }*/                               
        }  
        for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == '% of personnel attending at least 20 hours of training'){
              if(HRFields.attending_min_hrs_Sales_Satya__c!=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_Sales_Satya__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }/*
           if(learningmetrics[i].Name == 'Cost Per Qualified Lead ($)'){
              if(MarketingFields.of_artifacts_published__c!=null){
                learnings[i].Current_Value__c = MarketingFields.of_artifacts_published__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }  */                  
           if(learningmetrics[i].Name == 'Cost Per Customer ($)'){
              if(FinanceFields.Sales_Satya_customer__c!=null){
                learnings[i].Current_Value__c = FinanceFields.Sales_Satya_customer__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }
           if(learningmetrics[i].Name == 'Cost Per New Sale $ ($)'){
              if(FinanceFields.Sales_Satya_cpns__c!=null){
                learnings[i].Current_Value__c = FinanceFields.Sales_Satya_cpns__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }                               
        }       
    }
    public void fetchSalesOverallFormulasData(){
    List<Financial__c> sum = [SELECT Current_Value__c 
    FROM Financial__c 
    WHERE LinkID__c IN(SELECT Id FROM Scorecard_Instances__c 
    WHERE Name LIKE 'sales%' and Month__c =:getMonth()AND Year__c =:getYear()) 
    AND Metrics__c IN(SELECT Id FROM Metrics__c 
    WHERE Department__c='Sales Marketing' AND Name='New Sales Billings ($mn)')];
   Decimal sumtotal = 0;
        for(Integer i=0;i<sum.size();i++){
              sumtotal = sumtotal+sum[i].Current_Value__c;
        }    
        for(Integer i=0;i<finances.size();i++){
            if(financemetrics[i].Name == 'New Sales Billings ($mn)'){
                finances[i].Current_Value__c = sumtotal;
            }
            if(financemetrics[i].Name == '75% * Dealsheet GM (%)'){
               if(FinanceFields.Overall_deal_sheet_GM__c!=null){
                 finances[i].Current_Value__c = FinanceFields.Overall_deal_sheet_GM__c;
               }else{
                 finances[i].Current_Value__c = 0;
               }
            }
            if(financemetrics[i].Name == '25% * Execution GM (%)'){
               if(FinanceFields.Overall_execution_GM__c!=null){
                 finances[i].Current_Value__c = FinanceFields.Overall_execution_GM__c;
               }else{
                 finances[i].Current_Value__c = 0;
               }
            }            
            if(financemetrics[i].Name == 'DSO (days)'){
               if(SalesFields.Sales_Overall__c!=null){
                 finances[i].Current_Value__c = SalesFields.Sales_Overall__c;
                 }else{
                 finances[i].Current_Value__c = 0;
               }
            }            
        }
       for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == '% of personnel attending at least 20 hours of training'){
              if(HRFields.attending_min_hrs_Sales_Overall__c!=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_Sales_Overall__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }
       } 
    }
    public void fetchVKFormulasData(){
      for(Integer i=0;i<finances.size();i++){
            if(financemetrics[i].Name == '75% * Dealsheet GM (%)'){
              if(FinanceFields.Dealsheet_GM_sales_VK__c!=null){
                finances[i].Current_Value__c = FinanceFields.Dealsheet_GM_sales_VK__c;
              }else{
              finances[i].Current_Value__c = 0;
              }
            }
            if(financemetrics[i].Name == '25% * Execution GM (%)'){
              if(FinanceFields.Execution_GM_sales_VK__c!=null){
                finances[i].Current_Value__c = FinanceFields.Execution_GM_sales_VK__c;
              }else{
              finances[i].Current_Value__c = 0;
              }
            }            
            /*if(financemetrics[i].Name == 'New Sales Billings ($mn)'){
               if(FinanceFields.Sales_VK_new_sales_billing__c!=null){
                finances[i].Current_Value__c = FinanceFields.Sales_VK_new_sales_billing__c;
               }else{
                finances[i].Current_Value__c = 0;
               }
            }*/                  
            if(financemetrics[i].Name == 'DSO (days)'){
               if(SalesFields.Sales_VK__c!=null){
                finances[i].Current_Value__c = SalesFields.Sales_VK__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            } 
            if(financemetrics[i].Name == 'New Sales Bookings (Total) ($mn)'){
               if(FinanceFields.Sales_VK_new_sales_booking__c!=null){
                finances[i].Current_Value__c = FinanceFields.Sales_VK_new_sales_booking__c;}
               else{
                finances[i].Current_Value__c = 0;
               }
            }                                       
        }
        /*for(Integer i=0;i<customermetrics.size();i++){
           if(customermetrics[i].Name == 'CSAT score'){
              if(MarketingFields.Key_Accounts_CP_PS__c!=null){
                customers[i].Current_Value__c = MarketingFields.Key_Accounts_CP_PS__c;
              }else{
                customers[i].Current_Value__c = 0;
              }
           }                
        }*/
        for(Integer i=0;i<internalmetrics.size();i++){
           if(internalmetrics[i].Name == 'Improving forecast accuracy and resource planning (Grade)'){//forcast
              if(RMGFields.Resource_forecast_planning_Sales_VK__c!=null){
                internals[i].Current_Value_Grade__c = RMGFields.Resource_forecast_planning_Sales_VK__c;
              }else{
                internals[i].Current_Value_Grade__c = 'None';
              }
           }/*
           if(internalmetrics[i].Name == '% of revenue from new services'){
              if(SEPGFields.Timeliness_in_projects_delivery__c!=null){
                internals[i].Current_Value__c = SEPGFields.Timeliness_in_projects_delivery__c;
              }else{
                internals[i].Current_Value__c = 0;
              }
           }*/                               
        }  
        for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == '% of personnel attending at least 20 hours of training'){
              if(HRFields.attending_min_hrs_Sales_VK__c!=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_Sales_VK__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }/*
           if(learningmetrics[i].Name == 'Cost Per Qualified Lead ($)'){
              if(MarketingFields.of_artifacts_published__c!=null){
                learnings[i].Current_Value__c = MarketingFields.of_artifacts_published__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }  */                  
           if(learningmetrics[i].Name == 'Cost Per Customer ($)'){
              if(FinanceFields.Sales_VK_customer__c!=null){
                learnings[i].Current_Value__c = FinanceFields.Sales_VK_customer__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }
           if(learningmetrics[i].Name == 'Cost Per New Sale $'){
              if(FinanceFields.Sales_VK_cpns__c!=null){
                learnings[i].Current_Value__c = FinanceFields.Sales_VK_cpns__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }                               
        }       
    }
    public void fetchISPFormulasData(){
        for(Integer i=0;i<learningmetrics.size();i++){
           if(learningmetrics[i].Name == 'a0BW0000002zGwq'){
              if(HRFields.attending_min_hrs_Inside_Sales__c!=null){
                learnings[i].Current_Value__c = HRFields.attending_min_hrs_Inside_Sales__c;
              }else{
                learnings[i].Current_Value__c = 0;
              }
           }
        }
    }
   
}