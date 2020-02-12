public class HRDataController {
ApexPages.StandardController controller{get; set;}
private String Name;
private String attending_min_hrs_of_Overal;
private String attending_min_hrs_Capital_Markets;
private String attending_min_hrs_CL;
private String attending_min_hrs_E_business;
private String attending_min_hrs_E_media;
private String attending_min_hrs_Facilities;
private String attending_min_hrs_Finance;
private String attending_min_hrs_Inside_Sales;
private String attending_min_hrs_IS;
private String attending_min_hrs_Marketing;
private String attending_min_hrs_Operations;
private String attending_min_hrs_Sales_DIT;
private String attending_min_hrs_Sales_Mani;

private String attending_min_hrs_Sales_Overall;
private String attending_min_hrs_Sales_VK;
private String attending_min_hrs_SOPS;
private String attending_min_hrs_Sales_Satya;


private String Attrition_rate;
private String Attrition_rate_for_CP_Plan_2012_AD;
private String Attrition_rate_for_CP_Plan_2012_kk;
private String Attrition_rate_for_CP_Plan_2012_ps;

private String Attrition_rate_for_CP_Plan_2012_RP;
private String ESAT_score;
private String ESAT_score_for_Facilities_Deptt;
private String ESAT_score_for_Finance_Deptt;
private String ESAT_score_for_IS_Team;
private String Month;
private String Year;







public String getName() {
return Name;
}
public void setName(String firstName) {
this.Name= firstName;
}

public String getattending_min_hrs_of_Overal() {
return attending_min_hrs_of_Overal;
}
public void setattending_min_hrs_of_Overal(String add) {
this.attending_min_hrs_of_Overal=add;
}
public String getattending_min_hrs_Capital_Markets() {
return attending_min_hrs_Capital_Markets;
}
public void setattending_min_hrs_Capital_Markets(String email) {
this.attending_min_hrs_Capital_Markets= email;
}
public String getattending_min_hrs_CL() {
return attending_min_hrs_CL;
}
public void setattending_min_hrs_CL(String add) {
this.attending_min_hrs_CL=add;
}
public String getattending_min_hrs_E_business() {
return attending_min_hrs_E_business;
}
public void setattending_min_hrs_E_business(String add) {
this.attending_min_hrs_E_business=add;
}
public String getattending_min_hrs_E_media() {
return attending_min_hrs_E_media;
}
public void setattending_min_hrs_E_media(String add) {
this.attending_min_hrs_E_media=add;
}


public String getattending_min_hrs_Facilities() {
return attending_min_hrs_Facilities;
}
public void setattending_min_hrs_Facilities(String add) {
this.attending_min_hrs_Facilities=add;
}
public String getattending_min_hrs_Finance() {
return attending_min_hrs_Finance;
}
public void setattending_min_hrs_Finance(String add) {
this.attending_min_hrs_Finance=add;
}
public String getattending_min_hrs_Inside_Sales() {
return attending_min_hrs_Inside_Sales;
}
public void setattending_min_hrs_Inside_Sales(String add) {
this.attending_min_hrs_Inside_Sales=add;
}
public String getattending_min_hrs_IS() {
return attending_min_hrs_IS;
}
public void setattending_min_hrs_IS(String add) {
this.attending_min_hrs_IS=add;
}
public String getattending_min_hrs_Marketing() {
return attending_min_hrs_Marketing;
}
public void setattending_min_hrs_Marketing(String add) {
this.attending_min_hrs_Marketing=add;
}
public String getattending_min_hrs_Operations() {
return attending_min_hrs_Operations;
}
public void setattending_min_hrs_Operations(String add) {
this.attending_min_hrs_Operations=add;
}
public String getattending_min_hrs_Sales_DIT() {
return attending_min_hrs_Sales_DIT;
}
public void setattending_min_hrs_Sales_DIT(String add) {
this.attending_min_hrs_Sales_DIT=add;
}
public String getattending_min_hrs_Sales_Mani() {
return attending_min_hrs_Sales_Mani;
}
public void setattending_min_hrs_Sales_Mani(String add) {
this.attending_min_hrs_Sales_Mani=add;
}


public String getattending_min_hrs_Sales_Overall() {
return attending_min_hrs_Sales_Overall;
}
public void setattending_min_hrs_Sales_Overall(String add) {
this.attending_min_hrs_Sales_Overall=add;
}
public String getattending_min_hrs_Sales_VK() {
return attending_min_hrs_Sales_VK;
}
public void setattending_min_hrs_Sales_VK(String add) {
this.attending_min_hrs_Sales_VK=add;
}
public String getattending_min_hrs_SOPS() {
return attending_min_hrs_SOPS;
}
public void setattending_min_hrs_SOPS(String add) {
this.attending_min_hrs_SOPS=add;
}
public String getattending_min_hrs_Sales_Satya() {
return attending_min_hrs_Sales_Satya;
}
public void setattending_min_hrs_Sales_Satya(String add) {
this.attending_min_hrs_Sales_Satya=add;
}



public String getAttrition_rate() {
return Attrition_rate;
}
public void setAttrition_rate(String add) {
this.Attrition_rate=add;
}
public String getAttrition_rate_for_CP_Plan_2012_AD() {
return Attrition_rate_for_CP_Plan_2012_AD;
}
public void setAttrition_rate_for_CP_Plan_2012_AD(String add) {
this.Attrition_rate_for_CP_Plan_2012_AD=add;
}
public String getAttrition_rate_for_CP_Plan_2012_kk() {
return Attrition_rate_for_CP_Plan_2012_kk;
}
public void setAttrition_rate_for_CP_Plan_2012_kk(String add) {
this.Attrition_rate_for_CP_Plan_2012_kk=add;
}
public String getAttrition_rate_for_CP_Plan_2012_ps() {
return Attrition_rate_for_CP_Plan_2012_ps;
}
public void setAttrition_rate_for_CP_Plan_2012_ps(String add) {
this.Attrition_rate_for_CP_Plan_2012_ps=add;
}



public String getAttrition_rate_for_CP_Plan_2012_RP() {
return Attrition_rate_for_CP_Plan_2012_RP;
}
public void setAttrition_rate_for_CP_Plan_2012_RP(String add) {
this.Attrition_rate_for_CP_Plan_2012_RP=add;
}
public String getESAT_score() {
return ESAT_score;
}
public void setESAT_score(String add) {
this.ESAT_score=add;
}
public String getESAT_score_for_Facilities_Deptt() {
return ESAT_score_for_Facilities_Deptt;
}
public void setESAT_score_for_Facilities_Deptt(String add) {
this.ESAT_score_for_Facilities_Deptt=add;
}
public String getESAT_score_for_Finance_Deptt() {
return ESAT_score_for_Finance_Deptt;
}
public void setESAT_score_for_Finance_Deptt(String add) {
this.ESAT_score_for_Finance_Deptt=add;
}

public String getESAT_score_for_IS_Team() {
return ESAT_score_for_IS_Team;
}
public void setESAT_score_for_IS_Team(String add) {
this.ESAT_score_for_IS_Team=add;
}
public String getMonth() {
return Month;
}
public void setMonth(String add) {
this.Month=add;
}
public String getYear() {
return Year;
}
public void setYear(String add) {
this.Year=add;
}

static testMethod void myTest() {


HRDataController controller = new HRDataController();
controller.getName();
controller.setName('abc');
controller.getattending_min_hrs_of_Overal();
controller.setattending_min_hrs_of_Overal('def');
controller.getattending_min_hrs_Capital_Markets();
controller.setattending_min_hrs_Capital_Markets('def');
controller.getattending_min_hrs_CL();
controller.setattending_min_hrs_CL('def');
controller.getattending_min_hrs_E_business();
controller.setattending_min_hrs_E_business('def');
controller.getattending_min_hrs_E_media();
controller.setattending_min_hrs_E_media('def');

controller.getattending_min_hrs_Facilities();
controller.setattending_min_hrs_Facilities('def');


controller.getattending_min_hrs_Finance();
controller.setattending_min_hrs_Finance('def');

controller.getattending_min_hrs_Inside_Sales();
controller.setattending_min_hrs_Inside_Sales('def');
controller.getattending_min_hrs_IS();
controller.setattending_min_hrs_IS('def');
controller.getattending_min_hrs_Marketing();
controller.setattending_min_hrs_Marketing('def');
controller.getattending_min_hrs_Operations();
controller.setattending_min_hrs_Operations('def');


controller.getattending_min_hrs_Sales_DIT();
controller.setattending_min_hrs_Sales_DIT('def');
controller.getattending_min_hrs_Sales_Mani();
controller.setattending_min_hrs_Sales_Mani('def');
controller.getattending_min_hrs_Sales_Overall();
controller.setattending_min_hrs_Sales_Overall('def');
controller.getattending_min_hrs_Sales_VK();
controller.setattending_min_hrs_Sales_VK('def');


controller.getattending_min_hrs_SOPS();
controller.setattending_min_hrs_SOPS('def');
controller.getattending_min_hrs_Sales_Satya();
controller.setattending_min_hrs_Sales_Satya('def');
controller.getAttrition_rate();
controller.setAttrition_rate('def');

controller.getAttrition_rate_for_CP_Plan_2012_AD();
controller.setAttrition_rate_for_CP_Plan_2012_AD('def');
controller.getAttrition_rate_for_CP_Plan_2012_kk();
controller.setAttrition_rate_for_CP_Plan_2012_kk('def');
controller.getAttrition_rate_for_CP_Plan_2012_ps();
controller.setAttrition_rate_for_CP_Plan_2012_ps('def');
controller.getAttrition_rate_for_CP_Plan_2012_RP();
controller.setAttrition_rate_for_CP_Plan_2012_RP('def');
controller.getESAT_score();
controller.setESAT_score('def');
controller.getMonth();
controller.setMonth('def');
controller.getESAT_score_for_Facilities_Deptt();
controller.setESAT_score_for_Facilities_Deptt('def');
controller.getESAT_score_for_Finance_Deptt();
controller.setESAT_score_for_Finance_Deptt('def');

controller.getESAT_score_for_IS_Team();
controller.setESAT_score_for_IS_Team('def');
controller.getYear();
controller.setYear('def');


}
}