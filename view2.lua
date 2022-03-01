-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	--배경
	local background = display.newImage("이미지/배경/집안배경.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)


	--캐릭터 배열

	--캐릭터 배열 생성
	local c={}
	--캐릭터 배열에 캐릭터 이미지 담기
	c[1] = display.newImage("이미지/캐릭터/주인공.png",display.contentWidth * 0.8,display.contentHeight / 2)
	c[2] = display.newImage("이미지/캐릭터/다람쥐친구.png",display.contentWidth * 0.2,display.contentHeight / 2)
	c[3] = display.newImage("이미지/캐릭터/곰친구.png",display.contentWidth * 0.2,display.contentHeight / 2)
	c[4] = display.newImage("이미지/캐릭터/토끼친구.png",display.contentWidth * 0.2,display.contentHeight / 2)
	c[5] = display.newImage("이미지/캐릭터/주인공.png",display.contentWidth * 0.8,display.contentHeight / 2)

    --처음 등장할 캐릭터 외의 캐릭터들은 투명도를 0으로
	for i=2,5 do
		c[i].alpha=0
	end
	--모든 캐릭터 객체는 씬그룹에 넣기
	for i=1,5 do
		sceneGroup:insert(c[i])
	end

	--채팅창 배열

	--채팅창 배열 생성
	local t={}
	--채팅창 배열에 채팅창 이미지 담기
	t[1] = display.newImage("이미지/채팅창/채팅창주인공.png")
	t[2] = display.newImage("이미지/채팅창/채팅창다람쥐.png")
	t[3] = display.newImage("이미지/채팅창/채팅창곰.png")
	t[4] = display.newImage("이미지/채팅창/채팅창토끼.png")
	t[5] = display.newImage("이미지/채팅창/채팅창주인공.png")
	
	--처음 등장할 캐릭터 외의 채팅창들은 투명도를 0으로
	for i=2,5 do
		t[i].alpha=0
	end
	--모든 채팅창 객체는 씬그룹에 넣기
	for i=1,5 do
		t[i].x = display.contentWidth /2
		t[i].y = display.contentHeight * 0.79
		sceneGroup:insert(t[i])
	end

	--채팅 배열
	local chatting={}
	--텍스트 배열
    local text={
    	"자! 다들 먹고 싶은 거 편히 말해봐!",
		"난 도토리 케이크!",
		"난 연어파이..",
		"그럼 난 당근수프!",
		"좋아 ! 여기서 딱 기다려~ 금방 준비해 올 테니까!!",
    }
    --채팅 배열에 텍스트 배열 넣기 setFillColor(0)=검정색 글씨
    for i=1,5 do
    	chatting[i]=display.newText(text[i],display.contentWidth*0.132,display.contentHeight*0.78)
    	chatting[i]:setFillColor(0)
    	chatting[i].size=50
    	chatting[i].anchorX,chatting[i].anchorY=0,0
    	sceneGroup:insert(chatting[i])
    end
    --처음 등장할 대사 외의 대사들은 투명도를 0으로
    for i=2,5 do
    	chatting[i].alpha=0
    end
 	
 	--클릭변수
	local j=1

	--클릭함수
	local function click(event)
		--탭할때마다 클릭변수 증가
		j=j+1
		--클릭할때마다 전의 이미지(캐릭터,채팅창,대사)들의 투명도는 0으로 등장해야할 이미지의 투명도를 1로
		if j>1 and j<=5 then
			c[j-1].alpha=0
			t[j-1].alpha=0
			chatting[j-1].alpha=0
			c[j].alpha=1
			t[j].alpha=1
			chatting[j].alpha=1
		end

		--모든 이미지들이 끝났으면 씬이동
		if j==6 then 
			composer.removeScene( "view2" )
			audio.pause( soundTable["chattSound"])
        	composer.setVariable("complete", true)
        	local options={
				effect ="fade",
				time=400
			}
        	composer.gotoScene("salmon1",options)
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
