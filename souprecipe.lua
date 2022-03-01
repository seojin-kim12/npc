-----------------------------------------------------------------------------------------
--
-- startView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

    local option = {
        isModal = true
     }

    local function go_back(event)
        if event.phase == "began" then
           composer.hideOverlay("recipe", option)
        end
     end
     
     local recipe=display.newImage("이미지/레시피/레시피_당근수프.png")
     recipe.x, recipe.y = display.contentWidth*0.5, display.contentHeight*0.5
     sceneGroup:insert(recipe)
     
     local exit = display.newImage("이미지/레시피/레시피_닫기.png")
     exit.x, exit.y = display.contentWidth*0.825, display.contentHeight*0.21
     sceneGroup:insert(exit)
     exit:addEventListener("touch",go_back)
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
