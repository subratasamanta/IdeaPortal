public class ScoreCardControllerTest{
private String Name;
private String Department;
private String SubDepartment;
private String User;
private String category;
private String frequency;

public void setName(String Name) {
this.Name= Name;
}
public String getName() {
return Name;
}
public void setDepartment(String Name) {
this.Department= Name;
}
public String getDepartment() {
return Department;
}
public void setUser(String Name) {
this.User= Name;
}
public String getSubDepartment() {
return SubDepartment;
}
public void setSubDepartment(String Name) {
this.SubDepartment= Name;
}
public String getUser() {
return User;
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

 @IsTest(SeeAllData=true) static void myTest() {
     
      
        ScoreCardControllerTest controller = new ScoreCardControllerTest();
        
        controller.setName('abc');
        controller.getName();
       
        
        controller.getcategory();
        controller.setcategory('def');
        controller.getDepartment();
        controller.setDepartment('def');
        controller.getSubDepartment();
        controller.setSubDepartment('def');
        controller.getUser();
        controller.setUser('def');
        
        controller.getfrequency();
        controller.setfrequency('def'); 
       
       
       
         
       
 
 }
 
 



}