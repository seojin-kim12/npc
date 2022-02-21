-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	--배경
	local background = display.newImage("이미지/배경/집안배경.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	--주인공
	local j = display.newImage("이미지/캐릭터/주인공.png")
	j.x = display.contentWidth * 0.8
	j.y = display.contentHeight / 2
	sceneGroup:insert(j)

	--토끼친구
	--[[local t = display.newImage("이미지/캐릭터/토끼친구.png")
	t.x = display.contentWidth * 0.2
	t.y = display.contentHeight / 2
	sceneGroup:insert(t)]]

	--곰친구
	--[[local g = display.newImage("이미지/캐릭터/곰친구.png")
	g.x = display.contentWidth * 0.3
	g.y = display.contentHeight / 2
	sceneGroup:insert(g)]]

	--다람쥐 친구
	local d = display.newImage("이미지/캐릭터/다람쥐친구.png")
	d.x = display.contentWidth * 0.2
	d.y = display.contentHeight / 2
	sceneGroup:insert(d)

	local forlog = display.newImageRect("이미지/채팅창/채팅창_주인공.png", 1920, 1080)
	forlog.x = display.contentWidth /2
	forlog.y = display.contentHeight / 2
	forlog.text = "자! 다들 먹고 싶은거 편히 말해봐"
	sceneGroup:insert(forlog)
	
	--[[local function page(event)

        composer.removeScene( "view1" )
        composer.setVariable("complete", true)
        composer.gotoScene("view2")

    end
	forlog:addEventListener("tap",page)]]
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
