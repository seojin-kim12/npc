-----------------------------------------------------------------------------------------
--
-- startView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	--테이블
	local background = display.newImage("이미지/배경/요리테이블.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	--그릇
	local pot = display.newImageRect("이미지/당근스프/스프_빈.png", 800.4375, 581.625)
	pot.x = display.contentWidth / 2
	pot.y = display.contentHeight * 0.6
	sceneGroup:insert(pot)

	--레시피창 불러오기--

	local option = {
		isModal = true
 	}

  	local function tutorial(event)
		audio.play(soundTable["button4Sound"])
		if event.phase == "began" then
	   		composer.showOverlay("souprecipe",option)
		end
	end

 	local recipe = display.newImage("이미지/레시피/레시피_버튼.png")
 	recipe.x, recipe.y = display.contentWidth*0.9, display.contentHeight*0.08
 	sceneGroup:insert(recipe)

 	recipe:addEventListener("touch",tutorial)

	
	--국자
	local ladle = display.newImageRect("이미지/당근스프/당근/국자_당근.png",526.5, 730.5)
	ladle.x = display.contentWidth *0.8
	ladle.y = display.contentHeight * 0.4
	sceneGroup:insert(ladle)
	
	ladle.id = "주걱"

	local function catch(event)
		if(event.phase == "began") then
			print(event.target.id.."드래그!")

			display.getCurrentStage():setFocus(event.target)
			event.target.isFocus = true
		elseif (event.phase == "moved") then
			if("event.target.isFocus") then

				event.target.x = event.xStart + event.xDelta
				event.target.y = event.yStart + event.yDelta
			end
		elseif(event.phase == "ended" or event.phase == "cancelled") then
			if(event.target.isFocus) then
				if( event.target.x < pot.x + 500 and event.target.x > pot.x - 500 and
				event.target.y < pot.y + 500 and event.target.y > pot.y - 500 )then
					display.remove(event.target)
					audio.play(soundTable["dropSound"])

						composer.removeScene( "soupView8_3" )
            			composer.setVariable("complete", true)
            			composer.gotoScene("soupView8_4",options)
						background.alpha = 0
						pot.alpha = 0
						ladle.alpha = 0
						recipe.alpha = 0
				else
					event.target.x = event.xStart
            		event.target.y = event.yStart
				end

				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
			end
			display.getCurrentStage():setFocus(nil)
			event.target.isFocus = false
		end
	end

	ladle:addEventListener("touch", catch)

	--커졌다 작아지기
	local i = 0
	local function big (event)
	   
	   if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 150^2 then
		  -- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
		  if i == 0 then
			audio.play(soundTable["mouseSound"])
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
 
	ladle:addEventListener("mouse",big)


		
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
