class LoadResource {
  ResourceLink[] list = {};
  FileList filelist;
  int[] loadStatus = {0, 0};
  LoadResource(FileList fl) {
    filelist = fl;
  }

  void add(String url, String type, String file_type) {

    if (url.length() > 0 && type.length() > 0 && file_type.length() > 0) {
      ResourceLink tmpLS = new ResourceLink(url, type, file_type);
      list = (ResourceLink[])append(list, tmpLS);
      println(">>\tAdded : ["+file_type+"] "+type+"/"+url );
    }
  }

  ResourceLink pop() {
    ResourceLink tmp = null;
    if (list.length > 0) {
      tmp = list[list.length-1];
      list = (ResourceLink[])shorten(list);
      return tmp;
    } else {
      println("Error: List is Emplty");
    }
    return tmp;
  }

  void clear() {    
    list = new ResourceLink[0];
  }

  void generate_bg() {
    loadStatus[1] += 1;
  }

  void _loadRes(boolean isReload) {
    loadStatus[0] = list.length;
    loadStatus[1] = 0;
    for (int i=0; i<list.length; i++) {
      if (checkUrlNotEmpty(list[i])) {
        String[] tmpUrl = this._generateUrl(list[i]);
        file_list.add(tmpUrl[1]);
        if (_isResourceEmpty(tmpUrl[1]) || isReload) {
          generate_bg();
          this._DownloadFile(tmpUrl);
        } else {
          println("File "+tmpUrl[1]+" not Exsit >> Dont Download");
        }
      } else {
        println("Error: Url not correct");
      }
    }
    this.clear();
  }

  private boolean _isResourceEmpty(String pathCheck) {
    File[] files = listFiles(pathCheck);
    if (files == null) {
      return true;
    }
    return false;
  }

  private String[] _generateUrl(ResourceLink rs) {
    String urlParam = "";
    String loadingUrl = "http://ddragon.leagueoflegends.com/cdn/";
    String cdnImgUrl = "http://ddragon.leagueoflegends.com/cdn/"+gameInfo_patch+"/";
    String cdnStatUrl = "https://acs-garena.leagueoflegends.com/v1/stats/game/TH/";
    String tmpUrl = "";
    switch(rs.getFileType()) {
    case "img":
      {
        if (rs.getType() == "champion/loading") {
          urlParam = rs.getFileType()+"/"+rs.getType()+"/"+rs.getUrl()+".jpg";
          tmpUrl = loadingUrl+urlParam;
        } else if(rs.getType() == "map"){
          urlParam = rs.getFileType()+"/"+rs.getType()+"/map"+rs.getUrl()+".png";
          tmpUrl = cdnImgUrl+urlParam;
        }else {
          urlParam = rs.getFileType()+"/"+rs.getType()+"/"+rs.getUrl()+".png";
          tmpUrl = cdnImgUrl+urlParam;
        }
        break;
      }
    case "json":
      {
        if (rs.getType() == "timeline") {
          urlParam = rs.getUrl()+"/"+rs.getType();
          tmpUrl = cdnStatUrl+urlParam;
          urlParam = rs.getFileType()+"/"+rs.getType()+"/"+rs.getUrl()+".json";
        } else if (rs.getType() == "match") {
          urlParam = rs.getUrl();
          tmpUrl = cdnStatUrl+urlParam;
          urlParam = rs.getFileType()+"/"+rs.getType()+"/"+rs.getUrl()+".json";
        } else if (rs.getType() == "data") {
          urlParam = "data/th_TH/"+rs.getUrl()+".json";
          tmpUrl = cdnImgUrl+urlParam;
        }

        break;
      }
    }

    return new String[] {tmpUrl, urlParam};
  }

  private void _DownloadFile(String[] urlParam) {
    boolean canSave;
    byte by[] = {};
    canSave = false;


    try {
      by = loadBytes(urlParam[0]);
      println(">>\tLoaded: "+by.length+" bytes");
      canSave = true;
    }
    catch(NullPointerException e) {
      println(e);
    }
    catch(Exception e) {
      println("Excp: Download SomeThing wrong");
    }
    finally {
      if (canSave) {
        println(">>\tSaved : "+urlParam[1]);      
        saveBytes(urlParam[1], by);
      }
    }
  }

  boolean checkUrlNotEmpty(ResourceLink re) {
    return (re.getUrl().length() > 0 && re.getType().length() > 0 && re.getFileType().length() > 0);
  }

  void printList() {
    println("--------Resource List------------");
    for (int i=0; i<list.length; i++) {
      println(list[i].getUrl());
    }
  }

  void _addItemResource(int[][] itemlist) {
    for (int i=0; i<itemlist.length; i++) {
      for (int j=0; j<itemlist[i].length; j++) {
        if (itemlist[i][j] > 0) {
          this.add(str(itemlist[i][j]), "item", "img");
        }
      }
    }
  }

  void _addChampionResource(int[] chmList) {
    ChampionData c = new ChampionData();

    for (int i=0; i<chmList.length; i++) {
      if (chmList[i] > 0) {
        this.add(c.getNameByID(chmList[i]), "champion", "img");
        this.add(c.getNameByID(chmList[i])+"_0", "champion/loading", "img");
      }
    }
  }

  private void _loadImageResInit(MatchData m) {
    this._addItemResource(m.getPlayersItems());
    this._addChampionResource(m.getChampionList());
    this._addMapResource(m.getMapID());
  }
  
  private void _addMapResource(int mapid){
    this.add(str(mapid),"map","img");
  }

  void loadMatchData(String mid) {
    /* Load Static FIle First */
    this.add(mid, "match", "json");
    this.add(mid, "timeline", "json");
    this._loadRes(false);
    
    /* Update GameVersion */
    MatchData m;
    m = new MatchData(matchID);
    m.getGameVersion();
    
    
    /*--------------------*/
    this.add("champion", "data", "json");
    this.add("item", "data", "json");
    this._loadRes(false);
  }

  void __loadAllChapionImages() {
    // Load For friends
    ChampionData c = new ChampionData();
    String[] chmList = c.getChampionNameList();
    for (int i=0; i<chmList.length; i++) {
      this.add(chmList[i], "champion", "img");
    }
  }

  int[] getLoadStatus() {
    return loadStatus;
  }
}