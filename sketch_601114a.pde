import ddf.minim.*;


void setup() {
  frameRate(60);
  size(1024, 576); 
  data_init();
  gui_init();  
  imginf_init();
  music_init();
  doingBeforeLoad();
  matchID = "168034397";
}


void draw() {
  if (onMousReleased && !mousePressed) {
    onMousReleased = true;
  }

  background(nowBackground);

  if (isFirstLoad) {
    initialize();
    temp_cidGold = new int[10];
    for (int i=0; i<temp_cidGold.length; i++) {  
      temp_cidGold[i] = 0;
    }
  } else {
    music_leaged_nerver_die.play();
    loadingScreen();
    loadingSplashLoad();
    main_menu();
    map_auto();
    map_build();
  }
}

void keyReleased() {
  keyReleased_isGetUserName();
}

void mousePressed() {
  onMousReleased = false;
}

void mouseReleased() {
  onMousReleased = true;
}

void doingBeforeLoad() {
}

void main_menu() {
  if (menu_auto_state_now == "main_menu") {
    menu_auto_state_now = "map_auto";
  }
}

float map_auto_width;
float map_auto_height;

PGraphics mask;
int[] temp_cidGold ;
void map_build() {
  int[] cidList = matchdata.getChampionList();
  float offset = 50;
  float hover_px = 0;
  float hover_py = 0;
  boolean mouserOver = false;

  if (menu_auto_state_now == "map_build") {
    nowBackground = color(255);
    rectMode(CORNER);


    fill(129, 165, 255);
    rect(0, 0, width/2, height);
    fill(255, 134, 142);
    rect(width/2, 0, width/2, height);

    fill(255);
    textAlign(CENTER, TOP);
    textSize(40);
    text("BLUE TEAM", width/4, 3.5*height/5);

    fill(255);
    textAlign(CENTER, TOP);
    textSize(40);
    text("RED TEAM", 3*width/4, 3.5*height/5);


    int[][] k = matchdata.getPlayersItems();
    String[] itemDesc = new String[2]; 
    /* Loop Item list */
    for (int i=0; i<k.length/2; i++) {
      for (int j=0; j<k[i].length; j++) {
        if (k[i][j] > 0) {
          PImage chImg = loadImage("img/item/"+k[i][j]+".png");
          float px = 50+j*50;
          float py = 50+i*70;
          imageMode(CORNER);
          image(chImg, px, py, 50, 50);
          if (isHover(px, py, 50)) {
            itemDesc[0] = itemdata.getItemNameByID(k[i][j]);
            itemDesc[1] = itemdata.getItemDescriptionByID(k[i][j]);
            rectMode(CORNER);
            fill(225, 255, 0, 100);
            rect(px, py, 50, 50);
            fill(225, 255, 0);
            rect(px +offset, py+offset, 200, 200);
            mouserOver = true;
            hover_px = px;
            hover_py = py;
          }
        }
      }
    }

    /* Loop Item list Right */
    for (int i=k.length/2; i<k.length; i++) {
      for (int j=k[i].length-1; j>=0; j--) {
        if (k[i][j] > 0) {
          PImage chImg = loadImage("img/item/"+k[i][j]+".png");
          float px = (width-100)+(j*-50);
          float py = 41+height/2+((k.length/2)-i)*70;
          imageMode(CORNER);
          image(chImg, px, py, 50, 50);
          if (isHover(px, py, 50)) {
            itemDesc[0] = itemdata.getItemNameByID(k[i][j]);
            itemDesc[1] = itemdata.getItemDescriptionByID(k[i][j]);
            rectMode(CORNER);
            fill(225, 255, 0, 100);
            rect(px, py, 50, 50);
            fill(225, 255, 0);
            rect(px +offset, py+offset, 200, 200);
            mouserOver = true;
            hover_px = px;
            hover_py = py;
          }
        }
      }
    }

    if (mouserOver) {

      rectMode(CORNER);
      textSize(15);
      fill(225, 255, 0);
      float tw = (textWidth(itemDesc[0]) > 60)?textWidth(itemDesc[0]): 60;
      rect(hover_px +offset, hover_py+offset, tw+30, 200);
      fill(0);
      pushMatrix();
      textAlign(LEFT, TOP);
      text(itemDesc[0], hover_px +offset +15, hover_py+offset+15);
      textSize(10);
      text(itemDesc[1], hover_px +offset +15, hover_py+offset+40, tw, 60);
      popMatrix();
    }


    for (int i=0; i<cidList.length; i++) {      
      String cname = champions.getNameByID(cidList[i]);
      PImage chImg = loadImage("img/champion/"+cname+".png");
      float px = 0;
      float py = 0;

      if (i<cidList.length/2) {
        px = 420;
        py = 50+i*70;
      } else {
        px = 560;
        py = 50+(i-cidList.length/2)*70;
      }
      image(chImg, px, py, 50, 50);
      if (isHover(px, py, 50)) {
        rectMode(CORNER);
        pushMatrix();
        fill(0, 0);
        stroke(255, 0, 0);
        strokeWeight(3);
        rect(px, py, 50, 50);
        noStroke();
        textSize(15);
        textAlign(LEFT, TOP);
        float ttw = textWidth(matchdata.getPlayerName(i));
        fill(255);
        rect(px+offset, py+offset, ttw+30, 50);
        fill(0);

        text(matchdata.getPlayerName(i), px+offset+15, py+offset+15);

        popMatrix();
      }
    }
    gui_botton_menu_show();
    if (main_menu_gold.getActive()) {
        menu_auto_state_now = "map_auto";
        main_menu_gold.completed();
        main_menu_build.completed();
      }
  }
}

void map_auto() {
  if (menu_auto_state_now == "map_auto") {
    nowBackground = color(255);
    PImage flag = loadImage("res/flag.png");
    PImage map = loadImage("img/map/map"+matchdata.getMapID()+".png");
    float[] MID_LEN_100 = {38.98, 61.32};
    float[] MID_LEN_200 = {57.57, 42.88, };
    float[] BOT_ADC_200 = {77.21, 90.13};
    float[] BOT_SUP_100 = {69.22, 90.13};
    float[] BOT_ADC_100 = {91.30, 70.91};
    float[] BOT_SUP_200 = {91.30, 63.87};
    float[] JGG_LEN_100 = {22.00, 50.00};
    float[] JGG_LEN_200 = {75.00, 50.00};
    float[] TOP_ADC_100 = {25.69, 90.00};
    float[] TOP_SUP_100 = {90.00, 33.13};
    float[] TOP_ADC_200 = {22.79, 88.50};
    float[] TOP_SUP_200 = {32.83, 88.50};

    String[] lane = matchdata.getLane();
    String[] role = matchdata.getRole();
    float px=0, py=0;

    pushMatrix();
    //rotate(radians(30));
    imageMode(CORNER);
    image(map, 0, 0);
    int[] cidList = matchdata.getChampionList();
    int[] cidGold = matchdata.getGold();
    image(flag, 0, 0, flag.width*0.1, flag.height*0.1);
    popMatrix();
    for (int i=0; i<lane.length; i++) {
      if (i <= lane.length/2) {
        fill(0, 0, 255);
        if (lane[i].equals("BUTTOM")) {
          if (role[i].equals("DUO_CARRY")) {
            px = BOT_ADC_100[0];
            py = BOT_ADC_100[1];
          }
          if (role[i].equals("DUO_SUPPORT")) {
            px = BOT_SUP_100[0];
            py = BOT_SUP_100[1];
          }
        } else if (lane[i].equals("TOP")) {
          if (role[i].equals("SOLO")) {
            px = TOP_ADC_100[0];
            py = TOP_ADC_100[1];
          }
        } else if (lane[i].equals("JUNGLE")) {
          if (role[i].equals("NONE")) {
            px = JGG_LEN_100[0];
            py = JGG_LEN_100[1];
          }
        } else if (lane[i].equals("MIDDLE")) {
          if (role[i].equals("SOLO")) {
            px = MID_LEN_100[0];
            py = MID_LEN_100[1];
          }
        }
      } else {
        fill(255, 0, 0);
        if (lane[i].equals("BUTTOM")) {
          if (role[i].equals("DUO_CARRY")) {
            px = BOT_ADC_200[0];
            py = BOT_ADC_200[1];
          }
          if (role[i].equals("DUO_SUPPORT")) {
            px = BOT_SUP_200[0];
            py = BOT_SUP_200[1];
          }
        } else if (lane[i].equals("TOP")) {
          if (role[i].equals("SOLO")) {
            px = TOP_ADC_200[0];
            py = TOP_ADC_200[1];
          }
        } else if (lane[i].equals("JUNGLE")) {
          if (role[i].equals("NONE")) {
            px = JGG_LEN_200[0];
            py = JGG_LEN_200[1];
          }
        } else if (lane[i].equals("MIDDLE")) {
          if (role[i].equals("SOLO")) {
            px = MID_LEN_200[0];
            py = MID_LEN_200[1];
          }
        }
      }

      float posx = map(px, 0, 100, 0, map.width);
      float posy = map(py, 0, 100, 0, map.height);
      pushMatrix();
      translate(0, 0);
      //rotateX(radians(45));
      println(lane[i]);
      ellipseMode(CORNER);
      ellipse(posx, posy, 20, 20);

      fill(255);
      String cname = champions.getNameByID(cidList[i]);
      PImage chImg1 = loadImage("img/champion/"+cname+".png");
      textAlign(CENTER, CENTER);
      text(lane[i], posx, posy-10);
      if (isHover(posx, posy, 20)) {
        fill(255);
        rectMode(CORNER);
        float ppt = textWidth(cname);
        rect(posx+20, posy, ppt+15, 50);
        fill(0);
        pushMatrix();
        textAlign(LEFT, TOP);
        text(cname, posx+25, posy);
        image(chImg1, posx+25, posy+15, 30, 30);
        popMatrix();
      }
      

      popMatrix();
    }


    int mx = findMax(cidGold);
    for (int i=0; i<cidList.length; i++) {      
      String cname = champions.getNameByID(cidList[i]);
      PImage chImg = loadImage("img/champion/"+cname+".png");
      float pxc = 10+i*55;
      image(chImg, 560, pxc, 50, 50);
      if (i<cidList.length/2) {
        fill(0, 0, 255);
      } else {
        fill(255, 0, 0);
      }
      textAlign(LEFT, TOP);
      text(matchdata.getPlayerName(i), 620, pxc);

      gui_botton_menu_show();

      if (i<cidList.length/2) {
        fill(0, 0, 255);
      } else {
        fill(255, 0, 0);
      }
      textAlign(LEFT, TOP);
      if (temp_cidGold[i] < cidGold[i] && main_menu_gold.getActive()) {
        temp_cidGold[i] += 232;
      }
      float w = map(temp_cidGold[i], 0, mx, 0, 240);
      if (main_menu_gold.getActive()) {
        text("GOLD:"+cidGold[i], 620, pxc+20);
        rectMode(CORNER);
        if (cidGold[i] == mx) {
          fill(255, 255, 0);
        }
        rect(750, pxc, w, 50);
      }
      if (main_menu_build.getActive()) {
        menu_auto_state_now = "map_build";
        main_menu_gold.completed();
        main_menu_build.completed();
      }
    }
  }
}

void gui_botton_menu_show() {
  main_menu_gold.show();
  main_menu_build.show();
}

int findMax(int[] a) {
  int mx = 0;
  for (int i=0; i<a.length; i++) {
    if (a[i] > mx) {
      mx = a[i];
    }
  }
  return mx;
}

boolean isHover(float px, float py, float s) {
  return (mouseX > px && mouseX < px+s)&&(mouseY > py && mouseY < py+s);
}


/*void mappp() {
 background(255, 2, 0);
 if (menu_auto_state_now == "map_auto") {
 //PImage map = loadImage("img/map/map"+matchdata.getMapID()+".png");
 PImage map = loadImage("img/champion/Ashe.png");
 mask=createGraphics(map.width, map.height);//draw the mask object
 mask.beginDraw();
 mask.smooth();//this really does nothing, i wish it did
 mask.background(255);//background color to target
 mask.fill(0);
 mask.ellipse(map.width/2, map.height/2, map.width, map.height);
 mask.endDraw();
 mask.loadPixels();
 map.loadPixels();
 
 for (int i=0; i<mask.pixels.length; i++) {
 //if white, change the color of the image to back with alpha = 0;
 if (mask.pixels[i] >= brightness(50)) {
 color alphaCol = color(0, 0, 0, 255);
 map.pixels[i] = alphaCol;
 }
 }
 
 map.updatePixels();
 image(map, 0, 0);
 
 imageMode(CORNER);
 //image(map, 0, 0, 289, 289);
 //image(map,0,0);
 fill(255, 0, 0);
 
 ellipse(47.01612685560054, 47.289496673610635, 20, 20);
 //println(timeline.getPlayerKillPos(2,4)[0],timeline.getPlayerKillPos(2,4)[1]);
 //println(timeline.getEventType(2,4));
 //timelineData.Position []k = timeline.getPlayerKillPosList();
 
 for (int i=0; i<k.length; i++) {
 float mx = k[i].px;
 float my = k[i].py;
 float posx = map(mx, 0, 13500, 0, 289);
 float posy = map(my, 0, 13500, 0, 289);
 
 ellipse(posx, posy, 10, 10);
 }
 }
 }*/