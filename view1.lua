-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view


	--배경
	local background = display.newImage("이미지/배경/숲배경.jpg")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	--캐릭터 배열
	local c={}
	c[1] = display.newImage("이미지/캐릭터/주인공.png",display.contentWidth * 0.8,display.contentHeight / 2)
	c[2] = display.newImage("이미지/캐릭터/토끼친구.png",display.contentWidth * 0.2,display.contentHeight / 2)
	c[3] = display.newImage("이미지/캐릭터/다람쥐친구.png",display.contentWidth * 0.2,display.contentHeight / 2)
	c[4] = display.newImage("이미지/캐릭터/곰친구.png",display.contentWidth * 0.2,display.contentHeight / 2)
	c[5] = display.newImage("이미지/캐릭터/주인공.png",display.contentWidth * 0.8,display.contentHeight / 2)

	c[1].alpha=1
	for i=2,5 do
		c[i].alpha=0
	end
	for i=1,5 do
		sceneGroup:insert(c[i])
	end


	--채팅창 배열
	local t={}
	t[1] = display.newImageRect("이미지/채팅창/채팅창주인공.png",1920,1080)
	t[2] = display.newImageRect("이미지/채팅창/채팅창토끼.png",1920,1080)
	t[3] = display.newImageRect("이미지/채팅창/채팅창다람쥐.png",1920,1080)
	t[4] = display.newImageRect("이미지/채팅창/채팅창곰.png",1920,1080)
	t[5] = display.newImageRect("이미지/채팅창/채팅창주인공.png",1920,1080)

	t[1].alpha=1
	for i=2,5 do
		t[i].alpha=0
	end
	for i=1,5 do
		t[i].x = display.contentWidth /2
		t[i].y = display.contentHeight / 2
		sceneGroup:insert(t[i])
	end

	--채팅 배열
	local chatting={}
	local text={
		"애들아 다들 와줘서 고마워~!",
		"새삼스럽게 뭘~",
		"오늘은 또 무슨 요리를 해 줄거야?",
		"오늘만 손꼽아 기다렸어..!",
		"그럼 이만 집에 들어갈까?",
	}

	for i=1,5 do
        chatting[i]=display.newText(text[i],display.contentWidth*0.3,display.contentHeight*0.8)
        chatting[i]:setFillColor(0)
        chatting[i].size=50
    end
    for i=2,5 do
        chatting[i].alpha=0
    end
 
    local j=1
    local function click(event)
        j=j+1
        if j>1 and j<=5 then
            c[j-1].alpha=0
            t[j-1].alpha=0
            chatting[j-1].alpha=0
            c[j].alpha=1
            t[j].alpha=1
            chatting[j].alpha=1
        end

        if j==6 then 
        	chatting[5].alpha=0
            composer.removeScene( "view1" )
            composer.setVariable("complete", true)
            local options={
                effect ="fade",
                time=400
            }
            composer.gotoScene("view2",options)
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