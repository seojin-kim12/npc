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
	local background = display.newImage("이미지/배경/오븐배경.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	local option =
	{
   	 	width = 1920,
   		height = 1080,
   		numFrames = 12
	}

	local ani =
	graphics.newImageSheet( "이미지/애니메이션/애니.png", option )


	local data = 
    {
        name = "animation",
        start = 1,
        count = 12,
        time = 2000,
        loopCount = 1,
        loopDirection = "forward"
    }

    local a=display.newSprite( ani,data )
    a.x, a.y = display.contentWidth/2,display.contentHeight/2
	sceneGroup:insert(a)

	a:play()

    
	local function spriteListener( event )
    print( event.name, event.target, event.phase, event.target.sequence )
    if event.phase=="ended" then 
    	a:pause()
		composer.removeScene( "ovenAni(pie)" )
		composer.setVariable("complete", true)
        local options={
            effect ="fade",
            time=400
        }
        composer.gotoScene("oven(pie)1",options)
    end
end
a:addEventListener( "sprite", spriteListener )
	
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
