class AccountData {
  String user;
  long accID;
  JSONObject jsonm;
  AccountData(String user) {
    this.user = user;
  }

  void loadData() {
    String url = "https://acs-garena.leagueoflegends.com/v1/players?name="+this.user+"&region=TH";
    try {
      JSONObject json = loadJSONObject(url);
      accID = json.getLong("accountId");
    }
    catch(Exception e) {
      println("Username Exist");
      isError = true;
      isMatchKey = true;
    }
    loadLastMatch();
  }

  long getAccID() {
    return accID;
  }

  void loadLastMatch() {
    String url = "https://acs-garena.leagueoflegends.com/v1/stats/player_history/TH/"+this.accID+"?begIndex=0&endIndex=20";
    println(url);
    if (accID >1000) {
      try {
        jsonm = loadJSONObject(url);
      }
      catch(Exception e) {
        println("Id is Exist");
        isError = true;
        isMatchKey = true;
      }
    } else {
      println("Id is Exist");
      isError = true;
      isMatchKey = true;
      isHasMatch = false;
    }
  }

  int getLastMatch() {
    int  f;
    if (accID >1000) {
      try {
        f= jsonm.getJSONObject("games").getJSONArray("games").getJSONObject(0).getInt("gameId");
      }
      catch(Exception e) {
        println("LoadLast match wrong");
        f = 168034397;
      }
      
    }else{
      f = 168034397;
    }
    return f;
  }
}