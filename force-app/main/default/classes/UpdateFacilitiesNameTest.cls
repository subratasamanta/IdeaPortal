public class UpdateFacilitiesNameTest{
private String Name;
private String Cost_of_Facilities;
private String Loss_due_to_compliance_issues;
private String Month;
private String Year;

static TestMethod void Test0_TestInsertWithValue()
{
string testValue = 'Fac_Oct';
 double value2=10;
insertTestObjectWithField2Value(testValue,value2);
try{
List<Facilities_Data_Form__c> testObj = [Select Name, Cost_of_Facilities__c from Facilities_Data_Form__c where Name= :testValue];
if(testObj.size() > 0){
System.assertNotEquals(testObj[0], null, 'Test 0 object was null and not inserted correctly');

System.assertEquals(testObj[0].Loss_due_to_compliance_issues__c , testObj[0].Cost_of_Facilities__c, 'Field1 and Field2 not equals in test 0');
}
}
catch (System.QueryException e) {
  System.debug('caught ya!');
}
}


private static void insertTestObjectWithField2Value(String testValue,double value2)
{
Facilities_Data_Form__c obj = new Facilities_Data_Form__c();
obj.Name = testValue;
obj.Cost_of_Facilities__c= value2;
insert obj;
}





}