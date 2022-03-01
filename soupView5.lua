-----------------------------------------------------------------------------------------
--
-- startView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local c = 0

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
	pot[1] = display.newImage("이미지/당근스프/당근/1당근냄비.png")
	pot[2] = display.newImage("이미지/당근스프/당근/2당근냄비_그을린.png")

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
		sceneGroup:insert(pot[i])
	end

	--냄비
	local pot2 = {} 
	pot2[1] = display.newImage("이미지/당근스프/당근/3물+당근냄비.png")
	pot2[2] = display.newImage("이미지/당근스프/당근/4물+당근냄비_그을린.png")

	for i = 1, 2 do
		pot2[i].alpha = 0
		pot2[i].x = display.contentWidth * 0.363
		pot2[i].y = display.contentHeight * 0.4
		sceneGroup:insert(pot2[i])
	end

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

	sceneGroup:insert(pot[1])
	sceneGroup:insert(pot[2])

	--물
	local water = display.newImageRect("이미지/당근스프/물.png", 192.375,487.125)
	water.x = display.contentWidth *0.85
	water.y = display.contentHeight * 0.2
	sceneGroup:insert(water)

	--다진마늘
	local garlic = display.newImageRect("이미지/당근스프/다진마늘.png", 324.75, 245.625)
	garlic.x = display.contentWidth *0.85
	garlic.y = display.contentHeight * 0.54
	sceneGroup:insert(garlic)

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
	water.id = "물"
	garlic.id = "마늘"

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
					display.remove(event.target)
					c = c + 1

					if(c == 2) then
						composer.removeScene( "soupView5" )
            			composer.gotoScene("soupView6")
						background.alpha = 0
						water.alpha = 0
						garlic.alpha = 0
						recipe.alpha = 0

						for i = 1, 3 do
							fire[i].alpha = 0
							handle[i].alpha = 0
						end
			
						for i = 1, 2 do
							pot[i].alpha = 0
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

		
		garlic:addEventListener("touch", catch)

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
					if( event.target.x < pot[1].x + 500 and event.target.x > pot[1].x - 500 and
					event.target.y < pot[1].y + 500 and event.target.y > pot[1].y - 500 )then
						display.remove(event.target)
						c = c + 1

						if(pot[1].alpha == 1) then
							pot[1].alpha = 0
							pot2[1].alpha = 1
						else
							pot[2].alpha = 0
							pot2[2].alpha = 1
						end
	
						if(c == 2) then
							composer.removeScene( "soupView5" )
							composer.gotoScene("soupView6")
	
							background.alpha = 0
							water.alpha = 0
							garlic.alpha = 0
							recipe.alpha = 0
	
							for i = 1, 3 do
								fire[i].alpha = 0
								handle[i].alpha = 0
							end

							for i = 1, 2 do
								pot[i].alpha = 0
								pot2[i].alpha = 0
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
		water:addEventListener("touch", catch2)

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
	 
		water:addEventListener("mouse",big)
		garlic:addEventListener("mouse",big)

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