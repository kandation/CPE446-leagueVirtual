boolean hasMatch(String matchID) {
  /*
  *  Check GameID is real
   */
  JSONObject json;
  try {
    json = loadJSONObject("https://acs-garena.leagueoflegends.com/v1/stats/game/TH/"+matchID);
  }
  catch(Exception e) {
    //println(e);
    return false;
  }
  return true;
}

void gui_init() {
  gui_b_isNameCorrectYes = new SampleButton("Yes, It's me", width_topCenter, height_topCenter+100,220,60);
  gui_b_isNameCorrectYes.setColor(color(255,255,0));
  gui_b_isNameCorrectNo = new SampleButton("No, Cat typed", width_topCenter, height_topCenter+160,120,20);
  gui_b_isNameCorrectNo.setColor(color(255, 58, 58));
  
  main_menu_gold = new SampleButton("Gold Eern", 100, height-30,220,50);
  main_menu_gold.setColor(color(255,255,0));
  
  main_menu_build = new SampleButton("Build", 300, height-30,220,50);
  main_menu_gold.setColor(color(100,255,265));
}

void data_init() {
  half_width = width/2;
  half_height = height/2;
  width_topCenter = cal_topCenterPos()[0];
  height_topCenter = cal_topCenterPos()[1];
  lw = new LoadResource(file_list);
  
}

void imginf_init() {
  lulu_loading = loadImage("res/lulu_loading.png");
  //menu_auto_state_now = "map_build";
}

void music_init(){
  minim = new Minim(this);
  music_leaged_nerver_die = minim.loadFile("lnd_smallmp3.mp3");
  
}

float[] cal_topCenterPos() {
  float h =height-(height*2/3);
  float w = width/2;
  float[] p = {w, h};
  return p;
}

boolean isNum(String n){
  return str(float(n)) != "NaN";
}