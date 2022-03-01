-----------------------------------------------------------------------------------------
--
-- acornCake5.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
    --오븐 뒷 배경--
    local background = display.newImage("이미지/배경/오븐_배경만.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	--오븐열림,닫힘--
	local oven={}
	oven[1] = display.newImageRect("이미지/오븐/오븐닫힘_버튼O_Off.png", 200*4.2, 150*3.2)
	oven[2] = display.newImageRect("이미지/오븐/오븐열림_아래O.png", 200*5, 150*5)
	oven[3] = display.newImageRect("이미지/도토리케이크/오븐_00(꺼짐).png", 200*4.2, 150*3.2)

	oven[1].x, oven[1].y = display.contentWidth*0.65, display.contentHeight / 2
	oven[2].x, oven[2].y = display.contentWidth*0.65, display.contentHeight*0.65
	oven[3].x, oven[3].y = display.contentWidth*0.65, display.contentHeight / 2
	
	oven[1].alpha=1
	for i=2,3 do
		oven[i].alpha=0
	end
	for i=1,3 do
		sceneGroup:insert(oven[i])
	end

	--레시피창 불러오기--
	local option = {
		isModal = true
	}

	local function tutorial(event)
		audio.play(soundTable["button4Sound"])
		if event.phase == "began" then
		composer.showOverlay("pierecipe2",option)
		end
	end

	local recipe = display.newImage("이미지/레시피/레시피_버튼.png")
	recipe.x, recipe.y = display.contentWidth*0.9, display.contentHeight*0.08
	sceneGroup:insert(recipe)
	recipe:addEventListener("touch",tutorial)

	--케이크 드래그--
	local cake = {}
	cake[1] = display.newImageRect("이미지/도토리케이크/케이크_반죽틀2_토끼손.png", 200*1.8, 150*2)
	cake[2] = display.newImageRect("이미지/도토리케이크/케이크_반죽틀2.png", 200*1.2, 150*1.3)

	cake[1].x, cake[1].y = display.contentWidth*0.25, display.contentHeight*0.6
	cake[2].x, cake[2].y = display.contentWidth*0.65, display.contentHeight*0.52

	for i=1,2 do
		cake[i].alpha=0
		sceneGroup:insert(cake[i])
	end

	--케이크--
	local c = display.newImageRect("이미지/도토리케이크/케이크_반죽틀2.png", 200*1.9, 150*2.1)
	c.x, c.y = display.contentWidth*0.25, display.contentHeight*0.61
	sceneGroup:insert(c)

	--클릭 이벤트(오븐닫힘->열림->닫힘)--
	local j=1
	local function click(event)              
		j=j+1
        if j==2 then
			audio.play(soundTable["ovenCloseSound"])
            oven[j-1].alpha=0
            oven[j].alpha=1

			local k=1
			cake[1].alpha=1
			--케이크 드래그--
			local function doughEvent(event)
				if(event.phase == "began")then
					display.getCurrentStage():setFocus(event.target)
					event.target.isFocus = true
					display.remove(c)
		
				elseif (event.phase == "moved") then    
					if(event.target.isFocus) then
						event.target.x=event.xStart + event.xDelta 
						event.target.y=event.yStart + event.yDelta 
					end                                            
		
				elseif(event.phase == "ended" or event.phase == "cancelled") then 
					if(event.target.isFocus) then
		
						 --if문을 통해 조건을 확인한뒤
						if event.target.x < oven[2].x + 450 and event.target.x > oven[2].x - 450      
						and event.target.y < oven[2].y + 300 and event.target.y > oven[2].y - 300 then 
							k=k+1
		
							if k==2 then
								audio.play(soundTable["putSound"])
								cake[k-1].alpha=0
								cake[k].alpha=1
							end
							else   
							event.target.x = event.xStart
							event.target.y = event.yStart
							end
		
						display.getCurrentStage():setFocus(nill)
						event.target.isFocus = false
						end
						display.getCurrentStage():setFocus(nill)
						event.target.isFocus = false

						--드래그를 해야만 클릭해서 오븐을 닫을 수 있고 그 후에 다음 장면으로 넘어 갈 수 있음
						local j=1
						local function click(event)              
							j=j+1

							if j==3 then
								audio.play(soundTable["ovenOpenSound"])
								display.remove(cake[1])
								display.remove(cake[2])
								oven[j-1].alpha=0
								oven[j].alpha=1
							end

							if j==4 then
								background.alpha=0
								for i=1,3 do
									oven[i].alpha=0
								end
								for i=1,2 do
									cake[i].alpha=0
								end
								recipe.alpha=0
								c.alpha=0
								composer.removeScene( "oven(acorn)1" )
								composer.setVariable("complete", true)
								local options={
									effect ="fade",
									time=400
								}
								composer.gotoScene("oven(acorn)2",options)
							end

						end

						for i=2, 3 do
							oven[i]:addEventListener("tap",click)
						end

					end
				end
		
			cake[k]:addEventListener("touch", doughEvent)
		end
    end

    oven[1]:addEventListener("tap",click)

	--객체에 마우스를 올리면 커지고 떼면 작아짐
	local i = 0
	local function big (event)
	
	if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 70^2 then
		-- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
		if i == 0 then
			audio.play(soundTable["mouseSound"])
			--local backgroundMusicChannel = audio.play(click1)
			event.target.width = event.target.width*1.2
			event.target.height = event.target.height*1.2
			i = i + 1
		end
	
	elseif (event.target.x-event.x)^2 + (event.target.y-event.y)^2 > 70^2 then
		if i == 1 then
			event.target.width =event.target.width/12*10
			event.target.height =event.target.height/12*10
			i = i - 1 
		end
		
	end
	end

	c:addEventListener("mouse",big)
	
	--레이아웃정리--
	cake[2]:toFront()
	oven[3]:toFront()
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
