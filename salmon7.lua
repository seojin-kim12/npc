-----------------------------------------------------------------------------------------
--
-- startView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImage("이미지/배경/요리테이블_왼손만.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	local p={}
	p[1]=display.newImageRect("이미지/연어파이/연어파이완성.png",860,718)
	p[1].x=display.contentWidth /2
	p[1].y=display.contentHeight /2
	sceneGroup:insert(p[1])

	for i=2,4 do
		p[i]=display.newImageRect("이미지/연어파이/계란물/"..(i-1).."단계.png",860,718)
		p[i].x=display.contentWidth /2
		p[i].y=display.contentHeight /2
		sceneGroup:insert(p[i])
		p[i].alpha=0
	end

	local egg = display.newImageRect("이미지/연어파이/계란물/계란물.png",533*0.8,381*0.8)
	egg.x = display.contentWidth *0.15
	egg.y = display.contentHeight *0.175
	sceneGroup:insert(egg)

	local brush = display.newImageRect("이미지/연어파이/계란물/요리붓기본.png",475,741)
	brush.x = display.contentWidth *0.8
	brush.y = display.contentHeight *0.6
	sceneGroup:insert(brush)

	local brush2 = display.newImageRect("이미지/연어파이/계란물/요리붓계란.png",475,741)
	brush2.x = display.contentWidth *0.8
	brush2.y = display.contentHeight *0.6
	brush2.alpha=0
	sceneGroup:insert(brush2)

	--마우스에 객체 고정
	local function big (event)
		brush.x=event.x+120
		brush.y=event.y-230
	end
	background:addEventListener("mouse",big)

	--객체에 마우스를 올리면 커지고 떼면 작아짐
	local i = 0
	local function big (event)
		
		if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 100^2 then
			-- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
			if i == 0 then
				audio.play( soundTable["mouseSound"] )
				event.target.width = event.target.width*1.2
				event.target.height = event.target.height*1.2
				i = i + 1
			end
		
		elseif (event.target.x-event.x)^2 + (event.target.y-event.y)^2 > 100^2 then
			if i == 1 then
				event.target.width =event.target.width/12*10
				event.target.height =event.target.height/12*10
				i = i - 1 
			end
			
		end
	end
	egg:addEventListener("mouse",big)

local c=1
	local function eggbrush(event)
		brush.alpha=0	
		c=c+1
		local function big (event)
			brush2.x=event.x+120
			brush2.y=event.y-230
			brush2.alpha=1
		end
		background:addEventListener("mouse",big)
    end
    egg:addEventListener("tap",eggbrush)

    local c2=1
	local function click(event)		
		--브러쉬에 계란물 안 묻히면 클릭 안되게
		if c>1 then
			c2=c2+1
			if c2>1 and c2<=4 then
				audio.play( soundTable["creamSound"] )
				p[c2-1].alpha=0
				p[c2].alpha=1
			end
			if c2>=5 then 
				composer.removeScene( "salmon7" )
       			composer.gotoScene("oven(pie)1",options)
        	end
    	end
    end
    for i=1,4 do
		p[i]:addEventListener("tap",click)
	end




    --레시피 불러오기
	local option = {
		isModal = true
	}

    local function tutorial(event)
		if event.phase == "began" then
			composer.showOverlay("pierecipe",option)
		end
	end

	local recipe = display.newImage("이미지/레시피버튼.png")
	recipe.x, recipe.y = display.contentWidth*0.9, display.contentHeight*0.08
	sceneGroup:insert(recipe)
	recipe:addEventListener("touch",tutorial)


	
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
