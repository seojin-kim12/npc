-----------------------------------------------------------------------------------------
--
-- startView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	--점수판별
	if(index % 3 == 0 or index % 3 == 2)then
		rabbitpoint = 0
	else
		rabbitpoint = 1
	end

	local c = 0
	
	--배경
	local background = display.newImage("이미지/당근스프/당근/가스레인지.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	--냄비
	local pot = display.newImage("이미지/당근스프/당근/0번냄비.png")
	pot.x = display.contentWidth * 0.363
	pot.y = display.contentHeight * 0.4
	sceneGroup:insert(pot)

	local pot2 = display.newImage("이미지/당근스프/당근/1당근냄비.png")
	pot2.x = display.contentWidth * 0.363
	pot2.y = display.contentHeight * 0.4
	pot2.alpha=0
	sceneGroup:insert(pot2)

	--손잡이
	local handle = {}
	handle[1] = display.newImage("이미지/당근스프/당근/손잡이_약불.png")
	handle[2] = display.newImage("이미지/당근스프/당근/손잡이_중불.png")
	handle[3] = display.newImage("이미지/당근스프/당근/손잡이_강불.png")

	for i = 1, 3 do
		handle[i].alpha = 0
	end

	for i=1,3 do
		handle[i].x = display.contentWidth * 0.8
		handle[i].y = display.contentHeight * 0.85
		sceneGroup:insert(handle[i])
	end

	--불
	local fire = {}
	fire[1] = display.newImage("이미지/당근스프/당근/불_약불.png")
	fire[2] = display.newImage("이미지/당근스프/당근/불_중불.png")
	fire[3] = display.newImage("이미지/당근스프/당근/불_강불.png")

	for i=1,3 do
		fire[i].alpha=0
	end

	fire[1].y = display.contentHeight * 0.7
	fire[2].y = display.contentHeight * 0.65
	fire[3].y = display.contentHeight * 0.62

	if (index % 3 == 1)then
		fire[3].alpha = 0
		handle[3].alpha = 0
		fire[1].alpha = 1
		handle[1].alpha = 1
	elseif (index % 3 == 2)then
		fire[1].alpha = 0
		handle[1].alpha = 0
		fire[2].alpha = 1
		handle[2].alpha = 1
	elseif (index % 3 == 0) then
		fire[2].alpha = 0
		handle[2].alpha = 0
		fire[3].alpha = 1
		handle[3].alpha = 1
	end
	
	sceneGroup:insert(pot)
	--버터
	local butter = display.newImageRect("이미지/당근스프/버터.png", 368.25, 280.5)
	butter.x = display.contentWidth *0.9
	butter.y = display.contentHeight * 0.3
	sceneGroup:insert(butter)

	--당근
	local carrot = display.newImageRect("이미지/당근스프/당근_3단계.png", 626.25, 132)
	carrot.x = display.contentWidth *0.85
	carrot.y = display.contentHeight * 0.5
	sceneGroup:insert(carrot)

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
	carrot.id = "당근"
	butter.id = "버터"

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
					c = c + 1

					if(c == 2) then
						composer.removeScene( "soupView3" )
            			composer.gotoScene("soupView4")

						background.alpha = 0
						pot.alpha = 0
						butter.alpha = 0
						carrot.alpha = 0
						recipe.alpha = 0

						for i = 1, 3 do
							fire[i].alpha = 0
							handle[i].alpha = 0
						end
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

		
		butter:addEventListener("touch", catch)

		local function catch2(event)
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
					c = c + 1
					pot.alpha=0
					pot2.alpha=1

					if(c == 2) then
						composer.removeScene( "soupView3" )
            			composer.gotoScene("soupView4")

						background.alpha = 0
						pot.alpha = 0
						butter.alpha = 0
						carrot.alpha = 0
						recipe.alpha = 0

						for i = 1, 3 do
							fire[i].alpha = 0
							handle[i].alpha = 0
						end
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
	carrot:addEventListener("touch", catch2)

		--커졌다 작아지기
		local i = 0
		local function big (event)
		   
		   if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 50^2 then
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
	 
		carrot:addEventListener("mouse",big)
		butter:addEventListener("mouse",big)

		for i=1,3 do
			fire[i].x = display.contentWidth * 0.363
			sceneGroup:insert(fire[i])
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