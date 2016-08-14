void seaquencerDraw(){
  stroke(0);
  strokeWeight(1);
  fill(255,127);
  
    for(int i = 0; i < sequencerBoxPosY.length; i++){
      rect(sequencerBoxPosX[i],sequencerBoxPosY[i],sequencerBoxW,sequencerBoxH);
    }
    
}

void seaquencerBarDraw(){
  
  noStroke();
    fill(255,0,255,127);
    rect(sequencerReaderBarX,sequencerReaderBarY,sequencerReaderBarW,sequencerReaderBarH);
    
    if(sequencerCounter > speed){
    sequencerReaderBarX += sequencerBoxW;
    sequencerCounter = 0;
    //println(second());
    if(sequencerReaderBarX> width){
      sequencerReaderBarX = 0;
    }
    
    }
    
    sequencerCounter++;
  
}

void seaquencerImageDraw(){
  
  noStroke();
  //strokeWeight(1);
  fill(0,255,255,127);
  
   if(kinect.getNumberOfUsers() > 0){
    userMap = kinect.getUsersPixels(SimpleOpenNI.USERS_ALL);
    
    for(int h = 0; h < sequencerDrawnBool.length; h++){
      sequencerDrawnBool[h] = false;
    }
    
        for(int i = 0; i < 640; i+=10){
      for(int j = 0; j < 480; j+=10){
      if(userMap[i + j*640 ] != 0){
        for(int k = 0; k < sequencerBoxPosX.length; k++){
        if(i < sequencerBoxPosX[k] + sequencerBoxW && i > sequencerBoxPosX[k]){//x
          if(j < sequencerBoxPosY[k] + sequencerBoxH && j > sequencerBoxPosY[k]){//y
          if(sequencerDrawnBool[k] == false){
            rect(sequencerBoxPosX[k],sequencerBoxPosY[k],sequencerBoxW,sequencerBoxH);
            sequencerDrawnBool[k] = true;
          }
            }//x
           }//y
          // rect(i,j,20,20);
          }//for k
        }//ユーザピクセルなら
       }//i
     }//j
   }//ユーザが存在するなら 
}

void seaquencerCheck(){
  
  for(int i = 0; i < sequencerGridX.length; i++){
    if(sequencerReaderBarX + sequencerBoxW/2 < sequencerGridX[i] + sequencerBoxW && sequencerReaderBarX + sequencerBoxW/2 > sequencerGridX[i]){
      oscSeaquencerCheck(i);
    }
  }
  
}

void oscSeaquencerCheck(int tempGridNumber){
  
  //println(sequencerDrawnBool.length);
  
  for(int h = 0; h < oscSequencer.length; h++){
    oscSequencer[h] = 0;
  }
  
  int tempK = tempGridNumber*14;
  
  for(int j = 0; j < oscSequencer.length; j++){
        
        if(sequencerDrawnBool[tempK] == true){
        oscSequencer[j] = 1;
        }
        
        //println(tempK);
        tempK ++;
        
      }
      
}



