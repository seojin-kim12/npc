-----------------------------------------------------------------------------------------
--
-- startView.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	--테이블
	local background = display.newImage("이미지/배경/요리테이블_왼손만.png")
	background.x = display.contentWidth / 2
	background.y = display.contentHeight / 2
	sceneGroup:insert(background)

	--칼
	local knife = display.newImageRect("이미지/당근스프/칼든토끼손.png",710,700)
	knife.x = display.contentWidth *0.8
	knife.y = display.contentHeight *0.6

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




	--객체에 마우스를 올리면 커지고 떼면 작아짐
	local i = 0
	local function big (event)
	   
	   if (event.target.x-event.x)^2 + (event.target.y-event.y)^2 < 50^2 then
		  -- i값을 지정해 놓는 이유는 범위 안에서는 크기가 더 늘어나거나 줄어들지 않고, 소리가 연이어 나오지 않음.
		  if i == 0 then
			 audio.play(soundTable["mouseSound"])
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

	--도마
	local board = display.newImageRect("이미지/당근스프/도마.png",1167.75,529.75)
	board.x = display.contentWidth / 2
	board.y = display.contentHeight * 0.45
	sceneGroup:insert(board)

	local function big (event)
   		knife.x=event.x+195
   		knife.y=event.y+120
	end
	background:addEventListener("mouse",big)


	--당근

	local carrot = {}
	carrot[1] = display.newImageRect("이미지/당근스프/당근_1단계.png",1067.25,264)
	carrot[2] = display.newImageRect("이미지/당근스프/당근_2단계.png",1067.25,264)
	carrot[3] = display.newImageRect("이미지/당근스프/당근_3단계.png",1067.25,264)

	for i=2,3 do
		carrot[i].alpha=0
	end

	for i=1,3 do
		carrot[i].x = display.contentWidth *0.56
		carrot[i].y = display.contentHeight *0.46
		sceneGroup:insert(carrot[i])
	end

	local j=1
    local function click(event)
        j=j+1
        if j>1 and j<=3 then
			audio.play(soundTable["chopSound"])
            carrot[j-1].alpha=0
            carrot[j].alpha=1
        end

		if j == 3 then
			knife.alpha = 0
		end

        if j==4 then 
            composer.removeScene( "soupView1" )
            composer.setVariable("complete", true)
            local options={
                effect ="fade",
                time=400
            }
            composer.gotoScene("soupView2",options)

			background.alpha = 0
			board.alpha = 0
			carrot[3].alpha = 0
			knife.alpha = 0
			recipe.alpha = 0

        end

    end
    board:addEventListener("tap",click)

   sceneGroup:insert(knife)

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
