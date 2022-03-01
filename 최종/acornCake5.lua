-----------------------------------------------------------------------------------------
--
-- acornCake5.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	--케이크완성탁자 배경--
	local background = display.newImage("이미지/배경/케이크테이블_배경.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	background.alpha=0
	sceneGroup:insert(background)
	background.alpha=1

	--토끼 완성--
	local rabbit = display.newImage("이미지/캐릭터/주인공.png",display.contentWidth * 0.8,display.contentHeight / 2)
	rabbit.alpha=0
	sceneGroup:insert(rabbit)
	rabbit.alpha=1

	--도토리케이크 완성--
	local cake = display.newImageRect("이미지/도토리케이크/도토리케이크6단계.png", 200*2, 200*2)
	cake.x, cake.y = display.contentWidth*0.25, display.contentHeight*0.6
	cake.alpha=0
	sceneGroup:insert(cake)
	cake.alpha=1
	audio.play(soundTable["successSound"])

	local function next(event)
		rabbit.alpha=0
		cake.alpha=0
		background.alpha=0
		composer.removeScene( "salmon8" )
		composer.setVariable("complete", true)
        local options={
            effect ="fade",
            time=1000
        }
        composer.gotoScene("reception0",options)
    end
	background:addEventListener("tap",next)
	
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
