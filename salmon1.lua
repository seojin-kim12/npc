-----------------------------------------------------------------------------------------
--
-- startView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	audio.play( soundTable["playSound"],{ loops=-1 } )

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
	c[1] = display.newImageRect("이미지/연어파이/연어파이재료/달걀.png",464*0.3,645*0.3)
	c[2] = display.newImageRect("이미지/연어파이/연어파이재료/밀가루.png",494*0.6,362*0.6)
	c[3] = display.newImageRect("이미지/연어파이/연어파이재료/버터.png",204*1.1,156*1.1)
	c[4] = display.newImageRect("이미지/연어파이/연어파이재료/설탕.png",100*1.1,191*1.1)
	c[5] = display.newImageRect("이미지/연어파이/연어파이재료/우유.png",150,216)

	for i=1,5 do
		c[i].x=display.contentWidth *i*0.12
		c[i].y=display.contentHeight *0.11
		sceneGroup:insert(c[i])
	end

	c[1].x= display.contentWidth *0.08
	c[2].x=	display.contentWidth *0.215


	--볼재료 배열 생성
	local b={}
	b[1] = display.newImageRect("이미지/연어파이/연어파이재료/볼재료/달걀.png",205,110)
	b[2] = display.newImageRect("이미지/연어파이/연어파이재료/볼재료/밀가루.png",225,172)
	b[3] = display.newImageRect("이미지/연어파이/연어파이재료/볼재료/버터.png",204,156)
	b[4] = display.newImageRect("이미지/연어파이/연어파이재료/볼재료/설탕.png",218,177)
	b[5] = display.newImageRect("이미지/연어파이/연어파이재료/볼재료/우유.png",342,85)
	for i=1,5 do
		b[i].alpha=0
		b[i].x=display.contentWidth *i*0.1
		b[i].y=display.contentHeight *0.11
		sceneGroup:insert(b[i])
	end

	--레시피 불러오기
	local option = {
		isModal = true
	}

    local function tutorial(event)
		if event.phase == "began" then
			audio.play(soundTable["button4Sound"])
			composer.showOverlay("pierecipe",option)
		end
	end

	local recipe = display.newImage("이미지/레시피버튼.png")
	recipe.x, recipe.y = display.contentWidth*0.9, display.contentHeight*0.08
	sceneGroup:insert(recipe)
	recipe:addEventListener("touch",tutorial)

	--객체에 마우스를 올리면 커지고 떼면 작아짐
	local i = 0
	local function big (event)
		
		if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 70^2 then
			-- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
			if i == 0 then
				audio.play( soundTable["mouseSound"] )
				event.target.width = event.target.width*1.2
				event.target.height = event.target.height*1.2
				i = i + 1
			end
		
		elseif (event.target.x-event.x)^2 + (event.target.y-event.y)^2 > 70^2 then
			if i == 1 then
				event.target.width =event.target.width/12*10
				event.target.height =event.target.height/12*10
				i = i - 1 
			end
			
		end
	end
	for i=1,5 do 
		c[i]:addEventListener("mouse",big)
	end



	--재료 드래그
	local check=0
	for i=1,5 do
	local function catch( event )
		if ( event.phase == "began" ) then
			display.getCurrentStage():setFocus( event.target )
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
					audio.play( soundTable["dropSound"] )
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

			--채팅 및 다음씬
			local function next(event)	
				bowl2.alpha=0
				bowl.alpha=0
				composer.removeScene( "salmon1" )
        		composer.setVariable("complete", true)
        		local options={
					effect ="fade",
					time=400
				}
        		composer.gotoScene("salmon2",options)
        	end
    		
			bowl2:addEventListener("tap",next)
		
		end
	end
	c[i]:addEventListener("touch", catch)

end

--레시피 불러오기
	local option = {
		isModal = true
	}

    local function tutorial(event)
		if event.phase == "began" then
			composer.showOverlay("pierecipe",option)
		end
	end

	local recipe = display.newImage("이미지/레시피버튼.png")
	recipe.x, recipe.y = display.contentWidth*0.9, display.contentHeight*0.08
	sceneGroup:insert(recipe)
	recipe:addEventListener("touch",tutorial)
	
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
