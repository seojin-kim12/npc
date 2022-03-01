-----------------------------------------------------------------------------------------
--
-- acornCake5.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
    
	sum = rabbitpoint + squirrelpoint + gompoint
    --배경
	local background = display.newImage("이미지/배경/주방.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	--리플레이 버튼--
	local rbutton = display.newImageRect("이미지/엔딩/버튼_리플레이.png", 200*1.8, 150*1)
	rbutton.x = display.contentWidth *0.5
	rbutton.y = display.contentHeight *0.82
	sceneGroup:insert(rbutton)
	rbutton.alpha=0

	--최종배경
	local fbackground = {}
	fbackground[1] = display.newImage("이미지/엔딩/엔딩1(실패).png")
	fbackground[2] = display.newImage("이미지/엔딩/엔딩2(한개성공).png")
	fbackground[3] = display.newImage("이미지/엔딩/엔딩3(두개성공).png")
	fbackground[4] = display.newImage("이미지/엔딩/엔딩4(세개성공).png")

	for i=1,4 do
		fbackground[i].x, fbackground[i].y = display.contentWidth / 2, display.contentHeight / 2
        fbackground[i].alpha=0
        sceneGroup:insert(fbackground[i])
	end

    --캐릭터
    local c = {}
    c[1] = display.newImage("이미지/캐릭터/주인공토끼1_기본.png",display.contentWidth * 0.8,display.contentHeight / 2)
    c[2] = display.newImage("이미지/캐릭터/주인공토끼1_난감.png",display.contentWidth * 0.8,display.contentHeight / 2)
    c[3] = display.newImage("이미지/캐릭터/토끼2_웃음.png",display.contentWidth * 0.2,display.contentHeight / 2)
    c[4] = display.newImage("이미지/캐릭터/토끼2_난감.png",display.contentWidth * 0.2,display.contentHeight / 2)
    c[5] = display.newImage("이미지/캐릭터/다람쥐_웃음.png",display.contentWidth * 0.2,display.contentHeight / 2)
    c[6] = display.newImage("이미지/캐릭터/다람쥐_난감.png",display.contentWidth * 0.2,display.contentHeight / 2)
    c[7] = display.newImage("이미지/캐릭터/곰_웃음.png",display.contentWidth * 0.2,display.contentHeight / 2)
    c[8] = display.newImage("이미지/캐릭터/곰_난감.png",display.contentWidth * 0.2,display.contentHeight / 2)

    for i=1,8 do
        c[i].alpha=0
        sceneGroup:insert(c[i])
	end

	--채팅창 배열
	local t={}
	t[1] = display.newImage("이미지/채팅창/채팅창토끼.png",1920,1080)
	t[2] = display.newImage("이미지/채팅창/채팅창다람쥐.png",1920,1080)
	t[3] = display.newImage("이미지/채팅창/채팅창곰.png",1920,1080)
	t[4] = display.newImage("이미지/채팅창/채팅창주인공.png",1920,1080)

	for i=1,4 do
		t[i].x = display.contentWidth /2
		t[i].y = display.contentHeight * 0.79
		sceneGroup:insert(t[i])
		t[i].alpha=0
	end

	--채팅 배열
	local chatting={}
	local text={
		"으아아..이게 뭐야...",
		"우와! 너무 맛있잖아!",
		"미안하지만 못 먹겠어...",
		"와!! 여기 완전 도토리케이크 맛집이네",
		"이..이게..ㅇ..연어파이..?",
		"이렇게 맛있는 연어파이는 처음 먹어봐!",
		"(두근두근) 얘들아 맛이 어때?",
		"역시 나는 요리천재!!",
		"힝..열심히 만들었는데...",
		"도토리케이크 장사나 해 볼까~",
		"다음에는 꼭 맛있게 구워줄게..",
		"고마워 다음에 또 만들어줄게!",
		"으앙 원래는 잘 만드는데...",
	}

	for i=1,13 do
		chatting[i]=display.newText(text[i],display.contentWidth*0.132,display.contentHeight*0.78)
    	chatting[i]:setFillColor(0)
    	chatting[i].size=50
    	chatting[i].anchorX,chatting[i].anchorY=0,0
		chatting[i].alpha=0
	end

	 --리플레이버튼에 마우스를 올리면 커지고 떼면 작아짐
	 local i = 0
	 local function big (event)
	 
	 if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 50^2 then
		 -- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
		 if i == 0 then
			audio.play(soundTable["mouseSound"])
			 --local backgroundMusicChannel = audio.play(click1)
			 event.target.width = event.target.width*1.2
			 event.target.height = event.target.height*1.2
			 i = i + 1
		 end
	 
		 elseif (event.target.x-event.x)^2 + (event.target.y-event.y)^2 > 50^2 then
			 if i == 1 then
				 event.target.width =event.target.width/12*10
				 event.target.height =event.target.height/12*10
				 i = i - 1 
			 end    
		 end
	 end
 
	 rbutton:addEventListener("mouse",big)
 

	--클릭할때마다 캐릭터랑 채팅창 등장--
	local j = 1
	local function click(event)
		j=j+1
		--주인공 독백
		if j==2 then
			audio.play(soundTable["mix3Sound"])
			c[1].alpha=1
			t[4].alpha=1
			chatting[7].alpha=1
		end

		--토끼반응 등장, 주인공 독백 사라짐--
		if j == 3 then
			audio.play(soundTable["mix3Sound"])
			c[1].alpha=0
			t[4].alpha=0
			chatting[7].alpha=0
			--포인트 계산---
			if rabbitpoint == 0 then
				chatting[1].alpha=1
				t[1].alpha=1
				c[4].alpha=1
			else
				chatting[2].alpha=1
				t[1].alpha=1
				c[3].alpha=1
			end
		end

		if j==4 then
			audio.play(soundTable["mix3Sound"])
			--포인트 계산---
			if rabbitpoint == 0 then
				chatting[1].alpha=0
				t[1].alpha=0
				c[4].alpha=0
			else
				chatting[2].alpha=0
				t[1].alpha=0
				c[3].alpha=0
			end

			--포인트 계산---
			if rabbitpoint == 0 then
				chatting[9].alpha=1
				t[4].alpha=1
				c[2].alpha=1
			else
				chatting[8].alpha=1
				t[4].alpha=1
				c[1].alpha=1
			end
		end

		if j == 5 then
			audio.play(soundTable["mix3Sound"])
			--포인트 계산---
			if rabbitpoint == 0 then
				chatting[9].alpha=0
				t[4].alpha=0
				c[2].alpha=0
			else
				chatting[8].alpha=0
				t[4].alpha=0
				c[1].alpha=0
			end

			--포인트 계산---
			if squirrelpoint == 0 then
				chatting[3].alpha=1
				t[2].alpha=1
				c[6].alpha=1
			else
				chatting[4].alpha=1
				t[2].alpha=1
				c[5].alpha=1
			end
		end

		if j==6 then
			audio.play(soundTable["mix3Sound"])
			--포인트 계산---
			if squirrelpoint == 0 then
				chatting[3].alpha=0
				t[2].alpha=0
				c[6].alpha=0
			else
				chatting[4].alpha=0
				t[2].alpha=0
				c[5].alpha=0
			end

			--포인트 계산---
			if squirrelpoint == 0 then
				chatting[11].alpha=1
				t[4].alpha=1
				c[2].alpha=1
			else
				chatting[10].alpha=1
				t[4].alpha=1
				c[1].alpha=1
			end
		end

		if j == 7 then
			audio.play(soundTable["mix3Sound"])
				--포인트 계산---
			if squirrelpoint == 0 then
				chatting[11].alpha=0
				t[4].alpha=0
				c[2].alpha=0
			else
				chatting[10].alpha=0
				t[4].alpha=0
				c[1].alpha=0
			end

			--포인트 계산---
			if gompoint == 0 then
				chatting[5].alpha=1
				t[3].alpha=1
				c[8].alpha=1
			else
				chatting[6].alpha=1
				t[3].alpha=1
				c[7].alpha=1
			end
		end

		if j==8 then
			audio.play(soundTable["mix3Sound"])
			--포인트 계산---
			if gompoint == 0 then
				chatting[5].alpha=0
				t[3].alpha=0
				c[8].alpha=0
			else
				chatting[6].alpha=0
				t[3].alpha=0
				c[7].alpha=0
			end

			--포인트 계산---
			if gompoint == 0 then
				chatting[13].alpha=1
				t[4].alpha=1
				c[2].alpha=1
			else
				chatting[12].alpha=1
				t[4].alpha=1
				c[1].alpha=1
			end

		end

		if j==9 then
			--포인트 계산---
			if gompoint == 0 then
				chatting[13].alpha=0
				t[4].alpha=0
				c[2].alpha=0
			else
				chatting[12].alpha=0
				t[4].alpha=0
				c[1].alpha=0
			end
			rbutton.alpha=1

			if sum== 0 then
				background.alpha=0
				for i=1,8 do
					c[i].alpha=0
				end
				for i=1,4 do
					t[i].alpha=0
				end
				for i=1,13 do
					chatting[i].alpha=0
				end
				audio.pause( soundTable["finalSound"])
				audio.play(soundTable["failSound"])
				fbackground[1].alpha=1
			end

			if sum==1 then
				background.alpha=0
				for i=1,8 do
					c[i].alpha=0
				end
				for i=1,4 do
					t[i].alpha=0
				end
				for i=1,13 do
					chatting[i].alpha=0
				end
				audio.pause( soundTable["finalSound"])
				audio.play(soundTable["failSound"])
				fbackground[2].alpha=1
			end

			if sum==2 then
				background.alpha=0
				for i=1,8 do
					c[i].alpha=0
				end
				for i=1,4 do
					t[i].alpha=0
				end
				for i=1,13 do
					chatting[i].alpha=0
				end
				audio.pause( soundTable["finalSound"])
				audio.play(soundTable["successSound"])
				fbackground[3].alpha=1
			end

			if sum == 3 then
				background.alpha=0
				for i=1,8 do
					c[i].alpha=0
				end
				for i=1,4 do
					t[i].alpha=0
				end
				for i=1,13 do
					chatting[i].alpha=0
				end
				audio.pause( soundTable["finalSound"])
				audio.play(soundTable["successSound"])
				fbackground[4].alpha=1
			end
		end
	end

	background:addEventListener("tap",click)

	
	--리플레이버튼 클릭시 스타트뷰로 넘어가기--
	local j=1
	local function click(event)
		j=j+1
		if j==2 then
		for i=1,4 do
			fbackground[i].alpha=0
		end
		rbutton.alpha=0
		composer.removeScene( "reception" )
		audio.pause(soundTable["successSound"])
		audio.pause(soundTable["failSound"])
		composer.setVariable("complete", true)
		local options={
			effect ="fade",
			time=400
		}
		composer.gotoScene("startView",options)
		end
	end	

	rbutton:addEventListener("tap",click)
	
	--레이아웃정리--
	rbutton:toFront()
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
