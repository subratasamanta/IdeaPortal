public class FinancialController {
private String Name;
private String Current_value;
private String initiative;
private String Objectives;
private String previous_value;
private String Review_Comments;
private String Targets;




private String Current_Value_Grade;
private String Future_Initiatives;
private String Grade;
private String LinkID;
private String Metrics;
private String Score;
private String Target_Grade_Value;
private String Weighted_1;
private String Weighted_2;

/* public String getFirstName() {
return this.firstName;
}*/

public void setName(String Name) {
this.Name= Name;
}
public String getName() {
return Name;
}
public String getCurrent_value() {
return Current_value;
}
public void setCurrent_value(String CV) {
this.Current_value=CV;
}
public String getObjective() {
return Objectives;
}
public void setObjective(String objective) {
this.Objectives=objective;
}
public String getinitiative() {
return initiative;
}
public void setinitiative(String initiative) {
this.initiative=initiative;
}

public String getprevious_value() {
return previous_value;
}
public Void setprevious_value(String previous_value) {
this.previous_value= previous_value;
}
public String getReview_Comments() {
return Review_Comments;
}
public void setReview_Comments(String add) {
this.Review_Comments=add;
}
public String getTargets() {
return Targets;
}
public void setTargets(String add) {
this.Targets=add;
}


public String getCurrent_Value_Grade() {
return Current_Value_Grade;
}
public void setCurrent_Value_Grade(String add) {
this.Current_Value_Grade=add;
}
public String getFuture_Initiatives() {
return Future_Initiatives;
}
public void setFuture_Initiatives(String add) {
this.Future_Initiatives=add;
}
public String getGrade() {
return Grade;
}
public void setGrade(String add) {
this.Grade=add;
}
public String getLinkID() {
return LinkID;
}
public void setLinkID(String add) {
this.LinkID=add;
}

public String getMetrics() {
return Metrics;
}
public void setMetrics(String add) {
this.Metrics=add;
}
public String getScore() {
return Score;
}
public void setScore(String add) {
this.Score=add;
}
public String getTarget_Grade_Value() {
return Target_Grade_Value;
}
public void setTarget_Grade_Value(String add) {
this.Target_Grade_Value=add;
}
public String getWeighted_1() {
return Weighted_1;
}
public void setWeighted_1(String add) {
this.Weighted_1=add;
}
public String getWeighted_2() {
return Weighted_2;
}
public void setWeighted_2(String add) {
this.Weighted_2=add;
}

static testMethod void myTest() {
FinancialController controller = new FinancialController();

controller.setName('abc');
controller.getName();

controller.getObjective();
controller.setObjective('def');

controller.getinitiative();
controller.setinitiative('def');

controller.getprevious_value();
controller.setprevious_value('def');

controller.getCurrent_value();
controller.setCurrent_value('def');

controller.getReview_Comments();
controller.setReview_Comments('def');

controller.getCurrent_Value_Grade();
controller.setCurrent_Value_Grade('def');
controller.getFuture_Initiatives();
controller.setFuture_Initiatives('def');
controller.getGrade();
controller.setGrade('def');
controller.getLinkID();
controller.setLinkID('def');
controller.getMetrics();
controller.setMetrics('def');
controller.getScore();
controller.setScore('def');
controller.getTarget_Grade_Value();
controller.setTarget_Grade_Value('def');
controller.getWeighted_1();
controller.setWeighted_1('def');
controller.getWeighted_2();
controller.setWeighted_2('def');



}
}