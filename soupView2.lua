-----------------------------------------------------------------------------------------
--
-- startView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	--배경
	local background = display.newImage("이미지/당근스프/당근/가스레인지.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	--냄비
	local pot = display.newImage("이미지/당근스프/당근/0번냄비.png")
	pot.x = display.contentWidth * 0.363
	pot.y = display.contentHeight * 0.4

	--손잡이
	local handle = {}
	handle[1] = display.newImage("이미지/당근스프/당근/손잡이_약불.png")
	handle[2] = display.newImage("이미지/당근스프/당근/손잡이_중불.png")
	handle[3] = display.newImage("이미지/당근스프/당근/손잡이_강불.png")

	handle[1].alpha = 1

	for i = 2, 3 do
		handle[i].alpha = 0
	end

	for i=1,3 do
		handle[i].x = display.contentWidth * 0.8
		handle[i].y = display.contentHeight * 0.85
		sceneGroup:insert(handle[i])
	end

	
	--타이머
	local clock = display.newImageRect("이미지/당근스프/당근/타이머.png", 199.5, 199.5)
	clock.x = display.contentWidth * 0.08
	clock.y = display.contentHeight * 0.1
	sceneGroup:insert(clock)

	--불
	local fire = {}
	fire[1] = display.newImage("이미지/당근스프/당근/불_약불.png")
	fire[2] = display.newImage("이미지/당근스프/당근/불_중불.png")
	fire[3] = display.newImage("이미지/당근스프/당근/불_강불.png")

	for i=1,3 do
		fire[i].alpha=0
	end

	fire[1].y = display.contentHeight * 0.7
	fire[2].y = display.contentHeight * 0.65
	fire[3].y = display.contentHeight * 0.62

	if (index % 3 == 1)then
		fire[3].alpha = 0
		handle[3].alpha = 0
		fire[1].alpha = 1
		handle[1].alpha = 1
	elseif (index % 3 == 2)then
		fire[1].alpha = 0
		handle[1].alpha = 0
		fire[2].alpha = 1
		handle[2].alpha = 1
	elseif (index % 3 == 0) then
		fire[2].alpha = 0
		handle[2].alpha = 0
		fire[3].alpha = 1
		handle[3].alpha = 1
	end

	sceneGroup:insert(pot)

    local function click(event)
        index=index+1
		if (index % 3 == 1)then
			fire[3].alpha = 0
			handle[3].alpha = 0
			fire[1].alpha = 1
			handle[1].alpha = 1
		elseif (index % 3 == 2)then
			fire[1].alpha = 0
			handle[1].alpha = 0
			fire[2].alpha = 1
			handle[2].alpha = 1
		elseif (index % 3 == 0) then
			fire[2].alpha = 0
			handle[2].alpha = 0
			fire[3].alpha = 1
			handle[3].alpha = 1
        end
    end
	for i=1,3 do 
		handle[i]:addEventListener("tap",click)
	 end

	sceneGroup:insert(pot)

  	--레시피창 불러오기--

	local option = {
		isModal = true
 	}

  	local function tutorial(event)
		audio.play(soundTable["button4Sound"])
		if event.phase == "began" then
	   		composer.showOverlay("souprecipe",option)
		end
	end

 	local recipe = display.newImage("이미지/레시피/레시피_버튼.png")
 	recipe.x, recipe.y = display.contentWidth*0.9, display.contentHeight*0.08
 	sceneGroup:insert(recipe)

 	recipe:addEventListener("touch",tutorial)

	--타이머
	local limit = 5
	local showLimit = display.newText(limit, display.contentWidth * 0.08, display.contentHeight * 0.1)
	showLimit:setFillColor(1)
	showLimit.size = 80
	sceneGroup:insert(showLimit)

	local function timeAttack(event)
		limit = limit - 1
		showLimit.text = limit
		showLimit:setFillColor(1)

		if(limit == 0)then
			composer.removeScene( "soupView2" )
         composer.gotoScene("soupView3")

			background.alpha = 0
			pot.alpha = 0
			recipe.alpha = 0
			clock.alpha = 0
			showLimit.alpha = 0

			for i = 1, 3 do
				fire[i].alpha = 0
				handle[i].alpha = 0
			end
		end
	end

	timer.performWithDelay(1000, timeAttack, 0)

	for i=1,3 do
		fire[i].x = display.contentWidth * 0.363
		sceneGroup:insert(fire[i])
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
