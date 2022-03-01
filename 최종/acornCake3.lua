-----------------------------------------------------------------------------------------
--
--  acornCake4.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	--탁자 배경--
	local background = display.newImage("이미지/배경/요리테이블.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	--도토리--
	local acorn = {}
	local acornGroup = display.newGroup()

	for i=1,2 do
		acorn[i] = display.newImageRect(acornGroup, "이미지/도토리케이크/도토리.png", 150*2, 200*1) 
	end
	acorn[1].x, acorn[1].y = display.contentWidth*0.15, display.contentHeight*0.6
	acorn[2].x, acorn[2].y = display.contentWidth*0.2, display.contentHeight*0.39
	sceneGroup:insert(acornGroup)

	 --생크림--
	 local whipp = {}
	 whipp[1] = display.newImageRect("이미지/도토리케이크/케이크_짤주머니.png", 300*2, 150*2)
	 whipp[2] = display.newImageRect("이미지/도토리케이크/케이크_짤주머니_2.png", 300*2, 150*2)
	 whipp[3] = display.newImageRect("이미지/도토리케이크/케이크_짤주머니_3.png", 300*2, 150*2)

	 for i=1,3 do
		whipp[i].x, whipp[i].y =display.contentWidth*0.8, display.contentHeight*0.2
		sceneGroup:insert(whipp[i])
	 end

	 whipp[1].alpha=1
	 for i=2,3 do
		whipp[i].alpha=0
	 end

	--레시피
	local recipe = display.newImage("이미지/레시피/레시피_버튼.png")
	recipe.x = display.contentWidth * 0.1
	recipe.y = display.contentHeight * 0.1
	sceneGroup:insert(recipe)
 
	local recipeApp = display.newImage("이미지/레시피/레시피_도토리케이크.png")
	recipeApp.x = display.contentWidth / 2
	recipeApp.y = display.contentHeight / 2
	recipeApp.alpha = 0
	sceneGroup:insert(recipeApp)
 
	local recipeCancle = display.newImage("이미지/레시피/레시피_닫기.png")
	recipeCancle.x = display.contentWidth * 0.82
	recipeCancle.y = display.contentHeight * 0.21
	recipeCancle.alpha = 0
	sceneGroup:insert(recipeApp)
 
	local function recipeAppear (event)
	   audio.play(soundTable["button4Sound"])
	   recipeApp.alpha = 1
	   recipeCancle.alpha = 1
	end
 
	local function recipeDisappear (event)
	   recipeApp.alpha = 0
	   recipeCancle.alpha = 0
	end
 
	recipe:addEventListener("tap", recipeAppear)
	recipeCancle:addEventListener("tap", recipeDisappear)
 
	--객체에 마우스를 올리면 커지고 떼면 작아짐
	local i = 0
	local function big (event)
		if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 80^2 then
			-- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
			if i == 0 then
				audio.play(soundTable["mouseSound"])
				--local backgroundMusicChannel = audio.play(click1)
				event.target.width = event.target.width*1.2
				event.target.height = event.target.height*1.2
				i = i + 1
			end
		
		elseif (event.target.x-event.x)^2 + (event.target.y-event.y)^2 > 80^2 then
			if i == 1 then
				event.target.width =event.target.width/12*10
				event.target.height =event.target.height/12*10
				i = i - 1 
			end
			
		end
	end

	for i=1,3 do
		whipp[i]:addEventListener("mouse",big)
	end
	for i=1,2 do 
		acorn[i]:addEventListener("mouse",big)
	end
	 
	 --다 구워진 케이크를 놓는 곳--
	 local cake={}
	 cake[1] = display.newImageRect("이미지/도토리케이크/도토리케이크1단계.png", 200*4.2, 150*4.2)
	 cake[2] = display.newImageRect("이미지/도토리케이크/도토리케이크2단계.png", 200*4.4, 150*4.4)
	 cake[3] = display.newImageRect("이미지/도토리케이크/도토리케이크3단계.png", 200*4.4, 150*4.4)
	 cake[4] = display.newImageRect("이미지/도토리케이크/도토리케이크4단계.png", 200*4.4, 150*4.6)
	 cake[5] = display.newImageRect("이미지/도토리케이크/도토리케이크5단계.png", 200*4.4, 150*4.6)
	 cake[6] = display.newImageRect("이미지/도토리케이크/도토리케이크6단계.png", 200*4.4, 150*5.1)

	 for i=2,6 do
		cake[i].alpha=0
	end
	for i=1,5 do
		cake[i].x, cake[i].y = display.contentWidth*0.5, display.contentHeight*0.6
		sceneGroup:insert(cake[i])
	end
	cake[6].x, cake[6].y = display.contentWidth*0.5, display.contentHeight*0.575
	sceneGroup:insert(cake[6])

	local j=1
	 --drag&drop--
	local function whippEvent(event)
		if(event.phase == "began")then 
			display.getCurrentStage():setFocus(event.target)
			event.target.isFocus = true

		elseif (event.phase == "moved") then    
			if(event.target.isFocus) then
				event.target.x=event.xStart + event.xDelta 
				event.target.y=event.yStart + event.yDelta 
			end                                            

		elseif(event.phase == "ended" or event.phase == "cancelled") then 
			if(event.target.isFocus) then
				 --if문을 통해 조건을 확인한뒤
				 if event.target.x < cake[1].x + 450 and event.target.x > cake[1].x - 450      
				 and event.target.y < cake[1].y + 300 and event.target.y > cake[1].y - 300 then 
					j=j+1

					if j>1 and j<=3 then
						audio.play(soundTable["putSound"])
						whipp[j-1].alpha=0
						whipp[j].alpha=1
						cake[j-1].alpha=0
						cake[j].alpha=1
					end

					if j==4 then
						audio.play(soundTable["putSound"])
						whipp[j-1].alpha=0
						cake[j-1].alpha=0
						cake[j].alpha=1

							--acorn drag&drop event--
							local function acornEvent(event)
								if(event.phase == "began")then 
									display.getCurrentStage():setFocus(event.target)
									event.target.isFocus = true

								elseif (event.phase == "moved") then    
									if(event.target.isFocus) then
										event.target.x=event.xStart + event.xDelta 
										event.target.y=event.yStart + event.yDelta 
									end                                            

								elseif(event.phase == "ended" or event.phase == "cancelled") then 
									if(event.target.isFocus) then
									--if문을 통해 조건을 확인한뒤
										if event.target.x < cake[1].x + 450 and event.target.x > cake[1].x - 450      
										and event.target.y < cake[1].y + 300 and event.target.y > cake[1].y - 300 then 
											display.remove(event.target) 
											j=j+1 
										
											if j==5 then
												audio.play(soundTable["putSound"])
												cake[j-1].alpha=0
												cake[j].alpha=1

											elseif j==6 then
												audio.play(soundTable["putSound"])
												cake[j-1].alpha=0
												cake[j].alpha=1
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

									local k=1
									local function click(event)
										k=k+1
										if k==2 then
											background.alpha=0
											acornGroup.alpha=0
											for i=1,3 do
												whipp[i].alpha=0
											end
											for i=1,6 do
												cake[i].alpha=0
											end
											recipe.alpha=0
											recipeApp.alpha=0
											composer.removeScene( "acornCake3" )
											composer.setVariable("complete", true)
											local options={
												effect ="fade",
												time=400
											}
											composer.gotoScene("acornCake5",options)
									end
								end

								cake[6]:addEventListener("tap",click)  
							end
						end

						for i=1,2 do
							acorn[i]:addEventListener("touch", 	acornEvent)
						end
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

		end
	end

	for i=1,3 do
		whipp[i]:addEventListener("touch", 	whippEvent)
	end

	--레이아웃정리--
	for i=1,3 do
		whipp[i]:toFront()
	 end
	recipeApp:toFront()
	recipeCancle:toFront()
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
