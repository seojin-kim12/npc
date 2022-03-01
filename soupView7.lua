-----------------------------------------------------------------------------------------
--
-- startView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	--점수 판별
	if(smoked > 1 or index % 3 == 2 or index % 3 == 0)then
		rabbitpoint = 0
	else
		rabbitpoint = 1
	end
	
	--배경
	local background = display.newImage("이미지/당근스프/당근/가스레인지.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	--냄비
	local pot = {} 
	pot[1] = display.newImage("이미지/당근스프/당근/3물+당근냄비.png")
	pot[2] = display.newImage("이미지/당근스프/당근/4물+당근냄비_그을린.png")

	if(index % 3 == 1 and smoked == 1) then
		pot[1].alpha = 1
		pot[2].alpha = 0
	else
		pot[2].alpha = 1
		pot[1].alpha = 0
	end

	for i = 1, 2 do
		pot[i].x = display.contentWidth * 0.363
		pot[i].y = display.contentHeight * 0.4
	end

	sceneGroup:insert(pot[1])
	sceneGroup:insert(pot[2])

	--주걱
	local spoon = display.newImageRect("이미지/당근스프/당근/주걱.png",221.375, 870.625)
	spoon.x = display.contentWidth *0.8
	spoon.y = display.contentHeight * 0.5

	--손잡이
	local handle = display.newImage("이미지/당근스프/당근/손잡이_소화.png")
	handle.x = display.contentWidth * 0.8
	handle.y = display.contentHeight * 0.85
	sceneGroup:insert(handle)
	sceneGroup:insert(spoon)

	--레시피 불러오기
	local option = {
		isModal = true
	 }
  
	  local function tutorial(event)
		if event.phase == "began" then
		   audio.play(soundTable["button4Sound"])
		   composer.showOverlay("souprecipe",option)
		end
	 end
  
	 local recipe = display.newImage("이미지/레시피버튼.png")
	 recipe.x, recipe.y = display.contentWidth*0.9, display.contentHeight*0.08
	 sceneGroup:insert(recipe)
	 recipe:addEventListener("touch",tutorial)

	--드래그 앤 드랍 이벤트
	spoon.id = "주걱"

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
				if( event.target.x < pot[1].x + 500 and event.target.x > pot[1].x - 500 and
				event.target.y < pot[1].y + 500 and event.target.y > pot[1].y - 500 )then
					audio.play(soundTable["creamSound"])
					display.remove(event.target)

						composer.removeScene( "soupView7" )
            			composer.gotoScene("soupView8_1")
						background.alpha = 0
						spoon.alpha = 0
						recipe.alpha = 0
			
						for i = 1, 2 do
							pot[i].alpha = 0
						end
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

	spoon:addEventListener("touch", catch)

	--커졌다 작아지기
	local i = 0
	local function big (event)
	   
	   if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 100^2 then
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
 
	spoon:addEventListener("mouse",big)

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
