/***********************************************/

  //ModelUtils.POSE_NOSE_INDEX            // Nariz
  //ModelUtils.POSE_LEFT_EYE_INDEX        // Ojo izdo
  //ModelUtils.POSE_LEFT_EAR_INDEX        // Oreja izda
  //ModelUtils.POSE_RIGHT_EYE_INDEX       // Ojo dcho
  //ModelUtils.POSE_RIGHT_EAR_INDEX       // Oreja dcha
  //ModelUtils.POSE_RIGHT_SHOULDER_INDEX  // Hombro dcho
  //ModelUtils.POSE_RIGHT_ELBOW_INDEX     // Codo dcho
  //ModelUtils.POSE_RIGHT_WRIST_INDEX     // Muñeca dcha
  //ModelUtils.POSE_LEFT_SHOULDER_INDEX   // Hombro izdo
  //ModelUtils.POSE_LEFT_ELBOW_INDEX      // Codo izdo
  //ModelUtils.POSE_LEFT_WRIST_INDEX      // Muñeca izda
  //ModelUtils.POSE_RIGHT_HIP_INDEX       // Cadera dcha
  //ModelUtils.POSE_RIGHT_KNEE_INDEX      // Rodilla dcha
  //ModelUtils.POSE_RIGHT_ANKLE_INDEX     // Tobillo dcho
  //ModelUtils.POSE_LEFT_HIP_INDEX        // Cadera izda
  //ModelUtils.POSE_LEFT_KNEE_INDEX       // Rodilla izda
  //ModelUtils.POSE_LEFT_ANKLE_INDEX      // Tobillo izda

/****************************************************/


// Import OSC
import oscP5.*;
import netP5.*;

/************* RUNWAYML COMMUNICATION ***************/
// import Runway library
import com.runwayml.*;

// Runway object to create OSC communication
RunwayOSC runway;
// Runway Port to listen
//static int runwaylisteningPort = 57200;

// Runway Port to send                //Data are not sent to Runway (not enabled)
//static int runwayPort = 57100;
// Host to send
//NetAddress myBroadcastLocation;

// This array will hold all the humans detected
JSONObject poneNet_data;

/*********** OSCHOOK COMMUNICATION *****************/

// OSC object to create OSC listener communication with oscHook
OscP5 oscHook;

// Port to listen from APP oscHook
static int oscHooklistenPort = 2345;

// APP oscHook Host                      //Data are not sent to the app (not enabled)
//String oscHookHost = "192.168.0.18";

// APP oscHook Port to send          
//int oscHooksendPort = 1234;

/*********************************************************/
float accelX,accelY,accelZ;
static float g = 9.8;
static float high_accel_ratio = 0.50;
static float low_accel_ratio = 0.50;
static float pose_identif_range = 0.20;

PImage intro_bg;
PImage mask, avatar, bar,bar_bg, home_bg, supermarket_bg;
PImage gel, fruits_veget, flour, legumes, pasta,face_masks,beer, cleaning,dairy, toilet_paper,meat,snacks,bakery,chocolate, exit,pay;
PImage clothes, washing_machine;
PImage tree;
PImage bridge;
PImage hospital,hospital_bg,vaccine;
PImage gel_game;

int avatar_x;
int avatar_y;
static int avatar_width = 33;
static int avatar_height = 75;
static int mask_width = 40;
static int mask_height = 25;
boolean wear_mask = false;
String game_mode;
boolean intro;


float nose_X, nose_Y;
float right_shoulder_X, right_shoulder_Y;
float left_shoulder_X, left_shoulder_Y;
float right_elbow_X, right_elbow_Y;
float left_elbow_X, left_elbow_Y;
float right_wrist_X, right_wrist_Y;
float left_wrist_X, left_wrist_Y;
float right_hip_X, right_hip_Y;
float left_hip_X, left_hip_Y;
float right_knee_X, right_knee_Y;
float left_knee_X, left_knee_Y;
float right_ankle_X, right_ankle_Y;
float left_ankle_X, left_ankle_Y;

int health_value = 100;
long timer_health_disc;

boolean delay_msg = false;

PFont f;                  //Text font



void setup () 
{
  //size (1800, 1050);      //This modifies the map size shown in the screen
  fullScreen();
  
  /************* SETUP COMMUNICATION *************/
  // Set APP oscHook communication listening
  oscHook = new OscP5(this, oscHooklistenPort);  
  // Set Runway OSC communication listeting
  runway = new RunwayOSC(this);  //Constructor to initialize and start the Library for situations where Runway runs on the same computer 
  
  
  /************* AVATAR POSITION IN THE START OF THE GAME *************/
  avatar_x = 250;     //Position the avatar in front of the house
  avatar_y = 450;
  
  /************* CARGA LAS IMÁGENES *************/
  intro_bg = loadImage("cabecera.jpg");
  intro_bg.resize(width,height);
  
  avatar = loadImage("avatar.png");
  mask = loadImage("macarilla.png");
  
  home_bg = loadImage("home.jpg");
  home_bg.resize(width,height);
  gel = loadImage("gel.jpg");
  gel.resize(int(width*0.20),int(height*0.20));
  exit = loadImage("exit.jpg");
  exit.resize(int(width*0.15),int(height*0.15)); 
  clothes = loadImage("clothes.jpg");
  clothes.resize(int(width*0.20),int(height*0.20));
  washing_machine = loadImage("washing_machine.jpg");
  washing_machine.resize(int(width*0.20),int(height*0.20));  
  
  supermarket_bg = loadImage("super.jpg");
  supermarket_bg.resize(width,height);
  fruits_veget = loadImage("fruits_and_vegetables.jpg");
  fruits_veget.resize(int(width*0.20),int(height*0.20));
  dairy = loadImage("lacteos.jpg");
  dairy.resize(int(width*0.20),int(height*0.20));
  face_masks = loadImage("Mascarillas.jpg");
  face_masks.resize(int(width*0.20),int(height*0.20));
  legumes = loadImage("legumbres.jpg");
  legumes.resize(int(width*0.20),int(height*0.20));
  meat = loadImage("meat.png");
  meat.resize(int(width*0.20),int(height*0.20));
  beer = loadImage("beer.jpg");
  beer.resize(int(width*0.20),int(height*0.20));
  snacks = loadImage("chips.jpg");
  snacks.resize(int(width*0.20),int(height*0.20));
  bakery = loadImage("bakery.jpg");
  bakery.resize(int(width*0.20),int(height*0.20));
  chocolate = loadImage("chocolate.jpg");
  chocolate.resize(int(width*0.20),int(height*0.20));
  toilet_paper = loadImage("toilet_paper.jpg");
  toilet_paper.resize(int(width*0.20),int(height*0.20));
  pay = loadImage("pay.jpg");
  pay.resize(int(width*0.15),int(height*0.15));
  
  virus = loadImage("coronavirus.png");
  bar = loadImage("bar.jpg");
  bar.resize(int(width*0.12),int(height*0.15));
  bar_bg = loadImage("bar_int.jpg");
  bar_bg.resize(width,height);
  
  tree = loadImage("tree_1.jpg");
  tree.resize(int(width*0.05),int(height*0.10));
  
  bridge = loadImage("bridge.jpg");
  bridge.resize(100,int(height*0.06));
  
  hospital = loadImage("hospital.jpg");
  hospital.resize(int(width*0.15),int(height*0.15));
  hospital_bg = loadImage("hospital3.jpg");
  hospital_bg.resize(width,height);
  vaccine = loadImage("vacuna.jpg");
  vaccine.resize(int(width*0.20),int(height*0.20));
  
  gel_game = loadImage("gel_sin_fondo.png");
  gel_game.resize(int(width*0.10),int(height*0.15)); 

  /************* CREATE THE BOXES LIMITS TO BE USED IN THE SUPERMARKET GAME *************/
  boxs[0] =new Box_lim(int(width*0.30),int(width*0.45),0,int(height*0.20));
  boxs[1] = new Box_lim(0,int(width*0.20),0,int(height*0.20));
  boxs[2] = new Box_lim(0,int(width*0.20),int(height*0.20),int(height*0.40));
  boxs[3] = new Box_lim(0,int(width*0.20),int(height*0.40),int(height*0.60));
  boxs[4] = new Box_lim(0,int(width*0.20),int(height*0.60),int(height*0.80));
  boxs[5] = new Box_lim(0,int(width*0.20),int(height*0.80),height);  
  boxs[6] = new Box_lim(int(width*0.80),width,0,int(height*0.20));
  boxs[7] = new Box_lim(int(width*0.80),width,int(height*0.20),int(height*0.40));
  boxs[8] = new Box_lim(int(width*0.80),width,int(height*0.40),int(height*0.60));
  boxs[9] = new Box_lim(int(width*0.80),width,int(height*0.60),int(height*0.80));
  boxs[10] = new Box_lim(int(width*0.80),width,int(height*0.80),height);
  boxs[11] = new Box_lim(int(width*0.55),int(width*0.70),0,int(height*0.20));
  
  /************* CREATE THE CHECKS LINES TO BE USED IN THE SUPERMARKET GAME *************/
  list_checks[1] = new Check(int(width*0.07),int(height*0.10),int(width*0.12),int(height*0.13),int(width*0.14),int(height*0.05));
  list_checks[2] = new Check(int(width*0.07),int(height*0.30),int(width*0.12),int(height*0.33),int(width*0.14),int(height*0.25));
  list_checks[3] = new Check(int(width*0.07),int(height*0.50),int(width*0.12),int(height*0.53),int(width*0.14),int(height*0.45));
  list_checks[4] = new Check(int(width*0.07),int(height*0.70),int(width*0.12),int(height*0.73),int(width*0.14),int(height*0.65));
  list_checks[5] = new Check(int(width*0.07),int(height*0.90),int(width*0.12),int(height*0.93),int(width*0.14),int(height*0.85));
  list_checks[6] = new Check(int(width*0.87),int(height*0.10),int(width*0.92),int(height*0.13),int(width*0.94),int(height*0.05));
  list_checks[7] = new Check(int(width*0.87),int(height*0.30),int(width*0.92),int(height*0.33),int(width*0.94),int(height*0.25));
  list_checks[8] = new Check(int(width*0.87),int(height*0.50),int(width*0.92),int(height*0.53),int(width*0.94),int(height*0.45));
  list_checks[9] = new Check(int(width*0.87),int(height*0.70),int(width*0.92),int(height*0.73),int(width*0.94),int(height*0.65));
  list_checks[10] = new Check(int(width*0.87),int(height*0.90),int(width*0.92),int(height*0.93),int(width*0.94),int(height*0.85));  
  
  
  /************* START OF THE GAME IN THE MODE "MAP" *************/
  game_mode = "map";
  
  /************* START OF TIMER TO DISCOUNT HEALTH POINTS *************/
  timer_health_disc = millis();
  
  /************* INTRO OF THE GAME *************/
  background(intro_bg);
    
  stroke(0);
  strokeWeight(1);
  fill(255,225);
  rect(width*0.30,height*0.10,width*0.40,height*0.20);
  rect(width*0.10,height*0.55,width*0.80,height*0.10);
  textAlign(CENTER);
  f = createFont("Arial", 50);                                //Text font and size
  fill(0);        
  textFont(f);
  text("COVID LIFE GAME", int(width*0.50),int(height*0.22));
  f = createFont("Arial", 30);                                //Text font and size        
  textFont(f);
  text("There are some rules you have to learn to get the vaccine and win the game. Good luck!", int(width*0.50),int(height*0.61));
  delay_msg= true;
  intro = true;
}


void draw ()
{
  if (delay_msg == true)
  {
    delay (5000);
    delay_msg = false;
    if ( (health_value <=0) || (immune == true) )
    {
      delay(5000);
      exit();
    }
    if (intro == true)
    {
      intro = false;
      delay (5000);
    }
  }
  
  background(0);

  game_mode = get_game_mode();
  if (game_mode == "map")
  {
    draw_map();
    draw_avatar();
    if (wear_mask == false)
    {
      msg_game (#FF0000,"msg_info", "If you don't wear a mask, you lose health points fastly. Go home to wear a mask!") ;
      if ( (millis() - timer_health_disc) > 1000 )        //Discount 2 health points/1 second
      {
        timer_health_disc = millis();
        health_value = health_value - 2;
      }
    }
    else if ( (millis() - timer_health_disc) > 3000 )    //Discount 1 health point/3 seconds
    {
      timer_health_disc = millis();
      health_value = health_value - 1;
    }
    
    if ( (home_visited == true) && (supermarket_visited == true) && (bar_visited == true) )
    {
      msg_game (#00FF00,"msg_info", "The Covid vaccine is already available. Go to the hospital!") ;
    }
    
  }
  
  else if (game_mode == "supermarket")
  {
    background(supermarket_bg);
    game_supermarket();
  }
  else if (game_mode == "bar")
  {
    background(bar_bg);
    game_bar();
  }
  else if (game_mode == "home")
  {
    background(home_bg);
    game_home();
  }
  else if (game_mode == "hospital")
  {
    background(hospital_bg);
    game_hospital();
  }
  
  if (health_value <=0)
  {
    background(0);
    draw_map();
    draw_avatar();
    
    // DISPLAY ALL VIRUS ON SCREEN
    for (int i = 0; i<60; i++) 
    {
      covid.add(new Coronavirus((int)random(0, width), (int)random(0, height), 40, 10));
    }
    iter = covid.iterator();
    while (iter.hasNext ()) 
    {
      Coronavirus virus = iter.next();
      virus.displayCoronavirus(); 
    }
    msg_game (#FF0000,"msg_win", "YOU ARE INFECTED! DO 14-DAYS QUARANTINE :(") ;
    delay_msg=true;
  }
  if (immune == true)
  {
    background(0);
    draw_map();
    draw_avatar();
    msg_game (#00FF00,"msg_win", "YOU ARE IMMUNE! BE HAPPY :)") ;
    delay_msg=true;
  }
  
  /************* DRAW THE HEALTH BAR *************/
  draw_health_bar();
}
