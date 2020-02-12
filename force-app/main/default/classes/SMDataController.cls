public class SMDataController {
ApexPages.StandardController controller{get; set;}
private String Name;
private String of_artifacts_published;
private String of_client_visits_by_GDMs_SPMs;
private String Achieve_intended_positioning_CL;
private String Achieve_intended_positioning_CM;
private String Achieve_intended_positioning_E_biz;
private String Achieve_intended_positioning_E_Media;
private String Achieve_intended_positioning_SOps;
private String Achieve_sales_process_compliance_CL;
private String Achieve_sales_process_compliance_E_biz;
private String Achieve_sales_process_compliance_E_Medi;
private String Achieve_sales_process_compliance_SOps;
private String Bookings_for_the_organization;



private String CSAT_score;
private String CSAT_score_for_Operations;
private String Customer_perception_of_Tavant;
private String Existing_client_sales_billings_CL;
private String Existing_client_sales_billings_CM;
private String Existing_client_sales_billings_E_biz;
private String Existing_client_sales_billings_E_Media;
private String Existing_client_sales_billings_SOps;
private String New_sales_billings_CL;
private String New_sales_billings_CM;
private String New_sales_billings_E_biz;
private String New_sales_billings_E_Media;
private String New_sales_billings_SOps;


private String Number_of_new_clients_CL;
private String Number_of_new_clients_CM;
private String Number_of_new_clients_E_biz;
private String Number_of_new_clients_E_Media;

private String Number_of_new_clients_SOps;
private String Number_of_new_customers_CL;
private String Number_of_new_customers_CM;
private String Number_of_new_customers_E_biz;

private String Number_of_new_customers_E_Media;
private String Number_of_new_customers_SOps;
private String Number_of_qualified_leads_CL;
private String Number_of_qualified_leads_CM;

private String Number_of_qualified_leads_E_biz;
private String Number_of_qualified_leads_E_Media;
private String Number_of_qualified_leads_SOps;
private String Revenue_from_Billings_for_the_organizati;

private String Sales_effectiveness_for_the_Org;
private String Sales_process_compliance_CM;
private String Total_bookings_CL;

private String Total_bookings_CM;
private String Total_bookings_E_biz;
private String Total_bookings_E_Media;
private String Total_bookings_SOps;
private String Total_IT_budget_of_all_clients_CL;
private String Total_IT_budget_of_all_clients_CM;
private String Total_IT_budget_of_all_clients_E_biz;
private String Total_IT_budget_of_all_clients_SOps;
private String Total_IT_budget_of_clients_in_E_media;

private String Year;
private String Month;
/* public String getFirstName() {
return this.firstName;
}*/





public String getName() {
return Name;
}
public void setName(String firstName) {
this.Name= firstName;
}

public String getof_artifacts_published() {
return of_artifacts_published;
}
public void setof_artifacts_published(String add) {
this.of_artifacts_published=add;
}
public String getof_client_visits_by_GDMs_SPMs() {
return of_client_visits_by_GDMs_SPMs;
}
public void setof_client_visits_by_GDMs_SPMs(String email) {
this.of_client_visits_by_GDMs_SPMs= email;
}
public String getAchieve_intended_positioning_CL() {
return Achieve_intended_positioning_CL;
}
public void setAchieve_intended_positioning_CL(String add) {
this.Achieve_intended_positioning_CL=add;
}

public String getAchieve_intended_positioning_CM() {
return Achieve_intended_positioning_CM;
}
public void setAchieve_intended_positioning_CM(String add) {
this.Achieve_intended_positioning_CM=add;
}
public String getAchieve_intended_positioning_E_biz() {
return Achieve_intended_positioning_E_biz;
}
public void setAchieve_intended_positioning_E_biz(String add) {
this.Achieve_intended_positioning_E_biz=add;
}
public String getAchieve_intended_positioning_E_Media() {
return Achieve_intended_positioning_E_Media;
}
public void setAchieve_intended_positioning_E_Media(String add) {
this.Achieve_intended_positioning_E_Media=add;
}
public String getAchieve_intended_positioning_SOps() {
return Achieve_intended_positioning_SOps;
}
public void setAchieve_intended_positioning_SOps(String add) {
this.Achieve_intended_positioning_SOps=add;
}

public String getAchieve_sales_process_compliance_CL() {
return Achieve_sales_process_compliance_CL;
}
public void setAchieve_sales_process_compliance_CL(String add) {
this.Achieve_sales_process_compliance_CL=add;
}
public String getAchieve_sales_process_compliance_E_biz() {
return Achieve_sales_process_compliance_E_biz;
}
public void setAchieve_sales_process_compliance_E_biz(String add) {
this.Achieve_sales_process_compliance_E_biz=add;
}
public String getAchieve_sales_process_compliance_E_Medi() {
return Achieve_sales_process_compliance_E_Medi;
}
public void setAchieve_sales_process_compliance_E_Medi(String add) {
this.Achieve_sales_process_compliance_E_Medi=add;
}
public String getAchieve_sales_process_compliance_SOps() {
return Achieve_sales_process_compliance_SOps;
}
public void setAchieve_sales_process_compliance_SOps(String add) {
this.Achieve_sales_process_compliance_SOps=add;
}
public String getBookings_for_the_organization() {
return Bookings_for_the_organization;
}
public void setBookings_for_the_organization(String add) {
this.Bookings_for_the_organization=add;
}
public String getCSAT_score() {
return CSAT_score;
}
public void setCSAT_score(String add) {
this.CSAT_score=add;
}





public String getCSAT_score_for_Operations() {
return CSAT_score_for_Operations;
}
public void setCSAT_score_for_Operations(String add) {
this.CSAT_score_for_Operations=add;
}
public String getCustomer_perception_of_Tavant() {
return Customer_perception_of_Tavant;
}
public void setCustomer_perception_of_Tavant(String add) {
this.Customer_perception_of_Tavant=add;
}
public String getExisting_client_sales_billings_CL() {
return Existing_client_sales_billings_CL;
}
public void setExisting_client_sales_billings_CL(String add) {
this.Existing_client_sales_billings_CL=add;
}
public String getExisting_client_sales_billings_CM() {
return Existing_client_sales_billings_CM;
}
public void setExisting_client_sales_billings_CM(String add) {
this.Existing_client_sales_billings_CM=add;
}
public String getExisting_client_sales_billings_E_biz() {
return Existing_client_sales_billings_E_biz;
}
public void setExisting_client_sales_billings_E_biz(String add) {
this.Existing_client_sales_billings_E_biz=add;
}
public String getExisting_client_sales_billings_E_Media() {
return Existing_client_sales_billings_E_Media;
}
public void setExisting_client_sales_billings_E_Media(String add) {
this.Existing_client_sales_billings_E_Media=add;
}
public String getExisting_client_sales_billings_SOps() {
return Existing_client_sales_billings_SOps;
}
public void setExisting_client_sales_billings_SOps(String add) {
this.Existing_client_sales_billings_SOps=add;
}
public String getNew_sales_billings_CL() {
return New_sales_billings_CL;
}
public void setNew_sales_billings_CL(String add) {
this.New_sales_billings_CL=add;
}
public String getNew_sales_billings_CM() {
return New_sales_billings_CM;
}
public void setNew_sales_billings_CM(String add) {
this.New_sales_billings_CM=add;
}
public String getNew_sales_billings_E_biz() {
return New_sales_billings_E_biz;
}
public void setNew_sales_billings_E_biz(String add) {
this.New_sales_billings_E_biz=add;
}
public String getNew_sales_billings_E_Media() {
return New_sales_billings_E_Media;
}
public void setNew_sales_billings_E_Media(String add) {
this.New_sales_billings_E_Media=add;
}
public String getNew_sales_billings_SOps() {
return New_sales_billings_SOps;
}
public void setNew_sales_billings_SOps(String add) {
this.New_sales_billings_SOps=add;
}





public String getNumber_of_qualified_leads_CL() {
return Number_of_qualified_leads_CL;
}
public void setNumber_of_qualified_leads_CL(String add) {
this.Number_of_qualified_leads_CL=add;
}
public String getNumber_of_qualified_leads_CM() {
return Number_of_qualified_leads_CM;
}
public void setNumber_of_qualified_leads_CM(String add) {
this.Number_of_qualified_leads_CM=add;
}
public String getNumber_of_qualified_leads_E_biz() {
return Number_of_qualified_leads_E_biz;
}
public void setNumber_of_qualified_leads_E_biz(String add) {
this.Number_of_qualified_leads_E_biz=add;
}
public String getNumber_of_qualified_leads_E_Media() {
return Number_of_qualified_leads_E_Media;
}
public void setNumber_of_qualified_leads_E_Media(String add) {
this.Number_of_qualified_leads_E_Media=add;
}
public String getNumber_of_qualified_leads_SOps() {
return Number_of_qualified_leads_SOps;
}
public void setNumber_of_qualified_leads_SOps(String add) {
this.Number_of_qualified_leads_SOps=add;
}
public String getRevenue_from_Billings_for_the_organizati() {
return Revenue_from_Billings_for_the_organizati;
}
public void setRevenue_from_Billings_for_the_organizati(String add) {
this.Revenue_from_Billings_for_the_organizati=add;
}

public String getSales_effectiveness_for_the_Org() {
return Sales_effectiveness_for_the_Org;
}
public void setSales_effectiveness_for_the_Org(String add) {
this.Sales_effectiveness_for_the_Org=add;
}
public String getSales_process_compliance_CM() {
return Sales_process_compliance_CM;
}
public void setSales_process_compliance_CM(String add) {
this.Sales_process_compliance_CM=add;
}
public String getTotal_bookings_CL() {
return Total_bookings_CL;
}
public void setTotal_bookings_CL(String add) {
this.Total_bookings_CL=add;
}
public String getTotal_bookings_CM() {
return Total_bookings_CM;
}
public void setTotal_bookings_CM(String add) {
this.Total_bookings_CM=add;
}
public String getTotal_bookings_E_biz() {
return Total_bookings_E_biz;
}
public void setTotal_bookings_E_biz(String add) {
this.Total_bookings_E_biz=add;
}
public String getTotal_bookings_E_Media() {
return Total_bookings_E_Media;
}
public void setTotal_bookings_E_Media(String add) {
this.Total_bookings_E_Media=add;
}
public String getTotal_bookings_SOps() {
return Total_bookings_SOps;
}
public void setTotal_bookings_SOps(String add) {
this.Total_bookings_SOps=add;
}
public String getTotal_IT_budget_of_all_clients_CL() {
return Total_IT_budget_of_all_clients_CL;
}
public void setTotal_IT_budget_of_all_clients_CL(String add) {
this.Total_IT_budget_of_all_clients_CL=add;
}
public String getTotal_IT_budget_of_all_clients_CM() {
return Total_IT_budget_of_all_clients_CM;
}
public void setTotal_IT_budget_of_all_clients_CM(String add) {
this.Total_IT_budget_of_all_clients_CM=add;
}
public String getTotal_IT_budget_of_all_clients_E_biz() {
return Total_IT_budget_of_all_clients_E_biz;
}
public void setTotal_IT_budget_of_all_clients_E_biz(String add) {
this.Total_IT_budget_of_all_clients_E_biz=add;
}
public String getTotal_IT_budget_of_all_clients_SOps() {
return Total_IT_budget_of_all_clients_SOps;
}
public void setTotal_IT_budget_of_all_clients_SOps(String add) {
this.Total_IT_budget_of_all_clients_SOps=add;
}
public String getTotal_IT_budget_of_clients_in_E_media() {
return Total_IT_budget_of_clients_in_E_media;
}
public void setTotal_IT_budget_of_clients_in_E_media(String add) {
this.Total_IT_budget_of_clients_in_E_media=add;
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


static testMethod void myTest() {


SMDataController controller = new SMDataController();
controller.getName();
controller.setName('abc');
controller.getof_artifacts_published();
controller.setof_artifacts_published('def');
controller.getof_client_visits_by_GDMs_SPMs();
controller.setof_client_visits_by_GDMs_SPMs('def');
controller.getAchieve_intended_positioning_CL();
controller.setAchieve_intended_positioning_CL('def');
controller.getAchieve_intended_positioning_CM();
controller.setAchieve_intended_positioning_CM('def');
controller.getAchieve_intended_positioning_E_biz();
controller.setAchieve_intended_positioning_E_biz('def');
controller.getAchieve_sales_process_compliance_E_Medi();
controller.setAchieve_sales_process_compliance_E_Medi('def');
controller.getAchieve_intended_positioning_SOps();
controller.setAchieve_intended_positioning_SOps('def');

controller.getBookings_for_the_organization();
controller.setBookings_for_the_organization('def');
controller.getCSAT_score();
controller.setCSAT_score('def');

controller.getCSAT_score_for_Operations();
controller.setCSAT_score_for_Operations('def');



controller.getCustomer_perception_of_Tavant();
controller.setCustomer_perception_of_Tavant('def');
controller.getExisting_client_sales_billings_CL();
controller.setExisting_client_sales_billings_CL('def');
controller.getExisting_client_sales_billings_CM();
controller.setExisting_client_sales_billings_CM('def');
controller.getExisting_client_sales_billings_E_biz();
controller.setExisting_client_sales_billings_E_biz('def');
controller.getExisting_client_sales_billings_E_Media();
controller.setExisting_client_sales_billings_E_Media('def');
controller.getExisting_client_sales_billings_SOps();
controller.setExisting_client_sales_billings_SOps('def');
controller.getNew_sales_billings_CL();
controller.setNew_sales_billings_CL('def');
controller.getNew_sales_billings_CM();
controller.setNew_sales_billings_CM('def');
controller.getNew_sales_billings_E_biz();
controller.setNew_sales_billings_E_biz('def');
controller.getNew_sales_billings_E_Media();
controller.setNew_sales_billings_E_Media('def');


controller.getNew_sales_billings_SOps();
controller.setNew_sales_billings_SOps('def');

controller.getNumber_of_qualified_leads_CL();
controller.setNumber_of_qualified_leads_CL('def');

controller.getNumber_of_qualified_leads_CM();
controller.setNumber_of_qualified_leads_CM('def');

controller.getNumber_of_qualified_leads_E_biz();
controller.setNumber_of_qualified_leads_E_biz('def');

controller.getNumber_of_qualified_leads_E_Media();
controller.setNumber_of_qualified_leads_E_Media('def');
controller.getNumber_of_qualified_leads_SOps();
controller.setNumber_of_qualified_leads_SOps('def');
controller.getRevenue_from_Billings_for_the_organizati();
controller.setRevenue_from_Billings_for_the_organizati('def');
controller.getSales_effectiveness_for_the_Org();
controller.setSales_effectiveness_for_the_Org('def');
controller.getSales_process_compliance_CM();
controller.setSales_process_compliance_CM('def');
controller.getTotal_bookings_CL();
controller.setTotal_bookings_CL('def');
controller.getTotal_bookings_CM();
controller.setTotal_bookings_CM('def');
controller.getTotal_bookings_E_biz();
controller.setTotal_bookings_E_biz('def');
controller.getTotal_bookings_E_Media();
controller.setTotal_bookings_E_Media('def');
controller.getTotal_bookings_SOps();
controller.setTotal_bookings_SOps('def');
controller.getTotal_IT_budget_of_all_clients_CL();
controller.setTotal_IT_budget_of_all_clients_CL('def');
controller.getTotal_IT_budget_of_all_clients_CM();
controller.setTotal_IT_budget_of_all_clients_CM('def');
controller.getTotal_IT_budget_of_all_clients_E_biz();
controller.setTotal_IT_budget_of_all_clients_E_biz('def');
controller.getTotal_IT_budget_of_all_clients_SOps();
controller.setTotal_IT_budget_of_all_clients_SOps('def');
controller.getTotal_IT_budget_of_clients_in_E_media();
controller.setTotal_IT_budget_of_clients_in_E_media('def');
controller.getYear();
controller.setYear('def');
}
}