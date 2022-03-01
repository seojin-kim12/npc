-----------------------------------------------------------------------------------------
--
-- acornCake5.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	audio.play( soundTable["finalSound"],{ loops=-1 } )
    
	--배경
	local background = display.newImage("이미지/엔딩/배경1(기대).png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

    --동물들이 먹는 배경
    local ebackground = display.newImage("이미지/엔딩/배경2(음식먹음).png")
	ebackground.x = display.contentWidth / 2
	ebackground.y = display.contentHeight / 2
    ebackground.alpha=0
	sceneGroup:insert(ebackground)

    --각 동물들에게 줄 메뉴 배열
    local manu = {}
    manu[1] = display.newImageRect("이미지/대접/기대물음표스프.png", 200*2.5, 150*2.5)
    manu[2] = display.newImageRect("이미지/대접/기대물음표파이.png", 200*2.5, 150*2.5)
    manu[3] = display.newImageRect("이미지/대접/기대물음표케이크.png", 200*2.3, 150*2.3)

    manu[1].x, manu[1].y = display.contentWidth*0.23, display.contentHeight*0.7
    manu[2].x, manu[2].y = display.contentWidth*0.5, display.contentHeight*0.7
    manu[3].x, manu[3].y = display.contentWidth*0.75, display.contentHeight*0.7

    for i=1,3 do
        manu[i].alpha=0
        sceneGroup:insert(manu[i])
    end

    --메뉴 클릭 시 하나씩 등장--
    local j=1
    local function click(event)
        j=j+1
        if j>1 and j<=4 then
            audio.play(soundTable["mix3Sound"])
            manu[j-1].alpha=1
        end

        --먹는 일러스트 삽입 부분--
        if j==5 then
            audio.play(soundTable["putSound"])
            background.alpha=0
            for i=1, 3 do
                manu[i].alpha=0
            end
            ebackground.alpha=1

            --먹는 일러스트 클릭 시 다음 장면으로 넘어 감--
            local k=1
            local function click(event)
                k=k+1
                if k== 2 then
                    ebackground.alpha=0
                    composer.removeScene( "reception0" )
					composer.setVariable("complete", true)
					composer.gotoScene("reception",options)
                end
            end

            ebackground:addEventListener("tap",click)

           --[[ background.alpha=0
            for i=1, 3 do
                manu[i].alpha=0
            end
            composer.removeScene( "reception0" )
            composer.setVariable("complete", true)
            local options={
                effect ="fade",
                time=400
            }
            composer.gotoScene("reception1",options)]]

        end
    end

    background:addEventListener("tap",click)
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
