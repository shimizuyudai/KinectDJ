//イメージエフェクトの作成ページ
void depthDraw(){
  
  
  
}

void outlineDraw(){
  
  if(kinect.getNumberOfUsers() > 0){
  stroke(0,255,0);
  strokeWeight(5);
    userMap = kinect.getUsersPixels(SimpleOpenNI.USERS_ALL);
    boolean wasUserPixel = false;
    boolean isUserPixel = false;
    for(int i = 0; i < userMap.length; i++){
      if(userMap[i] != 0){
        isUserPixel = true;
      }else{
        isUserPixel = false;
      }
      
      if(isUserPixel != wasUserPixel){
        point(i%640,i/640);
      }
      
      wasUserPixel = isUserPixel;
      
    }
  }
}

void silhouetteDraw(){
  if(kinect.getNumberOfUsers() > 0){
  stroke(0,255,0);
  strokeWeight(10);
    userMap = kinect.getUsersPixels(SimpleOpenNI.USERS_ALL);
   // for(int j = 0; j < 640; j+=10){
     
    for(int i = 0; i < 640; i+=10){
      for(int j = 0; j < 480; j+=10){
      if(userMap[i + j*640 ] != 0){
        point(i,j);
      }
      }
      
     }
   // }
  }
}
