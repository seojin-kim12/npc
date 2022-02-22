-----------------------------------------------------------------------------------------
--
-- startView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	--배경
	local background = display.newImage("이미지/배경/요리테이블.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	local bowl = display.newImageRect("이미지/연어파이/빈볼.png",980,700)
	bowl.x = display.contentWidth / 2
	bowl.y = display.contentHeight *0.59
	sceneGroup:insert(bowl)

	

	--재료 배열 생성
	local c={}
	c[1] = display.newImageRect("이미지/연어파이재료/달걀.png",100,137)
	c[2] = display.newImageRect("이미지/연어파이재료/밀가루.png",225,172)
	c[3] = display.newImageRect("이미지/연어파이재료/버터.png",204,156)
	c[4] = display.newImageRect("이미지/연어파이재료/설탕.png",100,191)
	c[5] = display.newImageRect("이미지/연어파이재료/우유.png",150,216)

	for i=1,5 do
		c[i].x=display.contentWidth *i*0.1
		c[i].y=display.contentHeight *0.11
		sceneGroup:insert(c[i])
	end


	--볼재료 배열 생성
	local b={}
	b[1] = display.newImageRect("이미지/연어파이재료/볼재료/달걀.png",100,137)
	b[2] = display.newImageRect("이미지/연어파이재료/볼재료/밀가루.png",225,172)
	b[3] = display.newImageRect("이미지/연어파이재료/볼재료/버터.png",204,156)
	b[4] = display.newImageRect("이미지/연어파이재료/볼재료/설탕.png",100,191)
	b[5] = display.newImageRect("이미지/연어파이재료/볼재료/우유.png",150,216)
	for i=1,5 do
		b[i].alpha=0
		b[i].x=display.contentWidth *i*0.1
		b[i].y=display.contentHeight *0.11
		sceneGroup:insert(b[i])
	end


	--채팅1
	local t1 = display.newImageRect("이미지/채팅창/채팅창주인공.png",1920,1080)
	t1.x=display.contentWidth /2
	t1.y=display.contentHeight /2
	sceneGroup:insert(t1)

	local chatting1=display.newText("먼저, 파이의 반죽을 만들어야해.\n재료를 볼에 넣어보자.",display.contentWidth*0.29,display.contentHeight*0.815)
    chatting1:setFillColor(0)
    chatting1.size=50
    sceneGroup:insert(chatting1)


    --채팅삭제
    local function next(event)	
		t1.alpha=0
		chatting1.alpha=0
    end
	t1:addEventListener("tap",next)


	--재료 드래그
	local check=0
	for i=1,5 do
	local function catch( event )
		if ( event.phase == "began" ) then
			display.getCurrentStage():setFocus( event.target )
			--드래그 시작시 채팅 사라짐
			t1.alpha=0
			chatting1.alpha=0
			event.target.isFocus = true
		elseif ( event.phase == "moved" ) then
			if ( event.target.isFocus ) then
				event.target.x = event.xStart + event.xDelta
				event.target.y = event.yStart + event.yDelta									
			end
		elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
			--볼의 범위 안에 객체가 들어가면
			if event.target.x < bowl.x + 450 and event.target.x > bowl.x - 450
				and event.target.y < bowl.y + 300 and event.target.y > bowl.y - 300 then
					--재료와 위치가 바뀜
					event.target.alpha=0
					b[i].alpha=1
					b[i].x=event.xStart + event.xDelta
					b[i].y=event.yStart + event.yDelta
					check=check+1
			else 									
				event.target.x = event.xStart
				event.target.y = event.yStart
			end
			if ( event.target.isFocus ) then
				display.getCurrentStage():setFocus( nil )
				event.target.isFocus = false
			end
			display.getCurrentStage():setFocus( nil )
			event.target.isFocus = false
		end
		--모든 재료가 볼에 들어가면
		if check==5 then
			--볼의 재료는 사라지고
			for i=1,5 do
				b[i].alpha=0
			end
			--반죽볼로 바뀜
			local bowl2 = display.newImageRect("이미지/연어파이/반죽볼.png",980,700)
			bowl2.x = display.contentWidth / 2
			bowl2.y = display.contentHeight *0.59
			sceneGroup:insert(bowl2)

			local check2=0

			--채팅 및 다음씬
			local function next(event)	
				check2=check2+1
				if check2==1 then
					local t2 = display.newImageRect("이미지/채팅창/채팅창주인공.png",1920,1080)
					t2.x=display.contentWidth /2
					t2.y=display.contentHeight /2
					sceneGroup:insert(t2)
					local chatting2=display.newText("좋아! 이제 파이에 넣을 재료를 손질해볼까?",display.contentWidth*0.31,display.contentHeight*0.8)
    				chatting2:setFillColor(0)
    				chatting2.size=50
    				sceneGroup:insert(chatting2)
				end
				if check2==2 then
					composer.removeScene( "salmon1" )
        			composer.setVariable("complete", true)
        			local options={
						effect ="fade",
						time=400
					}
        			composer.gotoScene("salmon2",options)
        		end
    		end
			background:addEventListener("tap",next)
		end
	end
	c[i]:addEventListener("touch", catch)

	end

	


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
