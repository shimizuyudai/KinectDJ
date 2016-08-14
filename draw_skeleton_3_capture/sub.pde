//主にインターフェイスの更新・描画のためのページ

void update(){
  
  if(wasNotKeyTouchCount > 1){
    oscKey = 0;
  }
  
  /*if(sequencerModeButtonNotTouchCount > 1){
    sequencerModeButtonTouch = false;
  }*/
      
  if(wasNotSwitchTouchCount > 1){
    wasSwitchTouch = false;
  }
  
  if(imageEffectSelectButtonWasNotTouchCount > 1){
    imageEffectSelectButtonWasTouch = false;
  }
  /*
  if(isRightHandPos.x == wasRightHandPos.x){
  fill(0);
  ellipse(width/2 + width/4, height/2,20,20);
  } 
  */  
         
  if(soundModeChaning){
    
      buttonBasePosX +=soundModeChangeingSpeed;
  
    if(buttonBasePosX <= -width){
    
    buttonBasePosX = -width;
    soundModeChangeingSpeed = 0;
    
    soundModeChaning = false;
    soundMode = 2;
  }
  
  if(buttonBasePosX >= 0){
    
    buttonBasePosX = 0;
    soundModeChangeingSpeed = 0;
    
    soundModeChaning = false;
    soundMode = 1;
  }
  /*
    switch(soundMode){
  case 1:
  if(soundModeChangeingSpeed < 0){
  buttonBasePosX +=soundModeChangeingSpeed;
  }
  if(buttonBasePosX <= -width){
    
    buttonBasePosX = -width;
    soundModeChangeingSpeed = 0;
    
    soundModeChaning = false;
    soundMode = 2;
  }
  break;
  
  case 2:
  
  if(soundModeChangeingSpeed > 0){
  buttonBasePosX +=soundModeChangeingSpeed;
  }
  
    if(buttonBasePosX >= 0){
    
    buttonBasePosX = 0; 
    soundModeChangeingSpeed = 0;
    
    soundModeChaning = false;
    soundMode = 1;
  }
  
  break;
  
  default:
  
  break;
  
    }//switch
    */
  }// if(soundModeChaning)
  
  soundModeChangeBarPosX = map(buttonBasePosX,-width,0,soundModeChangeBarBaseX,(soundModeChangeBarBaseX + soundModeChangeBarBaseW) - soundModeChangeBarW);
  
  //println(soundMode);
  //リズム
  
  for(int i = 0; i < buttonPosX.length; i++){
  buttonPosX[i] = buttonBasePosX + buttonSizeW*i;
}
  
  //白鍵
  
  keyBasePos = buttonBasePosX + width;
  
  for(int i = 0;i < whiteKeyPosX.length; i++){
  whiteKeyPosX[i] = keyBasePos + keyW*i;
}
  //黒鍵

 blackKeyPosX[0] = whiteKeyPosX[1] - blackKeyW/2; 
 blackKeyPosX[1] = whiteKeyPosX[2] - blackKeyW/2;
 blackKeyPosX[2] = whiteKeyPosX[4] - blackKeyW/2;
 blackKeyPosX[3] = whiteKeyPosX[5] - blackKeyW/2;
 blackKeyPosX[4] = whiteKeyPosX[6] - blackKeyW/2;
 blackKeyPosX[5] = whiteKeyPosX[8] - blackKeyW/2; 
 blackKeyPosX[6] = whiteKeyPosX[9] - blackKeyW/2;
 blackKeyPosX[7] = whiteKeyPosX[11] - blackKeyW/2; 
 blackKeyPosX[8] = whiteKeyPosX[12] - blackKeyW/2;
 blackKeyPosX[9] = whiteKeyPosX[13] - blackKeyW/2;  
 
 //----------------------------------------------------
  
  if(isPlay){
    
    playorstopButton = stopButton;
    oscPlay = 1;
    
  }else{
    
    playorstopButton = playButton;
    oscPlay = 0;
    
  }
  
  oscPlaySpeed = map(scratchSliderButtonPosX,scratchSliderBasePosX,scratchSliderBasePosX + scratchSliderW,-2,2);
  
}

//---------------------------------------------------------------------

void displayBaseDraw(){
  
  //------------インターフェイス関連-------------------
  noStroke();
    fill(buttonColor[0],127);
  rect(buttonPosX[0],0,buttonSizeW,buttonSizeH);
    fill(buttonColor[1],127);
  rect(buttonPosX[1],0,buttonSizeW,buttonSizeH);
    fill(buttonColor[2],127);
  rect(buttonPosX[2],0,buttonSizeW,buttonSizeH);
    fill(buttonColor[3],127);
  rect(buttonPosX[3],0,buttonSizeW,buttonSizeH);
  
  fill(labelColor,127);
  textSize(labelSize);
  for(int i = 0; i < buttonLabel.length; i ++){
  text(buttonLabel[i],buttonPosX[i] + buttonSizeW/2,buttonSizeH/2);
  }
  
  stroke(255,255,255,127);
  strokeWeight(3);
  line(scratchSliderBasePosX,scratchSliderBasePosY,
         scratchSliderBasePosX + scratchSliderW,scratchSliderBasePosY);
         
  noStroke();
  fill(200,200,200);
  ellipse(scratchSliderButtonPosX,scratchSliderBasePosY,scratchSliderButtonSize,scratchSliderButtonSize);
  
//キーボード
  
  //白鍵
  stroke(0,100);
  strokeWeight(2);
  fill(255,127);
  
  for(int i = 0;i < whiteKeyPosX.length; i++){
  rect(whiteKeyPosX[i],0,keyW,keyH);
}
  
  //黒鍵
  noStroke();
  fill(127);
  stroke(0,127);
  
  for(int i = 0;i < blackKeyPosX.length; i++){
  rect(blackKeyPosX[i],0,blackKeyW,blackKeyH);
}


//再生・停止ボタン

  tint(255,127);
  image(playorstopButton,playorstopButtonPosX,playorstopButtonPosY,playorstopButtonSizeW,playorstopButtonSizeH);
  
  //モード切り替えバー
  
  stroke(255,127);
  strokeWeight(3);
  line(soundModeChangeBarBaseX,soundModeChangeBarBaseY,soundModeChangeBarBaseX + soundModeChangeBarBaseW,soundModeChangeBarBaseY);
  fill(255,127);
  textSize(changeSoundModeLabelTextSize);
  text(changeSoundModeLabel,changeSoundModeLabelPosX,changeSoundModeLabelPosY);
  
  stroke(255,0,0,127);
  line(soundModeChangeBarPosX,soundModeChangeBarBaseY,soundModeChangeBarPosX + soundModeChangeBarW,soundModeChangeBarBaseY);
  
  stroke(0);
  strokeWeight(1);
  fill(255,127);
  for(int i = 0; i < imageEffectSelectBoxPosY.length; i++){
    rect(imageEffectSelectBoxPosX,imageEffectSelectBoxPosY[i],imageEffectSelectBoxW,imageEffectSelectBoxH);
    //text(,
  }
  
  stroke(255,0,0);
  strokeWeight(3);
  //fill(255,127);
  textSize(imageEffectSelectBoxH*0.3);
  for(int i = 0; i < imageEffectSelectLabels.length; i++){
    text(imageEffectSelectLabels[i], imageEffectSelectBoxPosX + imageEffectSelectBoxW/2, imageEffectSelectBoxPosY[i] + imageEffectSelectBoxH/2);
  }
  
  
  for(int i = 0; i < imageEffectSelectBoxPosY.length; i++){
    if((i+1) == imageMode){
      fill(255,0,0,127);
      noStroke();
      rect(imageEffectSelectBoxPosX,imageEffectSelectBoxPosY[i],imageEffectSelectBoxW,imageEffectSelectBoxH);
      fill(255,127);
      text(imageEffectSelectLabels[i], imageEffectSelectBoxPosX + imageEffectSelectBoxW/2, imageEffectSelectBoxPosY[i] + imageEffectSelectBoxH/2);
    }
  }
  
  int tempSequencerModeButtonOpacity;
  
  if(sequencerMode){
  tempSequencerModeButtonOpacity = 150;
  }else{
   tempSequencerModeButtonOpacity = 100; 
  }
  
  
  fill(255,255,0,tempSequencerModeButtonOpacity);
  stroke(127,127);
  strokeWeight(3);
  ellipse(sequencerModeButtonPosX,sequencerModeButtonPosY,sequencerModeButtonSizeW,sequencerModeButtonSizeH);
  
  fill(255,tempSequencerModeButtonOpacity);
  textSize(sequencerModeButtonLabelSize);
  for(int i = 0; i < sequencerModeButtonLabel.length; i++){
  text(sequencerModeButtonLabel[i], sequencerModeButtonLabelPos[i].x, sequencerModeButtonLabelPos[i].y);
  }
  
  if(sequencerModeButtonTouch){
    fill(255,255,0,200);
  stroke(127,127);
  strokeWeight(3);
  ellipse(sequencerModeButtonPosX,sequencerModeButtonPosY,sequencerModeButtonSizeW,sequencerModeButtonSizeH);
  fill(255,200);
  textSize(sequencerModeButtonLabelSize);
  for(int i = 0; i < sequencerModeButtonLabel.length; i++){
  text(sequencerModeButtonLabel[i], sequencerModeButtonLabelPos[i].x, sequencerModeButtonLabelPos[i].y);
  }
  
  }


  
  
    //------------インターフェイス関連-------------------
}









