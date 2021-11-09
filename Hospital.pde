boolean immune;

void game_hospital()
{ 
  color fill_rect = 0;
  String msg = "";
  
  
  /*********************** SHOW THE 'EXIT' IMAGE ***********************/
  image(exit,int(width*0.30),0);   //Box exit
  fill(0);
  textAlign(CENTER);
  f = createFont("Arial", 24);
  textFont(f);
  text("EXIT", int(width*0.37),int(height*0.02));
  
  
  
  /*********************** DRAW THE ENVIRONMENT OF BEFORE "ACCESSING TO THE HOSPITAL" **************************/
  if (gel_applied == false)
  {
    //SHOW THE IMAGE OF THE GEL
    image(gel,int(width*0.80),int(height*0.80));   //Box 10
    fill(0);
    textAlign(CENTER);
    f = createFont("Arial", 24);
    textFont(f);
    text("GEL", int(width*0.90),int(height*0.82));
    msg = "Please, you have to use gel to access to the hospital";
    fill_rect = 200; 
  }
  
  /*********************** DRAW THE ENVIRONMENT OF GAME MODE = HOSPITAL ***********************/
  else if ( (home_visited == true) && (supermarket_visited == true) && (bar_visited == true) )
  {   
    //SHOW THE IMAGE OF THE VACCINE
    image(vaccine,int(width*0.80),int(height*0.40));   //Box 7
    fill(0);
    textAlign(CENTER);
    f = createFont("Arial", 24);
    textFont(f);
    text("COVID VACCINE", int(width*0.90),int(height*0.42)); 
  }  
  
  /*********************** DRAW THE AVATAR POSE AND DETECT THE SELECTION OF THE BOXES ***********************/
  if (poneNet_data != null) 
  {
    draw_avatar_pose();
    if (wear_mask == true)
    {
      int prop = int(abs(left_shoulder_X-right_shoulder_X));
      image(mask,nose_X-prop*0.175,nose_Y-prop*0.05,prop*0.35,prop*0.25);
    }
    //CHECK IF THE LEFT OR RIGHT HAND SELECT THE 'EXIT' OF THE HOSPITAL
    if ( boxs[0].check_is_sel(left_wrist_X, left_wrist_Y, right_wrist_X, right_wrist_Y, 1500) == true )
    {
      avatar_x = int(width*0.60);        //Position the avatar in front of the hospital
      avatar_y = int(height*0.20);
      //Reset las variables
      gel_applied = false;
      immune = false;
      for (int i=0;i<=11;i++) 
      {
        boxs[i].rst_status();
      }
      timer_health_disc = millis();
      game_mode = "map";  //Change the game mode
    }
    else
    {
      msg = "Please, you have to use gel to access to the hospital";
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
        //hospital_visited = true;
      }
      else if ( (gel_applied == true) && (home_visited == true) && (supermarket_visited == true) && (bar_visited == true) )
      {
        msg = "Move your shoulder to the vaccine to be immune";
        fill_rect = 200;
        
        ///CHECK IF THE LEFT OR RIGHT SHOULDER SELECT/DESELECT THE VACCINE
        if ( (immune == false) && (boxs[8].check_is_sel(left_shoulder_X, left_shoulder_Y, right_shoulder_X, right_shoulder_Y, 1500) == true) )
        {
          immune = true;
        }        
        
      }
      else if (gel_applied == true) 
      {
        msg = "The vaccine is not ready yet";
        fill_rect = #FF0000;
        delay_msg = true;
        avatar_x = int(width*0.60);        //Position the avatar in front of the hospital
        avatar_y = int(height*0.20);
        //Reset the variables
        gel_applied = false;
        immune = false;
        for (int i=0;i<=11;i++) 
        {
          boxs[i].rst_status();
        }
        timer_health_disc = millis();
        game_mode = "map";  //Change the game mode
      }
      
    }
  }
  
  /************** DISPLAYS THE APPROPRIATE GAME MESSAGE **************/
  //(at the final of the condition)
  msg_game (fill_rect,"msg_info", msg) ;
}
