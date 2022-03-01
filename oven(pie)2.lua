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
    local background = display.newImage("이미지/배경/오븐_배경만(확대).png")
    background.x = display.contentWidth / 2
    background.y = display.contentHeight / 2
    sceneGroup:insert(background)

	--오븐닫힘--
	local oven = {}
	oven[1] = display.newImage("이미지/연어파이/오븐/연어오븐_00(꺼짐).png")
	oven[2] = display.newImage("이미지/연어파이/오븐/연어오븐_01.png")
	oven[3] = display.newImage("이미지/연어파이/오븐/연어오븐_02.png")
	oven[4] = display.newImage("이미지/연어파이/오븐/연어오븐_03.png")
	oven[5] = display.newImage("이미지/연어파이/오븐/연어오븐_04.png")
	oven[6] = display.newImage("이미지/연어파이/오븐/연어오븐_05.png")
	oven[7] = display.newImage("이미지/연어파이/오븐/연어오븐_06.png")
	oven[8] = display.newImage("이미지/연어파이/오븐/연어오븐_07.png")
	oven[9] = display.newImage("이미지/연어파이/오븐/연어오븐_08.png")
	oven[10] = display.newImage("이미지/연어파이/오븐/연어오븐_09.png")
	oven[11] = display.newImage("이미지/연어파이/오븐/연어오븐_10.png")
	oven[12] = display.newImage("이미지/연어파이/오븐/연어오븐_11.png")
	oven[13] = display.newImage("이미지/연어파이/오븐/연어오븐_12.png")
	oven[14] = display.newImage("이미지/연어파이/오븐/연어오븐_13.png")
	oven[15] = display.newImage("이미지/연어파이/오븐/연어오븐_14.png")
	oven[16] = display.newImage("이미지/연어파이/오븐/연어오븐_15.png")

	oven[1].alpha=1
	for i=2, 16 do
		oven[i].alpha=0
	end
	for i=1, 16 do
		oven[i].x, oven[i].y = display.contentWidth / 2, display.contentHeight / 2
		sceneGroup:insert(oven[i])
	end

	--버튼 장식용--
	local sbutton = display.newImageRect("이미지/오븐/오븐버튼_Off.png", 150*0.7, 200*0.6)
	sbutton.x, sbutton.y = display.contentWidth*0.3, display.contentHeight*0.23
	sceneGroup:insert(sbutton)

    --버튼게임용--
    local button={}
    button[1] = display.newImageRect("이미지/오븐/오븐버튼_Off.png", 150*0.7, 200*0.6)  --안누름
	button[2] = display.newImageRect("이미지/오븐/오븐버튼_On.png", 150*0.7, 200*0.6)  --누름
	button[3] = display.newImageRect("이미지/오븐/오븐버튼_Off.png", 150*0.7, 200*0.6)  --안누름

	button[1].alpha=1
    for i=2,3 do
		button[i].alpha=0
	end
	for i=1,3 do
		button[i].x, button[i].y = display.contentWidth*0.7, display.contentHeight*0.23
		sceneGroup:insert(button[i])
	end

	--레시피 불러오기
	local option = {
		isModal = true
	}

    local function tutorial(event)
		if event.phase == "began" then
			audio.play(soundTable["button4Sound"])
			composer.showOverlay("pierecipe",option)
		end
	end

	local recipe = display.newImage("이미지/레시피버튼.png")
	recipe.x, recipe.y = display.contentWidth*0.9, display.contentHeight*0.08
	sceneGroup:insert(recipe)
	recipe:addEventListener("touch",tutorial)

	--타이머 앞에 숫자--
	local timerNum = {}
	timerNum[1] = display.newText("00:0", display.contentWidth*0.5, display.contentHeight*0.24)
	timerNum[2] = display.newText("00:", display.contentWidth*0.5, display.contentHeight*0.24)
	
	timerNum[1].alpha=1
	timerNum[2].alpha=0
	for i=1,2 do
		timerNum[i]:setFillColor(1)
		timerNum[i].size = 80
		sceneGroup:insert(timerNum[i])
	end



	--timer start--
	local time = 0
	local showLimit = display.newText(time, display.contentWidth*0.55, display.contentHeight*0.24)
	showLimit:setFillColor(1)
	showLimit.size = 80
	sceneGroup:insert(showLimit)

	local function timeAttack(event)
			print(time.."초")
			if time>=0 and time < 15 then
				oven[time+1].alpha=0
				oven[time+2].alpha=1
			end
			time = time + 1
			showLimit.text = time
	end

	--시간 제한--
	local limit = 15
	
	--버튼에 마우스를 올리면 커지고 떼면 작아짐
	local i = 0
	local function big (event)
	
	if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 50^2 then
		-- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
		if i == 0 then
			--local backgroundMusicChannel = audio.play(click1)
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

	for i=1,3 do
		button[i]:addEventListener("mouse",big)
	end

	--버튼on, off--
	local k=1
	local j=1
	local function click(event)              
		j=j+1
		k=k+1
		--버튼배열이 2일때 즉, 열린버튼으로 바꿀 때--
		if j == 2 then
			button[j-1].alpha=0
			button[j].alpha=1

			t = timer.performWithDelay(1000, timeAttack, 0)  --(딜레이시간, 함수, 반복횟수)를 매개변수로 가짐--

			local function timeAttack(event)
				print(limit.."남음")
				limit = limit - 1
		

				if limit == 0 then 
					gompoint=gompoint+1
					timer.pause( l )
					composer.setVariable("complete", false)  --complete변수에 false값을 담아줌--
					composer.gotoScene("oven(pie)3_3")              --view2로 넘겨줌--
				end

				if limit == 5 then
					timerNum[1].alpha=0
					timerNum[2].alpha=1
				end
			end
		
			l = timer.performWithDelay(1000, timeAttack, 0)  

		end

		--버튼 배열이 3일때 즉, 닫힌버튼으로 바꿀 때--
		if j == 3 then
			audio.play(soundTable["tingSound"])
			button[j-1].alpha=0
			button[j].alpha=1

			timer.pause( l )
			timer.pause( t ) 

			print(time)
			--타임이 10초 전이면--
			if time < 10 then
				gompoint=gompoint+1
				background.alpha=0
				sbutton.alpha=0
				for i=1,3 do
					button[i].alpha=0
				end
				for i=1,2 do
					timerNum[i].alpha=0
				end
				for i=1,16 do
					oven[i].alpha=0
				end
				showLimit.alpha=0
				composer.removeScene( "oven(pie)2" )
				composer.setVariable("complete", true)
				local options={
					effect ="fade",
					time=300
				}
				composer.gotoScene("oven(pie)3_1",options)
			end

			--타임이 10초라면--
			if time == 10 then
				background.alpha=0
				sbutton.alpha=0
				for i=1,3 do
					button[i].alpha=0
				end
				for i=1,2 do
					timerNum[i].alpha=0
				end
				for i=1,16 do
					oven[i].alpha=0
				end
				showLimit.alpha=0
				composer.removeScene( "oven(pie)2" )
				composer.setVariable("complete", true)
				local options={
					effect ="fade",
					time=300
				}
				composer.gotoScene("oven(pie)3_2",options)
			end

			--타임이 10초 후라면--
			if time > 10 then
				gompoint=gompoint+1
				background.alpha=0
				sbutton.alpha=0
				for i=1,3 do
					button[i].alpha=0
				end
				for i=1,2 do
					timerNum[i].alpha=0
				end
				for i=1,16 do
					oven[i].alpha=0
				end
				showLimit.alpha=0
				composer.removeScene( "oven(pie)2" )
				composer.setVariable("complete", true)
				local options={
					effect ="fade",
					time=400
				}
				composer.gotoScene("oven(pie)3_3",options)
			end
			
		end

	end

	for i=1, 3 do
		button[i]:addEventListener("tap",click)
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
