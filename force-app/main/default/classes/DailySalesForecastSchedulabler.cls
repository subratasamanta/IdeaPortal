/**********************************************************************
Name:  
Copyright © 2016  Tavant
======================================================
======================================================
Purpose:                                                            

======================================================
======================================================
History                                                            
-------                                                            
VERSION  AUTHOR         DATE            DETAIL                         FEATURES/CSR/TTP
1.0 -    Praveen KH     01/07/2016      INITIAL DEVELOPMENT            FEATURES 
***********************************************************************/

global class DailySalesForecastSchedulabler implements Schedulable{
    global void execute(SchedulableContext SC){
        DailySalesForecastBatch batchJob = new DailySalesForecastBatch(); 
        Database.executeBatch(batchJob, 10);  
    }
}