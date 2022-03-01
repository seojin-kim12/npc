-----------------------------------------------------------------------------------------
--
--  acornCake1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	--탁자 배경--
	local background = display.newImage("이미지/배경/요리테이블_왼손만.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	--바닐라 엑기스 섞을 막대기--
	local stick1= display.newImage("이미지/도토리케이크/막대기_01.png")
	stick1.x, stick1.y = display.contentWidth*0.12, display.contentHeight*0.4
	sceneGroup:insert(stick1)
	stick1.alpha=1

	local stick2= display.newImage("이미지/도토리케이크/막대기_02.png")
	stick2.x, stick2.y = display.contentWidth*0.12, display.contentHeight*0.4
	stick2.alpha=0
	sceneGroup:insert(stick2)

	--바닐라 휘젓는 모습--
	local sticks = {}
	sticks[1] = display.newImage("이미지/도토리케이크/막대기_05.png")
	sticks[2] = display.newImage("이미지/도토리케이크/막대기_03.png")
	sticks[3] = display.newImage("이미지/도토리케이크/막대기_04.png")

	for i=1,3 do
		sticks[i].x, sticks[i].y = display.contentWidth/2, display.contentHeight*0.4
		sticks[i].alpha=0
		sceneGroup:insert(sticks[i])
	end

	--바닐라 엑기스손--
	vanilla = display.newImageRect("이미지/도토리케이크/바닐라액기스_02.png", 150*1.6, 200*1.6)
	vanilla.x, vanilla.y = display.contentWidth*0.27, display.contentHeight*0.25
	vanilla.alpha=0
	sceneGroup:insert(vanilla)

	--바닐라 엑기스 통--
	vanillat = display.newImageRect("이미지/도토리케이크/바닐라액기스_01.png", 150*1.2, 200*1.6)
	vanillat.x, vanillat.y = display.contentWidth*0.28, display.contentHeight*0.22
	sceneGroup:insert(vanillat)
	vanillat.alpha=1
	
	 --바닐라 위치 다름--
	 vanillac = display.newImageRect("이미지/도토리케이크/바닐라액기스_03.png", 150*2, 200*2)
	 vanillac.x, vanillac.y = display.contentWidth*0.6, display.contentHeight*0.4
	 vanillac.alpha=0
	 sceneGroup:insert(vanillac)


	 --케이크 반죽통--
	 local doughBoll = display.newImageRect("이미지/도토리케이크/케이크_반죽.png", 200*2.5, 150*2.5)
	 doughBoll.x, doughBoll.y = display.contentWidth*0.75, display.contentHeight*0.23
	 sceneGroup:insert(doughBoll)

	 --케이크 반죽--
	local dough = display.newImageRect("이미지/도토리케이크/케이크_반죽만_손추가.png", 200*2, 150*2)
	dough.x, dough.y = display.contentWidth*0.75, display.contentHeight*0.22
	dough.alpha=0
	sceneGroup:insert(dough)

	--케이크 틀--
	local mold = display.newImageRect("이미지/도토리케이크/케이크_반죽틀.png", 200*4.1, 150*4.1)
	mold.x, mold.y = display.contentWidth*0.5, display.contentHeight*0.7
	sceneGroup:insert(mold)
	mold.alpha=1

	--반죽이 틀에 들어가 있는거--
	local doughMold = display.newImageRect("이미지/도토리케이크/케이크_반죽틀2.png", 200*3.9, 150*3.9)
	doughMold.x, doughMold.y = display.contentWidth*0.5, display.contentHeight*0.7
	sceneGroup:insert(doughMold)
	doughMold.alpha=1

	--레시피창 불러오기--
	local option = {
		isModal = true
	}

	local function tutorial(event)
		if event.phase == "began" then
			audio.play(soundTable["button4Sound"])
			composer.showOverlay("pierecipe2",option)
		end
	end

	local recipe = display.newImage("이미지/레시피/레시피_버튼.png")
	recipe.x, recipe.y = display.contentWidth*0.9, display.contentHeight*0.08
	sceneGroup:insert(recipe)
	recipe:addEventListener("touch",tutorial)

	--객체(바닐라,도우볼)에 마우스를 올리면 커지고 떼면 작아짐
	local i = 0
	local function big (event)
	
	if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 60^2 then
		-- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
		if i == 0 then
			audio.play(soundTable["mouseSound"])
			--local backgroundMusicChannel = audio.play(click1)
			event.target.width = event.target.width*1.2
			event.target.height = event.target.height*1.2
			i = i + 1
		end
	
	elseif (event.target.x-event.x)^2 + (event.target.y-event.y)^2 > 60^2 then
		if i == 1 then
			event.target.width =event.target.width/12*10
			event.target.height =event.target.height/12*10
			i = i - 1 
		end
		
	end
	end

	vanillat:addEventListener("mouse",big)
	doughBoll:addEventListener("mouse",big)

	---스틱 커지기---
	local i = 0
	local function big (event)
	
	if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 30^2 then
		-- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
		if i == 0 then
			audio.play(soundTable["mouseSound"])
			--local backgroundMusicChannel = audio.play(click1)
			event.target.width = event.target.width*1.2
			event.target.height = event.target.height*1.2
			i = i + 1
		end
	
	elseif (event.target.x-event.x)^2 + (event.target.y-event.y)^2 > 30^2 then
		if i == 1 then
			event.target.width =event.target.width/12*10
			event.target.height =event.target.height/12*10
			i = i - 1 
		end
		
	end
	end

	stick1:addEventListener("mouse",big)

	---클릭하면 도우 볼 삭제---
	local j=1
	local function click(event)
		j=j+1
		if j==2 then
			display.remove(doughBoll)
			dough.alpha=1

			local score = 0
				--drag&drop--
				local function doughEvent(event)
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
							if event.target.x < mold.x + 450 and event.target.x > mold.x - 450      
							and event.target.y < mold.y + 300 and event.target.y > mold.y - 300 then 
								display.remove(event.target)  
								score=score+1    
								audio.play(soundTable["doughSound"])

								if score == 1 then
									display.remove(mold)      
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
						
						-----------바닐라 드래그 앤 드롭해서 넣는 이벤트 구현-----------------
						local j=1
						local function click(event) 
							j=j+1
							if j== 2 then
								display.remove(vanillat)
								vanilla.alpha=1

								local k=1
								local function vanillaEvent(event)
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
											if event.target.x < doughMold.x + 450 and event.target.x > doughMold.x - 450      
											and event.target.y < doughMold.y + 300 and event.target.y > doughMold.y - 300 then 
												k=k+1
												audio.play(soundTable["dropSound"])

												if k==2 then
													display.remove(vanilla)
													vanillac.alpha=1
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

											------바닐라 액기스를 뿌려야 휘저을 수 있음--
											local j=1
											local function click(event) 
												j=j+1
												if j== 2 then
													display.remove(stick1)
													display.remove(vanillac)
													stick2.alpha=1

													local k=1
													local function stickEvent(event)
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
																if event.target.x < doughMold.x + 450 and event.target.x > doughMold.x - 450      
																and event.target.y < doughMold.y + 300 and event.target.y > doughMold.y - 300 then 
																	k=k+1

																	if k==2 then
																		audio.play(soundTable["putSound"])
																		display.remove(stick2)
																		sticks[1].alpha=1
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

																------------클릭 이벤트(휘젓는 모습)-----------
																local j=1
																local function click(event) 
																	j=j+1
																	if j > 1 and j<=3 then
																		audio.play(soundTable["mix3Sound"])
																		sticks[j-1].alpha=0
																		sticks[j].alpha=1
																	end

																	if j == 4 then
																		sticks[j-1].alpha=0
																	end
																
																	if j==5 then
																		background.alpha=0
																		stick1.alpha=0
																		stick2.alpha=0
																		for i=1,3 do
																			sticks[i].alpha=0
																		end
																		vanilla.alpha=0
																		vanillat.alpha=0
																		vanillac.alpha=0
																		doughBoll.alpha=0
																		dough.alpha=0
																		mold.alpha=0
																		doughMold.alpha=0
																		recipe.alpha=0
																		composer.removeScene( "acornCake1" )
																			composer.setVariable("complete", true)
																			local options={
																				effect ="fade",
																				time=400
																			}
																		composer.gotoScene("oven(acorn)1",options)
																	end
																end

																doughMold:addEventListener("tap", click)
																------------------------------------------------

															end
														end

													stick2:addEventListener("touch", stickEvent)

												end
											end
											stick1:addEventListener("tap",click)     					
											-------------------------------------------

										end
									end

								vanilla:addEventListener("touch", vanillaEvent)

							end
						end
						vanillat:addEventListener("tap",click)     	
						----------------------------------------------
					end
				end

				dough:addEventListener("touch", doughEvent)

		end
	end

	doughBoll:addEventListener("tap", click)

	--레이아웃--
	mold:toFront()
	dough:toFront()
	doughBoll:toFront()
	vanilla:toFront()
	vanillat:toFront()
	vanillac:toFront()
	stick2:toFront()
	for i=1, 3 do
		sticks[i]:toFront()
	end
	recipe:toFront()
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
