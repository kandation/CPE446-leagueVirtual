class MatchData{
  JSONObject  json;
  MatchData(String matchID){
    json = loadJSONObject("json/match/"+matchID+".json");
    this.getGameVersion();
  }
  
  String getGameMode(){
    return json.getString("gameMode");
  }
  String getGameType(){
    return json.getString("gameType");
  }
  
  int getSeasonID(){
    return json.getInt("seasonId");
  }
  
  int getMapID(){
    return json.getInt("mapId");
  }
  
  long getCreation(){
    return json.getLong("gameCreation");
  }
  
  int getPlayerNum(){
    return json.getJSONArray("participants").size();
  }
  
  String getPlayerName(int pid){
    if(pid <= getPlayerNum()){
      String summonerName = json.getJSONArray("participantIdentities").getJSONObject(pid).getJSONObject("player").getString("summonerName");
      return summonerName;
    }else{
      return "";
    }
  }
  
  JSONObject getPlayerData(int pid){
    return json.getJSONArray("participantIdentities").getJSONObject(pid);
  }
  
  String getGameVersion(){
    String s = gameInfo_patch;
    try{
      String kk = json.getString("gameVersion");
      String[] version = split(kk, '.');
      s = join(subset(version, 0,2),'.')+".1";
      gameInfo_patch = s;
    }catch(Exception e){
      println("Error: File Not Correct");
    }return s;
  }
  
  int[][] getPlayersItems(){
    int s = this.getPlayerNum();
    int[][] temp = new int[s][7];
    for(int i=0;i<temp.length;i++){
      for(int j=0;j<temp[i].length;j++){
        String itemTag = "item"+str(j);
        temp[i][j] = json.getJSONArray("participants").getJSONObject(i).getJSONObject("stats").getInt(itemTag);
        //println(temp[i][j]);
      }
    }
    return temp;
  }
  
  int[] getChampionList(){
    int s  =this.getPlayerNum();
    int[] c = new int[s];
    for(int i=0; i<c.length;i++){
      c[i] = json.getJSONArray("participants").getJSONObject(i).getInt("championId");
    }
    return c;
  }
  
  String[] getRole(){
    int s  =this.getPlayerNum();
    String[] c = new String[s];
    for(int i=0; i<c.length;i++){
      c[i] = json.getJSONArray("participants").getJSONObject(i).getJSONObject("timeline").getString("role");
    }
    return c;
  }
  String[] getLane(){
    int s  =this.getPlayerNum();
    String[] c = new String[s];
    for(int i=0; i<c.length;i++){
      c[i] = json.getJSONArray("participants").getJSONObject(i).getJSONObject("timeline").getString("lane");
    }
    return c;
  }
  
  int[] getGold(){
    int s  =this.getPlayerNum();
    int[] c = new int[s];
    for(int i=0; i<c.length;i++){
      c[i] = json.getJSONArray("participants").getJSONObject(i).getJSONObject("stats").getInt("goldEarned");
    }
    return c;
  }
  
  int[] getKill(){
    int s  =this.getPlayerNum();
    int[] c = new int[s];
    for(int i=0; i<c.length;i++){
      c[i] = json.getJSONArray("participants").getJSONObject(i).getJSONObject("stats").getInt("kills");
    }
    return c;
  }
  int[] getDead(){
    int s  =this.getPlayerNum();
    int[] c = new int[s];
    for(int i=0; i<c.length;i++){
      c[i] = json.getJSONArray("participants").getJSONObject(i).getJSONObject("stats").getInt("deaths");
    }
    return c;
  }
  int[] getAssist(){
    int s  =this.getPlayerNum();
    int[] c = new int[s];
    for(int i=0; i<c.length;i++){
      c[i] = json.getJSONArray("participants").getJSONObject(i).getJSONObject("stats").getInt("assists");
    }
    return c;
  }
  
  
 
  
  /*int[] getKDA(){
    return;
  }*/
}