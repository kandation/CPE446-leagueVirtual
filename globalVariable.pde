String gameInfo_patch = "6.24.1";
String matchID="";
String keyd ="";
String menu_auto_state_now = "exit_load_data";
FileList file_list = new FileList();
LoadResource lw;
ChampionData champions;
AccountData userAccount;
MatchData matchdata;
ItemData itemdata;
TimelineData timeline;

color nowBackground = color(255);

/* Images */
PImage lulu_loading;
PImage[] splashLoadingCham;


/* Time and Counter */
float time_exit_count = 340;
long time_splashLoad_first = -1;

/* Opperties */
float half_width;
float half_height;
float width_topCenter;
float height_topCenter;



/* BooleanList */
boolean isMatchKey = false;
boolean isFirstLoad= true;
boolean isFirstThread = true;
boolean isGetUserName = false;
boolean isKeyRelessed = false;
boolean isHasMatch = true;
boolean onMousReleased = false;
boolean isError = false;

/* Gui */
boolean gui_isNameCorrectYes = false;

SampleButton gui_b_isNameCorrectYes;
SampleButton gui_b_isNameCorrectNo;

SampleButton main_menu_gold;
SampleButton main_menu_map;
SampleButton main_menu_build;




/* Animation */


/* Sound */
Minim minim;
AudioPlayer music_leaged_nerver_die;

/* void loadingScreen */
float img_last_state_cout = 255;
float img_cmu_logo_cout = 0;
boolean img_cmu_logo_cout_exit = false;
float img_lol_logo_cout = 0;
boolean img_lol_logo_cout_exit = false;