public with sharing class SubscribeObjCls {
    @AuraEnabled
    public static void doSubscribe(String targetObjectId,String buttonLabel){
        List<EntitySubscription> listEntitySub = new List<EntitySubscription>();
        listEntitySub = [SELECT Id FROM EntitySubscription WHERE ParentId =: targetObjectId AND SubscriberId =: 
                                        UserInfo.getUserId() limit 1000];
        if(listEntitySub.Size() == 0 && buttonLabel == 'Subscribe') {
            createEntitySubscription(targetObjectId);
        }
        if(listEntitySub.Size() > 0 && buttonLabel == 'Unsubscribe') {
            deleteEntitySubscription(listEntitySub);
        } 
    }
    public static void createEntitySubscription(String targetObjectId){
        EntitySubscription entitySub = new EntitySubscription();
        entitySub.ParentId = targetObjectId;
        entitySub.SubscriberId = UserInfo.getUserId();
        entitySub.NetworkId = Network.getNetworkId();
        insert entitySub;

    }
    public static void deleteEntitySubscription(List<EntitySubscription> listEntitySub){        
        if(listEntitySub.Size() > 0){
            delete listEntitySub;
        }     
    }
}