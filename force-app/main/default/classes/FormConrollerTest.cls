public class FormConrollerTest{
private String Name;
private String Department;
private String category;
private String frequency;

public void setName(String Name) {
this.Name= Name;
}
public String getName() {
return Name;
}
public String getDepartment() {
return Department;
}
public void setDepartment(String Department) {
this.Department=Department;
}
public String getcategory() {
return category;
}
public void setcategory(String category) {
this.category=category;
}
public String getfrequency() {
return frequency;
}
public void setfrequency(String frequency) {
this.frequency=frequency;
}
public static testMethod void scoreform() {
FormConrollerTest controller = new FormConrollerTest();

controller.setName('abc');
controller.getName();

controller.getDepartment();
controller.setDepartment('def');

controller.getcategory();
controller.setcategory('def');

controller.getfrequency();
controller.setfrequency('def');

}
}