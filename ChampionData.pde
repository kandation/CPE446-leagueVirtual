class ChampionData{
  JSONObject  json;
  ChampionData(){
    json = loadJSONObject("data/th_TH/champion.json");
  }
  
  String[] getChampionNameList(){
    String[] k = (String[])json.getJSONObject("data").keys().toArray(new String[json.size()]);
    return k;
  }
  
  String getNameByID(int cid){
    String[] k = getChampionNameList();
    for(String chmName : k){  
      String tempChmID = json.getJSONObject("data").getJSONObject(chmName).getString("key");
      if(str(cid).equals(tempChmID)){
        return chmName;
      }
    }
    return "0";    
  }
}

class ItemData{
  JSONObject json;
  ItemData(){
    json = loadJSONObject("data/th_TH/item.json");
  }
  
  String getItemNameByID(int tid){
    return json.getJSONObject("data").getJSONObject(str(tid)).getString("name");
  }
  
  String getItemDescriptionByID(int tid){
    return json.getJSONObject("data").getJSONObject(str(tid)).getString("plaintext");
  }
  
}