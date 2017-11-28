void initialize() {
  if (!isMatchKey) {
    if (!isGetUserName) {
      i_showUsernameType();
      //isGetUserName = true;
      //keyd = "pyruvate";
      if (key == ENTER && keyPressed) {
        keyd = trim(keyd);
        isGetUserName = true;
      }
    } else {
      fill(0);
      if(checkSummonerNameOrNot()){
        i_showConfirmName();        
      }else{
        i_showConfirmMatch();
      }
      
    }
  }
  if (!isHasMatch || isError) {
      println("Error: Match not Founded!!" + time_exit_count);
      pushMatrix();
      PImage poro_error = loadImage("res/foryord_poro.png");
      imageMode(CENTER);
      textSize(10);
      text("Something Error", width_topCenter, height_topCenter-30);
      textSize(30);
      text("Close in ... "+str(round(time_exit_count/frameRate)), width_topCenter, height_topCenter);
      image(poro_error, width/2, height/2);
      popMatrix();
      time_exit_count -= 1.0;
      if (time_exit_count <= 0) {
        exit();
      }
    }
  if (isMatchKey) {  
    if (isFirstLoad && isFirstThread) {
      println("_________Running Loadded Thread_________");
      thread("loadDataFromInternet");     
      isFirstThread = false;
    }
    if (isFirstLoad && isHasMatch) {
      i_showLoadBar(lw.getLoadStatus()[0], lw.getLoadStatus()[1]);
      i_showResourceStatusLoad();
      if (abs(lw.getLoadStatus()[0]-lw.getLoadStatus()[1])<= 1) {
        saveFrame("lastest.png");
      }
    }

    
  }
}

boolean checkSummonerNameOrNot(){
  return !isNum(trim(keyd));
}

void loadDataFromInternet() {
  if (!hasMatch(matchID) || !isHasMatch) {
    isHasMatch = false;
  } else {       
    lw.loadMatchData(matchID);
    /* Call Static File From Local */
    matchdata = new MatchData(matchID);
    champions = new ChampionData();
    itemdata = new ItemData();
    timeline = new TimelineData();
    lw._loadImageResInit(matchdata);
    lw._loadRes(false);
    isFirstLoad = false;
  }
}
void resetAll(){
 matchID="";
 keyd ="";
 menu_auto_state_now = "exit_load_data";
  
}

void loadingScreen() {
  pushMatrix();
  if (menu_auto_state_now.equals("exit_load_data")) {
    if (img_last_state_cout > 0) {
      PImage img_last_state = loadImage("lastest.png");
      img_last_state_cout = constrain(img_last_state_cout, 0, 255);
      tint(img_last_state_cout);
      img_last_state_cout-=3.2;
      image(img_last_state, half_width, half_height); 
      nowBackground = color(0);
    } else {
      menu_auto_state_now = "show_cmu_logo";
    }
  } else if (menu_auto_state_now.equals("show_cmu_logo")) {
    PImage cmu_logo = loadImage("res/cmu_logo.png");
    img_cmu_logo_cout = constrain(img_cmu_logo_cout, -255, 255);
    tint(abs(img_cmu_logo_cout));
    img_cmu_logo_cout += 2.3;
    image(cmu_logo, half_width, half_height, cmu_logo.width*0.72, cmu_logo.height*0.72);
    if (img_cmu_logo_cout > 255) {
      img_cmu_logo_cout = -1*img_cmu_logo_cout;
      img_cmu_logo_cout_exit = true;
    }
    if (img_cmu_logo_cout > 0 && img_cmu_logo_cout_exit) {
      menu_auto_state_now = "show_lol_logo";
    }
  } else if (menu_auto_state_now == "show_lol_logo") {
    PImage lol_logo = loadImage("res/lol_logo.png");    
    if (!img_lol_logo_cout_exit) {
      img_lol_logo_cout = constrain(img_lol_logo_cout, 0, 255);
      tint(abs(img_lol_logo_cout));
      img_lol_logo_cout += 2.1;
    } else {
      img_lol_logo_cout += 1;
    }

    image(lol_logo, half_width, half_height, lol_logo.width*0.61, lol_logo.height*0.61);
    if (img_lol_logo_cout > 255 && !img_lol_logo_cout_exit) {
      img_lol_logo_cout = 0;
      img_lol_logo_cout_exit = true;
    }

    if (img_lol_logo_cout > 250 && img_lol_logo_cout_exit) {
      saveFrame("lastest.png");
      img_last_state_cout = 255;
      menu_auto_state_now = "show_gg_pk";
    }
    println(menu_auto_state_now);
  }else if(menu_auto_state_now == "show_gg_pk"){
    if (img_last_state_cout > 0) {
    PImage img_last_state = loadImage("lastest.png");
    img_last_state_cout = constrain(img_last_state_cout, 0, 255);
    tint(img_last_state_cout);
    img_last_state_cout-=1.3;
    image(img_last_state, half_width, half_height); 
    nowBackground = color(255);
    }else{
      menu_auto_state_now = "show_splash_load";
    }
  }
  popMatrix();
}

void loadingSplashLoad(){
  if(menu_auto_state_now == "show_splash_load"){
    if(time_splashLoad_first == -1){
      time_splashLoad_first = millis();
    }
    if(millis() - time_splashLoad_first >= 8000){
      menu_auto_state_now = "main_menu";
    }
    nowBackground = color(0);
    String[] c = champions.getChampionNameList();
    int[] cid = matchdata.getChampionList();
    String cname;
    splashLoadingCham = new PImage[cid.length];
    tint(255);
    float img_width = width/cid.length;
    float img_ratio;
    PImage vs = loadImage("res/vs.png");
    
    
    for(int i=0; i<cid.length/2;i++){
      cname = champions.getNameByID(cid[i]);
      imageMode(CORNER);
      splashLoadingCham[i] = loadImage("img/champion/loading/"+cname+"_0.jpg");
      img_ratio = (float)splashLoadingCham[i].width/splashLoadingCham[i].height;
      image(splashLoadingCham[i],i*(2*img_width),0,2*img_width,splashLoadingCham[i].height*img_ratio);
    }
    for(int i=cid.length/2; i<cid.length;i++){
      cname = champions.getNameByID(cid[i]);
      imageMode(CORNER);
      splashLoadingCham[i] = loadImage("img/champion/loading/"+cname+"_0.jpg");
      img_ratio = (float)splashLoadingCham[i].width/splashLoadingCham[i].height;
      image(splashLoadingCham[i],(i-(cid.length/2))*(2*img_width),splashLoadingCham[i].height/2,2*img_width,splashLoadingCham[i].height/2);
    }
    pushMatrix();
    imageMode(CENTER);
    image(vs,half_width, half_height,vs.width*0.8, vs.height*0.8);
    popMatrix();
  }
}