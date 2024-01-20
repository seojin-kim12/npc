-----------------------------------------------------------------------------------------
--
-- startView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local s={}

	s[1]=display.newRect(display.contentWidth*0.35, display.contentHeight*0.5,50,650)
	s[2]=display.newRect(display.contentWidth*0.455, display.contentHeight*0.5,50,800)
	s[3]=display.newRect(display.contentWidth*0.525, display.contentHeight*0.5,50,800)
	s[4]=display.newRect(display.contentWidth*0.595, display.contentHeight*0.5,50,800)
	s[5]=display.newRect(display.contentWidth*0.67, display.contentHeight*0.5,50,650)
	for i=1,5 do 
		s[i]:setFillColor(0)
		sceneGroup:insert(s[i])
		s[i].alpha=0
	end

	local background = display.newImage("이미지/배경/요리테이블_왼손만.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	local p={}
	for i=1,7 do
		p[i] = display.newImageRect("이미지/연어파이/반죽"..i..".png",890,772)
		p[i].x = display.contentWidth / 2
		p[i].y = display.contentHeight / 2
		p[i].alpha=0
		sceneGroup:insert(p[i])
	end
	p[1].alpha=1

	local knife = display.newImageRect("이미지/칼.png",710,700)
	knife.x = display.contentWidth *0.8
	knife.y = display.contentHeight *0.6
	sceneGroup:insert(knife)

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

	local function big (event)
		knife.x=event.x+195
		knife.y=event.y+120
	end
	background:addEventListener("mouse",big)

	local function click(event)
		p[1].alpha=0
		p[2].alpha=1
		s[1].alpha=1
	end
	p[1]:addEventListener("tap",click)

	local j=0

	for i=1,5 do
		local function chop(event)
			p[i+1].alpha=0
			p[i+2].alpha=1
			if i>=1 and i<=4 then
				s[i].alpha=0
				s[i+1].alpha=1
				audio.play( soundTable["chopSound"] )
			end
			if i==5 then
				audio.play( soundTable["chopSound"] )
				knife.alpha=0
			end
		end
		s[i]:addEventListener("tap",chop)
	end

	local function next(event)
		p[7].alpha=0
		composer.removeScene( "salmon5" )
        composer.setVariable("complete", true)
        local options={
			effect ="fade",
		time=400
			}
       	composer.gotoScene("salmon6",options)
    end
    p[7]:addEventListener("tap",next)
	



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