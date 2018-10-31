trigger AccountAddressTrigger on Account (before insert, before update) {
    
   
    set<id> idsets = new set<id>();
    idsets.add(Trigger.new[0].id);
    OrderHelper.RollUpOrderItems(idsets);
}