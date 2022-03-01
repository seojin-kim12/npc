-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"

gompoint = 0
rabbitpoint = 0
squirrelpoint = 0
index = 1
smoked = 1

soundTable = {

   --배경음악
   playSound= audio.loadSound( "음악/배경음/게임 플레이 음악.mp3" ),
   chattSound= audio.loadSound( "음악/배경음/배경음 2.mp3" ),
   firstSound= audio.loadSound( "음악/배경음/도입부 배경음.mp3" ),
   finalSound= audio.loadSound( "음악/배경음/떠날때 배경음.mp3" ),
 
   --효과음
   --막대기 케이크 볼 안에 넣는 소리
   putSound = audio.loadSound( "음악/효과음/002_휙(만화적).mp3" ),
   --마우스
    mouseSound = audio.loadSound( "음악/효과음/버튼 2.mp3" ),
    --볼에 넣는 소리
    dropSound=audio.loadSound( "음악/효과음/바닐라 엑기스 떨어지는 소리.mp3" ),
    --칼질
    chopSound = audio.loadSound( "음악/효과음/칼질 하는 소리.mp3" ),
    --크림
    creamSound= audio.loadSound( "음악/효과음/크림.mp3" ),
    --섞는 소리
    mix1Sound= audio.loadSound( "음악/효과음/휘휘 젓는 소리 (1).mp3" ),
    mix2Sound= audio.loadSound( "음악/효과음/휘휘 젓는 소리(2).mp3" ),
    mix3Sound= audio.loadSound( "음악/효과음/휘휘 젓는 소리 (3).mp3" ),
    --굽는 소리
    grillSound= audio.loadSound( "음악/효과음/굽는 소리.wav" ),
    --물 끓는 소리
    boilSound= audio.loadSound( "음악/효과음/물 끓는 소리.flac" ),
    --반죽소리
    doughSound= audio.loadSound( "음악/효과음/반죽 붓는 소리.mp3" ),
    --조미료
    seasoningSound= audio.loadSound( "음악/효과음/조미료.mp3" ),
    --타이머
    timerSound= audio.loadSound( "음악/효과음/타이머.mp3" ),
    --오븐
    ovenOpenSound= audio.loadSound( "음악/효과음/오븐 여는 소리.mp3" ),
    ovenCloseSound= audio.loadSound( "음악/효과음/오븐 닫는 소리.mp3" ),
    --효과음
    tingSound= audio.loadSound( "음악/효과음/팅 소리.mp3" ),
    button1Sound= audio.loadSound( "음악/효과음/버튼 1.wav" ),
    button3Sound= audio.loadSound( "음악/효과음/버튼 3.mp3" ),
    button4Sound= audio.loadSound( "음악/효과음/버튼 4.mp3" ),
    --성공실패
    successSound= audio.loadSound( "음악/효과음/성공시 효과음.mp3" ),
    failSound= audio.loadSound( "음악/효과음/실패시 효과음.mp3" ),
 }
audio.setVolume( 0.1 )

-- event listeners for tab buttons:
local function onFirstView( event )
	composer.gotoScene( "startView" )
end





onFirstView()	-- invoke first tab button's onPress event manually






