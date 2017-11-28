void i_showUsernameType() {
  pushMatrix();
  fill(0);
  textSize(25);
  textAlign(CENTER, CENTER);
  text("Enter SummonerName or MatchId", width_topCenter, height_topCenter);
  fill(50);
  textSize(60);
  text(keyd, width_topCenter, height_topCenter+80);
  fill(200);
  text(keyd, width_topCenter, height_topCenter+83);
  popMatrix();
}

void i_showResourceStatusLoad() {
  pushMatrix();
  imageMode(CENTER);
  translate(half_width, half_height);
  rotate(radians(frameCount));
  image(lulu_loading, 0, 0, 180, 180);
  popMatrix();

  pushMatrix();
  fill(0);
  translate(half_width, half_height);
  textAlign(CENTER, CENTER);
  textMode(CENTER);
  textSize(20);
  String state = "("+str(lw.getLoadStatus()[1])+"/"+str(lw.getLoadStatus()[0])+")";
  text("Loading Resource"+state, 0, 185);
  popMatrix();
}

void i_showConfirmName() {  
  pushMatrix();
  textSize(50);
  text("Is "+keyd, half_width, half_height-100);
  popMatrix();
  gui_b_isNameCorrectYes.show();
  gui_b_isNameCorrectNo.show();
  if (gui_b_isNameCorrectYes.getActive()) {
    
    userAccount = new AccountData(keyd);
    userAccount.loadData();
    userAccount.loadLastMatch();
    matchID = str(userAccount.getLastMatch());
    println(userAccount.getAccID());
    println(str(int(matchID)));
    isMatchKey = true;
    gui_b_isNameCorrectYes.completed();
  }
  if (gui_b_isNameCorrectNo.getActive()) {
    gui_b_isNameCorrectNo.completed(); 
    isGetUserName = false;
  }
}

void i_showLoadBar(float full, float now) {
  pushMatrix();
  translate(width/2, 0);
  noStroke();
  fill(255, 255, 0);
  rect(0, height-10, width, 5);
  fill(0);
  float st = now/full;
  st = map(st, 0, 1, 0, width);
  rect(0, height-10, st, 5);
  popMatrix();
}

void i_showConfirmMatch(){
  pushMatrix();
  textSize(50);
  text("Goto Match "+keyd, half_width, half_height-100);
  popMatrix();
  gui_b_isNameCorrectYes.show();
  gui_b_isNameCorrectNo.show();
  if (gui_b_isNameCorrectYes.getActive()) {
    matchID = trim(keyd);
    isMatchKey = true;
    gui_b_isNameCorrectYes.completed();
  }
  if (gui_b_isNameCorrectNo.getActive()) {
    gui_b_isNameCorrectNo.completed(); 
    isGetUserName = false;
  }
}