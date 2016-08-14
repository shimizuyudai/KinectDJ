//マウスイベントによるインタフェイスのテストページ

void mouseDragged(){
  //判定開始
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
  
  //image(playButton,playorstopButtonPosX,playorstopButtonPosY,playorstopButtonSizeW,playorstopButtonSizeH);
  /*
  if(mouseX < playorstopButtonPosX + playorstopButtonSizeW && mouseX > playorstopButtonPosX){
    if(mouseY < playorstopButtonPosY + playorstopButtonSizeH && mouseY > playorstopButtonPosY){
    
    isPlay = !isPlay;
    
    }
  }
  */
  
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



  if(mouseX < soundModeChangeBarBaseX + soundModeChangeBarBaseW && mouseX > soundModeChangeBarBaseX){
    if(mouseY < soundModeChangeBarBaseY + MARGIN && mouseY > soundModeChangeBarBaseY - MARGIN){
       soundModeChaning = true;
       soundModeChangeingSpeed = mouseX -pmouseX;
    }
  }

  
  
  
  
  
}

void mousePressed(){
  
   // if(!imageEffectSelectButtonWasTouch){
    if(mouseX < imageEffectSelectBoxPosX + imageEffectSelectBoxW && mouseX > imageEffectSelectBoxPosX){//x
    imageEffectSelectButtonWasNotTouchCount = 0;
    for(int i = 0; i < imageEffectSelectBoxPosY.length; i++){
      if(mouseY < imageEffectSelectBoxPosY[i] + imageEffectSelectBoxH && mouseY > imageEffectSelectBoxPosY[i]){//y
        //println(i);
        imageMode = i + 1;
      }
    }
  }
  
  
  
  if(mouseX < playorstopButtonPosX + playorstopButtonSizeW && mouseX > playorstopButtonPosX){
    if(mouseY < playorstopButtonPosY + playorstopButtonSizeH && mouseY > playorstopButtonPosY){
    
    isPlay = !isPlay;
    
    }
  }
  /*
  for(int i = 0; i < buttonPosX.length; i++){
  if(mouseX < buttonPosX[i] + buttonSizeW && mouseX > buttonPosX[i]){
    if(mouseY < buttonSizeH && mouseY > 0){
    fill(buttonColor[i]);
    rect(buttonPosX[i],0,buttonSizeW,buttonSizeH);
    text(buttonLabel[i],buttonPosX[i] + buttonSizeW/2,buttonSizeH/2);
    }
  }
  
  }
  */
  
  boolean blackKeyPress = false;
 if(mouseY < buttonSizeH && mouseY > 0){ //鍵盤の上か
   if(mouseY < blackKeyH && mouseY > 0){//黒鍵Y
   for(int i = 0; i < blackKeyPosX.length; i++){
  if(mouseX < blackKeyPosX[i] + blackKeyW && mouseX > blackKeyPosX[i]){
   // println("BLACKKEYPRESSED!");
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
   if(mouseX < whiteKeyPosX[i] + keyW && mouseX > whiteKeyPosX[i]){
     
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
   
 }else{
   oscKey = 0;
 }//鍵盤の上か

  
}

void keyPressed(){
  
  if(key == CODED){
    if(keyCode == DOWN){
      imageMode++;
      if(imageMode > 4){
        imageMode = 1;
      }
    }
    
   if(keyCode == UP){
    sequencerMode = !sequencerMode;
   }
  }
  
}
