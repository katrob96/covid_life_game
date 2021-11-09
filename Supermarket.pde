
boolean shopping_mode = false;
int cont_items = 0;
boolean supermarket_visited = false;

/*********************** BOXES ***********************/
Box_lim box0,box1,box2,box3,box4,box5,box6,box7,box8,box9,box10,box11;
Check check_in_box_0, check_in_box_1, check_in_box_2, check_in_box_3, check_in_box_4, check_in_box_5, check_in_box_6, check_in_box_7, check_in_box_8, check_in_box_9, check_in_box_10, check_in_box_11;

Box_lim[] boxs = {box0,box1,box2,box3,box4,box5,box6,box7,box8,box9,box10,box11};
Check[] list_checks = {check_in_box_0, check_in_box_1, check_in_box_2, check_in_box_3, check_in_box_4, check_in_box_5, check_in_box_6, check_in_box_7, check_in_box_8, check_in_box_9, check_in_box_10, check_in_box_11};




void game_supermarket()
{
  color fill_rect = 0;
  String msg = "";
  
  /*********************** SHOW THE 'EXIT' IMAGE ***********************/
  image(exit,int(width*0.30),0);   //Box exit
  strokeWeight(10);
  fill(0);
  textAlign(CENTER);
  f = createFont("Arial", 24);
  textFont(f);
  text("EXIT", int(width*0.37),int(height*0.02));
  
  
  
  /*********************** DRAW THE ENVIRONMENT OF BEFORE "SHOPPING" **************************/
  if (shopping_mode == false)
  {
    //SHOW THE IMAGE OF THE GEL
    image(gel,int(width*0.80),int(height*0.80));   //Box 10
    strokeWeight(10);
    fill(0);
    textAlign(CENTER);
    f = createFont("Arial", 24);
    textFont(f);
    text("GEL", int(width*0.90),int(height*0.82));
    
    msg = "Please, you have to use gel to access to the supermarket";
    fill_rect = 200; 
  }
  
  /*********************** DRAW THE ENVIRONMENT OF GAME MODE = SUPERMARKET ***********************/
  else
  {
    //SHOW THE ITEMS IN THE SCREEN
    //PImage gel, fruits_veget, flour, legumes, pasta,face_masks,beer, cleaning,dairy, toilet_paper, exit,pay;
    strokeWeight(10);
    fill(0);
    textAlign(CENTER);
    f = createFont("Arial", 24);
    textFont(f);    
    image(legumes,0,0);                                     //Box 1
    text("LEGUMES", int(width*0.10),int(height*0.02));
    image(face_masks,0,int(height*0.20));                   //Box 2
    text("FACE MASKS", int(width*0.10),int(height*0.22));
    image(meat,0,int(height*0.40));                         //Box 3
    text("MEAT", int(width*0.10),int(height*0.42));
    image(fruits_veget,0,int(height*0.60));                 //Box 4
    text("FRUITS AND VEGETABLES", int(width*0.10),int(height*0.62));
    image(dairy,0,int(height*0.80));                        //Box 5
    text("DAIRY PRODUCTS", int(width*0.10),int(height*0.82));
    image(snacks,int(width*0.80),0);                        //Box 6
    text("SNACKS", int(width*0.90),int(height*0.02));
    image(beer,int(width*0.80),int(height*0.20));           //Box 7
    text("BEER", int(width*0.90),int(height*0.22));
    image(chocolate,int(width*0.80),int(height*0.40));      //Box 8
    text("CHOCOLATE", int(width*0.90),int(height*0.42));
    image(bakery,int(width*0.80),int(height*0.60));         //Box 9
    text("BAKERY", int(width*0.90),int(height*0.62));
    image(toilet_paper,int(width*0.80),int(height*0.80));   //Box 10
    text("TOILET PAPER", int(width*0.90),int(height*0.82));
    
    //SHOW THE BOX OF 'PAYMENT'
    image(pay,int(width*0.55),0);                  //Box 11
    text("PAY", int(width*0.62),int(height*0.02));
    
    //SHOW THE 'CHECK' IF THE ITEM IS SELECTED   
    for (int i=1; i<=10;i=i+1)
    {
      if (boxs[i].draw_check == true)
      {
        strokeWeight(20);  //DRAWS A GREEN CHECK
        stroke(0,255,0);
        line(list_checks[i].line1[0],list_checks[i].line1[1],list_checks[i].line1[2],list_checks[i].line1[3]);
        line(list_checks[i].line2[0],list_checks[i].line2[1],list_checks[i].line2[2],list_checks[i].line2[3]);
      }
    }    
    msg = "Select 5 items you'd have to pass a lockdown";
    fill_rect = 200;
  }
  
  /*********************** DRAW THE AVATAR POSE AND DETECT THE SELECTION OF THE BOXES ***********************/
  if (poneNet_data != null) 
  {
    draw_avatar_pose();
    if (wear_mask ==true)
    {
      int prop = int(abs(left_shoulder_X-right_shoulder_X));
      image(mask,nose_X-prop*0.15,nose_Y-prop*0.1,prop*0.3,prop*0.2);
    }
    
    //CHECK IF THE LEFT OR RIGHT HAND SELECT THE 'EXIT' OF THE SUPERMARKET
    if ( boxs[0].check_is_sel(left_wrist_X, left_wrist_Y, right_wrist_X, right_wrist_Y, 1500) == true )
    {       
      avatar_x = 400;     //Position the avatar in front of the supermarket
      avatar_y = 100;
      shopping_mode = false;
      for (int i=0;i<=11;i++) 
      {
        boxs[i].rst_status();
      }
      timer_health_disc = millis();
      game_mode = "map";  //Change the game mode
    }
    else
    {
      //CHECK IF THE LEFT OR RIGHT HAND SELECT THE 'GEL' (POSITION OF THE BOX 10)
      if ( (shopping_mode == false) && (boxs[10].check_is_sel(left_wrist_X, left_wrist_Y, right_wrist_X, right_wrist_Y, 1500) == true) )
      {
        shopping_mode = true;
        
        cont_items = 0;
        for (int i=0;i<=11;i++) 
        {
          boxs[i].rst_status();
        }
        boxs[10].block_sel = true;
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
        supermarket_visited = true;        
      }
      
      else if (shopping_mode == true)
      {
        //msg = "Select 5 items to pass the Covid pandemic";
        //CHECK IF THE LEFT OR RIGHT HAND SELECT/DESELECT AN ITEM
        for (int i=1;i<=10;i++)
        {
          boolean flag = boxs[i].check_is_sel(left_wrist_X, left_wrist_Y, right_wrist_X, right_wrist_Y, 1500);
        }        

        //CHECK IF THE LEFT OR RIGHT HAND SELECT/DESELECT 'PAY'
        if (boxs[11].check_is_sel(left_wrist_X, left_wrist_Y, right_wrist_X, right_wrist_Y, 1500) == true)
        {
          cont_items = 0;
          //pay_status = true;
          for (int i=1;i<=10;i++)
          {
            if (boxs[i].draw_check == true)
            {
              cont_items++;              
            }
          }
          if (cont_items==5)
          {
            int health_points = 0;
            if (boxs[1].draw_check == true) {health_points = health_points + 5;}
            if (boxs[2].draw_check == true) {health_points = health_points + 5;}
            if (boxs[3].draw_check == true) {health_points = health_points + 3;}
            if (boxs[4].draw_check == true) {health_points = health_points + 3;}
            if (boxs[5].draw_check == true) {health_points = health_points + 5;}
            if (boxs[6].draw_check == true) {health_points = health_points - 5;}
            if (boxs[7].draw_check == true) {health_points = health_points - 10;}
            if (boxs[8].draw_check == true) {health_points = health_points - 5;}
            if (boxs[9].draw_check == true) {health_points = health_points - 5;}
            if (boxs[10].draw_check == true) {health_points = health_points + 0;}
            if (health_value + health_points <= 100)
            {
              health_value = health_value + health_points;
            }
            else
            {
              health_value = 100;
            }
            if (health_points > 0)
            {
              msg = "Great! Your items are healthy. You get " + health_points + " health points";
              fill_rect = #00FF00;
              delay_msg = true;
            }
            else 
            {
              msg = "Your items are not healthy. You lose " + health_points + " health points";
              fill_rect = #FF0000;
              delay_msg = true;
            }
            avatar_x = 400;     //Position the avatar in front of the supermarket
            avatar_y = 100;
            shopping_mode = false;
            for (int i=0;i<=11;i++) 
            {
              boxs[i].rst_status();
            }
            timer_health_disc = millis();
            game_mode = "map";  //Change the game mode
          }
          else
          {
            msg = "YOU MUST SELECT 5 ITEMS BEFORE PAYING";
            fill_rect = #E36B2C;
            delay_msg = true;
          }
        }
      }
    }
  }
  
  /************** DISPLAYS THE APPROPRIATE GAME MESSAGE **********/
  //(at the final of the condition)
  msg_game (fill_rect,"msg_info", msg);

}
