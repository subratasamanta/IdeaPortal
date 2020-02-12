public class PMODataController {
private String Name;
private String reuse_for_Capital_Markets_Practice;
private String reuse_for_Consumer_Lending_Practice;
private String reuse_for_Ebusiness_practice;
private String reuse_for_Emedia_Practice;
private String reuse_for_SOPS_Practice;
private String Degree_of_reusability_for_the_Org;
private String Month;
private String Year;

public String getName() {
return Name;
}
public void setName(String firstName) {
this.Name= firstName;
}
public String getreuse_for_Capital_Markets_Practice() {
return reuse_for_Capital_Markets_Practice;
}
public void setreuse_for_Capital_Markets_Practice(String firstName) {
this.Name= reuse_for_Capital_Markets_Practice;
}
public String getreuse_for_Consumer_Lending_Practice() {
return reuse_for_Consumer_Lending_Practice;
}
public void setreuse_for_Consumer_Lending_Practice(String firstName) {
this.reuse_for_Consumer_Lending_Practice= firstName;
}
public String getreuse_for_Ebusiness_practice() {
return reuse_for_Ebusiness_practice;
}
public void setreuse_for_Ebusiness_practice(String firstName) {
this.reuse_for_Ebusiness_practice= firstName;
}
public String getreuse_for_Emedia_Practice() {
return reuse_for_Emedia_Practice;
}
public void setreuse_for_Emedia_Practice(String firstName) {
this.reuse_for_Emedia_Practice= firstName;
}
public String getreuse_for_SOPS_Practice() {
return reuse_for_SOPS_Practice;
}
public void setreuse_for_SOPS_Practice(String firstName) {
this.reuse_for_SOPS_Practice= firstName;
}
public String getDegree_of_reusability_for_the_Org() {
return Degree_of_reusability_for_the_Org;
}
public void setDegree_of_reusability_for_the_Org(String firstName) {
this.Degree_of_reusability_for_the_Org= firstName;
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


PMODataController controller = new PMODataController();
controller.getName();
controller.setName('abc');
controller.getreuse_for_Capital_Markets_Practice();
controller.setreuse_for_Capital_Markets_Practice('abc');
controller.getreuse_for_Consumer_Lending_Practice();
controller.setreuse_for_Consumer_Lending_Practice('abc');
controller.getreuse_for_Ebusiness_practice();
controller.setreuse_for_Ebusiness_practice('abc');
controller.getreuse_for_Emedia_Practice();
controller.setreuse_for_Emedia_Practice('abc');
controller.getreuse_for_SOPS_Practice();
controller.setreuse_for_SOPS_Practice('abc');
controller.getDegree_of_reusability_for_the_Org();
controller.setDegree_of_reusability_for_the_Org('abc');
controller.getMonth();
controller.setMonth('abc');
controller.getYear();
controller.setYear('abc');


}
}