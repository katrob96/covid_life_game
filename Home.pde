boolean gel_applied = false;
boolean left_hand_taking;
boolean right_hand_taking;
boolean clothes_washed = false;
boolean clothes_taked = false;
boolean home_visited = false;
  
void game_home()
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
  
  
  
  /*********************** DRAW THE ENVIRONMENT OF BEFORE "ACCESSING TO HOME" **************************/
  if (gel_applied == false)
  {
    wear_mask = false;
    //SHOW THE IMAGE OF THE GEL
    image(gel,int(width*0.80),int(height*0.80));   //Box 10
    fill(0);
    textAlign(CENTER);
    f = createFont("Arial", 24);
    textFont(f);
    text("GEL", int(width*0.90),int(height*0.82));
  }
  
  /*********************** DRAW THE ENVIRONMENT OF GAME MODE = HOME ***********************/
  else 
  {   
    //SHOW THE WASHING MACHINE
    image(washing_machine,int(width*0.80),int(height*0.80));   //Box 10
    fill(0);
    textAlign(CENTER);
    f = createFont("Arial", 24);
    textFont(f);    
    text("WASHING MACHINE", int(width*0.90),int(height*0.82));
    
    //SHOW THE MASKS
    if (wear_mask == false)
    {
      image(face_masks,0,0);   //Box 1
      text("MASKS", int(width*0.10),int(height*0.02));
    }
    
    //SHOW THE CLOTHES
    if (clothes_taked == false)
    {
      image(clothes,0,int(height*0.80));                 //Box 5
      text("DIRTY CLOTHES", int(width*0.10),int(height*0.82));       
    }
    else if ( (wear_mask == true) && (clothes_taked == true) )
    {
      avatar_x = 250;     //Position the avatar in front of the house
      avatar_y = 450;
      //Reset the variables
      gel_applied = false;
      clothes_washed = false;
      clothes_taked = false;
      left_hand_taking = false;
      right_hand_taking = false;
      for (int i=0;i<=11;i++) 
      {
        boxs[i].rst_status();
      }
      timer_health_disc = millis();
      game_mode = "map";  //Change the game mode
    }
  }
  
  
  /*********************** DRAW THE AVATAR POSE AND DETECT THE SELECTION OF THE BOXES ***********************/
  if (poneNet_data != null) 
  {
    draw_avatar_pose();
    if (wear_mask ==true)
    {
      int prop = int(abs(left_shoulder_X-right_shoulder_X));
      image(mask,nose_X-prop*0.175,nose_Y-prop*0.05,prop*0.35,prop*0.25);
    }
    //CHECK IF THE LEFT OR RIGHT HAND SELECT THE 'EXIT' AT HOME
    if ( boxs[0].check_is_sel(left_wrist_X, left_wrist_Y, right_wrist_X, right_wrist_Y, 1500) == true )
    { 
      avatar_x = 250;     //Position the avatar in front of the house
      avatar_y = 450;
      //Reset the variables
      gel_applied = false;
      clothes_washed = false;
      clothes_taked = false;
      left_hand_taking = false;
      right_hand_taking = false;
      for (int i=0;i<=11;i++) 
      {
        boxs[i].rst_status();
      }
      timer_health_disc = millis();
      game_mode = "map";  //Change the game mode
    }
    else
    {
      msg = "Use gel to enter home";
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
        home_visited = true;
      }
      else if (gel_applied == true)
      {
        msg = "Take the mask";
        fill_rect = 200;
        
        //CHECK IF THE LEFT OR RIGHT HAND SELECT THE MASKS
        if ( (wear_mask == false) && (boxs[1].check_is_sel(left_wrist_X, left_wrist_Y, right_wrist_X, right_wrist_Y, 1500) == true) )
        {
          msg = "Great! Wearing the mask protects you from Covid";
          fill_rect = #00FF00;
          delay_msg = true;
          wear_mask = true;
          for (int i=0;i<=11;i++) 
          {
            boxs[i].rst_status();
          }
        }
        
        else if (clothes_washed == false)
        {
          msg = "Do laundry to desinfect your clothes. Put them in the washing machine";
          fill_rect = 200;
          //CHECK IF THE LEFT HAND SELECT THE CLOTHES
          if ( clothes_taked == false )
          {
            //CHECK IF THE LEFT OR RIGHT HAND SELECT THE DIRTY CLOTHES
            if( boxs[5].check_is_sel(left_wrist_X, left_wrist_Y, right_wrist_X, right_wrist_Y, 1500) == true )
            {
              clothes_taked = true;
              if ((left_wrist_X >= 0) && (left_wrist_X <= width*0.2) && (left_wrist_Y >= height*0.8) && (left_wrist_Y <= height))
              {
                left_hand_taking = true;
              }
              else 
              {
                right_hand_taking = true;
              }
              for (int i=0;i<=11;i++) 
              {
                boxs[i].rst_status();
              }
            }            
          }
          if (clothes_taked == true)
          {
            if (left_hand_taking == true)
            {
              image (clothes, int(left_wrist_X)-int(width*0.1),int(left_wrist_Y)-int(height*0.1));
              //CHECK IF THE LEFT HAND SELECT THE WASHING MACHINE
              if (boxs[10].check_is_sel(left_wrist_X, left_wrist_Y, left_wrist_X, left_wrist_Y, 1500) == true)
              {
                msg = "Great! You get 15 health points for washing your clothes";
                fill_rect = #00FF00;
                delay_msg = true;
                if (health_value + 15 <= 100)
                {
                  health_value = health_value + 15;
                }
                else
                {
                  health_value = 100;
                }
                clothes_washed = true;
              }
            }          
            else if (right_hand_taking == true)
            {
              image (clothes, int(right_wrist_X)-int(width*0.1),int(right_wrist_Y)-int(height*0.1));
              //CHECK IF THE RIGHT HAND SELECT THE WASHING MACHINE
              if (boxs[10].check_is_sel(right_wrist_X, right_wrist_Y, right_wrist_X, right_wrist_Y, 1500) == true)
              {
                msg = "Great! You get 15 health points for washing your clothes";
                fill_rect = #00FF00;
                delay_msg = true;
                if (health_value + 15 <= 100)
                {
                  health_value = health_value + 15;
                }
                else
                {
                  health_value = 100;
                }
                clothes_washed = true;
              }
            }          
          }
        }
      }
    }
  }
  
  /************** DISPLAYS THE APPROPRIATE GAME MESSAGE **************/
  //(at the final of the condition)
  msg_game (fill_rect,"msg_info", msg) ;
}
