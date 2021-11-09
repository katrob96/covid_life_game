void draw_map()
{  
 background(#62dcf5);
 noStroke();
 
 // park area
 fill(107, 168, 61); //green
 rect(50,700,1580,300); 
 
 
 // green area
 rect(1050,0,580,1000);
 
 // residential area
 fill(107, 168, 61); //color green
 rect(50,0,900,650); //grass
 fill(125);//fill(48, 48, 47); //grey
 rect(100,0,600,200); //top small dark grey rectangle
 rect(100,200,800,400); // bottom big dark grey rectangle
 
 // home
 fill(194, 193, 153); // color home
 rect(150,300,75,75); // house base
 fill(161, 109, 74); // color roof
 triangle(150,300,225,300,187,263); //house roof
 fill(#62dcf5);
 rect(160,310,15,25); //window left
 rect(200,310,15,25); //window right
 fill(128, 99, 79); //color door
 rect(177,345,20,30); // door
 fill(107, 168, 61);// front yard grass
 rect(150,375,75,10); //front yard 
 //home text
 fill(#ffffff);
 String s="HOME"; 
 textAlign(CENTER);
 textSize(30);
 text(s, 187, 415); 
 //supermarket
 fill(208, 215, 217);
 rect(500,10,190,100);
 //trolley
 strokeWeight(2);
 stroke(0,0,0);
 line(550,60,650,45);//lineAB
 line(650,45,650,90);//lineBD
 line(550,90,650,90);//lineCD
 line(550,60,550,90);//lineAC
 strokeWeight(2);
 line(550,60,650,60);//lineAG
 line(550,75,650,75);//lineEF
 line(560,60,560,90);//lineSH
 line(570,60,570,90);//lineRI
 line(580,57,580,90);//lineQJ
 line(590,55,590,90);//etc
 line(600,53,600,90);
 line(610,51,610,90);
 line(620,49,620,90);
 line(630,47,630,90);
 line(640,45,640,90);
 fill(0,0,0);
 ellipse(570,100,10,10);
 ellipse(640,100,10,10);
 strokeWeight(4);
 line(650,45,660,40);
 fill(224, 67, 58);
 textAlign(CENTER);
 textSize(25);
 text("SUPERMARKET", 595, 35); 
 
 //more water area
 noStroke();
 fill(#62dcf5);
 rect(750,0,400,150);
 
 //more map
 image(tree,50,725);
 image(tree,150,725);
 image(tree,250,725);
 image(tree,350,725);
 image(tree,450,725);
 image(tree,550,725);
 image(tree,650,725);
 image(tree,750,725);
 image(tree,850,725);
 image(tree,950,725);
 image(tree,50,725+int(height*0.12));
 image(tree,150,725+int(height*0.12));
 image(tree,250,725+int(height*0.12));
 image(tree,350,725+int(height*0.12));
 image(tree,450,725+int(height*0.12));
 image(tree,550,725+int(height*0.12));
 image(tree,650,725+int(height*0.12));
 image(tree,750,725+int(height*0.12));
 image(tree,850,725+int(height*0.12));
 image(tree,950,725+int(height*0.12));
 image(bridge,950,500); 
 image(hospital,width*0.65,height*0.10);
 image(bar,width*0.65,height*0.70);
}

void draw_avatar()
{
  /*********************** IDENTIFIES THE AVATAR'S MOVEMENT ***********************/
  if ( (accelY/g >= high_accel_ratio) && (abs(accelX/g) <= low_accel_ratio) && (abs(accelZ/g) <= low_accel_ratio) )
  {
    move_avatar(0,0);
    println("PHONE: Repose position (vertical)");
  }  
  else if ( (accelZ/g >= high_accel_ratio) && (abs(accelX/g) <= low_accel_ratio) && (abs(accelY/g) <= low_accel_ratio) )
  {
    move_avatar(0,-10);
    println("PHONE: Up");
  }
  else if ( (-1*accelZ/g >= high_accel_ratio) && (abs(accelX/g) <= low_accel_ratio) && (abs(accelY/g) <= low_accel_ratio) )
  {
    move_avatar(0,10);
    println("PHONE: Down");
  }
  else if ( (accelX/g >= high_accel_ratio) && (abs(accelY/g) <= low_accel_ratio) && (abs(accelZ/g) <= low_accel_ratio) )
  {
    move_avatar(-10,0);
    println("PHONE: Left");
  }
  else if ( (-1*accelX/g >= high_accel_ratio) && (abs(accelY/g) <= low_accel_ratio) && (abs(accelZ/g) <= low_accel_ratio) )
  {
    move_avatar(10,0);
    println("PHONE: Right");
  }  
  else 
  {
    move_avatar(0,0);
    println("PHONE: Undefined position");
  }

  delay(100);
}

/*********************** FUNCTION THAT DRAWS THE AVATAR MOVING ***********************/
void move_avatar(int x_add, int y_add) {  
  noStroke();
  fill(0,255,0);
  if ( (avatar_x+avatar_width+x_add <= 750) && (avatar_x+x_add >= 50) && (avatar_y+y_add <= 150) && (avatar_y+y_add >= 0) )
  {
    avatar_x = avatar_x + x_add;
    avatar_y = avatar_y + y_add;
  }
  else if ( (avatar_x+avatar_width+x_add <= 950) && (avatar_x+x_add >= 50) && (avatar_y+avatar_height+y_add <= 650) && (avatar_y+y_add >= 150) )
  {
    avatar_x = avatar_x + x_add;
    avatar_y = avatar_y + y_add;
  }
  else if ( (avatar_x+avatar_width+x_add <= 1630) && (avatar_x+x_add >= 50) && (avatar_y+avatar_height+y_add <= 1000) && (avatar_y+y_add >= 700) )
  {
    avatar_x = avatar_x + x_add;
    avatar_y = avatar_y + y_add;
  }
  else if ( (avatar_x+avatar_width+x_add <= 1630) && (avatar_x+x_add >= 1150) && (avatar_y+y_add <= 150) && (avatar_y+y_add >= 0) )
  {
    avatar_x = avatar_x + x_add;
    avatar_y = avatar_y + y_add;
  }
  else if ( (avatar_x+avatar_width+x_add <= 1630) && (avatar_x+x_add >= 1050) && (avatar_y+y_add <= 700) && (avatar_y+y_add >= 150) )
  {
    avatar_x = avatar_x + x_add;
    avatar_y = avatar_y + y_add;
  }
  else if ( (avatar_x+avatar_width+x_add <= 1050+avatar_width) && (avatar_x+avatar_width+x_add >= 950) && (avatar_y+avatar_height+y_add <= 500+int(height*0.06)) && (avatar_y+avatar_height+y_add >= 500+int(height*0.02)) )
  {
    avatar_x = avatar_x + x_add;
    avatar_y = avatar_y + y_add;
  }
  
  image(avatar, avatar_x, avatar_y);
  if (wear_mask == true)
  {
    image(mask, avatar_x+(avatar_width/2), avatar_y+(avatar_height/2));
  }  
}
