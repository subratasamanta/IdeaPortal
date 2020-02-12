/*
* Description: This Apex class is used in an Apex Trigger named "RunLeadAssignmentRule" for avoiding recursion in trigger.
* RunLeadAssignmentRuleTest
*-------------------------------------------------------------------------------------------------------
*  Author                          Date                               Project         
*  Shiwangi Jha                    6/12/2018                          Tavant Internal Sales 
*-------------------------------------------------------------------------------------------------------
*/
public class AvoidRecursion {
    public static boolean firstRun = true;
}