public class MetricsController {
ApexPages.StandardController controller{get; set;}
private String Name;
private String Objective;
private String Department;
private String Sub_Department;
private String Category;
private String Scorecard;


private String Grade;
private String Metric_Type;
private String Score_formula;
private String Type;
private String Weightage_1;
private String Weightage_2;
private String Yearly_Target;
private String Yearly_Target2;
/* public String getFirstName() {
return this.firstName;
}*/

public void setName(String firstName) {
this.Name= firstName;
}
public String getObjective() {
return Objective;
}
public String getName() {
return Name;
}
public void setObjective(String add) {
this.Objective=add;
}
public void setDepartment(String email) {
this.Department= email;
}
public void setSub_Department(String num) {
this.Sub_Department= num;
}
public void setCategory(String lName) {
this.Category= lName;
}

/* public String getLastName() {
return this.lastName;
}*/

public void setGrade(String Name) {
this.Grade= Name;
}
public String getGrade() {
return Grade;
}
public void setMetric_Type(String firstName) {
this.Metric_Type= firstName;
}

public String getMetric_Type() {
return Metric_Type;
}
public void setType(String firstName) {
this.Type= firstName;
}
public String getType() {
return Type;
}
public void setWeightage_1(String firstName) {
this.Weightage_1= firstName;
}
public String getWeightage_1() {
return Weightage_1;
}
public void setWeightage_2(String firstName) {
this.Weightage_2= firstName;
}
public String getWeightage_2() {
return Weightage_2;
}
public void setYearly_Target(String firstName) {
this.Yearly_Target= firstName;
}
public String getYearly_Target() {
return Yearly_Target;
}
public void setYearly_Target2(String firstName) {
this.Yearly_Target2= firstName;
}
public String getYearly_Target2() {
return Yearly_Target2;
}

 static testMethod void myTest() {


MetricsController controller = new MetricsController();

controller.setName('abc');
controller.getObjective();
controller.getName();
controller.setObjective('def');
controller.setDepartment('def');
controller.setSub_Department('def');
controller.setCategory('def');
controller.getGrade();
controller.setGrade('abc');
controller.getMetric_Type();
controller.setMetric_Type('abc');
controller.getType();
controller.setType('abc');
controller.getWeightage_1();
controller.setWeightage_1('abc');
controller.getWeightage_2();
controller.setWeightage_2('abc');
controller.getYearly_Target();
controller.setYearly_Target('abc');
controller.getYearly_Target2();
controller.setYearly_Target2('abc');
}



}