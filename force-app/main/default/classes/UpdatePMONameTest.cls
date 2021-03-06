public class UpdatePMONameTest{
private String Name;
private String reuse_for_Capital_Markets_Practice;
private String reuse_for_Consumer_Lending_Practice;
private String reuse_for_Ebusiness_practice;
private String reuse_for_Emedia_Practice;
private String reuse_for_SOPS_Practice;
private String Degree_of_reusability_for_the_Org;
private String Month;
private String Year;

static TestMethod void Test0_TestInsertWithValue()
{
string testValue = 'Fac_Oct';
 String value2='January';
insertTestObjectWithField2Value(testValue,value2);
try{
List<PMO_Data_Form__c> testObj = [Select Name, Month__c, Year__c from PMO_Data_Form__c where Name= :testValue];
if(testObj.size() > 0){
System.assertNotEquals(testObj[0], null, 'Test 0 object was null and not inserted correctly');

System.assertEquals(testObj[0].Month__c , testObj[0].Year__c, 'Field1 and Field2 not equals in test 0');
}
}
catch (System.QueryException e) {
  System.debug('caught ya!');
}
}


private static void insertTestObjectWithField2Value(String testValue,String value2)
{
PMO_Data_Form__c obj = new PMO_Data_Form__c();
obj.Name = testValue;
obj.Month__c = value2;
insert obj;
}


}