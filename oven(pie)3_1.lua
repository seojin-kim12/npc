-----------------------------------------------------------------------------------------
--
-- acornCake5.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
    gompoint=gompoint-1
    --오븐 뒷 배경--
    local background = display.newImage("이미지/배경/오븐_배경만.png")
    background.x = display.contentWidth / 2
    background.y = display.contentHeight / 2
    background.alpha=0
    sceneGroup:insert(background)

    --오븐닫힘--
    local oven={}
    oven[1] = display.newImageRect("이미지/연어파이/오븐_연어파이_02.png", 200*7.2, 150*5.2)
    oven[2] = display.newImageRect("이미지/오븐/오븐열림_아래O.png", 200*8.2, 150*6.8)

    oven[1].x, oven[1].y = display.contentWidth / 2, display.contentHeight*0.4
    oven[2].x, oven[2].y = display.contentWidth / 2, display.contentHeight *0.53

	for i=1,2 do
        oven[i].alpha=0
		sceneGroup:insert(oven[i])
	end

     --덜 익은 케이크--
     local cake = display.newImageRect("이미지/연어파이/덜익은파이.png", 200*2.4, 150*1.7)
     cake.x = display.contentWidth / 2
     cake.y = display.contentHeight *0.37
     cake.alpha=0
     sceneGroup:insert(cake)

     cake.alpha=1
     oven[1].alpha=1
     background.alpha=1

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
     
    --케이크에 마우스를 올리면 커지고 떼면 작아짐
    local i = 0
    local function big (event)
    
    if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 250^2 then
        -- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
        if i == 0 then
            --local backgroundMusicChannel = audio.play(click1)
            event.target.width = event.target.width*1.2
            event.target.height = event.target.height*1.2
            i = i + 1
        end
    
        elseif (event.target.x-event.x)^2 + (event.target.y-event.y)^2 > 250^2 then
            if i == 1 then
                event.target.width =event.target.width/12*10
                event.target.height =event.target.height/12*10
                i = i - 1 
            end    
        end
    end

    cake:addEventListener("mouse",big)

    --클릭 이벤트(오븐닫힘->열림)--
	local j=1
	local function click(event)              
		j=j+1
        if j==2 then
            oven[j-1].alpha=0
            oven[j].alpha=1
		end
        if j==3 then
            --클릭 이벤트(케이크누르면 다음 뷰 넘어가기)--
            local function click(event)              
                    display.remove(cake)
                    composer.removeScene( "oven(pie)3_1" )
                    composer.setVariable("complete", true)
                    local options={
                        effect ="fade",
                        time=400
                    }
                    composer.gotoScene("salmon8",options)
                end
            cake:addEventListener("tap",click)
        end
    end

	for i=1, 2 do
    	oven[i]:addEventListener("tap",click)
	end
    --레이아웃정리--
    oven[1]:toFront()
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