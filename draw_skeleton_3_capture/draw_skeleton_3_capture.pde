import SimpleOpenNI.*;
import oscP5.*;
import netP5.*;
import processing.opengl.*;

SimpleOpenNI kinect;

OscP5 oscP5;
NetAddress myRemoteLocation;

//----------
boolean trackingUser = false;
boolean existUser = false;

//-----------------------------------シーケンサ-----------------------------------

int sequencerBoxNUM = 16*14;//シーケンサ（縦x横);
float sequencerBoxPosX[] = new float[sequencerBoxNUM];
float sequencerBoxPosY[] = new float[sequencerBoxNUM];
float sequencerBoxW;
float sequencerBoxH;
float sequencerReaderBarX;
float sequencerReaderBarY;
float sequencerReaderBarW;
float sequencerReaderBarH;
float sequencerReaderBarSpeed;
float sequencerGridX[] = new float[16];

boolean sequencerDrawnBool[] = new boolean[sequencerBoxNUM];
int oscSequencer[] = new int[14];

float sequencerModeButtonPosX;
float sequencerModeButtonPosY;
float sequencerModeButtonSizeH;
float sequencerModeButtonSizeW;
float sequencerModeButtonLabelSize;
String sequencerModeButtonLabel[] = {"sequencer","Mode"};
PVector sequencerModeButtonLabelPos[] = {new PVector(0,0),new PVector(0,0)};
boolean sequencerModeButtonTouch;
int sequencerModeButtonNotTouchCount;

boolean sequencerMode = false;

float BPM = 120*4;
float speed;
float FRAMERATE = 30;
float sequencerCounter;



//---------------------画像エフェクト--------------------------

int[] userMap;
float imageEffectSelectBoxBasePosY;
float imageEffectSelectBoxPosX;
float imageEffectSelectBoxPosY[] = new float[4];
float imageEffectSelectBoxW;
float imageEffectSelectBoxH;

boolean imageEffectSelectButtonWasTouch;
int imageEffectSelectButtonWasNotTouchCount;

String imageEffectSelectLabels[] = {"RGB","Depth","Pixelation","Outline"};

//-------OSC関連---------------

int oscPlay;
int oscKick;
int oscHihat;
int oscSnare;
int oscEffect;
int oscKey;
float oscPlaySpeed;

//====================インターフェイス==============================

int soundMode = 1;
int imageMode = 1;
float MARGIN;

//--------モード切り替え関連------------------

float soundModeChangeBarBaseX;//x
float soundModeChangeBarBaseY;//y
float soundModeChangeBarBaseW;//w
float soundModeChangeBarH;//h

String changeSoundModeLabel = "changeSoundMode";
float changeSoundModeLabelPosX;
float changeSoundModeLabelPosY;
float changeSoundModeLabelTextSize;

boolean soundModeChaning;
float  soundModeChangeingSpeed;

float soundModeChangeBarPosX;
float soundModeChangeBarW;
//--------モード切り替え関連------------------

//-------------リズム関連------------------

float buttonSizeW;
float buttonSizeH;

float buttonBasePosX = 0;
float buttonPosX[] = new float[4];
color buttonColor[] = new color[4];
String buttonLabel[] = {"kick","hihat","snare","effect"};
color labelColor = color(255,255,255);
float labelSize;
float selectThreshold;//選択・選択解除の閾値

//boolean wasTap;

//-------------リズム関連終了----------------

//---------------スクラッチ関連----------------

float scratchSliderBasePosX;
float scratchSliderBasePosY;
float scratchSliderW;

float scratchSliderButtonSize = 20;
float scratchSliderButtonPosX;

//-------------キーボード関連--------------
int whiteKeyNUM = 14;//白鍵の数
int blackKeyNUM = 10;//黒鍵の数
float whiteKeyPosX[] = new float[whiteKeyNUM];
float blackKeyPosX[] = new float[blackKeyNUM];
float keyW;
float keyH;
float blackKeyW;
float blackKeyH;
float keyBasePos;

int wasNotKeyTouchCount = 0;

//-------------キーボード関連終了--------------
//----------再生・停止-----------------

PImage playButton;
PImage stopButton;

PImage playorstopButton;

float playorstopButtonPosX;
float playorstopButtonPosY;
float playorstopButtonSizeW;
float playorstopButtonSizeH;

boolean isPlay;

boolean wasSwitchTouch = false;
int wasNotSwitchTouchCount;

//----------再生・停止終了-----------------

//------------動き関連----------------
int wasPosRefreshCountThrshold = 10;//何フレームごとにwasPosを更新するか
int wasPosRefreshCounter = 0;//カウンター

PVector wasRightHandPos;
PVector wasLeftHandPos;
PVector isRightHandPos;
PVector isLeftHandPos;
PVector isRightShoulderPos;
PVector isLeftShoulderPos;
PVector isTorsoPos;

float DistHandAndShoulderThreshold = 450; //どれほど手と肩が離れていれば入力状態と判断するか

//タップ関連
int wasTapPosRefreshCounter;
int wasTapPosRefreshCountThrshold = 5;
PVector wasTapRightHandPos;
PVector wasTapLeftHandPos;
boolean wasTap;
float tappingThreshold = 30;

//------------動き関連終了----------------


//----------インターフェイス部分終了-----------------

void setup(){
  
  frameRate(FRAMERATE);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableRGB();
  kinect.enableUser(SimpleOpenNI.SKEL_PROFILE_ALL);
  kinect.setMirror(true);
  size(640,480);
  //fill(255,0,0);
  //-------------osc関連---------
  oscP5 = new OscP5(this, 7000);
  oscP5.plug(this, "getData", "/test1");
  myRemoteLocation = new NetAddress("127.0.0.1", 7001);
  
  
  
  //---------インターフェイス----------------
  
  textAlign(CENTER,CENTER);
 
buttonSizeW = width/4;
buttonSizeH = buttonSizeW/2.5;

for(int i = 0; i < buttonPosX.length; i++){
  buttonPosX[i] = buttonBasePosX + buttonSizeW*i;
}

buttonColor[0] = color(255,0,100);
buttonColor[1] = color(255,200,0);
buttonColor[2] = color(0,200,255);
buttonColor[3] = color(0,200,0);

labelSize = buttonSizeW/6;

//スクラッチ
 scratchSliderW = width/2;
 scratchSliderBasePosX = (width - scratchSliderW)/2;
 scratchSliderBasePosY = height/2;
 scratchSliderButtonPosX = (scratchSliderBasePosX + scratchSliderW/2);

MARGIN = buttonSizeH/4;

oscPlaySpeed = map(scratchSliderButtonPosX,scratchSliderBasePosX,scratchSliderBasePosX + scratchSliderW,-2,2);

//-------------キーボード関連----------------
//白鍵
keyW = width/(whiteKeyNUM*0.99);
keyH = buttonSizeH;
blackKeyW = keyW*0.6;
blackKeyH = keyH*0.6;

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

//-------------キーボード関連終了----------------

//---------------再生スイッチ--------------------
playButton = loadImage("playButton.png");
stopButton = loadImage("stopButton.png");
playorstopButton = playButton;
isPlay = false;


playorstopButtonSizeW = buttonSizeW/2;
playorstopButtonSizeH = playButton.height*(playorstopButtonSizeW/playButton.width);
playorstopButtonPosX = scratchSliderBasePosX - MARGIN - playorstopButtonSizeW;
playorstopButtonPosY = scratchSliderBasePosY - playorstopButtonSizeH/2;


//int selectedOpacity = 255;

  //-----------モード切り替え関連------
  soundModeChangeBarBaseX = buttonSizeW*3 + MARGIN;
  soundModeChangeBarBaseY = buttonSizeH + MARGIN*2;
  soundModeChangeBarBaseW = buttonSizeW -MARGIN*2;
  soundModeChangeBarH = MARGIN*2;
  
  changeSoundModeLabelPosX = soundModeChangeBarBaseX + soundModeChangeBarBaseW/2;
  changeSoundModeLabelPosY = soundModeChangeBarBaseY - MARGIN;
  changeSoundModeLabelTextSize = soundModeChangeBarBaseW/10;//changeSoundModeLabel.length();
  
  soundModeChangeBarW = soundModeChangeBarBaseW/5;
  soundModeChangeBarPosX = soundModeChangeBarBaseX;
  //-----------------------------------
  imageEffectSelectBoxW = playorstopButtonSizeW;
  imageEffectSelectBoxH = buttonSizeH/1.5;
  
  imageEffectSelectBoxBasePosY = height/2 - imageEffectSelectBoxH*2;
  imageEffectSelectBoxPosX = scratchSliderBasePosX + scratchSliderW + MARGIN;
  for(int i = 0; i < imageEffectSelectBoxPosY.length; i++){
    imageEffectSelectBoxPosY[i] = imageEffectSelectBoxBasePosY + imageEffectSelectBoxH*i;
  }
  //imageEffectSelectBoxPosY[] = new float[4];
  
  //------------シーケンサ--------------------
  
  sequencerBoxW = width/16;
  sequencerBoxH = height/14;
  
  int tempSeauencerCountI = 0;
  int tempSeauencerCountJ = 0;
  
  for(int i = 0; i < sequencerBoxPosY.length; i++){
    sequencerBoxPosY[i] = tempSeauencerCountI;
    sequencerBoxPosX[i] = /*keyBasePos + width + */tempSeauencerCountJ;
    tempSeauencerCountI +=sequencerBoxH;
    if((i + 1)%14 == 0){
      tempSeauencerCountI = 0;
      tempSeauencerCountJ +=sequencerBoxW;
    }
  }
  
   
   sequencerReaderBarY = 0;
   sequencerReaderBarW = sequencerBoxW;
   sequencerReaderBarH = height;
   sequencerReaderBarSpeed = width/160;
   sequencerReaderBarX = 0;
   
   for(int i = 0; i < sequencerGridX.length; i++){
     sequencerGridX[i] = sequencerBoxW*i;
   }
   
   speed = FRAMERATE*(60/BPM);
   
   //println(speed);
   

 sequencerModeButtonSizeW = sequencerBoxW*2 -3;
 sequencerModeButtonSizeH = sequencerModeButtonSizeW -3;
 sequencerModeButtonPosX = width/2;
 sequencerModeButtonPosY = height/2 - ((sequencerModeButtonSizeW/2) + scratchSliderButtonSize + (scratchSliderButtonSize/2));
 
 sequencerModeButtonLabelSize = sequencerModeButtonSizeW/(sequencerModeButtonLabel[0].length()*0.6);
 sequencerModeButtonLabelPos[0].x = sequencerModeButtonPosX;
 sequencerModeButtonLabelPos[0].y = sequencerModeButtonPosY - sequencerModeButtonLabelSize/2;
 sequencerModeButtonLabelPos[1].x = sequencerModeButtonPosX;
 sequencerModeButtonLabelPos[1].y = sequencerModeButtonPosY + sequencerModeButtonLabelSize/2;


  

//----------インターフェイス部分終了-----------------

//---------動き関連------------------

wasRightHandPos = new PVector(0,0);
wasLeftHandPos = new PVector(0,0);
isRightHandPos = new PVector(0,0);
isLeftHandPos = new PVector(0,0);
isTorsoPos = new PVector(0,0);
isRightShoulderPos = new PVector(0,0);
isLeftShoulderPos = new PVector(0,0);

//タップ関連
wasTapRightHandPos = new PVector(0,0);
wasTapLeftHandPos = new PVector(0,0);

}

void draw(){
  
 background(0);
 
sequencerModeButtonNotTouchCount = 0;
  
  //-------kinectの処理---------------
  kinect.update();
  tint(255,255);
  
  PImage rgbImage = kinect.rgbImage();
  PImage depthImage = kinect.depthImage();
  //image(kinect.depthImage(),0,0);
  switch(imageMode){
    case 1:
    image(rgbImage,0,0);
    break;
    
    case 2:
    image(depthImage,0,0);
    break;
    
    case 3:
    silhouetteDraw();
    //outlineDraw();
    break;
    
    case 4:
    outlineDraw();
    break;
    
    default:
    
    break;
  }
  
  
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  
  if(userList.size() > 0){//ユーザが存在しているときの処理
    //println("user");
    existUser = true;
    int userId = userList.get(0);
    
    if(kinect.isTrackingSkeleton(userId)){//ユーザをトラッキングしているときの処理
    
    trackingUser = true;
    
      drawSkeleton(userId);
       
         kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HAND,isRightHandPos);//右手の現在位置の更新
         kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HAND,isLeftHandPos);//左手の現在位置の更新
         kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_SHOULDER,isRightShoulderPos);//右肩の現在位置の更新
         kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_SHOULDER,isLeftShoulderPos);//左肩の現在位置の更新
         //kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HAND,isTorsoPos);//腰の現在位置の更新
         
         //チェック・更新
         check(isRightHandPos,wasRightHandPos,isLeftShoulderPos,wasTapRightHandPos);//isRightShoulderPos);//右手に関するチェック
         check(isLeftHandPos,wasLeftHandPos,isRightShoulderPos,wasTapLeftHandPos);//左手に関するチェック
         
       if(wasPosRefreshCounter > wasPosRefreshCountThrshold){//何フレームごとかに前回ポイントの更新
       
         wasPosRefreshCounter = 0;//カウンターをリセット
         
         wasRightHandPos.x = isRightHandPos.x;//右手の前回位置の更新
         wasRightHandPos.y = isRightHandPos.y;//右手の前回位置の更新
         wasRightHandPos.z = isRightHandPos.z;//右手の前回位置の更新
         
         wasLeftHandPos.x = isLeftHandPos.x;//左手の前回位置の更新
         wasLeftHandPos.y = isLeftHandPos.y;//左手の前回位置の更新
         wasLeftHandPos.z = isLeftHandPos.z;//左手の前回位置の更新
         
         //fill(0);
         //ellipse(width/2 + width/4, height/2 -50,20,20);
         
       }
       
       if(wasTapPosRefreshCounter > wasTapPosRefreshCountThrshold){//タップ用のカウンターリセット
         
         wasTapRightHandPos.x = isRightHandPos.x;//右手の前回位置の更新
         wasTapRightHandPos.y = isRightHandPos.y;//右手の前回位置の更新
         wasTapRightHandPos.z = isRightHandPos.z;//右手の前回位置の更新
         
         wasTapLeftHandPos.x = isLeftHandPos.x;//左手の前回位置の更新
         wasTapLeftHandPos.y = isLeftHandPos.y;//左手の前回位置の更新
         wasTapLeftHandPos.z = isLeftHandPos.z;//左手の前回位置の更新
         
       }
       
       wasPosRefreshCounter++;//カウンター
       wasTapPosRefreshCounter++;//タップカウンター
       
       
       
       
    }//ユーザをトラッキングしているときの処理終了
    
    else{
    
   if(trackingUser){
   wasRightHandPos = new PVector(0,0);
   wasLeftHandPos = new PVector(0,0);
   isRightHandPos = new PVector(0,0);
   isLeftHandPos = new PVector(0,0);
   isTorsoPos = new PVector(0,0);
   isRightShoulderPos = new PVector(0,0);
   isLeftShoulderPos = new PVector(0,0);
   wasTapRightHandPos = new PVector(0,0);
   wasTapLeftHandPos = new PVector(0,0);
   trackingUser = false; 
   }
   
  }//ユーザをトラッキングしていないときの処理終了
  
  }//ユーザが存在しているときの処理終了
  else{
    existUser = false;
  }
  //----------kinectの処理終了--------------
  
  
  if(!sequencerMode){
  update();//更新
  
  displayBaseDraw();//描画
  
  }else{
    
  update();//更新
  
  displayBaseDraw();//描画
  
  seaquencerDraw();
  
  seaquencerImageDraw();
  
  seaquencerBarDraw();
  
  seaquencerCheck();
  
  }
  
  /*for(int i = 0; i < oscSequencer.length; i++){
    println(oscSequencer[i]);
  }*/
  
  //print(isPlay);
  
  //oscPlaySpeed = map(scratchSliderButtonPosX,scratchSliderBasePosX,scratchSliderBasePosX + scratchSliderW,-2,2);
   OscMessage myMessage = new OscMessage("/test");
   myMessage.add(oscPlay);//add message
   myMessage.add(oscKick);//add message
   myMessage.add(oscHihat);//add message
   myMessage.add(oscSnare);//add message
   myMessage.add(oscEffect);//add message
   myMessage.add(oscKey);//add message
   myMessage.add(oscPlaySpeed);//add message
   if(sequencerMode){
     for(int i = 0; i < oscSequencer.length; i++){
       myMessage.add(oscSequencer[i]);
     }
   }else{
     for(int i = 0; i < oscSequencer.length; i++){
       myMessage.add(0);
     }
   }
  oscP5.send(myMessage, myRemoteLocation); 
 
 //println("TorF" + sequencerModeButtonNotTouchCount );
 
 oscPlay = 0;
 oscKick = 0;
 oscHihat = 0;
 oscSnare = 0;
 oscEffect = 0;
// oscKey = 0;

}//draw


    
  

  
  
