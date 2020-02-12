public class FinanceDataController4 {
ApexPages.StandardController controller{get; set;}
private String Name;
private String GM_of_Hosting_Business;
private String Amount_of_Loss_due_to_compliance_issues;
private String Dealsheet_GM_Capital_Markets_project;
private String Dealsheet_GM_for_CL_projects;
private String Dealsheet_GM_for_E_business_projects;
private String Dealsheet_GM_for_E_media_projects;
private String Dealsheet_GM_key_Accs_AD;
private String Dealsheet_GM_key_Accs_KK;
private String Dealsheet_GM_key_Accs_PS;
private String Dealsheet_GM_key_Accs_RP;
private String Dealsheet_GM_sales_DIT;
private String Dealsheet_GM_sales_Mani;
private String Dealsheet_GM_sales_Satya;
private String Dealsheet_GM_sales_VK;
private String Dealsheet_GM_for_SOPS_projects;
private String EBITDA;
private String Execution_GM_Capital_Markets_projects;
private String Execution_GM_for_CL_projects;
private String Execution_GM_for_E_business_projects;
private String Execution_GM_for_E_media_projects;
private String Execution_GM_key_Accs_AD;
private String Execution_GM_key_Accs_KK;
private String Execution_GM_key_Accs_PS;
private String Execution_GM_key_Accs_RP;
private String Execution_GM_sales_DIT;


private String Execution_GM_sales_Mani;
private String Execution_GM_sales_Satya;
private String Execution_GM_sales_VK;
private String Execution_GM_for_SOPS_projects;

private String Overall_deal_sheet_GM;
private String Overall_execution_GM;
private String Overall_Org_GM;
private String Total_biiling_in_Consumer_Lending;

private String Total_Billing;
private String Total_billing_in_Capital_Markets;
private String Total_billing_in_E_business;
private String Total_billing_in_E_media;

private String Total_billing_in_Key_Account_CP_AD;
private String Total_billing_in_Key_Account_CP_kk;
private String Total_billing_in_Key_Account_CP_ps;
private String Total_billing_in_Key_Account_CP_RP;

private String Total_billing_in_SOPS;
private String Total_billinTotal_g_in_Capital_Markets;
private String Total_expenditures;
private String Year;
private String Month;
/* public String getFirstName() {
return this.firstName;
}*/

private String Bookings_for_the_organization;
private String existing_client_sales_billing_CM;
private String New_sales_billings_CM;
private String Total_bookings_CM;
private String existing_client_sales_billing_CL;
private String New_sales_billings_CL;
private String Total_bookings_CL;
private String existing_client_sales_billing_E_biz;
private String New_sales_billings_E_biz;
private String Total_bookings_E_biz;
private String existing_client_sales_billing_emedia;
private String New_sales_billings_E_Media;
private String Total_bookings_E_Media;
private String Inside_Sales_cpns;
private String Inside_Sales_customer;
private String Key_Account_CP_AD_existing_c_billing;
private String Key_Account_CP_KK_existing_c_billing;
private String Key_Account_CP_PS_existing_c_billing;
private String Key_Account_CP_RP_existing_c_billing;
private String Key_Account_CP_AD_booking;
private String Key_Account_CP_AD_existing_client;
private String Key_Account_CP_KK_bookings;
private String Key_Account_CP_KK_existing_client;
private String Key_Account_CP_PS_bookings;
private String Key_Account_CP_PS_existing_client;
private String Key_Account_CP_RP_bookings;
private String Key_Account_CP_RP_existing_client;
private String Marketing_cost_per_client;
private String Marketing_cost_per_new_sale;
private String Sales_DIT_cpns;
private String Sales_DIT_customer;
private String Sales_DIT_new_sales_booking;
private String Sales_DIT_new_sales_billing;
private String Sales_Mani_cpns;
private String Sales_Mani_new_sales_booking;
private String Sales_Mani_new_sales_billing;
private String Sales_Mani_customer;
private String Sales_Overall_customer;
private String Sales_Overall_new_sales_booking;
private String Sales_Overall_new_sales_billing;
private String Sales_Overall_cpns;
private String Sales_Satya_customer;
private String Sales_Satya_new_sales_booking;
private String Sales_Satya_cpns;
private String Sales_VK_cpns;
private String Sales_VK_customer;
private String Sales_VK_new_sales_booking;
private String Sales_VK_new_sales_billing;
private String existing_client_sales_billing_SOps;
private String New_sales_billings_SOps;
private String Total_bookings_SOps;

private String Total_cost_of_marketing;
private String Total_new_sales;





public String getName() {
return Name;
}
public void setName(String firstName) {
this.Name= firstName;
}

public String getGM_of_Hosting_Business() {
return GM_of_Hosting_Business;
}
public void setGM_of_Hosting_Business(String add) {
this.GM_of_Hosting_Business=add;
}
public String getAmount_of_Loss_due_to_compliance_issues() {
return Amount_of_Loss_due_to_compliance_issues;
}
public void setAmount_of_Loss_due_to_compliance_issues(String email) {
this.Amount_of_Loss_due_to_compliance_issues= email;
}
public String getDealsheet_GM_Capital_Markets_project() {
return Dealsheet_GM_Capital_Markets_project;
}
public void setDealsheet_GM_Capital_Markets_project(String add) {
this.Dealsheet_GM_Capital_Markets_project=add;
}

public String getDealsheet_GM_for_CL_projects() {
return Dealsheet_GM_for_CL_projects;
}
public void setDealsheet_GM_for_CL_projects(String add) {
this.Dealsheet_GM_for_CL_projects=add;
}
public String getDealsheet_GM_for_E_business_projects() {
return Dealsheet_GM_for_E_business_projects;
}
public void setDealsheet_GM_for_E_business_projects(String add) {
this.Dealsheet_GM_for_E_business_projects=add;
}
public String getDealsheet_GM_for_E_media_projects() {
return Dealsheet_GM_for_E_media_projects;
}
public void setDealsheet_GM_for_E_media_projects(String add) {
this.Dealsheet_GM_for_E_media_projects=add;
}
public String getExecution_GM_for_E_business_projects() {
return Execution_GM_for_E_business_projects;
}
public void setExecution_GM_for_E_business_projects(String add) {
this.Execution_GM_for_E_business_projects=add;
}

public String getDealsheet_GM_key_Accs_AD() {
return Dealsheet_GM_key_Accs_AD;
}
public void setDealsheet_GM_key_Accs_AD(String add) {
this.Dealsheet_GM_key_Accs_AD=add;
}
public String getDealsheet_GM_key_Accs_KK() {
return Dealsheet_GM_key_Accs_KK;
}
public void setDealsheet_GM_key_Accs_KK(String add) {
this.Dealsheet_GM_key_Accs_KK=add;
}
public String getDealsheet_GM_key_Accs_PS() {
return Dealsheet_GM_key_Accs_PS;
}
public void setDealsheet_GM_key_Accs_PS(String add) {
this.Dealsheet_GM_key_Accs_PS=add;
}
public String getDealsheet_GM_key_Accs_RP() {
return Dealsheet_GM_key_Accs_RP;
}
public void setDealsheet_GM_key_Accs_RP(String add) {
this.Dealsheet_GM_key_Accs_RP=add;
}
public String getExecution_GM_sales_DIT() {
return Execution_GM_sales_DIT;
}
public void setExecution_GM_sales_DIT(String add) {
this.Execution_GM_sales_DIT=add;
}
public String getExecution_GM_sales_Mani() {
return Execution_GM_sales_Mani;
}
public void setExecution_GM_sales_Mani(String add) {
this.Execution_GM_sales_Mani=add;
}
public String getDealsheet_GM_sales_Satya() {
return Dealsheet_GM_sales_Satya;
}
public void setDealsheet_GM_sales_Satya(String add) {
this.Dealsheet_GM_sales_Satya=add;
}
public String getExecution_GM_sales_VK() {
return Execution_GM_sales_VK;
}
public void setExecution_GM_sales_VK(String add) {
this.Execution_GM_sales_VK=add;
}
public String getDealsheet_GM_for_SOPS_projects() {
return Dealsheet_GM_for_SOPS_projects;
}
public void setDealsheet_GM_for_SOPS_projects(String add) {
this.Dealsheet_GM_for_SOPS_projects=add;
}
public String getOverall_deal_sheet_GM() {
return Overall_deal_sheet_GM;
}
public void setOverall_deal_sheet_GM(String add) {
this.Overall_deal_sheet_GM=add;
}
public String getOverall_execution_GM() {
return Overall_execution_GM;
}
public void setOverall_execution_GM(String add) {
this.Overall_execution_GM=add;
}
public String getOverall_Org_GM() {
return Overall_Org_GM;
}
public void setOverall_Org_GM(String add) {
this.Overall_Org_GM=add;
}
public String getTotal_biiling_in_Consumer_Lending() {
return Total_biiling_in_Consumer_Lending;
}
public void setTotal_biiling_in_Consumer_Lending(String add) {
this.Total_biiling_in_Consumer_Lending=add;
}
public String getTotal_Billing() {
return Total_Billing;
}
public void setTotal_Billing(String add) {
this.Total_Billing=add;
}
public String getTotal_billing_in_Capital_Markets() {
return Total_billing_in_Capital_Markets;
}
public void setTotal_billing_in_Capital_Markets(String add) {
this.Total_billing_in_Capital_Markets=add;
}
public String getTotal_billing_in_E_business() {
return Total_billing_in_E_business;
}
public void setTotal_billing_in_E_business(String add) {
this.Total_billing_in_E_business=add;
}
public String getTotal_billing_in_E_media() {
return Total_billing_in_E_media;
}
public void setTotal_billing_in_E_media(String add) {
this.Total_billing_in_E_media=add;
}
public String getTotal_billing_in_Key_Account_CP_AD() {
return Total_billing_in_Key_Account_CP_AD;
}
public void setTotal_billing_in_Key_Account_CP_AD(String add) {
this.Total_billing_in_Key_Account_CP_AD=add;
}
public String getTotal_billing_in_Key_Account_CP_kk() {
return Total_billing_in_Key_Account_CP_kk;
}
public void setTotal_billing_in_Key_Account_CP_kk(String add) {
this.Total_billing_in_Key_Account_CP_kk=add;
}
public String getTotal_billing_in_Key_Account_CP_ps() {
return Total_billing_in_Key_Account_CP_ps;
}
public void setTotal_billing_in_Key_Account_CP_ps(String add) {
this.Total_billing_in_Key_Account_CP_ps=add;
}
public String getTotal_billing_in_Key_Account_CP_RP() {
return Total_billing_in_Key_Account_CP_RP;
}
public void setTotal_billing_in_Key_Account_CP_RP(String add) {
this.Total_billing_in_Key_Account_CP_RP=add;
}
public String getTotal_billing_in_SOPS() {
return Total_billing_in_SOPS;
}
public void setTotal_billing_in_SOPS(String add) {
this.Total_billing_in_SOPS=add;
}
public String getTotal_billinTotal_g_in_Capital_Markets() {
return Total_billinTotal_g_in_Capital_Markets;
}
public void setTotal_billinTotal_g_in_Capital_Markets(String add) {
this.Total_billinTotal_g_in_Capital_Markets=add;
}
public String getTotal_expenditures() {
return Total_expenditures;
}
public void setTotal_expenditures(String add) {
this.Total_expenditures=add;
}
public String getYear() {
return Year;
}
public void setYear(String add) {
this.Year=add;
}
public String getMonth() {
return Month;
}
public void setMonth(String add) {
this.Month=add;
}





public String getBookings_for_the_organization() {
return Bookings_for_the_organization;
}
public void setBookings_for_the_organization(String add) {
this.Bookings_for_the_organization=add;
}
public String getexisting_client_sales_billing_CM() {
return existing_client_sales_billing_CM;
}
public void setexisting_client_sales_billing_CM(String add) {
this.existing_client_sales_billing_CM=add;
}
public String getNew_sales_billings_CM() {
return New_sales_billings_CM;
}
public void setNew_sales_billings_CM(String add) {
this.New_sales_billings_CM=add;
}
public String getTotal_bookings_CM() {
return Total_bookings_CM;
}
public void setTotal_bookings_CM(String add) {
this.Total_bookings_CM=add;
}
public String getexisting_client_sales_billing_CL() {
return existing_client_sales_billing_CL;
}
public void setexisting_client_sales_billing_CL(String add) {
this.existing_client_sales_billing_CL=add;
}
public String getNew_sales_billings_CL() {
return New_sales_billings_CL;
}
public void setNew_sales_billings_CL(String add) {
this.New_sales_billings_CL=add;
}
public String getTotal_bookings_CL() {
return Total_bookings_CL;
}
public void setTotal_bookings_CL(String add) {
this.Total_bookings_CL=add;
}
public String getexisting_client_sales_billing_E_biz() {
return existing_client_sales_billing_E_biz;
}
public void setexisting_client_sales_billing_E_biz(String add) {
this.existing_client_sales_billing_E_biz=add;
}
public String getNew_sales_billings_E_biz() {
return New_sales_billings_E_biz;
}
public void setNew_sales_billings_E_biz(String add) {
this.New_sales_billings_E_biz=add;
}








public String getTotal_bookings_E_biz() {
return Total_bookings_E_biz;
}
public void setTotal_bookings_E_biz(String add) {
this.Total_bookings_E_biz=add;
}
public String getexisting_client_sales_billing_emedia() {
return existing_client_sales_billing_emedia;
}
public void setexisting_client_sales_billing_emedia(String add) {
this.existing_client_sales_billing_emedia=add;
}
public String getNew_sales_billings_E_Media() {
return New_sales_billings_E_Media;

}
public void setNew_sales_billings_E_Media(String add) {
this.New_sales_billings_E_Media=add;
}
public void setTotal_bookings_E_Media(String add) {
this.Total_bookings_E_Media=add;
}
public String getTotal_bookings_E_Media() {
return Total_bookings_E_Media;
}
public void setInside_Sales_cpns(String add) {
this.Inside_Sales_cpns=add;
}
public String getInside_Sales_cpns() {
return Inside_Sales_cpns;
}
public void setInside_Sales_customer(String add) {
this.Inside_Sales_customer=add;
}
public String getInside_Sales_customer() {
return Inside_Sales_customer;
}
public void setKey_Account_CP_AD_existing_c_billing(String add) {
this.Key_Account_CP_AD_existing_c_billing=add;
}
public String getKey_Account_CP_AD_existing_c_billing() {
return Key_Account_CP_AD_existing_c_billing;
}
public String getKey_Account_CP_KK_existing_c_billing() {
return Key_Account_CP_KK_existing_c_billing;
}
public void setKey_Account_CP_KK_existing_c_billing(String add) {
this.Key_Account_CP_KK_existing_c_billing=add;
}
public String getKey_Account_CP_PS_existing_c_billing() {
return Key_Account_CP_PS_existing_c_billing;}
public void setKey_Account_CP_PS_existing_c_billing(String add) {
this.Key_Account_CP_PS_existing_c_billing=add;
}

public String getKey_Account_CP_RP_existing_c_billing() {
return Key_Account_CP_RP_existing_c_billing;}
public void setKey_Account_CP_RP_existing_c_billing(String add) {
this.Key_Account_CP_RP_existing_c_billing=add;
}
public String getKey_Account_CP_AD_booking() {
return Key_Account_CP_AD_booking;}
public void setKey_Account_CP_AD_booking(String add) {
this.Key_Account_CP_AD_booking=add;
}
public String getKey_Account_CP_AD_existing_client() {
return Key_Account_CP_AD_existing_client;}
public void setKey_Account_CP_AD_existing_client(String add) {
this.Key_Account_CP_AD_existing_client=add;
}
public String getKey_Account_CP_KK_bookings() {
return Key_Account_CP_KK_bookings;}
public void setKey_Account_CP_KK_bookings(String add) {
this.Key_Account_CP_KK_bookings=add;
}
public String getKey_Account_CP_KK_existing_client() {
return Key_Account_CP_KK_existing_client;}
public void setKey_Account_CP_KK_existing_client(String add) {
this.Key_Account_CP_KK_existing_client=add;
}
public String getKey_Account_CP_PS_bookings() {
return Key_Account_CP_PS_bookings;}
public void setKey_Account_CP_PS_bookings(String add) {
this.Key_Account_CP_PS_bookings=add;
}





public String getKey_Account_CP_PS_existing_client() {
return Key_Account_CP_PS_existing_client;}
public void setKey_Account_CP_PS_existing_client(String add) {
this.Key_Account_CP_PS_existing_client=add;
}
public String getKey_Account_CP_RP_bookings() {
return Key_Account_CP_RP_bookings;}
public void setKey_Account_CP_RP_bookings(String add) {
this.Key_Account_CP_RP_bookings=add;
}
public String getKey_Account_CP_RP_existing_client() {
return Key_Account_CP_RP_existing_client;}
public void setKey_Account_CP_RP_existing_client(String add) {
this.Key_Account_CP_RP_existing_client=add;
}
public String getMarketing_cost_per_client() {
return Marketing_cost_per_client;}
public void setMarketing_cost_per_client(String add) {
this.Marketing_cost_per_client=add;
}
public String getSales_DIT_cpns() {
return Sales_DIT_cpns;}
public void setSales_DIT_cpns(String add) {
this.Sales_DIT_cpns=add;
}
public String getSales_DIT_customer() {
return Sales_DIT_customer;}
public void setSales_DIT_customer(String add) {
this.Sales_DIT_customer=add;
}
public String getSales_DIT_new_sales_booking() {
return Sales_DIT_new_sales_booking;}
public void setSales_DIT_new_sales_booking(String add) {
this.Sales_DIT_new_sales_booking=add;
}
public String getSales_DIT_new_sales_billing() {
return Sales_DIT_new_sales_billing;}
public void setSales_DIT_new_sales_billing(String add) {
this.Sales_DIT_new_sales_billing=add;
}
public String getSales_Mani_cpns() {
return Sales_Mani_cpns;}
public void setSales_Mani_cpns(String add) {
this.Sales_Mani_cpns=add;
}
public String getSales_Mani_new_sales_booking() {
return Sales_Mani_new_sales_booking;}
public void setSales_Mani_new_sales_booking(String add) {
this.Sales_Mani_new_sales_booking=add;
}


public String getSales_Mani_new_sales_billing() {
return Sales_Mani_new_sales_billing;}
public void setSales_Mani_new_sales_billing(String add) {
this.Sales_Mani_new_sales_billing=add;
}
public String getSales_Mani_customer() {
return Sales_Mani_customer;}
public void setSales_Mani_customer(String add) {
this.Sales_Mani_customer=add;
}
public String getSales_Overall_customer() {
return Sales_Overall_customer;}
public void setSales_Overall_customer(String add) {
this.Sales_Overall_customer=add;
}
public String getSales_Overall_new_sales_booking() {
return Sales_Overall_new_sales_booking;}
public void setSales_Overall_new_sales_booking(String add) {
this.Sales_Overall_new_sales_booking=add;
}




public String getSales_Overall_new_sales_billing() {
return Sales_Overall_new_sales_billing;}
public void setSales_Overall_new_sales_billing(String add) {
this.Sales_Overall_new_sales_billing=add;
}
public String getSales_Overall_cpns() {
return Sales_Overall_cpns;}
public void setSales_Overall_cpns(String add) {
this.Sales_Overall_cpns=add;
}
public String getSales_Satya_customer() {
return Sales_Satya_customer;}
public void setSales_Satya_customer(String add) {
this.Sales_Satya_customer=add;
}
public String getSales_Satya_new_sales_booking() {
return Sales_Satya_new_sales_booking;}
public void setSales_Satya_new_sales_booking(String add) {
this.Sales_Satya_new_sales_booking=add;
}
public String getSales_Satya_cpns() {
return Sales_Satya_cpns;}
public void setSales_Satya_cpns(String add) {
this.Sales_Satya_cpns=add;
}



public String getSales_VK_cpns() {
return Sales_VK_cpns;}
public void setSales_VK_cpns(String add) {
this.Sales_VK_cpns=add;
}
public String getSales_VK_customer() {
return Sales_VK_customer;}
public void setSales_VK_customer(String add) {
this.Sales_VK_customer=add;
}
public String getSales_VK_new_sales_booking() {
return Sales_VK_new_sales_booking;}
public void setSales_VK_new_sales_booking(String add) {
this.Sales_VK_new_sales_booking=add;
}
public String getSales_VK_new_sales_billing() {
return Sales_VK_new_sales_billing;}
public void setSales_VK_new_sales_billing(String add) {
this.Sales_VK_new_sales_billing=add;
}
public String getexisting_client_sales_billing_SOps() {
return existing_client_sales_billing_SOps;}
public void setexisting_client_sales_billing_SOps(String add) {
this.existing_client_sales_billing_SOps=add;
}


public String getNew_sales_billings_SOps() {
return New_sales_billings_SOps;}
public void setNew_sales_billings_SOps(String add) {
this.New_sales_billings_SOps=add;
}
public String getTotal_bookings_SOps() {
return Total_bookings_SOps;}
public void setTotal_bookings_SOps(String add) {
this.Total_bookings_SOps=add;
}

public String getTotal_cost_of_marketing() {
return Total_cost_of_marketing;}
public void setTotal_cost_of_marketing(String add) {
this.Total_cost_of_marketing=add;
}
public String getTotal_new_sales() {
return Total_new_sales;}
public void setTotal_new_sales(String add) {
this.Total_new_sales=add;
}



static testMethod void myTest() {


FinanceDataController4 controller = new FinanceDataController4();
controller.getName();
controller.setName('abc');
controller.getGM_of_Hosting_Business();
controller.setGM_of_Hosting_Business('def');
controller.getAmount_of_Loss_due_to_compliance_issues();
controller.setAmount_of_Loss_due_to_compliance_issues('def');
controller.getNew_sales_billings_CM();
controller.setNew_sales_billings_CM('def');
controller.getDealsheet_GM_for_CL_projects();
controller.setDealsheet_GM_for_CL_projects('def');
controller.getDealsheet_GM_for_E_business_projects();
controller.setDealsheet_GM_for_E_business_projects('def');
controller.getDealsheet_GM_for_E_media_projects();
controller.setDealsheet_GM_for_E_media_projects('def');
controller.getExecution_GM_for_E_business_projects();
controller.setExecution_GM_for_E_business_projects('def');

controller.getDealsheet_GM_key_Accs_AD();
controller.setDealsheet_GM_key_Accs_AD('def');
controller.getTotal_biiling_in_Consumer_Lending();
controller.setTotal_biiling_in_Consumer_Lending('def');

controller.getTotal_billing_in_Capital_Markets();
controller.setTotal_billing_in_Capital_Markets('def');



controller.getDealsheet_GM_key_Accs_KK();
controller.setDealsheet_GM_key_Accs_KK('def');
controller.getDealsheet_GM_key_Accs_PS();
controller.setDealsheet_GM_key_Accs_PS('def');
controller.getDealsheet_GM_key_Accs_RP();
controller.setDealsheet_GM_key_Accs_RP('def');
controller.getExecution_GM_sales_DIT();
controller.setExecution_GM_sales_DIT('def');
controller.getExecution_GM_sales_Mani();
controller.setExecution_GM_sales_Mani('def');
controller.getDealsheet_GM_sales_Satya();
controller.setDealsheet_GM_sales_Satya('def');
controller.getExecution_GM_sales_VK();
controller.setExecution_GM_sales_VK('def');
controller.getDealsheet_GM_for_SOPS_projects();
controller.setDealsheet_GM_for_SOPS_projects('def');
controller.getOverall_deal_sheet_GM();
controller.setOverall_deal_sheet_GM('def');
controller.getOverall_execution_GM();
controller.setOverall_execution_GM('def');


controller.getOverall_Org_GM();
controller.setOverall_Org_GM('def');

controller.getTotal_biiling_in_Consumer_Lending();
controller.setTotal_biiling_in_Consumer_Lending('def');

controller.getTotal_Billing();
controller.setTotal_Billing('def');

controller.getTotal_billing_in_Capital_Markets();
controller.setTotal_billing_in_Capital_Markets('def');

controller.getTotal_billing_in_Capital_Markets();
controller.setTotal_billing_in_Capital_Markets('def');
controller.getTotal_billing_in_E_business();
controller.setTotal_billing_in_E_business('def');
controller.getTotal_billing_in_E_media();
controller.setTotal_billing_in_E_media('def');
controller.getTotal_billing_in_Key_Account_CP_AD();
controller.setTotal_billing_in_Key_Account_CP_AD('def');
controller.getTotal_billing_in_Key_Account_CP_kk();
controller.setTotal_billing_in_Key_Account_CP_kk('def');
controller.getTotal_billing_in_Key_Account_CP_ps();
controller.setTotal_billing_in_Key_Account_CP_ps('def');
controller.getTotal_billing_in_Key_Account_CP_RP();
controller.setTotal_billing_in_Key_Account_CP_RP('def');
controller.getTotal_billing_in_SOPS();
controller.setTotal_billing_in_SOPS('def');
controller.getTotal_billinTotal_g_in_Capital_Markets();
controller.setTotal_billinTotal_g_in_Capital_Markets('def');
controller.getTotal_expenditures();
controller.setTotal_expenditures('def');
controller.getYear();
controller.setYear('def');


controller.getBookings_for_the_organization();
controller.setBookings_for_the_organization('def');
controller.getexisting_client_sales_billing_CM();
controller.setexisting_client_sales_billing_CM('def');
controller.getNew_sales_billings_CM();
controller.setNew_sales_billings_CM('def');
controller.getTotal_bookings_CM();
controller.setTotal_bookings_CM('def');
controller.getTotal_bookings_CM();
controller.setTotal_bookings_CM('def');
controller.getexisting_client_sales_billing_CL();
controller.setexisting_client_sales_billing_CL('def');
controller.getNew_sales_billings_CL();
controller.setNew_sales_billings_CL('def');
controller.getTotal_bookings_CL();
controller.setTotal_bookings_CL('def');

controller.getexisting_client_sales_billing_E_biz();
controller.setexisting_client_sales_billing_E_biz('def');
controller.getNew_sales_billings_E_biz();
controller.setNew_sales_billings_E_biz('def');
controller.getexisting_client_sales_billing_emedia();
controller.setexisting_client_sales_billing_emedia('def');
controller.getNew_sales_billings_E_Media();
controller.setNew_sales_billings_E_Media('def');
controller.getTotal_bookings_E_Media();
controller.setTotal_bookings_E_Media('def');
controller.getInside_Sales_cpns();
controller.setInside_Sales_cpns('def');
controller.getInside_Sales_customer();
controller.setInside_Sales_customer('def');


controller.getKey_Account_CP_AD_existing_c_billing();
controller.setKey_Account_CP_AD_existing_c_billing('def');
controller.getKey_Account_CP_KK_existing_c_billing();
controller.setKey_Account_CP_KK_existing_c_billing('def');
controller.getKey_Account_CP_PS_existing_c_billing();
controller.setKey_Account_CP_PS_existing_c_billing('def');
controller.getKey_Account_CP_RP_existing_c_billing();
controller.setKey_Account_CP_RP_existing_c_billing('def');
controller.getKey_Account_CP_AD_booking();
controller.setKey_Account_CP_AD_booking('def');
controller.getKey_Account_CP_KK_bookings();
controller.setKey_Account_CP_KK_bookings('def');
controller.getKey_Account_CP_PS_bookings();
controller.setKey_Account_CP_PS_bookings('def');


controller.getKey_Account_CP_PS_existing_client();
controller.setKey_Account_CP_PS_existing_client('def');
controller.getKey_Account_CP_RP_bookings();
controller.setKey_Account_CP_RP_bookings('def');
controller.getKey_Account_CP_RP_existing_client();
controller.setKey_Account_CP_RP_existing_client('def');
controller.getMarketing_cost_per_client();
controller.setMarketing_cost_per_client('def');
controller.getSales_DIT_cpns();
controller.setSales_DIT_cpns('def');
controller.getSales_DIT_customer();
controller.setSales_DIT_customer('def');



controller.getSales_DIT_new_sales_booking();
controller.setSales_DIT_new_sales_booking('def');
controller.getSales_DIT_new_sales_billing();
controller.setSales_DIT_new_sales_billing('def');
controller.getSales_Mani_cpns();
controller.setSales_Mani_cpns('def');
controller.getSales_Mani_new_sales_booking();
controller.setSales_Mani_new_sales_booking('def');
controller.getSales_Mani_new_sales_billing();
controller.setSales_Mani_new_sales_billing('def');


controller.getSales_Mani_customer();
controller.setSales_Mani_customer('def');
controller.getSales_Overall_customer();
controller.setSales_Overall_customer('def');
controller.getSales_Overall_new_sales_booking();
controller.setSales_Overall_new_sales_booking('def');
controller.getSales_Overall_new_sales_billing();
controller.setSales_Overall_new_sales_billing('def');
controller.getSales_Overall_cpns();
controller.setSales_Overall_cpns('def');
controller.getSales_Satya_customer();
controller.setSales_Satya_customer('def');
controller.getSales_Satya_new_sales_booking();
controller.setSales_Satya_new_sales_booking('def');


controller.getSales_Satya_cpns();
controller.setSales_Satya_cpns('def');
controller.getSales_VK_cpns();
controller.setSales_VK_cpns('def');
controller.getSales_VK_customer();
controller.setSales_VK_customer('def');
controller.getSales_VK_new_sales_booking();
controller.setSales_VK_new_sales_booking('def');
controller.getSales_VK_new_sales_billing();
controller.setSales_VK_new_sales_billing('def');
controller.getexisting_client_sales_billing_SOps();
controller.setexisting_client_sales_billing_SOps('def');




controller.getNew_sales_billings_SOps();
controller.setNew_sales_billings_SOps('def');
controller.getTotal_bookings_SOps();
controller.setTotal_bookings_SOps('def');
controller.getTotal_bookings_SOps();
controller.setTotal_bookings_SOps('def');
controller.getTotal_biiling_in_Consumer_Lending();
controller.setTotal_biiling_in_Consumer_Lending('def');

controller.getTotal_cost_of_marketing();
controller.setTotal_cost_of_marketing('def');
controller.getTotal_new_sales();
controller.setTotal_new_sales('def');



}
}