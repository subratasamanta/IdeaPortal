public class FacilitiesDataController {
private String Name;
private String Cost_of_Facilities;
private String Loss_due_to_compliance_issues;
private String Month;
private String Year;

public String getName() {
return Name;
}
public void setName(String firstName) {
this.Name= firstName;
}
public String getCost_of_Facilities() {
return Cost_of_Facilities;
}
public void setCost_of_Facilities(String firstName) {
this.Name= Cost_of_Facilities;
}
public String getLoss_due_to_compliance_issues() {
return Loss_due_to_compliance_issues;
}
public void setLoss_due_to_compliance_issues(String firstName) {
this.Loss_due_to_compliance_issues= firstName;
}

public String getMonth() {
return Month;
}
public void setMonth(String firstName) {
this.Month= firstName;
}
public String getYear() {
return Year;
}
public void setYear(String firstName) {
this.Year= firstName;
}

static testMethod void myTest() {


FacilitiesDataController controller = new FacilitiesDataController();
controller.getName();
controller.setName('abc');
controller.getCost_of_Facilities();
controller.setCost_of_Facilities('abc');
controller.getLoss_due_to_compliance_issues();
controller.setLoss_due_to_compliance_issues('abc');
controller.getMonth();
controller.setMonth('abc');
controller.getYear();
controller.setYear('abc');


}
}