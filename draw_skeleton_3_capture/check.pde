//メインループから来るチェック動作を条件等でサブルーチンに振り分けるページ
void check(PVector tempIsHandPos,PVector tempWasHandPos,PVector tempIsShoulderPos,PVector tempWasTapPos){
  //println(tempIsShoulderPos.z - tempIsHandPos.z);
  PVector convertedIsHandPos = new PVector();
  kinect.convertRealWorldToProjective(tempIsHandPos, convertedIsHandPos);
  
  PVector convertedWasHandPos = new PVector();
  kinect.convertRealWorldToProjective(tempWasHandPos, convertedWasHandPos);
  
  //-----------------------------インプット状態------------------------------------------------------------------------------
  
  if(tempIsShoulderPos.z - tempIsHandPos.z > DistHandAndShoulderThreshold){//肩と手の距離の比較（インプット状態の時）
  
  wasNotSwitchTouchCount = 0;
  /*
  textSize(40);
  fill(255,0,0);
  float textPrintDist = tempIsShoulderPos.z - tempIsHandPos.z;
  text("INPUT",width/2,height/2 - 50);
  */
  
  //---------------シーケンサモード切り替え-------------------
  
  if(wasSwitchTouch == false){
  sequencerModeChange(convertedIsHandPos);
  }
  
  //----------イメージエフェクト切り替えボタンのチェック---------------------
  
  if(!imageEffectSelectButtonWasTouch){
    if(convertedIsHandPos.x < imageEffectSelectBoxPosX + imageEffectSelectBoxW && convertedIsHandPos.x > imageEffectSelectBoxPosX){//x
    imageEffectSelectButtonWasNotTouchCount = 0;
    for(int i = 0; i < imageEffectSelectBoxPosY.length; i++){
      if(convertedIsHandPos.y < imageEffectSelectBoxPosY[i] + imageEffectSelectBoxH && convertedIsHandPos.y > imageEffectSelectBoxPosY[i]){//y
        //println(i);
        imageMode = i + 1;
        
      }
    }
  }
  }
  
  //-----------スクラッチスライダのチェック----------------
  if(isPlay){
  scratchSliderButtonCheck(convertedIsHandPos);
  }
  //----------再生・停止ボタンのチェック----------------
  if(wasSwitchTouch == false){
  playOrStopButtonCheck(convertedIsHandPos);
  }
  //-------------モード切り替えバーのチェック--------
  /*
  fill(255,0,0,127);
  ellipse(convertedIsHandPos.x,convertedIsHandPos.y,20,20);
  fill(0,0,255,127);
  ellipse(convertedWasHandPos.x,convertedWasHandPos.y,20,20);
  */
  if(convertedIsHandPos.x == convertedWasHandPos.x){
    
    //println("failed");
    
  }
  modeChangeCheck(convertedIsHandPos, convertedWasHandPos);
  
  }else{//インプット状態でないとき
    wasNotSwitchTouchCount++;
    imageEffectSelectButtonWasNotTouchCount++;
  };
  
  
  
  //-----------上部ボタンのチェック----------------
switch(soundMode) {
  
  case 1: //リズムパターン
  /*
  textSize(40);
  fill(255,0,0);
  //float textPrintDist = tempIsShoulderPos.z - tempIsHandPos.z;
  text(tempWasTapPos.z - tempIsHandPos.z,width/2,height/2 - 50);
  */
  //rythmPatternButtonCheck(convertedIsHandPos);
  //println(tempWasTapPos.z - tempIsHandPos.z);
  
  if(tempWasTapPos.z - tempIsHandPos.z > tappingThreshold){//tapしているとき
  
  if(convertedIsHandPos.y < buttonSizeH){//y
  rythmPatternButtonCheck(convertedIsHandPos);
  //println(tempWasTapPos.z - tempIsHandPos.z);
  wasTap = true;
  
  }//y
  
  }else{
  wasTap = false;
  }
  
  oscKey = 0;
  
    break;
    
  case 2: //キーボード
  
  if(tempIsShoulderPos.z - tempIsHandPos.z > DistHandAndShoulderThreshold){
  
    keybordCheck(convertedIsHandPos);
  
  }else{
    
    wasNotKeyTouchCount++;
    
  
  }
  
  
  
  
  
    break;
    
    default:
    
    break;
    
}//switch
  

  
}
