//チェック関連のサブルーチン郡ページ

void modeChangeCheck(PVector tempIsPos, PVector tempWasPos){//モード切り替えのチェック

 if(tempIsPos.x < soundModeChangeBarBaseX + soundModeChangeBarBaseW && tempIsPos.x > soundModeChangeBarBaseX){//x
    if(tempIsPos.y < soundModeChangeBarBaseY + MARGIN && tempIsPos.y > soundModeChangeBarBaseY - MARGIN){//y
      if(tempIsPos.x != tempWasPos.x){//前回と今回が同じでなければ
       soundModeChaning = true;
       soundModeChangeingSpeed = tempIsPos.x - tempWasPos.x;
      }
    }
  }
}

//---------------------------------------------------------------------------------------------------

void rythmButtonCheck(PVector tempIsPos,PVector tempWasPos){//リズムボタンのチェック
  
    for(int i = 0; i < buttonPosX.length; i++){
  if(mouseX < buttonPosX[i] + buttonSizeW && mouseX > buttonPosX[i]){
    if(mouseY < buttonSizeH && mouseY > 0){
    fill(buttonColor[i]);
    noStroke();
    rect(buttonPosX[i],0,buttonSizeW,buttonSizeH);
    fill(255);
    textSize(labelSize);
    text(buttonLabel[i],buttonPosX[i] + buttonSizeW/2,buttonSizeH/2);
    }
  }
  
  }
  
}

//---------------------------------------------------------------------------------------------------

void scratchButtonCheck(PVector tempPos){//スクラッチボタンのチェック
  
    if(mouseX < scratchSliderBasePosX + scratchSliderW && mouseX > scratchSliderBasePosX){ //スクラッチボタンのチェック
    if(mouseY < scratchSliderBasePosY + scratchSliderButtonSize && mouseY > scratchSliderBasePosY - scratchSliderButtonSize){
      //判定後の動作
    if(mouseX < scratchSliderBasePosX + scratchSliderW && mouseX > scratchSliderBasePosX){
      
      scratchSliderButtonPosX = mouseX;
      
    }else{
      if(mouseX > scratchSliderBasePosX + scratchSliderW){//最大値を超えたとき
        
        scratchSliderButtonPosX = scratchSliderBasePosX + scratchSliderW;
        
      }
      
      if(mouseX < scratchSliderBasePosX){//最小値を下回るとき
        
        scratchSliderButtonPosX = scratchSliderBasePosX;
        
      }
    }
    
    
    //判定後の動作終了
    }
  }
  //判定終了
  
}


//------------------------------------------------------------------------------------------  
  
void keybordCheck(PVector tempPos){
  
    boolean blackKeyPress = false;
 if(tempPos.y < buttonSizeH && tempPos.y > 0){ //鍵盤の上か
   if(tempPos.y < blackKeyH && tempPos.y > 0){//黒鍵Y
   for(int i = 0; i < blackKeyPosX.length; i++){
  if(tempPos.x < blackKeyPosX[i] + blackKeyW && tempPos.x > blackKeyPosX[i]){
    println("BLACKKEYPRESSED!");
      blackKeyPress = true;
      if(i == 0){
        oscKey = 2;
      }else if(i == 1){
        oscKey = 4;
      }else if(i == 2){
        oscKey = 7;
      }else if(i == 3){
        oscKey = 9;
      }else if(i == 4){
        oscKey = 11;
      }else if(i == 5){
        oscKey = 14;
      }else if(i == 6){
        oscKey = 16;
      }else if(i == 7){
        oscKey = 19;
      }else if(i == 8){
        oscKey = 21;
      }else if(i == 9){
        oscKey = 23;
      }
      
    }
   }//for
   }//黒鍵Y
   
   if(blackKeyPress == false){
   for(int i = 0; i < whiteKeyPosX.length; i++){
   if(tempPos.x < whiteKeyPosX[i] + keyW && tempPos.x > whiteKeyPosX[i]){
     
     if(i == 0){
       oscKey = 1;
     }else if(i == 1){
       oscKey = 3;
     }else if(i == 2){
       oscKey = 5;
     }else if(i == 3){
       oscKey = 6;
     }else if(i == 4){
       oscKey = 8;
     }else if(i == 5){
       oscKey = 10;
     }else if(i == 6){
       oscKey = 12;
     }else if(i == 7){
       oscKey = 13;
     }else if(i == 8){
       oscKey = 15;
     }else if(i == 9){
       oscKey = 17;
     }else if(i == 10){
       oscKey = 18;
     }else if(i == 11){
       oscKey = 20;
     }else if(i == 12){
       oscKey = 22;
     }else if(i == 13){
       oscKey = 24;
     }
     
   }//if
   }//for
   }
   
   wasNotKeyTouchCount = 0;
   
 }else{
   wasNotKeyTouchCount++;
 }//鍵盤の上か
  
  
  
  
}

//-------------------------------------------------------------------------------------------

void playOrStopButtonCheck(PVector tempPos){
  
  if(tempPos.x < playorstopButtonPosX + playorstopButtonSizeW && tempPos.x > playorstopButtonPosX){
    if(tempPos.y < playorstopButtonPosY + playorstopButtonSizeH && tempPos.y > playorstopButtonPosY){
    
    isPlay = !isPlay;
    wasSwitchTouch = true;
    
    }
  }

  
}

//--------------------------------------------------------------------------------------------

void scratchSliderButtonCheck(PVector tempPos){

  //判定開始
  if(tempPos.x < scratchSliderBasePosX + scratchSliderW && tempPos.x > scratchSliderBasePosX){ //スクラッチボタンのチェック
    if(tempPos.y < scratchSliderBasePosY + scratchSliderButtonSize && tempPos.y > scratchSliderBasePosY - scratchSliderButtonSize){
      //判定後の動作
    if(tempPos.x < scratchSliderBasePosX + scratchSliderW && tempPos.x > scratchSliderBasePosX){
      
      scratchSliderButtonPosX = tempPos.x;
      
    }else{
      if(tempPos.x > scratchSliderBasePosX + scratchSliderW){//最大値を超えたとき
        
        scratchSliderButtonPosX = scratchSliderBasePosX + scratchSliderW;
        
      }
      
      if(tempPos.x < scratchSliderBasePosX){//最小値を下回るとき
        
        scratchSliderButtonPosX = scratchSliderBasePosX;
        
      }
    }
    //判定後の動作終了
    }
  }
  //判定終了

}
//---------------------------------------------------------------------------------------------
void rythmPatternButtonCheck(PVector tempConvertedIsPos){//
if(!wasTap){

  if(tempConvertedIsPos.y < buttonSizeH && tempConvertedIsPos.y > 0){//y
  for(int i = 0; i < buttonPosX.length; i++){
   if(tempConvertedIsPos.x < buttonPosX[i] + buttonSizeW && tempConvertedIsPos.x > buttonPosX[i]){//x
   if(i == 0){
     oscKick = 1;
   }else if(i == 1){
     oscHihat = 1;
   }else if(i == 2){
     oscSnare = 1;
   }else if(i == 3){
     oscEffect = 1;
   }
    fill(buttonColor[i]);
    noStroke();
    rect(buttonPosX[i],0,buttonSizeW,buttonSizeH);
    fill(255);
    textSize(labelSize);
    text(buttonLabel[i],buttonPosX[i] + buttonSizeW/2,buttonSizeH/2);
    //println("TAPPING!");
   }//x
  }//for
  }//y
  
}
}
//---------------------------------------------------------------------------------------------
void imageModeButtonCheck(PVector tempPos){//イメージモードの切り替え
  
  
  
  
  
}

void sequencerButtonCheck(){
  
}

//------------シーケンサモードの切り替え-----------------
int checkSequencerMode(PVector tempConvertedPos){
  
  int tempInt = 1;

  if(tempConvertedPos.x < sequencerModeButtonPosX + sequencerModeButtonSizeW/2 && tempConvertedPos.x > sequencerModeButtonPosX - sequencerModeButtonSizeW/2){
    if(tempConvertedPos.y < sequencerModeButtonPosY + sequencerModeButtonSizeH/2 && tempConvertedPos.y > sequencerModeButtonPosY - sequencerModeButtonSizeH/2){
      tempInt = 0;
      sequencerModeButtonTouch = true;
     // println("touched");
    }
  }
  
  return tempInt;
  
}

void sequencerModeChange(PVector tempConvertedPos){
  
  if(tempConvertedPos.x < sequencerModeButtonPosX + sequencerModeButtonSizeW/2 && tempConvertedPos.x > sequencerModeButtonPosX - sequencerModeButtonSizeW/2){
    if(tempConvertedPos.y < sequencerModeButtonPosY + sequencerModeButtonSizeH/2 && tempConvertedPos.y > sequencerModeButtonPosY - sequencerModeButtonSizeH/2){
      sequencerMode = !sequencerMode;
      wasSwitchTouch = true;
      //sequencerModeButtonTouch = true;
     // println("touched");
    }
  }
  
}





  
