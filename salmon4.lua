-----------------------------------------------------------------------------------------
--
-- startView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImage("이미지/배경/요리테이블.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	local pie=display.newImageRect("이미지/연어파이/파이_반죽6.png",860,718)
	pie.x=display.contentWidth /2
	pie.y=display.contentHeight /2
	sceneGroup:insert(pie)

	local pie2=display.newImageRect("이미지/연어파이/파이_반죽7.png",860,718)
	pie2.x=display.contentWidth /2
	pie2.y=display.contentHeight /2
	pie2.alpha=0
	sceneGroup:insert(pie2)

	local salmon=display.newImageRect("이미지/연어파이/연어파이재료/연어썰기/연어4.png",500,200)
	salmon.x=display.contentWidth *0.16
	salmon.y=display.contentHeight *0.13
	sceneGroup:insert(salmon)


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
		
		if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 100^2 then
			-- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
			if i == 0 then
				audio.play( soundTable["mouseSound"] )
				event.target.width = event.target.width*1.2
				event.target.height = event.target.height*1.2
				i = i + 1
			end
		
		elseif (event.target.x-event.x)^2 + (event.target.y-event.y)^2 > 100^2 then
			if i == 1 then
				event.target.width =event.target.width/12*10
				event.target.height =event.target.height/12*10
				i = i - 1 
			end
			
		end
	end
	salmon:addEventListener("mouse",big)

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
			if event.target.x < pie.x + 450 and event.target.x > pie.x - 450
				and event.target.y < pie.y + 300 and event.target.y > pie.y - 300 then
					--재료와 위치가 바뀜
					event.target.alpha=0
					pie2.alpha=1
					event.target.x=event.xStart + event.xDelta
					event.target.y=event.yStart + event.yDelta
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
		
	end
	salmon:addEventListener("touch", catch)

	local function next(event)
		pie.alpha=0
		pie2.alpha=0
		composer.removeScene( "salmon4" )
        composer.setVariable("complete", true)
        local options={
			effect ="fade",
		time=400
			}
       	composer.gotoScene("salmon5",options)
    end
    pie2:addEventListener("tap",next)

    
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
