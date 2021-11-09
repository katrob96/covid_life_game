boolean bar_visited = false;

import java.util.Iterator;
PImage virus;

ArrayList<Coronavirus> covid = new ArrayList<Coronavirus>();
Iterator<Coronavirus> iter;
static int numcovids = 30;
static int covidRadius = 30;

int points_virus_game;
boolean create_virus_random = true;

/************* THIS CLASS REPRESENTS A SPACE ROCK *************/
class Coronavirus {

  PVector loc;
  PVector velocity;
  int radius;  

  Coronavirus(int tempXPos, int tempYPos, int tempRadius, int tempFallRate) {
    loc = new PVector(tempXPos, tempYPos);
    velocity = new PVector(0,tempFallRate);
    radius = tempRadius;    
  }

  /************* DISPLAY THE CORONAVIRUS ON SCREEN *************/
  void displayCoronavirus() {
    if (loc.y>0)
    {
      noStroke();
      fill(0, 255, 0);
      image(virus,loc.x, loc.y, radius, radius);
      //textSize(60);
      //ellipse(loc.x, loc.y, radius, radius);
    }
  }

  /************* INCREMENT THE 'Y' POSITION OF THE CORONAVIRUS TO SIMULATE "FALLING" *************/
  void fall() {
    loc.add(velocity);
  }
  
  /************* RETURN THE 'X' POSITION OF THE CORONAVIRUS *************/
  float getXPos() {
    return loc.x;
  }
  
  /************* RETURN THE 'Y' POSITION OF THE CORONAVIRUS *************/
  float getYPos() {
    return loc.y;
  }
}

void game_bar()
{
  color fill_rect = 0;
  String msg = "";
  
  
  /************* SHOW THE 'EXIT' IMAGE *************/
  image(exit,int(width*0.30),0);        //Box: 'exit'
  fill(0);
  textAlign(CENTER);
  f = createFont("Arial", 24);
  textFont(f);
  text("EXIT", int(width*0.37),int(height*0.02));
  
  
  
  /************************** DRAW THE ENVIRONMENT OF BEFORE "ACCESSING TO THE BAR" **************************/
  if (gel_applied == false)
  {
    //MUESTRA LA IMAGEN DEL GEL DESINFECTANTE
    image(gel,int(width*0.80),int(height*0.80));   //Box 10
    fill(0);
    textAlign(CENTER);
    f = createFont("Arial", 24);
    textFont(f);
    text("GEL", int(width*0.90),int(height*0.82));
    msg = "Please, you have to use gel to access to the bar";
    fill_rect = 200; 
    
    /************************** DRAW THE AVATAR POSE AND DETECT THE SELECTION OF THE BOXES **************************/
    if (poneNet_data != null) 
    {
      draw_avatar_pose();
      if (wear_mask == true)
      {
        int prop = int(abs(left_shoulder_X-right_shoulder_X));
        image(mask,nose_X-prop*0.175,nose_Y-prop*0.05,prop*0.35,prop*0.25);
      }
      //CHECK IF THE LEFT OR RIGHT HAND SELECT THE 'EXIT' IN THE BAR
      if ( boxs[0].check_is_sel(left_wrist_X, left_wrist_Y, right_wrist_X, right_wrist_Y, 1500) == true )
      { 
        avatar_x = int(width*0.60);        //Position the avatar in front of the hospital
        avatar_y = int(height*0.65);
        //Reset the variables
        gel_applied = false;
        for (int i=0;i<=11;i++) 
        {
          boxs[i].rst_status();
        }
        timer_health_disc = millis();
        game_mode = "map";  //Change the game mode
      }
      else
      {
        msg = "Please, you have to use gel to access to the bar";
        fill_rect = 200;
        //CHECK IF THE LEFT OR RIGHT HAND SELECT THE 'GEL' (POSITION OF THE BOX 10)
        if ( (gel_applied == false) && (boxs[10].check_is_sel(left_wrist_X, left_wrist_Y, right_wrist_X, right_wrist_Y, 1500) == true) )
        {
          gel_applied = true;        
          if (health_value + 5 <= 100)
          {
            health_value = health_value + 5;
          }
          else
          {
            health_value = 100;
          }
          msg = "Great! You get 5 health points for using gel";
          fill_rect = #00FF00;
          delay_msg = true;
          for (int i=0;i<=11;i++) 
          {
            boxs[i].rst_status();
          }
        }
      }
    }
    
    //DISPLAYS THE APPROPRIATE GAME MESSAGE
    //(at the final of the condition)
    msg_game (fill_rect,"msg_info", msg) ;
  }
  
  else if (gel_applied == true)
  {
    bar_visited=true;
    game_covid_killer();
  }
}

void game_covid_killer()
{ 
  
  
  if (poneNet_data != null) 
  {
    draw_avatar_pose();
    image(gel_game,left_wrist_X-int(width*0.05), left_wrist_Y-int(height*0.075));
    image(gel_game, right_wrist_X-int(width*0.05), right_wrist_Y-int(height*0.075));
    if (wear_mask == true)
    {
      int prop = int(abs(left_shoulder_X-right_shoulder_X));
      image(mask,nose_X-prop*0.175,nose_Y-prop*0.05,prop*0.35,prop*0.25);
    }
    if (create_virus_random == true)
    {
      create_virus_random = false;
      for (int i = 0; i<numcovids; i++) 
      {
        covid.add(new Coronavirus((int)random(0, width), (int)random(-height, -100), covidRadius, 4));
      }
      msg_game (200,"msg_info", "You are in a highest contagion risk area. Kill viruses with gel");
      delay_msg = true;
    }
    else
    {
      iter = covid.iterator();
      while (iter.hasNext ()) 
      {
        Coronavirus virus = iter.next();
        virus.fall();
        virus.displayCoronavirus();
        
        if (virus.getYPos() > height+virus.radius) 
        {
          iter.remove();      
        }
        else if ( ((abs(virus.getXPos()-left_wrist_X) < width*0.05) && (abs(virus.getYPos()-left_wrist_Y) < height*0.07) ) || ( (abs(virus.getXPos()-right_wrist_X) < width*0.05) && (abs(virus.getYPos()-right_wrist_Y) < height*0.07) ) ) 
        {
          //Left or right wrist has touched the virus
          iter.remove();
          fill(250,0,0);
          ellipse(virus.getXPos(),virus.getYPos(),50,50);
          points_virus_game = points_virus_game + 1;      
        }
      }
      if ( covid.isEmpty()  )
      {
        msg_game (#00FF00,"msg_info", "You have killed " + str(points_virus_game) + " virus. You get "  + str(points_virus_game) + " health points");
        delay_msg = true;
        if (health_value + points_virus_game <= 100)
        {
          health_value = health_value + points_virus_game;
        }
        else
        {
          health_value = 100;
        }
        
        avatar_x = int(width*0.60);        //Position the avatar in front of the hospital
        avatar_y = int(height*0.65);
        points_virus_game = 0;
        create_virus_random = true;
        gel_applied = false;
        timer_health_disc = millis();
        game_mode = "map";  //Change the game mode
        
      }
      else
      {
        msg_game (200,"msg_info", "You have killed " + str(points_virus_game) );
      }
    }
  }
  
}
