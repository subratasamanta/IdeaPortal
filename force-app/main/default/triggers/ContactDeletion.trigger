trigger ContactDeletion on Contact (after insert) {
	if(Trigger.new.size() > 0) {
		delete [select id from Contact__c]; 
	}
}