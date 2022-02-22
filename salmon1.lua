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
			if ( event.target.isFocus ) then
				display.getCurrentStage():setFocus( nil )
				event.target.isFocus = false
			end
			display.getCurrentStage():setFocus( nil )
			event.target.isFocus = false
		end
	end

	for i=1,5 do
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
