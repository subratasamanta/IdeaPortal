public class SEPGDataController {
private String Name;
private String Significant_audit_findings_for_Ops_Team;
private String Projects_at_or_above_CMMi_level;
private String Timeliness_in_projects_delivery;
private String Month;
private String Year;

public String getName() {
return Name;
}
public void setName(String firstName) {
this.Name= firstName;
}
public String getSignificant_audit_findings_for_Ops_Team() {
return Significant_audit_findings_for_Ops_Team;
}
public void setSignificant_audit_findings_for_Ops_Team(String firstName) {
this.Name= Significant_audit_findings_for_Ops_Team;
}
public String getProjects_at_or_above_CMMi_level() {
return Projects_at_or_above_CMMi_level;
}
public void setProjects_at_or_above_CMMi_level(String firstName) {
this.Projects_at_or_above_CMMi_level= firstName;
}
public String getTimeliness_in_projects_delivery() {
return Timeliness_in_projects_delivery;
}
public void setTimeliness_in_projects_delivery(String firstName) {
this.Timeliness_in_projects_delivery= firstName;
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


SEPGDataController controller = new SEPGDataController();
controller.getName();
controller.setName('abc');
controller.getSignificant_audit_findings_for_Ops_Team();
controller.setSignificant_audit_findings_for_Ops_Team('abc');
controller.getProjects_at_or_above_CMMi_level();
controller.setProjects_at_or_above_CMMi_level('abc');
controller.getTimeliness_in_projects_delivery();
controller.setTimeliness_in_projects_delivery('abc');
controller.getMonth();
controller.setMonth('abc');
controller.getYear();
controller.setYear('abc');


}
}