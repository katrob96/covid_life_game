class Box_lim 
{
  int lim_left, lim_right, lim_top, lim_bottom;
  boolean draw_check = false;
  boolean block_sel = false;
  boolean timer_run = false;
  float time_in_box;
  //boolean block_box_sel;
  Box_lim(int lim_L, int lim_R, int lim_T, int lim_B) {
    lim_left = lim_L;
    lim_right = lim_R;
    lim_top = lim_T;
    lim_bottom = lim_B;    
  }
  
  void rst_status()
  {
    draw_check = false;
    block_sel = false;
    timer_run = false;
  }
  
  boolean check_is_sel
    (float left_hand_x, float left_hand_y, float right_hand_x, float right_hand_y, int time_for_sel
     )
    
    
  {
    //CHECK IF THE INTRODUCED COORDINATES SELECT A DETERMINATED BOX
    if ( ((left_hand_x >= lim_left) && (left_hand_x <= lim_right) && (left_hand_y >= lim_top) && (left_hand_y <= lim_bottom)) || ((right_hand_x >= lim_left) && (right_hand_x <= lim_right) && (right_hand_y >= lim_top) && (right_hand_y <= lim_bottom)) )
    {
      if (timer_run == false)
      {
        time_in_box = millis();
        timer_run = true;
      }          
      if ( ( (millis()-time_in_box) >= time_for_sel ) && (block_sel==false) )
      {
        draw_check = !draw_check;    //Change the selection status (draw 'check' or not)
        timer_run = false;
        block_sel=true;
        return true;
      }
      else
      {
        return false;
      }
    }
    else
    {
      timer_run =false;
      block_sel = false;
      return false;
    }
  }
}

class Check 
{
  int[]line1 = {0,0,0,0};
  int[]line2 ={0,0,0,0};
  Check(int px, int py, int qx, int qy, int rx, int ry) {
    line1[0] = px;
    line1[1] = py;
    line1[2] = qx;
    line1[3] = qy; 
    line2[0] = qx;
    line2[1] = qy;
    line2[2] = rx;
    line2[3] = ry;   
  }
  
}

void msg_game (color fill, String type_txt, String txt)
{
  /*********************** SHOW THE GAME MESSAGE ACCORDING... ***********************/
  stroke(0);
  strokeWeight(1);
  fill(fill,175);
  textAlign(CENTER);
  switch (type_txt){
    case "msg_info":
      rect(width*0.20,height*0.55,width*0.60,height*0.10);
      f = createFont("Arial", 30);            //Text font and size 
      fill(0);        
      textFont(f);
      text(txt, int(width*0.50),int(height*0.61));
      break;
    case "msg_win":
      rect(width*0.15,height*0.40,width*0.70,height*0.20);
      f = createFont("Arial", 45);            //Text font and size
      fill(0);
      textFont(f);
      text(txt, int(width*0.50),int(height*0.52));
      break;
    default:
      break;
  }

  
}


void draw_avatar_pose()
{
  get_pose_keypoints();
  /*********************** DRAW THE AVATAR'S HEAD ACCORDING TO THE NOSE POSITION ***********************/
  float size_shoulder = abs(left_shoulder_X - right_shoulder_X);  //Avatar's size reference
  strokeWeight(4);
  stroke(30);
  fill(50);          
  ellipse(nose_X,nose_Y,size_shoulder*0.4,size_shoulder*0.6);

  /*********************** DRAW THE AVATAR'S BODY TRUNK ***********************/
  stroke(30);
  strokeWeight(4);
  fill(50);
  quad(right_shoulder_X,right_shoulder_Y,left_shoulder_X,left_shoulder_Y,left_hip_X,left_hip_Y,right_hip_X,right_hip_Y);
  
  /*********************** DRAW THE AVATAR'S ARMS ***********************/
  stroke(30);
  strokeWeight(40);
  line(right_shoulder_X,right_shoulder_Y,right_elbow_X,right_elbow_Y);
  line(right_elbow_X,right_elbow_Y,right_wrist_X,right_wrist_Y);
  line(left_shoulder_X,left_shoulder_Y,left_elbow_X,left_elbow_Y);
  line(left_elbow_X,left_elbow_Y,left_wrist_X,left_wrist_Y);
  
  /*********************** DRAW THE AVATAR'S JOINTS ***********************/
  stroke(30);
  strokeWeight(4);
  fill(50);
  //RIGHT SHOULDER
  ellipse(right_shoulder_X,right_shoulder_Y,size_shoulder*0.10,size_shoulder*0.10);
  //LEFT SHOULDER
  ellipse(left_shoulder_X,left_shoulder_Y,size_shoulder*0.10,size_shoulder*0.10);
  //RIGHT ELBOW
  ellipse(right_elbow_X,right_elbow_Y,size_shoulder*0.10,size_shoulder*0.10);
  //LEFT ELBOW
  ellipse(left_elbow_X,left_elbow_Y,size_shoulder*0.10,size_shoulder*0.10);
  //RIGHT WRIST
  ellipse(right_wrist_X,right_wrist_Y,size_shoulder*0.15,size_shoulder*0.15);
  //LEFT WRIST
  ellipse(left_wrist_X,left_wrist_Y,size_shoulder*0.15,size_shoulder*0.15);
}

String get_game_mode()
{
  /*********************** DETECTS THE COORDINATES TO ACCESS TO THE SUPERMARKET ***********************/
  // SUPERMARKET := rect(500,10,190,100);
  if ( (avatar_x+(avatar_width*0.5) <= 690) && (avatar_x+(avatar_width*0.5) >= 500) && (avatar_y+(avatar_height*0.5) <= 110) && (avatar_y+(avatar_height*0.5) >= 10) )
  {
    return "supermarket";    
  }
  
  /*********************** DETECTS THE COORDINATES TO BE IN GAME MODE "COVID KILLER" ***********************/
  else if ( (avatar_x+(avatar_width*0.5) <= width*0.77) && (avatar_x+(avatar_width*0.5) >= width*0.65) && (avatar_y+(avatar_height*0.5) <= height*0.85) && (avatar_y+(avatar_height*0.5) >= height*0.70) )
  {
    return "bar";    
  }
  else if ( (avatar_x+(avatar_width*0.5) <= 225) && (avatar_x+(avatar_width*0.5) >= 150) && (avatar_y+(avatar_height*0.5) <= 375) && (avatar_y+(avatar_height*0.5) >= 300) )
  {
    return "home";    
  }
  else if ( (avatar_x+(avatar_width*0.5) <= width*0.80) && (avatar_x+(avatar_width*0.5) >= width*0.65) && (avatar_y+(avatar_height*0.5) <= height*0.25) && (avatar_y+(avatar_height*0.5) >= height*0.10) )
  {
    return "hospital";    
  }  
  else
  {
    return "map";    
  }
}


void draw_health_bar()
{
  /**************************** DRAW THE HEALTH BAR ****************************/
  /* It is drawn at the end of the code so that the health bar is always in front of the rest of the drawings */
  stroke(25);
  strokeWeight(1);
  fill(9,13,250);
  textAlign(CENTER);
  f = createFont("Arial", 24);  //Text font and size
  textFont(f);
  text("HEALTH BAR", width*0.85+100,40);
  fill(25,255,25);
  rect(width*0.85,50,health_value*2,30);
  fill(255,25,25);
  rect((width*0.85)+(health_value*2),50,200-(health_value*2),30);
  /******************************************************************************/
}



void get_pose_keypoints()
{
  JSONArray humans = poneNet_data.getJSONArray("poses");    
  for(int h = 0; h < humans.size(); h++) {          //h = quantity of human in the camera
    JSONArray keypoints = humans.getJSONArray(h);   //keypoitns = coodinates of all points of a human
    
    //Now that we have one human, let's draw its body parts
    
    /**************************** NOSE ****************************/
    JSONArray nose = keypoints.getJSONArray(ModelUtils.POSE_NOSE_INDEX);  //stores the coordinates of a human's nose
    nose_X =nose.getFloat(0) * width;                                     //stores the first "nose" data that corresponds to the X coordinate of the nose
    nose_Y =nose.getFloat(1) * height;                                    //stores the second "nose" data that corresponds to the Y coordinate of the nose
    //println("NOSE: " + nose);
    
    /**************************** LEFT SHOULDER ****************************/
    JSONArray left_shoulder = keypoints.getJSONArray(ModelUtils.POSE_LEFT_SHOULDER_INDEX);
    left_shoulder_X =left_shoulder.getFloat(0) * width;
    left_shoulder_Y =left_shoulder.getFloat(1) * height;
    //println("LEFT SHOULDER: " + left_shoulder);
    
    /**************************** RIGHT SHOULDER ****************************/
    JSONArray right_shoulder = keypoints.getJSONArray(ModelUtils.POSE_RIGHT_SHOULDER_INDEX);
    right_shoulder_X =right_shoulder.getFloat(0) * width;
    right_shoulder_Y =right_shoulder.getFloat(1) * height;
    //println("ROGHT SHOULDER: " + right_shoulder);
    
    /**************************** LEFT ELBOW ****************************/
    JSONArray left_elbow = keypoints.getJSONArray(ModelUtils.POSE_LEFT_ELBOW_INDEX);
    left_elbow_X =left_elbow.getFloat(0) * width;
    left_elbow_Y =left_elbow.getFloat(1) * height;
    //println("LEFT ELBOW: " + left_elbow);
    
    /**************************** RIGHT ELBOW ****************************/
    JSONArray right_elbow = keypoints.getJSONArray(ModelUtils.POSE_RIGHT_ELBOW_INDEX);
    right_elbow_X =right_elbow.getFloat(0) * width;
    right_elbow_Y =right_elbow.getFloat(1) * height;
    //println("RIGHT ELBOW: " + right_elbow);
    
    /**************************** LEFT WRIST ****************************/
    JSONArray left_wrist = keypoints.getJSONArray(ModelUtils.POSE_LEFT_WRIST_INDEX);
    left_wrist_X =left_wrist.getFloat(0) * width;
    left_wrist_Y =left_wrist.getFloat(1) * height;
    //println("LEFT WRIST: " + left_wrist);
    
    /**************************** RIGHT WRIST ****************************/
    JSONArray right_wrist = keypoints.getJSONArray(ModelUtils.POSE_RIGHT_WRIST_INDEX);
    right_wrist_X =right_wrist.getFloat(0) * width;
    right_wrist_Y =right_wrist.getFloat(1) * height;
    //println("RIGHT WRIST: " + right_wrist);
    
    /**************************** LEFT HIP ****************************/
    JSONArray left_hip = keypoints.getJSONArray(ModelUtils.POSE_LEFT_HIP_INDEX);
    left_hip_X =left_hip.getFloat(0) * width;
    left_hip_Y =left_hip.getFloat(1) * height;
    //println("LEFT HIP: " + left_hip);
    
    /**************************** RIGHT HIP ****************************/
    JSONArray right_hip = keypoints.getJSONArray(ModelUtils.POSE_RIGHT_HIP_INDEX);
    right_hip_X =right_hip.getFloat(0) * width;
    right_hip_Y =right_hip.getFloat(1) * height;
    //println("RIGHT HIP: " + right_hip);
    
    /**************************** LEFT KNEE ****************************/
    JSONArray left_knee = keypoints.getJSONArray(ModelUtils.POSE_LEFT_KNEE_INDEX);
    left_knee_X =left_knee.getFloat(0) * width;
    left_knee_Y =left_knee.getFloat(1) * height;
    //println("LEFT KNEE: " + left_knee);
    
    /**************************** RIGHT KNEE ****************************/
    JSONArray right_knee = keypoints.getJSONArray(ModelUtils.POSE_RIGHT_KNEE_INDEX);
    right_knee_X =right_knee.getFloat(0) * width;
    right_knee_Y =right_knee.getFloat(1) * height;
    //println("RIGHT KNEE: " + right_knee);
    
    /**************************** LEFT ANKLE ****************************/
    JSONArray left_ankle = keypoints.getJSONArray(ModelUtils.POSE_LEFT_ANKLE_INDEX);
    left_ankle_X =left_ankle.getFloat(0) * width;
    left_ankle_Y =left_ankle.getFloat(1) * height;
    //println("LEFT ANKLE: " + left_ankle);
    
    /**************************** RIGHT ANKLE ****************************/
    JSONArray right_ankle = keypoints.getJSONArray(ModelUtils.POSE_RIGHT_ANKLE_INDEX);
    right_ankle_X =right_ankle.getFloat(0) * width;
    right_ankle_Y =right_ankle.getFloat(1) * height;
    //println("RIGHT ANKLE: " + right_ankle); 

  }
}



// OSC Event: listens to data coming from Runway
void oscEvent(OscMessage theOscMessage) {
  //LLEGA UN MENSAJE POR DATO: JSON, X, Y, Z
  if (theOscMessage.checkAddrPattern("/accelerometer/x")==true) {
    accelX = theOscMessage.get(0).floatValue();   //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
    //println("x: "+accelX);
  }
  
  else if (theOscMessage.checkAddrPattern("/accelerometer/y")==true) {
    accelY = theOscMessage.get(0).floatValue();  
    //println("y: "+accelY);
  }
  
  else if (theOscMessage.checkAddrPattern("/accelerometer/z")==true) {
    accelZ = theOscMessage.get(0).floatValue();  
    //println("z: "+accelZ);
  }
  else {
    //if (!theOscMessage.addrPattern().equals("/data")) return;
    //String dataString = theOscMessage.get(0).stringValue();
    //// We then parse it as a JSONObject
    //data = parseJSONObject(dataString);
    //println(data);
  }
}

// this is called when new Runway data is available
void runwayDataEvent(JSONObject runwayData){
  // point the sketch data to the Runway incoming data 
  poneNet_data = runwayData;  
}
