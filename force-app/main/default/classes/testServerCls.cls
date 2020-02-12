public class testServerCls {
    @AuraEnabled
    public static String getId() {
        Id userId = UserInfo.getUserId();
        return userId;
    }
}