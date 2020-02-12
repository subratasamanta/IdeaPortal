trigger autoPopulateUserDeatils on Idea__c (after insert) {
    UserDetails.getUserDetails(trigger.new);
    
}