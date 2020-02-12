@isTest 
public class ChatterActivityTest{
    public static testMethod void myUnitTest(){
      
      list<User> gdm = [Select Id, Is_GDM__c From User where Id=:userinfo.getuserid()];
      
      
      update gdm;
      system.debug('Test Class Start');
      ChatterActivityCtrl  ctrl = new ChatterActivityCtrl();

      ctrl.SFromDate = date.newInstance(20,11,2014);
      ctrl.SToDate = date.newInstance(01,01,2013);
      ctrl.runReport();

      ctrl.SFromDate = date.newInstance(10,11,2014);
      ctrl.SToDate = date.newInstance(25,11,2014);
      ctrl.runReport();

      ctrl.SFromDate = date.newInstance(20,11,2014);
      ctrl.SToDate = date.newInstance(29,11,2014);
      ctrl.runReport();
      ctrl.QueryFeed(gdm, date.newInstance(20,11,2014), date.newInstance(29,11,2014));
      
      ChatterActivityCtrl.ReportWrapper r = new ChatterActivityCtrl.ReportWrapper('test',0);
      system.debug('Test Class End');
    }
}