public class RMG_Data_FormFieldPreventerTest{
private String Name;
private String Attain_desired_role_ratios;

 
static TestMethod void Test0_TestInsertWithValue()
{
string testValue = 'Fac_Oct';
 String value2='January';
  String value3='January';
insertTestObjectWithField2Value(testValue,value2,value3);
try{
List<RMG_Data_Form__c> testObj = [Select Name, Month__c, Year__c from RMG_Data_Form__c where Name= :testValue];
if(testObj.size() > 0){
System.assertNotEquals(testObj[0], null, 'Test 0 object was null and not inserted correctly');

System.assertEquals(testObj[0].Month__c , testObj[0].Year__c, 'Field1 and Field2 not equals in test 0');
}
}
catch (System.QueryException e) {
  System.debug('caught ya!');
}
}


private static void insertTestObjectWithField2Value(String testValue,String value2, String value3)
{
RMG_Data_Form__c obj = new RMG_Data_Form__c();
obj.Name = testValue;
obj.Month__c = value2;
obj.Year__c= value3;
insert obj;
}



}